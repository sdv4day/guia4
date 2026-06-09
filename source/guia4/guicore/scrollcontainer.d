module guia4.guicore.scrollcontainer;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.utils.logger;
import guia4.utils.math : clamp;
import guia4.platform_win32.win32defs;
import std.utf;
import std.algorithm;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

/**
 * ScrollableContainer — a control that clips and scrolls its children
 * using GDI viewport offset, with a vertical scrollbar.
 *
 * Rendering approach:
 *   1. SaveDC to preserve original clip region + viewport origin
 *   2. IntersectClipRect to clip drawing to this container's bounds
 *   3. OffsetViewportOrgEx to shift children upward by _scrollY
 *   4. Render each visible child via renderWithGDI
 *   5. RestoreDC to undo clip and offset
 *   6. Draw the scrollbar on top (unclipped)
 *
 * Mouse wheel scrolls content. Scrollbar thumb supports click-and-drag.
 * Hover effect on thumb is tracked.
 *
 * Children are positioned as usual (absolute coords = container.x + rel.x).
 * The viewport offset shifts everything so child at (cx+5, cy+5)
 * appears at (cx+5, cy+5 - _scrollY) on screen.
 */
class ScrollableContainer : Control
{
    private int _scrollY = 0;
    private int _contentHeight = 0;   // total virtual height of content
    private int _thumbHeight = 0;     // height of the scrollbar thumb in pixels
    private int _scrollbarWidth = 14; // width of the vertical scrollbar

    // Scrollbar colors
    private COLORREF _trackColor   = cast(COLORREF)0x00F0F0F0; // light grey
    private COLORREF _thumbColor   = cast(COLORREF)0x00C0C0C0; // grey
    private COLORREF _thumbHover   = cast(COLORREF)0x00A0A0A0; // darker grey
    private bool _thumbHovered = false;

    // ── Thumb drag state ──
    private bool _isDragging = false;
    private int _dragStartY = 0;       // mouse Y at drag start (container-local)
    private int _dragStartScrollY = 0; // scrollY at drag start

    this()
    {
        super();
        logTrace("ScrollableContainer.ctor()");

        // Register mouse handlers
        onMouseWheel(&handleMouseWheel);
        onMouseDown(&handleMouseDown);
        onMouseUp(&handleMouseUp);
        onMouseMove(&handleMouseMove);
    }

    this(Control parent)
    {
        this();
        if (parent)
            parent.addChild(this);
    }

    /// Convenience constructor: contentHeight, width, height
    this(int contentHeight_, int width_, int height_)
    {
        this();
        _contentHeight = contentHeight_;
        width = width_;
        height = height_;
        logTrace("ScrollableContainer.ctor(contentHeight=", contentHeight_,
                 ", w=", width_, ", h=", height_, ")");
    }

    // ── Properties ────────────────────────────────────────────────

    int scrollY() const @property { return _scrollY; }
    void scrollY(int v) @property
    {
        _scrollY = v.clamp(0, maxScroll());
        markDirty(DirtyBits.Visual);
    }

    int contentHeight() const @property { return _contentHeight; }
    void contentHeight(int v) @property
    {
        _contentHeight = v;
        updateScrollbar();
        markDirty(DirtyBits.Visual);
    }

    int scrollbarWidth() const @property { return _scrollbarWidth; }
    void scrollbarWidth(int v) @property { _scrollbarWidth = v; markDirty(DirtyBits.Visual); }

    /// Maximum scroll value (can't scroll past the bottom)
    private int maxScroll() const
    {
        return std.algorithm.max(0, _contentHeight - height());
    }

    /// Whether the content exceeds the container height
    private bool needsScrollbar() const
    {
        return _contentHeight > height();
    }

    /// Update scrollbar thumb size and clamp scroll position
    private void updateScrollbar()
    {
        if (!needsScrollbar())
        {
            _thumbHeight = 0;
            _scrollY = 0;
            return;
        }

        // Thumb height proportional to visible area vs content area
        float visibleRatio = cast(float)height() / _contentHeight;
        _thumbHeight = cast(int)(height() * visibleRatio);
        _thumbHeight = std.algorithm.max(_thumbHeight, 10); // minimum 10px thumb

        // Clamp scroll position
        _scrollY = _scrollY.clamp(0, maxScroll());
    }

    /// How many pixels of scroll per mouse wheel notch
    private int scrollStep() const
    {
        return 20;
    }

    // ── Wheel handler ────────────────────────────────────────────

    /// Called when ScrollableContainer receives a mouse wheel event
    private void handleMouseWheel(ref MouseWheelEvent ev)
    {
        int delta = ev.delta;
        logTrace("ScrollableContainer.handleMouseWheel(delta=", delta, ")");

        if (delta > 0)
        {
            // Scroll up (negative delta moves content down to reveal more above)
            _scrollY = (_scrollY - scrollStep()).clamp(0, maxScroll());
        }
        else
        {
            // Scroll down
            _scrollY = (_scrollY + scrollStep()).clamp(0, maxScroll());
        }

        markDirty(DirtyBits.Visual);
        logTrace("ScrollableContainer: scrollY now ", _scrollY);
    }

    // ── Thumb drag handlers ──────────────────────────────────────

    /// Returns true if container-local x is inside the scrollbar track.
    private bool isInScrollbar(int lx) const
    {
        return lx >= width() - _scrollbarWidth && lx < width();
    }

    /// Returns the thumb top edge in container-local coordinates.
    private int computeThumbTop() const
    {
        if (_thumbHeight <= 0 || maxScroll() <= 0)
            return 0;
        float ratio = cast(float)_scrollY / maxScroll();
        int available = height() - _thumbHeight;
        return cast(int)(available * ratio);
    }

    /// Handle mouse-down: start drag if on the scrollbar thumb.
    private void handleMouseDown(ref MouseEvent event)
    {
        if (!needsScrollbar() || _thumbHeight <= 0)
            return;

        if (!isInScrollbar(event.x))
            return;

        int tTop = computeThumbTop();
        if (event.y >= tTop && event.y < tTop + _thumbHeight)
        {
            _isDragging = true;
            _dragStartY = event.y;
            _dragStartScrollY = _scrollY;
            logTrace("ScrollableContainer: thumb drag started at y=", event.y);
        }
    }

    /// Handle mouse-up: stop drag.
    private void handleMouseUp(ref MouseEvent event)
    {
        if (_isDragging)
        {
            _isDragging = false;
            _thumbHovered = false;
            logTrace("ScrollableContainer: thumb drag ended");
        }
    }

    /// Handle mouse-move: during drag → update scroll; otherwise → hover tracking.
    private void handleMouseMove(ref MouseEvent event)
    {
        if (_isDragging)
        {
            int deltaY = event.y - _dragStartY;
            float scrollPerPixel = cast(float)maxScroll() / (height() - _thumbHeight);
            _scrollY = cast(int)(_dragStartScrollY + deltaY * scrollPerPixel);
            _scrollY = _scrollY.clamp(0, maxScroll());
            markDirty(DirtyBits.Visual);
            logTrace("ScrollableContainer: drag scrollY=", _scrollY);
        }
        else
        {
            // Hover tracking for thumb color
            if (isInScrollbar(event.x))
            {
                int tTop = computeThumbTop();
                _thumbHovered = (event.y >= tTop && event.y < tTop + _thumbHeight);
            }
            else
            {
                _thumbHovered = false;
            }
        }
    }

    // ── Child management ─────────────────────────────────────────

    /// Compute content height from children (auto-calculated).
    /// Each child's bottom edge = child.y + child.height - this.y (relative to container).
    private int computeContentHeight()
    {
        int maxBottom = 0;
        foreach (child; children())
        {
            int childBottom = child.y() + child.height() - y();
            if (childBottom > maxBottom)
                maxBottom = childBottom;
        }
        return std.algorithm.max(maxBottom, height());
    }

    /// Recalculate content height from current children and update scrollbar.
    /// Call this after repositioning children, adding/removing via raw _children, or
    /// after container resize. The `addChild` override calls this automatically.
    void recalcContent()
    {
        _contentHeight = computeContentHeight();
        updateScrollbar();
        markDirty(DirtyBits.Visual);
    }

    override void addChild(Control child)
    {
        super.addChild(child);
        recalcContent();
    }

    /// Auto-adaptive content: recalc content height on every render pass so
    /// any child repositioning (via applyLayout, manual y() set, etc.) is
    /// automatically reflected in the scrollbar.
    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        // Recompute content height before drawing — this makes the scrollbar
        // self-adapt to any out-of-band child repositioning.
        int prevContentH = _contentHeight;
        _contentHeight = computeContentHeight();
        updateScrollbar();
        if (_contentHeight != prevContentH)
            logTrace("ScrollableContainer.renderWithGDI: contentH ", prevContentH, " → ", _contentHeight);

        // ── now delegate to the real rendering ──
        renderContent(hdc);
    }

    /// The actual rendering logic, extracted so renderWithGDI can insert
    /// the auto-adaptive recalc before it.
    private void renderContent(HDC hdc)
    {
        logTrace("ScrollableContainer.renderContent() at (", x(), ",", y(),
                 ") size=", width(), "x", height(), " scrollY=", _scrollY);

        int rx = x();
        int ry = y();
        int rw = width();
        int rh = height();

        // ── Draw container background (BEFORE clip/offset so it stays fixed) ──
        RECT bgRect = {
            cast(LONG)rx, cast(LONG)ry,
            cast(LONG)(rx + rw), cast(LONG)(ry + rh)
        };
        HBRUSH bgBrush = CreateSolidBrush(cast(COLORREF)0x00F8F8F8);
        FillRect(hdc, &bgRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // ── Save DC state before clipping/scrolling children ──
        int savedDC = SaveDC(hdc);

        // ── Clip to container bounds ──
        IntersectClipRect(hdc, rx, ry, rx + rw, ry + rh);

        // ── Apply scroll offset for children ──
        POINT oldOrigin;
        OffsetViewportOrgEx(hdc, 0, -_scrollY, &oldOrigin);

        // ── Render each visible child ──
        foreach (child; children())
        {
            if (child.visible())
            {
                child.renderWithGDI(hdc.Value);
            }
        }

        // ── Restore DC (removes clip rect and viewport offset) ──
        RestoreDC(hdc, savedDC);

        // ── Draw border ──
        HPEN borderPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00CCCCCC);
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)borderPen);
        HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));

        Rectangle(hdc, rx, ry, rx + rw, ry + rh);

        SelectObject(hdc, oldPen);
        SelectObject(hdc, oldBrush);
        DeleteObject(cast(HGDIOBJ)borderPen);

        // ── Draw scrollbar (on top, unclipped, after RestoreDC) ──
        if (needsScrollbar())
        {
            drawScrollbar(hdc, rx, ry, rw, rh);
        }
    }

    /// Draw a vertical scrollbar on the right side
    private void drawScrollbar(HDC hdc, int rx, int ry, int rw, int rh)
    {
        logTrace("ScrollableContainer.drawScrollbar() called — needsScrollbar=", needsScrollbar(),
                 " contentH=", _contentHeight, " viewH=", height(),
                 " thumbH=", _thumbHeight, " maxScroll=", maxScroll());
        int sbLeft = rx + rw - _scrollbarWidth;
        int sbTop = ry;
        int sbWidth = _scrollbarWidth;
        int sbHeight = rh;

        // ── Track background ──
        RECT trackRect = {
            cast(LONG)sbLeft, cast(LONG)sbTop,
            cast(LONG)(sbLeft + sbWidth), cast(LONG)(sbTop + sbHeight)
        };
        HBRUSH trackBrush = CreateSolidBrush(_trackColor);
        FillRect(hdc, &trackRect, trackBrush);
        DeleteObject(cast(HGDIOBJ)trackBrush);

        // ── Thumb ──
        if (_thumbHeight > 0 && maxScroll() > 0)
        {
            // Thumb position proportional to scroll progress
            float scrollRatio = cast(float)_scrollY / maxScroll();
            int availableTrack = sbHeight - _thumbHeight;
            int thumbTop = sbTop + cast(int)(availableTrack * scrollRatio);

            COLORREF thumb = _thumbHovered ? _thumbHover : _thumbColor;
            HBRUSH thumbBrush = CreateSolidBrush(thumb);
            RECT thumbRect = {
                cast(LONG)(sbLeft + 2), cast(LONG)thumbTop,
                cast(LONG)(sbLeft + sbWidth - 2), cast(LONG)(thumbTop + _thumbHeight)
            };
            FillRect(hdc, &thumbRect, thumbBrush);
            DeleteObject(cast(HGDIOBJ)thumbBrush);

            // ── Thumb border ──
            HPEN thumbPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00B0B0B0);
            HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)thumbPen);
            HGDIOBJ oldBrush2 = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));

            Rectangle(hdc, thumbRect.left, thumbRect.top, thumbRect.right, thumbRect.bottom);

            SelectObject(hdc, oldPen);
            SelectObject(hdc, oldBrush2);
            DeleteObject(cast(HGDIOBJ)thumbPen);
        }
    }

    override void render()
    {
    }
}

