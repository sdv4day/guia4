// Written in the D programming language.

module windows.win32.graphics.gdiplus;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, HINSTANCE, HRESULT, HWND, PSTR, PWSTR, RECT, RECTL, SIZE;
public import windows.win32.graphics.directdraw : IDirectDrawSurface7;
public import windows.win32.graphics.gdi : BITMAPINFO, HBITMAP, HDC, HENHMETAFILE, HMETAFILE, HPALETTE, HRGN, LOGFONTA,
                                           LOGFONTW, METAHEADER;
public import windows.win32.system.com : IStream, IUnknown;
public import windows.win32.ui.windowsandmessaging : HICON;

extern(Windows) @nogc nothrow:


// Enums


enum FillMode : int
{
    FillModeAlternate = 0x00000000,
    FillModeWinding   = 0x00000001,
}

enum QualityMode : int
{
    QualityModeInvalid = 0xffffffff,
    QualityModeDefault = 0x00000000,
    QualityModeLow     = 0x00000001,
    QualityModeHigh    = 0x00000002,
}

enum CompositingMode : int
{
    CompositingModeSourceOver = 0x00000000,
    CompositingModeSourceCopy = 0x00000001,
}

enum CompositingQuality : int
{
    CompositingQualityInvalid        = 0xffffffff,
    CompositingQualityDefault        = 0x00000000,
    CompositingQualityHighSpeed      = 0x00000001,
    CompositingQualityHighQuality    = 0x00000002,
    CompositingQualityGammaCorrected = 0x00000003,
    CompositingQualityAssumeLinear   = 0x00000004,
}

enum Unit : int
{
    UnitWorld      = 0x00000000,
    UnitDisplay    = 0x00000001,
    UnitPixel      = 0x00000002,
    UnitPoint      = 0x00000003,
    UnitInch       = 0x00000004,
    UnitDocument   = 0x00000005,
    UnitMillimeter = 0x00000006,
}

enum MetafileFrameUnit : int
{
    MetafileFrameUnitPixel      = 0x00000002,
    MetafileFrameUnitPoint      = 0x00000003,
    MetafileFrameUnitInch       = 0x00000004,
    MetafileFrameUnitDocument   = 0x00000005,
    MetafileFrameUnitMillimeter = 0x00000006,
    MetafileFrameUnitGdi        = 0x00000007,
}

enum CoordinateSpace : int
{
    CoordinateSpaceWorld  = 0x00000000,
    CoordinateSpacePage   = 0x00000001,
    CoordinateSpaceDevice = 0x00000002,
}

enum WrapMode : int
{
    WrapModeTile       = 0x00000000,
    WrapModeTileFlipX  = 0x00000001,
    WrapModeTileFlipY  = 0x00000002,
    WrapModeTileFlipXY = 0x00000003,
    WrapModeClamp      = 0x00000004,
}

enum HatchStyle : int
{
    HatchStyleHorizontal             = 0x00000000,
    HatchStyleVertical               = 0x00000001,
    HatchStyleForwardDiagonal        = 0x00000002,
    HatchStyleBackwardDiagonal       = 0x00000003,
    HatchStyleCross                  = 0x00000004,
    HatchStyleDiagonalCross          = 0x00000005,
    HatchStyle05Percent              = 0x00000006,
    HatchStyle10Percent              = 0x00000007,
    HatchStyle20Percent              = 0x00000008,
    HatchStyle25Percent              = 0x00000009,
    HatchStyle30Percent              = 0x0000000a,
    HatchStyle40Percent              = 0x0000000b,
    HatchStyle50Percent              = 0x0000000c,
    HatchStyle60Percent              = 0x0000000d,
    HatchStyle70Percent              = 0x0000000e,
    HatchStyle75Percent              = 0x0000000f,
    HatchStyle80Percent              = 0x00000010,
    HatchStyle90Percent              = 0x00000011,
    HatchStyleLightDownwardDiagonal  = 0x00000012,
    HatchStyleLightUpwardDiagonal    = 0x00000013,
    HatchStyleDarkDownwardDiagonal   = 0x00000014,
    HatchStyleDarkUpwardDiagonal     = 0x00000015,
    HatchStyleWideDownwardDiagonal   = 0x00000016,
    HatchStyleWideUpwardDiagonal     = 0x00000017,
    HatchStyleLightVertical          = 0x00000018,
    HatchStyleLightHorizontal        = 0x00000019,
    HatchStyleNarrowVertical         = 0x0000001a,
    HatchStyleNarrowHorizontal       = 0x0000001b,
    HatchStyleDarkVertical           = 0x0000001c,
    HatchStyleDarkHorizontal         = 0x0000001d,
    HatchStyleDashedDownwardDiagonal = 0x0000001e,
    HatchStyleDashedUpwardDiagonal   = 0x0000001f,
    HatchStyleDashedHorizontal       = 0x00000020,
    HatchStyleDashedVertical         = 0x00000021,
    HatchStyleSmallConfetti          = 0x00000022,
    HatchStyleLargeConfetti          = 0x00000023,
    HatchStyleZigZag                 = 0x00000024,
    HatchStyleWave                   = 0x00000025,
    HatchStyleDiagonalBrick          = 0x00000026,
    HatchStyleHorizontalBrick        = 0x00000027,
    HatchStyleWeave                  = 0x00000028,
    HatchStylePlaid                  = 0x00000029,
    HatchStyleDivot                  = 0x0000002a,
    HatchStyleDottedGrid             = 0x0000002b,
    HatchStyleDottedDiamond          = 0x0000002c,
    HatchStyleShingle                = 0x0000002d,
    HatchStyleTrellis                = 0x0000002e,
    HatchStyleSphere                 = 0x0000002f,
    HatchStyleSmallGrid              = 0x00000030,
    HatchStyleSmallCheckerBoard      = 0x00000031,
    HatchStyleLargeCheckerBoard      = 0x00000032,
    HatchStyleOutlinedDiamond        = 0x00000033,
    HatchStyleSolidDiamond           = 0x00000034,
    HatchStyleTotal                  = 0x00000035,
    HatchStyleLargeGrid              = 0x00000004,
    HatchStyleMin                    = 0x00000000,
    HatchStyleMax                    = 0x00000034,
}

enum DashStyle : int
{
    DashStyleSolid      = 0x00000000,
    DashStyleDash       = 0x00000001,
    DashStyleDot        = 0x00000002,
    DashStyleDashDot    = 0x00000003,
    DashStyleDashDotDot = 0x00000004,
    DashStyleCustom     = 0x00000005,
}

enum DashCap : int
{
    DashCapFlat     = 0x00000000,
    DashCapRound    = 0x00000002,
    DashCapTriangle = 0x00000003,
}

enum LineCap : int
{
    LineCapFlat          = 0x00000000,
    LineCapSquare        = 0x00000001,
    LineCapRound         = 0x00000002,
    LineCapTriangle      = 0x00000003,
    LineCapNoAnchor      = 0x00000010,
    LineCapSquareAnchor  = 0x00000011,
    LineCapRoundAnchor   = 0x00000012,
    LineCapDiamondAnchor = 0x00000013,
    LineCapArrowAnchor   = 0x00000014,
    LineCapCustom        = 0x000000ff,
    LineCapAnchorMask    = 0x000000f0,
}

enum CustomLineCapType : int
{
    CustomLineCapTypeDefault         = 0x00000000,
    CustomLineCapTypeAdjustableArrow = 0x00000001,
}

enum LineJoin : int
{
    LineJoinMiter        = 0x00000000,
    LineJoinBevel        = 0x00000001,
    LineJoinRound        = 0x00000002,
    LineJoinMiterClipped = 0x00000003,
}

enum PathPointType : int
{
    PathPointTypeStart        = 0x00000000,
    PathPointTypeLine         = 0x00000001,
    PathPointTypeBezier       = 0x00000003,
    PathPointTypePathTypeMask = 0x00000007,
    PathPointTypeDashMode     = 0x00000010,
    PathPointTypePathMarker   = 0x00000020,
    PathPointTypeCloseSubpath = 0x00000080,
    PathPointTypeBezier3      = 0x00000003,
}

enum WarpMode : int
{
    WarpModePerspective = 0x00000000,
    WarpModeBilinear    = 0x00000001,
}

enum LinearGradientMode : int
{
    LinearGradientModeHorizontal       = 0x00000000,
    LinearGradientModeVertical         = 0x00000001,
    LinearGradientModeForwardDiagonal  = 0x00000002,
    LinearGradientModeBackwardDiagonal = 0x00000003,
}

enum CombineMode : int
{
    CombineModeReplace    = 0x00000000,
    CombineModeIntersect  = 0x00000001,
    CombineModeUnion      = 0x00000002,
    CombineModeXor        = 0x00000003,
    CombineModeExclude    = 0x00000004,
    CombineModeComplement = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/tablet/imagetype-complex-type))], [])

enum ImageType : int
{
    ImageTypeUnknown  = 0x00000000,
    ImageTypeBitmap   = 0x00000001,
    ImageTypeMetafile = 0x00000002,
}

enum InterpolationMode : int
{
    InterpolationModeInvalid             = 0xffffffff,
    InterpolationModeDefault             = 0x00000000,
    InterpolationModeLowQuality          = 0x00000001,
    InterpolationModeHighQuality         = 0x00000002,
    InterpolationModeBilinear            = 0x00000003,
    InterpolationModeBicubic             = 0x00000004,
    InterpolationModeNearestNeighbor     = 0x00000005,
    InterpolationModeHighQualityBilinear = 0x00000006,
    InterpolationModeHighQualityBicubic  = 0x00000007,
}

enum PenAlignment : int
{
    PenAlignmentCenter = 0x00000000,
    PenAlignmentInset  = 0x00000001,
}

enum BrushType : int
{
    BrushTypeSolidColor     = 0x00000000,
    BrushTypeHatchFill      = 0x00000001,
    BrushTypeTextureFill    = 0x00000002,
    BrushTypePathGradient   = 0x00000003,
    BrushTypeLinearGradient = 0x00000004,
}

enum PenType : int
{
    PenTypeSolidColor     = 0x00000000,
    PenTypeHatchFill      = 0x00000001,
    PenTypeTextureFill    = 0x00000002,
    PenTypePathGradient   = 0x00000003,
    PenTypeLinearGradient = 0x00000004,
    PenTypeUnknown        = 0xffffffff,
}

enum MatrixOrder : int
{
    MatrixOrderPrepend = 0x00000000,
    MatrixOrderAppend  = 0x00000001,
}

enum GenericFontFamily : int
{
    GenericFontFamilySerif     = 0x00000000,
    GenericFontFamilySansSerif = 0x00000001,
    GenericFontFamilyMonospace = 0x00000002,
}

enum FontStyle : int
{
    FontStyleRegular    = 0x00000000,
    FontStyleBold       = 0x00000001,
    FontStyleItalic     = 0x00000002,
    FontStyleBoldItalic = 0x00000003,
    FontStyleUnderline  = 0x00000004,
    FontStyleStrikeout  = 0x00000008,
}

enum SmoothingMode : int
{
    SmoothingModeInvalid      = 0xffffffff,
    SmoothingModeDefault      = 0x00000000,
    SmoothingModeHighSpeed    = 0x00000001,
    SmoothingModeHighQuality  = 0x00000002,
    SmoothingModeNone         = 0x00000003,
    SmoothingModeAntiAlias    = 0x00000004,
    SmoothingModeAntiAlias8x4 = 0x00000004,
    SmoothingModeAntiAlias8x8 = 0x00000005,
}

enum PixelOffsetMode : int
{
    PixelOffsetModeInvalid     = 0xffffffff,
    PixelOffsetModeDefault     = 0x00000000,
    PixelOffsetModeHighSpeed   = 0x00000001,
    PixelOffsetModeHighQuality = 0x00000002,
    PixelOffsetModeNone        = 0x00000003,
    PixelOffsetModeHalf        = 0x00000004,
}

enum TextRenderingHint : int
{
    TextRenderingHintSystemDefault            = 0x00000000,
    TextRenderingHintSingleBitPerPixelGridFit = 0x00000001,
    TextRenderingHintSingleBitPerPixel        = 0x00000002,
    TextRenderingHintAntiAliasGridFit         = 0x00000003,
    TextRenderingHintAntiAlias                = 0x00000004,
    TextRenderingHintClearTypeGridFit         = 0x00000005,
}

enum MetafileType : int
{
    MetafileTypeInvalid      = 0x00000000,
    MetafileTypeWmf          = 0x00000001,
    MetafileTypeWmfPlaceable = 0x00000002,
    MetafileTypeEmf          = 0x00000003,
    MetafileTypeEmfPlusOnly  = 0x00000004,
    MetafileTypeEmfPlusDual  = 0x00000005,
}

enum EmfType : int
{
    EmfTypeEmfOnly     = 0x00000003,
    EmfTypeEmfPlusOnly = 0x00000004,
    EmfTypeEmfPlusDual = 0x00000005,
}

enum ObjectType : int
{
    ObjectTypeInvalid         = 0x00000000,
    ObjectTypeBrush           = 0x00000001,
    ObjectTypePen             = 0x00000002,
    ObjectTypePath            = 0x00000003,
    ObjectTypeRegion          = 0x00000004,
    ObjectTypeImage           = 0x00000005,
    ObjectTypeFont            = 0x00000006,
    ObjectTypeStringFormat    = 0x00000007,
    ObjectTypeImageAttributes = 0x00000008,
    ObjectTypeCustomLineCap   = 0x00000009,
    ObjectTypeGraphics        = 0x0000000a,
    ObjectTypeMax             = 0x0000000a,
    ObjectTypeMin             = 0x00000001,
}

enum EmfPlusRecordType : int
{
    WmfRecordTypeSetBkColor                  = 0x00010201,
    WmfRecordTypeSetBkMode                   = 0x00010102,
    WmfRecordTypeSetMapMode                  = 0x00010103,
    WmfRecordTypeSetROP2                     = 0x00010104,
    WmfRecordTypeSetRelAbs                   = 0x00010105,
    WmfRecordTypeSetPolyFillMode             = 0x00010106,
    WmfRecordTypeSetStretchBltMode           = 0x00010107,
    WmfRecordTypeSetTextCharExtra            = 0x00010108,
    WmfRecordTypeSetTextColor                = 0x00010209,
    WmfRecordTypeSetTextJustification        = 0x0001020a,
    WmfRecordTypeSetWindowOrg                = 0x0001020b,
    WmfRecordTypeSetWindowExt                = 0x0001020c,
    WmfRecordTypeSetViewportOrg              = 0x0001020d,
    WmfRecordTypeSetViewportExt              = 0x0001020e,
    WmfRecordTypeOffsetWindowOrg             = 0x0001020f,
    WmfRecordTypeScaleWindowExt              = 0x00010410,
    WmfRecordTypeOffsetViewportOrg           = 0x00010211,
    WmfRecordTypeScaleViewportExt            = 0x00010412,
    WmfRecordTypeLineTo                      = 0x00010213,
    WmfRecordTypeMoveTo                      = 0x00010214,
    WmfRecordTypeExcludeClipRect             = 0x00010415,
    WmfRecordTypeIntersectClipRect           = 0x00010416,
    WmfRecordTypeArc                         = 0x00010817,
    WmfRecordTypeEllipse                     = 0x00010418,
    WmfRecordTypeFloodFill                   = 0x00010419,
    WmfRecordTypePie                         = 0x0001081a,
    WmfRecordTypeRectangle                   = 0x0001041b,
    WmfRecordTypeRoundRect                   = 0x0001061c,
    WmfRecordTypePatBlt                      = 0x0001061d,
    WmfRecordTypeSaveDC                      = 0x0001001e,
    WmfRecordTypeSetPixel                    = 0x0001041f,
    WmfRecordTypeOffsetClipRgn               = 0x00010220,
    WmfRecordTypeTextOut                     = 0x00010521,
    WmfRecordTypeBitBlt                      = 0x00010922,
    WmfRecordTypeStretchBlt                  = 0x00010b23,
    WmfRecordTypePolygon                     = 0x00010324,
    WmfRecordTypePolyline                    = 0x00010325,
    WmfRecordTypeEscape                      = 0x00010626,
    WmfRecordTypeRestoreDC                   = 0x00010127,
    WmfRecordTypeFillRegion                  = 0x00010228,
    WmfRecordTypeFrameRegion                 = 0x00010429,
    WmfRecordTypeInvertRegion                = 0x0001012a,
    WmfRecordTypePaintRegion                 = 0x0001012b,
    WmfRecordTypeSelectClipRegion            = 0x0001012c,
    WmfRecordTypeSelectObject                = 0x0001012d,
    WmfRecordTypeSetTextAlign                = 0x0001012e,
    WmfRecordTypeDrawText                    = 0x0001062f,
    WmfRecordTypeChord                       = 0x00010830,
    WmfRecordTypeSetMapperFlags              = 0x00010231,
    WmfRecordTypeExtTextOut                  = 0x00010a32,
    WmfRecordTypeSetDIBToDev                 = 0x00010d33,
    WmfRecordTypeSelectPalette               = 0x00010234,
    WmfRecordTypeRealizePalette              = 0x00010035,
    WmfRecordTypeAnimatePalette              = 0x00010436,
    WmfRecordTypeSetPalEntries               = 0x00010037,
    WmfRecordTypePolyPolygon                 = 0x00010538,
    WmfRecordTypeResizePalette               = 0x00010139,
    WmfRecordTypeDIBBitBlt                   = 0x00010940,
    WmfRecordTypeDIBStretchBlt               = 0x00010b41,
    WmfRecordTypeDIBCreatePatternBrush       = 0x00010142,
    WmfRecordTypeStretchDIB                  = 0x00010f43,
    WmfRecordTypeExtFloodFill                = 0x00010548,
    WmfRecordTypeSetLayout                   = 0x00010149,
    WmfRecordTypeResetDC                     = 0x0001014c,
    WmfRecordTypeStartDoc                    = 0x0001014d,
    WmfRecordTypeStartPage                   = 0x0001004f,
    WmfRecordTypeEndPage                     = 0x00010050,
    WmfRecordTypeAbortDoc                    = 0x00010052,
    WmfRecordTypeEndDoc                      = 0x0001005e,
    WmfRecordTypeDeleteObject                = 0x000101f0,
    WmfRecordTypeCreatePalette               = 0x000100f7,
    WmfRecordTypeCreateBrush                 = 0x000100f8,
    WmfRecordTypeCreatePatternBrush          = 0x000101f9,
    WmfRecordTypeCreatePenIndirect           = 0x000102fa,
    WmfRecordTypeCreateFontIndirect          = 0x000102fb,
    WmfRecordTypeCreateBrushIndirect         = 0x000102fc,
    WmfRecordTypeCreateBitmapIndirect        = 0x000102fd,
    WmfRecordTypeCreateBitmap                = 0x000106fe,
    WmfRecordTypeCreateRegion                = 0x000106ff,
    EmfRecordTypeHeader                      = 0x00000001,
    EmfRecordTypePolyBezier                  = 0x00000002,
    EmfRecordTypePolygon                     = 0x00000003,
    EmfRecordTypePolyline                    = 0x00000004,
    EmfRecordTypePolyBezierTo                = 0x00000005,
    EmfRecordTypePolyLineTo                  = 0x00000006,
    EmfRecordTypePolyPolyline                = 0x00000007,
    EmfRecordTypePolyPolygon                 = 0x00000008,
    EmfRecordTypeSetWindowExtEx              = 0x00000009,
    EmfRecordTypeSetWindowOrgEx              = 0x0000000a,
    EmfRecordTypeSetViewportExtEx            = 0x0000000b,
    EmfRecordTypeSetViewportOrgEx            = 0x0000000c,
    EmfRecordTypeSetBrushOrgEx               = 0x0000000d,
    EmfRecordTypeEOF                         = 0x0000000e,
    EmfRecordTypeSetPixelV                   = 0x0000000f,
    EmfRecordTypeSetMapperFlags              = 0x00000010,
    EmfRecordTypeSetMapMode                  = 0x00000011,
    EmfRecordTypeSetBkMode                   = 0x00000012,
    EmfRecordTypeSetPolyFillMode             = 0x00000013,
    EmfRecordTypeSetROP2                     = 0x00000014,
    EmfRecordTypeSetStretchBltMode           = 0x00000015,
    EmfRecordTypeSetTextAlign                = 0x00000016,
    EmfRecordTypeSetColorAdjustment          = 0x00000017,
    EmfRecordTypeSetTextColor                = 0x00000018,
    EmfRecordTypeSetBkColor                  = 0x00000019,
    EmfRecordTypeOffsetClipRgn               = 0x0000001a,
    EmfRecordTypeMoveToEx                    = 0x0000001b,
    EmfRecordTypeSetMetaRgn                  = 0x0000001c,
    EmfRecordTypeExcludeClipRect             = 0x0000001d,
    EmfRecordTypeIntersectClipRect           = 0x0000001e,
    EmfRecordTypeScaleViewportExtEx          = 0x0000001f,
    EmfRecordTypeScaleWindowExtEx            = 0x00000020,
    EmfRecordTypeSaveDC                      = 0x00000021,
    EmfRecordTypeRestoreDC                   = 0x00000022,
    EmfRecordTypeSetWorldTransform           = 0x00000023,
    EmfRecordTypeModifyWorldTransform        = 0x00000024,
    EmfRecordTypeSelectObject                = 0x00000025,
    EmfRecordTypeCreatePen                   = 0x00000026,
    EmfRecordTypeCreateBrushIndirect         = 0x00000027,
    EmfRecordTypeDeleteObject                = 0x00000028,
    EmfRecordTypeAngleArc                    = 0x00000029,
    EmfRecordTypeEllipse                     = 0x0000002a,
    EmfRecordTypeRectangle                   = 0x0000002b,
    EmfRecordTypeRoundRect                   = 0x0000002c,
    EmfRecordTypeArc                         = 0x0000002d,
    EmfRecordTypeChord                       = 0x0000002e,
    EmfRecordTypePie                         = 0x0000002f,
    EmfRecordTypeSelectPalette               = 0x00000030,
    EmfRecordTypeCreatePalette               = 0x00000031,
    EmfRecordTypeSetPaletteEntries           = 0x00000032,
    EmfRecordTypeResizePalette               = 0x00000033,
    EmfRecordTypeRealizePalette              = 0x00000034,
    EmfRecordTypeExtFloodFill                = 0x00000035,
    EmfRecordTypeLineTo                      = 0x00000036,
    EmfRecordTypeArcTo                       = 0x00000037,
    EmfRecordTypePolyDraw                    = 0x00000038,
    EmfRecordTypeSetArcDirection             = 0x00000039,
    EmfRecordTypeSetMiterLimit               = 0x0000003a,
    EmfRecordTypeBeginPath                   = 0x0000003b,
    EmfRecordTypeEndPath                     = 0x0000003c,
    EmfRecordTypeCloseFigure                 = 0x0000003d,
    EmfRecordTypeFillPath                    = 0x0000003e,
    EmfRecordTypeStrokeAndFillPath           = 0x0000003f,
    EmfRecordTypeStrokePath                  = 0x00000040,
    EmfRecordTypeFlattenPath                 = 0x00000041,
    EmfRecordTypeWidenPath                   = 0x00000042,
    EmfRecordTypeSelectClipPath              = 0x00000043,
    EmfRecordTypeAbortPath                   = 0x00000044,
    EmfRecordTypeReserved_069                = 0x00000045,
    EmfRecordTypeGdiComment                  = 0x00000046,
    EmfRecordTypeFillRgn                     = 0x00000047,
    EmfRecordTypeFrameRgn                    = 0x00000048,
    EmfRecordTypeInvertRgn                   = 0x00000049,
    EmfRecordTypePaintRgn                    = 0x0000004a,
    EmfRecordTypeExtSelectClipRgn            = 0x0000004b,
    EmfRecordTypeBitBlt                      = 0x0000004c,
    EmfRecordTypeStretchBlt                  = 0x0000004d,
    EmfRecordTypeMaskBlt                     = 0x0000004e,
    EmfRecordTypePlgBlt                      = 0x0000004f,
    EmfRecordTypeSetDIBitsToDevice           = 0x00000050,
    EmfRecordTypeStretchDIBits               = 0x00000051,
    EmfRecordTypeExtCreateFontIndirect       = 0x00000052,
    EmfRecordTypeExtTextOutA                 = 0x00000053,
    EmfRecordTypeExtTextOutW                 = 0x00000054,
    EmfRecordTypePolyBezier16                = 0x00000055,
    EmfRecordTypePolygon16                   = 0x00000056,
    EmfRecordTypePolyline16                  = 0x00000057,
    EmfRecordTypePolyBezierTo16              = 0x00000058,
    EmfRecordTypePolylineTo16                = 0x00000059,
    EmfRecordTypePolyPolyline16              = 0x0000005a,
    EmfRecordTypePolyPolygon16               = 0x0000005b,
    EmfRecordTypePolyDraw16                  = 0x0000005c,
    EmfRecordTypeCreateMonoBrush             = 0x0000005d,
    EmfRecordTypeCreateDIBPatternBrushPt     = 0x0000005e,
    EmfRecordTypeExtCreatePen                = 0x0000005f,
    EmfRecordTypePolyTextOutA                = 0x00000060,
    EmfRecordTypePolyTextOutW                = 0x00000061,
    EmfRecordTypeSetICMMode                  = 0x00000062,
    EmfRecordTypeCreateColorSpace            = 0x00000063,
    EmfRecordTypeSetColorSpace               = 0x00000064,
    EmfRecordTypeDeleteColorSpace            = 0x00000065,
    EmfRecordTypeGLSRecord                   = 0x00000066,
    EmfRecordTypeGLSBoundedRecord            = 0x00000067,
    EmfRecordTypePixelFormat                 = 0x00000068,
    EmfRecordTypeDrawEscape                  = 0x00000069,
    EmfRecordTypeExtEscape                   = 0x0000006a,
    EmfRecordTypeStartDoc                    = 0x0000006b,
    EmfRecordTypeSmallTextOut                = 0x0000006c,
    EmfRecordTypeForceUFIMapping             = 0x0000006d,
    EmfRecordTypeNamedEscape                 = 0x0000006e,
    EmfRecordTypeColorCorrectPalette         = 0x0000006f,
    EmfRecordTypeSetICMProfileA              = 0x00000070,
    EmfRecordTypeSetICMProfileW              = 0x00000071,
    EmfRecordTypeAlphaBlend                  = 0x00000072,
    EmfRecordTypeSetLayout                   = 0x00000073,
    EmfRecordTypeTransparentBlt              = 0x00000074,
    EmfRecordTypeReserved_117                = 0x00000075,
    EmfRecordTypeGradientFill                = 0x00000076,
    EmfRecordTypeSetLinkedUFIs               = 0x00000077,
    EmfRecordTypeSetTextJustification        = 0x00000078,
    EmfRecordTypeColorMatchToTargetW         = 0x00000079,
    EmfRecordTypeCreateColorSpaceW           = 0x0000007a,
    EmfRecordTypeMax                         = 0x0000007a,
    EmfRecordTypeMin                         = 0x00000001,
    EmfPlusRecordTypeInvalid                 = 0x00004000,
    EmfPlusRecordTypeHeader                  = 0x00004001,
    EmfPlusRecordTypeEndOfFile               = 0x00004002,
    EmfPlusRecordTypeComment                 = 0x00004003,
    EmfPlusRecordTypeGetDC                   = 0x00004004,
    EmfPlusRecordTypeMultiFormatStart        = 0x00004005,
    EmfPlusRecordTypeMultiFormatSection      = 0x00004006,
    EmfPlusRecordTypeMultiFormatEnd          = 0x00004007,
    EmfPlusRecordTypeObject                  = 0x00004008,
    EmfPlusRecordTypeClear                   = 0x00004009,
    EmfPlusRecordTypeFillRects               = 0x0000400a,
    EmfPlusRecordTypeDrawRects               = 0x0000400b,
    EmfPlusRecordTypeFillPolygon             = 0x0000400c,
    EmfPlusRecordTypeDrawLines               = 0x0000400d,
    EmfPlusRecordTypeFillEllipse             = 0x0000400e,
    EmfPlusRecordTypeDrawEllipse             = 0x0000400f,
    EmfPlusRecordTypeFillPie                 = 0x00004010,
    EmfPlusRecordTypeDrawPie                 = 0x00004011,
    EmfPlusRecordTypeDrawArc                 = 0x00004012,
    EmfPlusRecordTypeFillRegion              = 0x00004013,
    EmfPlusRecordTypeFillPath                = 0x00004014,
    EmfPlusRecordTypeDrawPath                = 0x00004015,
    EmfPlusRecordTypeFillClosedCurve         = 0x00004016,
    EmfPlusRecordTypeDrawClosedCurve         = 0x00004017,
    EmfPlusRecordTypeDrawCurve               = 0x00004018,
    EmfPlusRecordTypeDrawBeziers             = 0x00004019,
    EmfPlusRecordTypeDrawImage               = 0x0000401a,
    EmfPlusRecordTypeDrawImagePoints         = 0x0000401b,
    EmfPlusRecordTypeDrawString              = 0x0000401c,
    EmfPlusRecordTypeSetRenderingOrigin      = 0x0000401d,
    EmfPlusRecordTypeSetAntiAliasMode        = 0x0000401e,
    EmfPlusRecordTypeSetTextRenderingHint    = 0x0000401f,
    EmfPlusRecordTypeSetTextContrast         = 0x00004020,
    EmfPlusRecordTypeSetInterpolationMode    = 0x00004021,
    EmfPlusRecordTypeSetPixelOffsetMode      = 0x00004022,
    EmfPlusRecordTypeSetCompositingMode      = 0x00004023,
    EmfPlusRecordTypeSetCompositingQuality   = 0x00004024,
    EmfPlusRecordTypeSave                    = 0x00004025,
    EmfPlusRecordTypeRestore                 = 0x00004026,
    EmfPlusRecordTypeBeginContainer          = 0x00004027,
    EmfPlusRecordTypeBeginContainerNoParams  = 0x00004028,
    EmfPlusRecordTypeEndContainer            = 0x00004029,
    EmfPlusRecordTypeSetWorldTransform       = 0x0000402a,
    EmfPlusRecordTypeResetWorldTransform     = 0x0000402b,
    EmfPlusRecordTypeMultiplyWorldTransform  = 0x0000402c,
    EmfPlusRecordTypeTranslateWorldTransform = 0x0000402d,
    EmfPlusRecordTypeScaleWorldTransform     = 0x0000402e,
    EmfPlusRecordTypeRotateWorldTransform    = 0x0000402f,
    EmfPlusRecordTypeSetPageTransform        = 0x00004030,
    EmfPlusRecordTypeResetClip               = 0x00004031,
    EmfPlusRecordTypeSetClipRect             = 0x00004032,
    EmfPlusRecordTypeSetClipPath             = 0x00004033,
    EmfPlusRecordTypeSetClipRegion           = 0x00004034,
    EmfPlusRecordTypeOffsetClip              = 0x00004035,
    EmfPlusRecordTypeDrawDriverString        = 0x00004036,
    EmfPlusRecordTypeStrokeFillPath          = 0x00004037,
    EmfPlusRecordTypeSerializableObject      = 0x00004038,
    EmfPlusRecordTypeSetTSGraphics           = 0x00004039,
    EmfPlusRecordTypeSetTSClip               = 0x0000403a,
    EmfPlusRecordTotal                       = 0x0000403b,
    EmfPlusRecordTypeMax                     = 0x0000403a,
    EmfPlusRecordTypeMin                     = 0x00004001,
}

enum StringFormatFlags : int
{
    StringFormatFlagsDirectionRightToLeft  = 0x00000001,
    StringFormatFlagsDirectionVertical     = 0x00000002,
    StringFormatFlagsNoFitBlackBox         = 0x00000004,
    StringFormatFlagsDisplayFormatControl  = 0x00000020,
    StringFormatFlagsNoFontFallback        = 0x00000400,
    StringFormatFlagsMeasureTrailingSpaces = 0x00000800,
    StringFormatFlagsNoWrap                = 0x00001000,
    StringFormatFlagsLineLimit             = 0x00002000,
    StringFormatFlagsNoClip                = 0x00004000,
    StringFormatFlagsBypassGDI             = 0x80000000,
}

enum StringTrimming : int
{
    StringTrimmingNone              = 0x00000000,
    StringTrimmingCharacter         = 0x00000001,
    StringTrimmingWord              = 0x00000002,
    StringTrimmingEllipsisCharacter = 0x00000003,
    StringTrimmingEllipsisWord      = 0x00000004,
    StringTrimmingEllipsisPath      = 0x00000005,
}

enum StringDigitSubstitute : int
{
    StringDigitSubstituteUser        = 0x00000000,
    StringDigitSubstituteNone        = 0x00000001,
    StringDigitSubstituteNational    = 0x00000002,
    StringDigitSubstituteTraditional = 0x00000003,
}

enum HotkeyPrefix : int
{
    HotkeyPrefixNone = 0x00000000,
    HotkeyPrefixShow = 0x00000001,
    HotkeyPrefixHide = 0x00000002,
}

enum StringAlignment : int
{
    StringAlignmentNear   = 0x00000000,
    StringAlignmentCenter = 0x00000001,
    StringAlignmentFar    = 0x00000002,
}

enum DriverStringOptions : int
{
    DriverStringOptionsCmapLookup      = 0x00000001,
    DriverStringOptionsVertical        = 0x00000002,
    DriverStringOptionsRealizedAdvance = 0x00000004,
    DriverStringOptionsLimitSubpixel   = 0x00000008,
}

enum FlushIntention : int
{
    FlushIntentionFlush = 0x00000000,
    FlushIntentionSync  = 0x00000001,
}

enum EncoderParameterValueType : int
{
    EncoderParameterValueTypeByte          = 0x00000001,
    EncoderParameterValueTypeASCII         = 0x00000002,
    EncoderParameterValueTypeShort         = 0x00000003,
    EncoderParameterValueTypeLong          = 0x00000004,
    EncoderParameterValueTypeRational      = 0x00000005,
    EncoderParameterValueTypeLongRange     = 0x00000006,
    EncoderParameterValueTypeUndefined     = 0x00000007,
    EncoderParameterValueTypeRationalRange = 0x00000008,
    EncoderParameterValueTypePointer       = 0x00000009,
}

enum EncoderValue : int
{
    EncoderValueColorTypeCMYK            = 0x00000000,
    EncoderValueColorTypeYCCK            = 0x00000001,
    EncoderValueCompressionLZW           = 0x00000002,
    EncoderValueCompressionCCITT3        = 0x00000003,
    EncoderValueCompressionCCITT4        = 0x00000004,
    EncoderValueCompressionRle           = 0x00000005,
    EncoderValueCompressionNone          = 0x00000006,
    EncoderValueScanMethodInterlaced     = 0x00000007,
    EncoderValueScanMethodNonInterlaced  = 0x00000008,
    EncoderValueVersionGif87             = 0x00000009,
    EncoderValueVersionGif89             = 0x0000000a,
    EncoderValueRenderProgressive        = 0x0000000b,
    EncoderValueRenderNonProgressive     = 0x0000000c,
    EncoderValueTransformRotate90        = 0x0000000d,
    EncoderValueTransformRotate180       = 0x0000000e,
    EncoderValueTransformRotate270       = 0x0000000f,
    EncoderValueTransformFlipHorizontal  = 0x00000010,
    EncoderValueTransformFlipVertical    = 0x00000011,
    EncoderValueMultiFrame               = 0x00000012,
    EncoderValueLastFrame                = 0x00000013,
    EncoderValueFlush                    = 0x00000014,
    EncoderValueFrameDimensionTime       = 0x00000015,
    EncoderValueFrameDimensionResolution = 0x00000016,
    EncoderValueFrameDimensionPage       = 0x00000017,
    EncoderValueColorTypeGray            = 0x00000018,
    EncoderValueColorTypeRGB             = 0x00000019,
}

enum EmfToWmfBitsFlags : int
{
    EmfToWmfBitsFlagsDefault          = 0x00000000,
    EmfToWmfBitsFlagsEmbedEmf         = 0x00000001,
    EmfToWmfBitsFlagsIncludePlaceable = 0x00000002,
    EmfToWmfBitsFlagsNoXORClip        = 0x00000004,
}

enum ConvertToEmfPlusFlags : int
{
    ConvertToEmfPlusFlagsDefault       = 0x00000000,
    ConvertToEmfPlusFlagsRopUsed       = 0x00000001,
    ConvertToEmfPlusFlagsText          = 0x00000002,
    ConvertToEmfPlusFlagsInvalidRecord = 0x00000004,
}

enum GpTestControlEnum : int
{
    TestControlForceBilinear  = 0x00000000,
    TestControlNoICM          = 0x00000001,
    TestControlGetBuildNumber = 0x00000002,
}

enum Status : int
{
    Ok                        = 0x00000000,
    GenericError              = 0x00000001,
    InvalidParameter          = 0x00000002,
    OutOfMemory               = 0x00000003,
    ObjectBusy                = 0x00000004,
    InsufficientBuffer        = 0x00000005,
    NotImplemented            = 0x00000006,
    Win32Error                = 0x00000007,
    WrongState                = 0x00000008,
    Aborted                   = 0x00000009,
    FileNotFound              = 0x0000000a,
    ValueOverflow             = 0x0000000b,
    AccessDenied              = 0x0000000c,
    UnknownImageFormat        = 0x0000000d,
    FontFamilyNotFound        = 0x0000000e,
    FontStyleNotFound         = 0x0000000f,
    NotTrueTypeFont           = 0x00000010,
    UnsupportedGdiplusVersion = 0x00000011,
    GdiplusNotInitialized     = 0x00000012,
    PropertyNotFound          = 0x00000013,
    PropertyNotSupported      = 0x00000014,
    ProfileNotFound           = 0x00000015,
}

enum DebugEventLevel : int
{
    DebugEventLevelFatal   = 0x00000000,
    DebugEventLevelWarning = 0x00000001,
}

enum Version : uint
{
    V2      = 0x00000002,
    V3      = 0x00000003,
}

enum GdiplusStartupParams : int
{
    GdiplusStartupDefault          = 0x00000000,
    GdiplusStartupNoSetRound       = 0x00000001,
    GdiplusStartupSetPSValue       = 0x00000002,
    GdiplusStartupReserved0        = 0x00000004,
    GdiplusStartupReserved1        = 0x00000008,
    GdiplusStartupReserved2        = 0x00000010,
    GdiplusStartupTransparencyMask = 0xff000000,
}

enum PaletteType : int
{
    PaletteTypeCustom           = 0x00000000,
    PaletteTypeOptimal          = 0x00000001,
    PaletteTypeFixedBW          = 0x00000002,
    PaletteTypeFixedHalftone8   = 0x00000003,
    PaletteTypeFixedHalftone27  = 0x00000004,
    PaletteTypeFixedHalftone64  = 0x00000005,
    PaletteTypeFixedHalftone125 = 0x00000006,
    PaletteTypeFixedHalftone216 = 0x00000007,
    PaletteTypeFixedHalftone252 = 0x00000008,
    PaletteTypeFixedHalftone256 = 0x00000009,
}

enum DitherType : int
{
    DitherTypeNone           = 0x00000000,
    DitherTypeSolid          = 0x00000001,
    DitherTypeOrdered4x4     = 0x00000002,
    DitherTypeOrdered8x8     = 0x00000003,
    DitherTypeOrdered16x16   = 0x00000004,
    DitherTypeSpiral4x4      = 0x00000005,
    DitherTypeSpiral8x8      = 0x00000006,
    DitherTypeDualSpiral4x4  = 0x00000007,
    DitherTypeDualSpiral8x8  = 0x00000008,
    DitherTypeErrorDiffusion = 0x00000009,
    DitherTypeMax            = 0x0000000a,
}

enum PaletteFlags : int
{
    PaletteFlagsHasAlpha  = 0x00000001,
    PaletteFlagsGrayScale = 0x00000002,
    PaletteFlagsHalftone  = 0x00000004,
}

enum ColorMode : int
{
    ColorModeARGB32 = 0x00000000,
    ColorModeARGB64 = 0x00000001,
}

enum ColorChannelFlags : int
{
    ColorChannelFlagsC    = 0x00000000,
    ColorChannelFlagsM    = 0x00000001,
    ColorChannelFlagsY    = 0x00000002,
    ColorChannelFlagsK    = 0x00000003,
    ColorChannelFlagsLast = 0x00000004,
}

enum ImageCodecFlags : int
{
    ImageCodecFlagsEncoder        = 0x00000001,
    ImageCodecFlagsDecoder        = 0x00000002,
    ImageCodecFlagsSupportBitmap  = 0x00000004,
    ImageCodecFlagsSupportVector  = 0x00000008,
    ImageCodecFlagsSeekableEncode = 0x00000010,
    ImageCodecFlagsBlockingDecode = 0x00000020,
    ImageCodecFlagsBuiltin        = 0x00010000,
    ImageCodecFlagsSystem         = 0x00020000,
    ImageCodecFlagsUser           = 0x00040000,
}

enum ImageLockMode : int
{
    ImageLockModeRead         = 0x00000001,
    ImageLockModeWrite        = 0x00000002,
    ImageLockModeUserInputBuf = 0x00000004,
}

enum ImageFlags : int
{
    ImageFlagsNone              = 0x00000000,
    ImageFlagsScalable          = 0x00000001,
    ImageFlagsHasAlpha          = 0x00000002,
    ImageFlagsHasTranslucent    = 0x00000004,
    ImageFlagsPartiallyScalable = 0x00000008,
    ImageFlagsColorSpaceRGB     = 0x00000010,
    ImageFlagsColorSpaceCMYK    = 0x00000020,
    ImageFlagsColorSpaceGRAY    = 0x00000040,
    ImageFlagsColorSpaceYCBCR   = 0x00000080,
    ImageFlagsColorSpaceYCCK    = 0x00000100,
    ImageFlagsHasRealDPI        = 0x00001000,
    ImageFlagsHasRealPixelSize  = 0x00002000,
    ImageFlagsReadOnly          = 0x00010000,
    ImageFlagsCaching           = 0x00020000,
}

enum RotateFlipType : int
{
    RotateNoneFlipNone = 0x00000000,
    Rotate90FlipNone   = 0x00000001,
    Rotate180FlipNone  = 0x00000002,
    Rotate270FlipNone  = 0x00000003,
    RotateNoneFlipX    = 0x00000004,
    Rotate90FlipX      = 0x00000005,
    Rotate180FlipX     = 0x00000006,
    Rotate270FlipX     = 0x00000007,
    RotateNoneFlipY    = 0x00000006,
    Rotate90FlipY      = 0x00000007,
    Rotate180FlipY     = 0x00000004,
    Rotate270FlipY     = 0x00000005,
    RotateNoneFlipXY   = 0x00000002,
    Rotate90FlipXY     = 0x00000003,
    Rotate180FlipXY    = 0x00000000,
    Rotate270FlipXY    = 0x00000001,
}

enum ItemDataPosition : int
{
    ItemDataPositionAfterHeader  = 0x00000000,
    ItemDataPositionAfterPalette = 0x00000001,
    ItemDataPositionAfterBits    = 0x00000002,
}

enum HistogramFormat : int
{
    HistogramFormatARGB  = 0x00000000,
    HistogramFormatPARGB = 0x00000001,
    HistogramFormatRGB   = 0x00000002,
    HistogramFormatGray  = 0x00000003,
    HistogramFormatB     = 0x00000004,
    HistogramFormatG     = 0x00000005,
    HistogramFormatR     = 0x00000006,
    HistogramFormatA     = 0x00000007,
}

enum ColorMatrixFlags : int
{
    ColorMatrixFlagsDefault   = 0x00000000,
    ColorMatrixFlagsSkipGrays = 0x00000001,
    ColorMatrixFlagsAltGray   = 0x00000002,
}

enum ColorAdjustType : int
{
    ColorAdjustTypeDefault = 0x00000000,
    ColorAdjustTypeBitmap  = 0x00000001,
    ColorAdjustTypeBrush   = 0x00000002,
    ColorAdjustTypePen     = 0x00000003,
    ColorAdjustTypeText    = 0x00000004,
    ColorAdjustTypeCount   = 0x00000005,
    ColorAdjustTypeAny     = 0x00000006,
}

enum CurveAdjustments : int
{
    AdjustExposure        = 0x00000000,
    AdjustDensity         = 0x00000001,
    AdjustContrast        = 0x00000002,
    AdjustHighlight       = 0x00000003,
    AdjustShadow          = 0x00000004,
    AdjustMidtone         = 0x00000005,
    AdjustWhiteSaturation = 0x00000006,
    AdjustBlackSaturation = 0x00000007,
}

enum CurveChannel : int
{
    CurveChannelAll   = 0x00000000,
    CurveChannelRed   = 0x00000001,
    CurveChannelGreen = 0x00000002,
    CurveChannelBlue  = 0x00000003,
}

// Constants


enum uint GDIP_EMFPLUS_RECORD_BASE = 0x00004000;

enum : uint
{
    PropertyTagTypeByte          = 0x00000001,
    PropertyTagTypeASCII         = 0x00000002,
    PropertyTagTypeShort         = 0x00000003,
    PropertyTagTypeLong          = 0x00000004,
    PropertyTagTypeRational      = 0x00000005,
    PropertyTagTypeUndefined     = 0x00000007,
    PropertyTagTypeSLONG         = 0x00000009,
    PropertyTagTypeSRational     = 0x0000000a,
    PropertyTagExifIFD           = 0x00008769,
    PropertyTagGpsIFD            = 0x00008825,
    PropertyTagNewSubfileType    = 0x000000fe,
    PropertyTagSubfileType       = 0x000000ff,
    PropertyTagImageWidth        = 0x00000100,
    PropertyTagImageHeight       = 0x00000101,
    PropertyTagBitsPerSample     = 0x00000102,
    PropertyTagCompression       = 0x00000103,
    PropertyTagPhotometricInterp = 0x00000106,
}

enum : uint
{
    PropertyTagCellWidth         = 0x00000108,
    PropertyTagCellHeight        = 0x00000109,
    PropertyTagFillOrder         = 0x0000010a,
    PropertyTagDocumentName      = 0x0000010d,
    PropertyTagImageDescription  = 0x0000010e,
    PropertyTagEquipMake         = 0x0000010f,
    PropertyTagEquipModel        = 0x00000110,
    PropertyTagStripOffsets      = 0x00000111,
    PropertyTagOrientation       = 0x00000112,
    PropertyTagSamplesPerPixel   = 0x00000115,
    PropertyTagRowsPerStrip      = 0x00000116,
    PropertyTagStripBytesCount   = 0x00000117,
    PropertyTagMinSampleValue    = 0x00000118,
    PropertyTagMaxSampleValue    = 0x00000119,
    PropertyTagXResolution       = 0x0000011a,
    PropertyTagYResolution       = 0x0000011b,
    PropertyTagPlanarConfig      = 0x0000011c,
    PropertyTagPageName          = 0x0000011d,
    PropertyTagXPosition         = 0x0000011e,
    PropertyTagYPosition         = 0x0000011f,
    PropertyTagFreeOffset        = 0x00000120,
    PropertyTagFreeByteCounts    = 0x00000121,
    PropertyTagGrayResponseUnit  = 0x00000122,
    PropertyTagGrayResponseCurve = 0x00000123,
}

enum : uint
{
    PropertyTagT6Option          = 0x00000125,
    PropertyTagResolutionUnit    = 0x00000128,
    PropertyTagPageNumber        = 0x00000129,
    PropertyTagTransferFuncition = 0x0000012d,
}

enum : uint
{
    PropertyTagDateTime              = 0x00000132,
    PropertyTagArtist                = 0x0000013b,
    PropertyTagHostComputer          = 0x0000013c,
    PropertyTagPredictor             = 0x0000013d,
    PropertyTagWhitePoint            = 0x0000013e,
    PropertyTagPrimaryChromaticities = 0x0000013f,
}

enum : uint
{
    PropertyTagHalftoneHints          = 0x00000141,
    PropertyTagTileWidth              = 0x00000142,
    PropertyTagTileLength             = 0x00000143,
    PropertyTagTileOffset             = 0x00000144,
    PropertyTagTileByteCounts         = 0x00000145,
    PropertyTagInkSet                 = 0x0000014c,
    PropertyTagInkNames               = 0x0000014d,
    PropertyTagNumberOfInks           = 0x0000014e,
    PropertyTagDotRange               = 0x00000150,
    PropertyTagTargetPrinter          = 0x00000151,
    PropertyTagExtraSamples           = 0x00000152,
    PropertyTagSampleFormat           = 0x00000153,
    PropertyTagSMinSampleValue        = 0x00000154,
    PropertyTagSMaxSampleValue        = 0x00000155,
    PropertyTagTransferRange          = 0x00000156,
    PropertyTagJPEGProc               = 0x00000200,
    PropertyTagJPEGInterFormat        = 0x00000201,
    PropertyTagJPEGInterLength        = 0x00000202,
    PropertyTagJPEGRestartInterval    = 0x00000203,
    PropertyTagJPEGLosslessPredictors = 0x00000205,
    PropertyTagJPEGPointTransforms    = 0x00000206,
    PropertyTagJPEGQTables            = 0x00000207,
    PropertyTagJPEGDCTables           = 0x00000208,
    PropertyTagJPEGACTables           = 0x00000209,
    PropertyTagYCbCrCoefficients      = 0x00000211,
    PropertyTagYCbCrSubsampling       = 0x00000212,
    PropertyTagYCbCrPositioning       = 0x00000213,
    PropertyTagREFBlackWhite          = 0x00000214,
    PropertyTagICCProfile             = 0x00008773,
    PropertyTagGamma                  = 0x00000301,
    PropertyTagICCProfileDescriptor   = 0x00000302,
}

enum : uint
{
    PropertyTagImageTitle            = 0x00000320,
    PropertyTagCopyright             = 0x00008298,
    PropertyTagResolutionXUnit       = 0x00005001,
    PropertyTagResolutionYUnit       = 0x00005002,
    PropertyTagResolutionXLengthUnit = 0x00005003,
    PropertyTagResolutionYLengthUnit = 0x00005004,
}

enum : uint
{
    PropertyTagPrintFlagsVersion         = 0x00005006,
    PropertyTagPrintFlagsCrop            = 0x00005007,
    PropertyTagPrintFlagsBleedWidth      = 0x00005008,
    PropertyTagPrintFlagsBleedWidthScale = 0x00005009,
}

enum : uint
{
    PropertyTagHalftoneLPIUnit         = 0x0000500b,
    PropertyTagHalftoneDegree          = 0x0000500c,
    PropertyTagHalftoneShape           = 0x0000500d,
    PropertyTagHalftoneMisc            = 0x0000500e,
    PropertyTagHalftoneScreen          = 0x0000500f,
    PropertyTagJPEGQuality             = 0x00005010,
    PropertyTagGridSize                = 0x00005011,
    PropertyTagThumbnailFormat         = 0x00005012,
    PropertyTagThumbnailWidth          = 0x00005013,
    PropertyTagThumbnailHeight         = 0x00005014,
    PropertyTagThumbnailColorDepth     = 0x00005015,
    PropertyTagThumbnailPlanes         = 0x00005016,
    PropertyTagThumbnailRawBytes       = 0x00005017,
    PropertyTagThumbnailSize           = 0x00005018,
    PropertyTagThumbnailCompressedSize = 0x00005019,
}

enum : uint
{
    PropertyTagThumbnailData                  = 0x0000501b,
    PropertyTagThumbnailImageWidth            = 0x00005020,
    PropertyTagThumbnailImageHeight           = 0x00005021,
    PropertyTagThumbnailBitsPerSample         = 0x00005022,
    PropertyTagThumbnailCompression           = 0x00005023,
    PropertyTagThumbnailPhotometricInterp     = 0x00005024,
    PropertyTagThumbnailImageDescription      = 0x00005025,
    PropertyTagThumbnailEquipMake             = 0x00005026,
    PropertyTagThumbnailEquipModel            = 0x00005027,
    PropertyTagThumbnailStripOffsets          = 0x00005028,
    PropertyTagThumbnailOrientation           = 0x00005029,
    PropertyTagThumbnailSamplesPerPixel       = 0x0000502a,
    PropertyTagThumbnailRowsPerStrip          = 0x0000502b,
    PropertyTagThumbnailStripBytesCount       = 0x0000502c,
    PropertyTagThumbnailResolutionX           = 0x0000502d,
    PropertyTagThumbnailResolutionY           = 0x0000502e,
    PropertyTagThumbnailPlanarConfig          = 0x0000502f,
    PropertyTagThumbnailResolutionUnit        = 0x00005030,
    PropertyTagThumbnailTransferFunction      = 0x00005031,
    PropertyTagThumbnailSoftwareUsed          = 0x00005032,
    PropertyTagThumbnailDateTime              = 0x00005033,
    PropertyTagThumbnailArtist                = 0x00005034,
    PropertyTagThumbnailWhitePoint            = 0x00005035,
    PropertyTagThumbnailPrimaryChromaticities = 0x00005036,
    PropertyTagThumbnailYCbCrCoefficients     = 0x00005037,
    PropertyTagThumbnailYCbCrSubsampling      = 0x00005038,
    PropertyTagThumbnailYCbCrPositioning      = 0x00005039,
    PropertyTagThumbnailRefBlackWhite         = 0x0000503a,
    PropertyTagThumbnailCopyRight             = 0x0000503b,
}

enum : uint
{
    PropertyTagChrominanceTable          = 0x00005091,
    PropertyTagFrameDelay                = 0x00005100,
    PropertyTagLoopCount                 = 0x00005101,
    PropertyTagGlobalPalette             = 0x00005102,
    PropertyTagIndexBackground           = 0x00005103,
    PropertyTagIndexTransparent          = 0x00005104,
    PropertyTagPixelUnit                 = 0x00005110,
    PropertyTagPixelPerUnitX             = 0x00005111,
    PropertyTagPixelPerUnitY             = 0x00005112,
    PropertyTagPaletteHistogram          = 0x00005113,
    PropertyTagExifExposureTime          = 0x0000829a,
    PropertyTagExifFNumber               = 0x0000829d,
    PropertyTagExifExposureProg          = 0x00008822,
    PropertyTagExifSpectralSense         = 0x00008824,
    PropertyTagExifISOSpeed              = 0x00008827,
    PropertyTagExifOECF                  = 0x00008828,
    PropertyTagExifVer                   = 0x00009000,
    PropertyTagExifDTOrig                = 0x00009003,
    PropertyTagExifDTDigitized           = 0x00009004,
    PropertyTagExifCompConfig            = 0x00009101,
    PropertyTagExifCompBPP               = 0x00009102,
    PropertyTagExifShutterSpeed          = 0x00009201,
    PropertyTagExifAperture              = 0x00009202,
    PropertyTagExifBrightness            = 0x00009203,
    PropertyTagExifExposureBias          = 0x00009204,
    PropertyTagExifMaxAperture           = 0x00009205,
    PropertyTagExifSubjectDist           = 0x00009206,
    PropertyTagExifMeteringMode          = 0x00009207,
    PropertyTagExifLightSource           = 0x00009208,
    PropertyTagExifFlash                 = 0x00009209,
    PropertyTagExifFocalLength           = 0x0000920a,
    PropertyTagExifSubjectArea           = 0x00009214,
    PropertyTagExifMakerNote             = 0x0000927c,
    PropertyTagExifUserComment           = 0x00009286,
    PropertyTagExifDTSubsec              = 0x00009290,
    PropertyTagExifDTOrigSS              = 0x00009291,
    PropertyTagExifDTDigSS               = 0x00009292,
    PropertyTagExifFPXVer                = 0x0000a000,
    PropertyTagExifColorSpace            = 0x0000a001,
    PropertyTagExifPixXDim               = 0x0000a002,
    PropertyTagExifPixYDim               = 0x0000a003,
    PropertyTagExifRelatedWav            = 0x0000a004,
    PropertyTagExifInterop               = 0x0000a005,
    PropertyTagExifFlashEnergy           = 0x0000a20b,
    PropertyTagExifSpatialFR             = 0x0000a20c,
    PropertyTagExifFocalXRes             = 0x0000a20e,
    PropertyTagExifFocalYRes             = 0x0000a20f,
    PropertyTagExifFocalResUnit          = 0x0000a210,
    PropertyTagExifSubjectLoc            = 0x0000a214,
    PropertyTagExifExposureIndex         = 0x0000a215,
    PropertyTagExifSensingMethod         = 0x0000a217,
    PropertyTagExifFileSource            = 0x0000a300,
    PropertyTagExifSceneType             = 0x0000a301,
    PropertyTagExifCfaPattern            = 0x0000a302,
    PropertyTagExifCustomRendered        = 0x0000a401,
    PropertyTagExifExposureMode          = 0x0000a402,
    PropertyTagExifWhiteBalance          = 0x0000a403,
    PropertyTagExifDigitalZoomRatio      = 0x0000a404,
    PropertyTagExifFocalLengthIn35mmFilm = 0x0000a405,
    PropertyTagExifSceneCaptureType      = 0x0000a406,
    PropertyTagExifGainControl           = 0x0000a407,
    PropertyTagExifContrast              = 0x0000a408,
    PropertyTagExifSaturation            = 0x0000a409,
    PropertyTagExifSharpness             = 0x0000a40a,
    PropertyTagExifDeviceSettingDesc     = 0x0000a40b,
    PropertyTagExifSubjectDistanceRange  = 0x0000a40c,
    PropertyTagExifUniqueImageID         = 0x0000a420,
}

enum : uint
{
    PropertyTagGpsLatitudeRef      = 0x00000001,
    PropertyTagGpsLatitude         = 0x00000002,
    PropertyTagGpsLongitudeRef     = 0x00000003,
    PropertyTagGpsLongitude        = 0x00000004,
    PropertyTagGpsAltitudeRef      = 0x00000005,
    PropertyTagGpsAltitude         = 0x00000006,
    PropertyTagGpsGpsTime          = 0x00000007,
    PropertyTagGpsGpsSatellites    = 0x00000008,
    PropertyTagGpsGpsStatus        = 0x00000009,
    PropertyTagGpsGpsMeasureMode   = 0x0000000a,
    PropertyTagGpsGpsDop           = 0x0000000b,
    PropertyTagGpsSpeedRef         = 0x0000000c,
    PropertyTagGpsSpeed            = 0x0000000d,
    PropertyTagGpsTrackRef         = 0x0000000e,
    PropertyTagGpsTrack            = 0x0000000f,
    PropertyTagGpsImgDirRef        = 0x00000010,
    PropertyTagGpsImgDir           = 0x00000011,
    PropertyTagGpsMapDatum         = 0x00000012,
    PropertyTagGpsDestLatRef       = 0x00000013,
    PropertyTagGpsDestLat          = 0x00000014,
    PropertyTagGpsDestLongRef      = 0x00000015,
    PropertyTagGpsDestLong         = 0x00000016,
    PropertyTagGpsDestBearRef      = 0x00000017,
    PropertyTagGpsDestBear         = 0x00000018,
    PropertyTagGpsDestDistRef      = 0x00000019,
    PropertyTagGpsDestDist         = 0x0000001a,
    PropertyTagGpsProcessingMethod = 0x0000001b,
    PropertyTagGpsAreaInformation  = 0x0000001c,
    PropertyTagGpsDate             = 0x0000001d,
    PropertyTagGpsDifferential     = 0x0000001e,
}

enum uint ALPHA_SHIFT = 0x00000018;
enum uint GREEN_SHIFT = 0x00000008;

enum : uint
{
    PixelFormatIndexed   = 0x00010000,
    PixelFormatGDI       = 0x00020000,
    PixelFormatAlpha     = 0x00040000,
    PixelFormatPAlpha    = 0x00080000,
    PixelFormatExtended  = 0x00100000,
    PixelFormatCanonical = 0x00200000,
    PixelFormatUndefined = 0x00000000,
    PixelFormatDontCare  = 0x00000000,
    PixelFormatMax       = 0x00000010,
}

// Callbacks

alias ImageAbort = BOOL function(void* param0);
alias DrawImageAbort = BOOL function();
alias GetThumbnailImageAbort = BOOL function();
alias EnumerateMetafileProc = BOOL function(EmfPlusRecordType param0, uint param1, uint param2, 
                                            const(ubyte)* param3, void* param4);
alias DebugEventProc = void function(DebugEventLevel level, PSTR message);
alias NotificationHookProc = Status function(size_t* token);
alias NotificationUnhookProc = void function(size_t token);

// Structs


struct GpGraphics
{
}

struct GpBrush
{
}

struct GpTexture
{
}

struct GpSolidFill
{
}

struct GpLineGradient
{
}

struct GpPathGradient
{
}

struct GpHatch
{
}

struct GpPen
{
}

struct GpCustomLineCap
{
}

struct GpAdjustableArrowCap
{
}

struct GpImage
{
}

struct GpBitmap
{
}

struct GpMetafile
{
}

struct GpImageAttributes
{
}

struct GpPath
{
}

struct GpRegion
{
}

struct GpPathIterator
{
}

struct GpFontFamily
{
}

struct GpFont
{
}

struct GpStringFormat
{
}

struct GpFontCollection
{
}

struct GpInstalledFontCollection
{
}

struct GpPrivateFontCollection
{
}

struct GpCachedBitmap
{
}

struct PathData
{
    ptrdiff_t Value;
}

struct CGpEffect
{
    ptrdiff_t Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/direct3dhlsl/dx-graphics-hlsl-matrix))], [])
struct Matrix
{
    ptrdiff_t Value;
}

struct Font
{
    ptrdiff_t Value;
}

struct FontCollection
{
    ptrdiff_t Value;
}

struct InstalledFontCollection
{
    ptrdiff_t Value;
}

struct PrivateFontCollection
{
    ptrdiff_t Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/gdiplusheaders/nl-gdiplusheaders-image))], [])
struct Image
{
    ptrdiff_t Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/gdiplusheaders/nl-gdiplusheaders-bitmap))], [])
struct Bitmap
{
    ptrdiff_t Value;
}

struct CustomLineCap
{
    ptrdiff_t Value;
}

struct CachedBitmap
{
    ptrdiff_t Value;
}

struct Metafile
{
    ptrdiff_t Value;
}

struct FontFamily
{
    ptrdiff_t Value;
}

struct Region
{
    ptrdiff_t Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1helper/nf-d2d1helper-sizef))], [])
struct SizeF
{
    float Width;
    float Height;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.foundation/ns-windows-foundation-size))], [])
struct Size
{
    int Width;
    int Height;
}

struct PointF
{
    float X;
    float Y;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.foundation/ns-windows-foundation-point))], [])
struct Point
{
    int X;
    int Y;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1helper/nf-d2d1helper-rectf))], [])
struct RectF
{
    float X;
    float Y;
    float Width;
    float Height;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windows.foundation/ns-windows-foundation-rect))], [])
struct Rect
{
    int X;
    int Y;
    int Width;
    int Height;
}

struct CharacterRange
{
    int First;
    int Length;
}

struct GdiplusStartupInput
{
    uint      GdiplusVersion;
    ptrdiff_t DebugEventCallback;
    BOOL      SuppressBackgroundThread;
    BOOL      SuppressExternalCodecs;
}

struct GdiplusStartupInputEx
{
    GdiplusStartupInput Base;
    int                 StartupParameters;
}

struct GdiplusStartupOutput
{
    ptrdiff_t NotificationHook;
    ptrdiff_t NotificationUnhook;
}

struct ColorPalette
{
    uint Flags;
    uint Count;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/uint[1] Entries;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WMP/color-element))], [])
struct Color
{
    uint Argb;
    int  AliceBlue            = 0xfff0f8ff;
    int  AntiqueWhite         = 0xfffaebd7;
    int  Aqua                 = 0xff00ffff;
    int  Aquamarine           = 0xff7fffd4;
    int  Azure                = 0xfff0ffff;
    int  Beige                = 0xfff5f5dc;
    int  Bisque               = 0xffffe4c4;
    int  Black                = 0xff000000;
    int  BlanchedAlmond       = 0xffffebcd;
    int  Blue                 = 0xff0000ff;
    int  BlueViolet           = 0xff8a2be2;
    int  Brown                = 0xffa52a2a;
    int  BurlyWood            = 0xffdeb887;
    int  CadetBlue            = 0xff5f9ea0;
    int  Chartreuse           = 0xff7fff00;
    int  Chocolate            = 0xffd2691e;
    int  Coral                = 0xffff7f50;
    int  CornflowerBlue       = 0xff6495ed;
    int  Cornsilk             = 0xfffff8dc;
    int  Crimson              = 0xffdc143c;
    int  Cyan                 = 0xff00ffff;
    int  DarkBlue             = 0xff00008b;
    int  DarkCyan             = 0xff008b8b;
    int  DarkGoldenrod        = 0xffb8860b;
    int  DarkGray             = 0xffa9a9a9;
    int  DarkGreen            = 0xff006400;
    int  DarkKhaki            = 0xffbdb76b;
    int  DarkMagenta          = 0xff8b008b;
    int  DarkOliveGreen       = 0xff556b2f;
    int  DarkOrange           = 0xffff8c00;
    int  DarkOrchid           = 0xff9932cc;
    int  DarkRed              = 0xff8b0000;
    int  DarkSalmon           = 0xffe9967a;
    int  DarkSeaGreen         = 0xff8fbc8b;
    int  DarkSlateBlue        = 0xff483d8b;
    int  DarkSlateGray        = 0xff2f4f4f;
    int  DarkTurquoise        = 0xff00ced1;
    int  DarkViolet           = 0xff9400d3;
    int  DeepPink             = 0xffff1493;
    int  DeepSkyBlue          = 0xff00bfff;
    int  DimGray              = 0xff696969;
    int  DodgerBlue           = 0xff1e90ff;
    int  Firebrick            = 0xffb22222;
    int  FloralWhite          = 0xfffffaf0;
    int  ForestGreen          = 0xff228b22;
    int  Fuchsia              = 0xffff00ff;
    int  Gainsboro            = 0xffdcdcdc;
    int  GhostWhite           = 0xfff8f8ff;
    int  Gold                 = 0xffffd700;
    int  Goldenrod            = 0xffdaa520;
    int  Gray                 = 0xff808080;
    int  Green                = 0xff008000;
    int  GreenYellow          = 0xffadff2f;
    int  Honeydew             = 0xfff0fff0;
    int  HotPink              = 0xffff69b4;
    int  IndianRed            = 0xffcd5c5c;
    int  Indigo               = 0xff4b0082;
    int  Ivory                = 0xfffffff0;
    int  Khaki                = 0xfff0e68c;
    int  Lavender             = 0xffe6e6fa;
    int  LavenderBlush        = 0xfffff0f5;
    int  LawnGreen            = 0xff7cfc00;
    int  LemonChiffon         = 0xfffffacd;
    int  LightBlue            = 0xffadd8e6;
    int  LightCoral           = 0xfff08080;
    int  LightCyan            = 0xffe0ffff;
    int  LightGoldenrodYellow = 0xfffafad2;
    int  LightGray            = 0xffd3d3d3;
    int  LightGreen           = 0xff90ee90;
    int  LightPink            = 0xffffb6c1;
    int  LightSalmon          = 0xffffa07a;
    int  LightSeaGreen        = 0xff20b2aa;
    int  LightSkyBlue         = 0xff87cefa;
    int  LightSlateGray       = 0xff778899;
    int  LightSteelBlue       = 0xffb0c4de;
    int  LightYellow          = 0xffffffe0;
    int  Lime                 = 0xff00ff00;
    int  LimeGreen            = 0xff32cd32;
    int  Linen                = 0xfffaf0e6;
    int  Magenta              = 0xffff00ff;
    int  Maroon               = 0xff800000;
    int  MediumAquamarine     = 0xff66cdaa;
    int  MediumBlue           = 0xff0000cd;
    int  MediumOrchid         = 0xffba55d3;
    int  MediumPurple         = 0xff9370db;
    int  MediumSeaGreen       = 0xff3cb371;
    int  MediumSlateBlue      = 0xff7b68ee;
    int  MediumSpringGreen    = 0xff00fa9a;
    int  MediumTurquoise      = 0xff48d1cc;
    int  MediumVioletRed      = 0xffc71585;
    int  MidnightBlue         = 0xff191970;
    int  MintCream            = 0xfff5fffa;
    int  MistyRose            = 0xffffe4e1;
    int  Moccasin             = 0xffffe4b5;
    int  NavajoWhite          = 0xffffdead;
    int  Navy                 = 0xff000080;
    int  OldLace              = 0xfffdf5e6;
    int  Olive                = 0xff808000;
    int  OliveDrab            = 0xff6b8e23;
    int  Orange               = 0xffffa500;
    int  OrangeRed            = 0xffff4500;
    int  Orchid               = 0xffda70d6;
    int  PaleGoldenrod        = 0xffeee8aa;
    int  PaleGreen            = 0xff98fb98;
    int  PaleTurquoise        = 0xffafeeee;
    int  PaleVioletRed        = 0xffdb7093;
    int  PapayaWhip           = 0xffffefd5;
    int  PeachPuff            = 0xffffdab9;
    int  Peru                 = 0xffcd853f;
    int  Pink                 = 0xffffc0cb;
    int  Plum                 = 0xffdda0dd;
    int  PowderBlue           = 0xffb0e0e6;
    int  Purple               = 0xff800080;
    int  Red                  = 0xffff0000;
    int  RosyBrown            = 0xffbc8f8f;
    int  RoyalBlue            = 0xff4169e1;
    int  SaddleBrown          = 0xff8b4513;
    int  Salmon               = 0xfffa8072;
    int  SandyBrown           = 0xfff4a460;
    int  SeaGreen             = 0xff2e8b57;
    int  SeaShell             = 0xfffff5ee;
    int  Sienna               = 0xffa0522d;
    int  Silver               = 0xffc0c0c0;
    int  SkyBlue              = 0xff87ceeb;
    int  SlateBlue            = 0xff6a5acd;
    int  SlateGray            = 0xff708090;
    int  Snow                 = 0xfffffafa;
    int  SpringGreen          = 0xff00ff7f;
    int  SteelBlue            = 0xff4682b4;
    int  Tan                  = 0xffd2b48c;
    int  Teal                 = 0xff008080;
    int  Thistle              = 0xffd8bfd8;
    int  Tomato               = 0xffff6347;
    int  Transparent          = 0x00ffffff;
    int  Turquoise            = 0xff40e0d0;
    int  Violet               = 0xffee82ee;
    int  Wheat                = 0xfff5deb3;
    int  White                = 0xffffffff;
    int  WhiteSmoke           = 0xfff5f5f5;
    int  Yellow               = 0xffffff00;
    int  YellowGreen          = 0xff9acd32;
    int  AlphaShift           = 0x00000018;
    int  RedShift             = 0x00000010;
    int  GreenShift           = 0x00000008;
    int  BlueShift            = 0x00000000;
    int  AlphaMask            = 0xff000000;
    int  RedMask              = 0x00ff0000;
    int  GreenMask            = 0x0000ff00;
    int  BlueMask             = 0x000000ff;
}

struct ENHMETAHEADER3
{
    uint   iType;
    uint   nSize;
    RECTL  rclBounds;
    RECTL  rclFrame;
    uint   dSignature;
    uint   nVersion;
    uint   nBytes;
    uint   nRecords;
    ushort nHandles;
    ushort sReserved;
    uint   nDescription;
    uint   offDescription;
    uint   nPalEntries;
    SIZE   szlDevice;
    SIZE   szlMillimeters;
}

struct PWMFRect16
{
    short Left;
    short Top;
    short Right;
    short Bottom;
}

struct WmfPlaceableFileHeader
{
align (2):
    uint       Key;
    short      Hmf;
    PWMFRect16 BoundingBox;
    short      Inch;
    uint       Reserved;
    short      Checksum;
}

struct MetafileHeader
{
    MetafileType Type;
    uint         Size;
    uint         Version;
    uint         EmfPlusFlags;
    float        DpiX;
    float        DpiY;
    int          X;
    int          Y;
    int          Width;
    int          Height;
union Anonymous
    {
        METAHEADER     WmfHeader;
        ENHMETAHEADER3 EmfHeader;
    }
    int          EmfPlusHeaderSize;
    int          LogicalDpiX;
    int          LogicalDpiY;
}

struct ImageCodecInfo
{
    GUID          Clsid;
    GUID          FormatID;
    const(PWSTR)  CodecName;
    const(PWSTR)  DllName;
    const(PWSTR)  FormatDescription;
    const(PWSTR)  FilenameExtension;
    const(PWSTR)  MimeType;
    uint          Flags;
    uint          Version;
    uint          SigCount;
    uint          SigSize;
    const(ubyte)* SigPattern;
    const(ubyte)* SigMask;
}

struct BitmapData
{
    uint   Width;
    uint   Height;
    int    Stride;
    int    PixelFormat;
    void*  Scan0;
    size_t Reserved;
}

struct EncoderParameter
{
    GUID  Guid;
    uint  NumberOfValues;
    uint  Type;
    void* Value;
}

struct EncoderParameters
{
    uint Count;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/EncoderParameter[1] Parameter;
}

struct ImageItemData
{
    uint  Size;
    uint  Position;
    void* Desc;
    uint  DescSize;
    void* Data;
    uint  DataSize;
    uint  Cookie;
}

struct PropertyItem
{
    uint   id;
    uint   length;
    ushort type;
    void*  value;
}

struct ColorMatrix
{
    float[25] m;
}

struct ColorMap
{
    Color oldColor;
    Color newColor;
}

struct SharpenParams
{
    float radius;
    float amount;
}

struct BlurParams
{
    float radius;
    BOOL  expandEdge;
}

struct BrightnessContrastParams
{
    int brightnessLevel;
    int contrastLevel;
}

struct RedEyeCorrectionParams
{
    uint  numberOfAreas;
    RECT* areas;
}

struct HueSaturationLightnessParams
{
    int hueLevel;
    int saturationLevel;
    int lightnessLevel;
}

struct TintParams
{
    int hue;
    int amount;
}

struct LevelsParams
{
    int highlight;
    int midtone;
    int shadow;
}

struct ColorBalanceParams
{
    int cyanRed;
    int magentaGreen;
    int yellowBlue;
}

struct ColorLUTParams
{
    ubyte[256] lutB;
    ubyte[256] lutG;
    ubyte[256] lutR;
    ubyte[256] lutA;
}

struct ColorCurveParams
{
    CurveAdjustments adjustment;
    CurveChannel     channel;
    int              adjustValue;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/direct3d9/functions))], [])
struct Effect
{
    void**     lpVtbl;
    CGpEffect* nativeEffect;
    int        auxDataSize;
    void*      auxData;
    BOOL       useAuxData;
}

struct Blur
{
    Effect Base;
}

struct Sharpen
{
    Effect Base;
}

struct RedEyeCorrection
{
    Effect Base;
}

struct BrightnessContrast
{
    Effect Base;
}

struct HueSaturationLightness
{
    Effect Base;
}

struct Levels
{
    Effect Base;
}

struct Tint
{
    Effect Base;
}

struct ColorBalance
{
    Effect Base;
}

struct ColorMatrixEffect
{
    Effect Base;
}

struct ColorLUT
{
    Effect Base;
}

struct ColorCurve
{
    Effect Base;
}

// Functions

@DllImport("gdiplus.dll")
void* GdipAlloc(size_t size);

@DllImport("gdiplus.dll")
void GdipFree(void* ptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("gdiplus.dll")
Status GdiplusStartup(size_t* token, const(GdiplusStartupInput)* input, GdiplusStartupOutput* output);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("gdiplus.dll")
void GdiplusShutdown(size_t token);

@DllImport("gdiplus.dll")
Status GdipCreateEffect(const(GUID) guid, CGpEffect** effect);

@DllImport("gdiplus.dll")
Status GdipDeleteEffect(CGpEffect* effect);

@DllImport("gdiplus.dll")
Status GdipGetEffectParameterSize(CGpEffect* effect, uint* size);

@DllImport("gdiplus.dll")
Status GdipSetEffectParameters(CGpEffect* effect, const(void)* params, const(uint) size);

@DllImport("gdiplus.dll")
Status GdipGetEffectParameters(CGpEffect* effect, uint* size, void* params);

@DllImport("gdiplus.dll")
Status GdipCreatePath(FillMode brushMode, GpPath** path);

@DllImport("gdiplus.dll")
Status GdipCreatePath2(const(PointF)* param0, const(ubyte)* param1, int param2, FillMode param3, GpPath** path);

@DllImport("gdiplus.dll")
Status GdipCreatePath2I(const(Point)* param0, const(ubyte)* param1, int param2, FillMode param3, GpPath** path);

@DllImport("gdiplus.dll")
Status GdipClonePath(GpPath* path, GpPath** clonePath);

@DllImport("gdiplus.dll")
Status GdipDeletePath(GpPath* path);

@DllImport("gdiplus.dll")
Status GdipResetPath(GpPath* path);

@DllImport("gdiplus.dll")
Status GdipGetPointCount(GpPath* path, int* count);

@DllImport("gdiplus.dll")
Status GdipGetPathTypes(GpPath* path, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* types, 
                        int count);

@DllImport("gdiplus.dll")
Status GdipGetPathPoints(GpPath* param0, PointF* points, int count);

@DllImport("gdiplus.dll")
Status GdipGetPathPointsI(GpPath* param0, Point* points, int count);

@DllImport("gdiplus.dll")
Status GdipGetPathFillMode(GpPath* path, FillMode* fillmode);

@DllImport("gdiplus.dll")
Status GdipSetPathFillMode(GpPath* path, FillMode fillmode);

@DllImport("gdiplus.dll")
Status GdipGetPathData(GpPath* path, PathData* pathData);

@DllImport("gdiplus.dll")
Status GdipStartPathFigure(GpPath* path);

@DllImport("gdiplus.dll")
Status GdipClosePathFigure(GpPath* path);

@DllImport("gdiplus.dll")
Status GdipClosePathFigures(GpPath* path);

@DllImport("gdiplus.dll")
Status GdipSetPathMarker(GpPath* path);

@DllImport("gdiplus.dll")
Status GdipClearPathMarkers(GpPath* path);

@DllImport("gdiplus.dll")
Status GdipReversePath(GpPath* path);

@DllImport("gdiplus.dll")
Status GdipGetPathLastPoint(GpPath* path, PointF* lastPoint);

@DllImport("gdiplus.dll")
Status GdipAddPathLine(GpPath* path, float x1, float y1, float x2, float y2);

@DllImport("gdiplus.dll")
Status GdipAddPathLine2(GpPath* path, const(PointF)* points, int count);

@DllImport("gdiplus.dll")
Status GdipAddPathArc(GpPath* path, float x, float y, float width, float height, float startAngle, 
                      float sweepAngle);

@DllImport("gdiplus.dll")
Status GdipAddPathBezier(GpPath* path, float x1, float y1, float x2, float y2, float x3, float y3, float x4, 
                         float y4);

@DllImport("gdiplus.dll")
Status GdipAddPathBeziers(GpPath* path, const(PointF)* points, int count);

@DllImport("gdiplus.dll")
Status GdipAddPathCurve(GpPath* path, const(PointF)* points, int count);

@DllImport("gdiplus.dll")
Status GdipAddPathCurve2(GpPath* path, const(PointF)* points, int count, float tension);

@DllImport("gdiplus.dll")
Status GdipAddPathCurve3(GpPath* path, const(PointF)* points, int count, int offset, int numberOfSegments, 
                         float tension);

@DllImport("gdiplus.dll")
Status GdipAddPathClosedCurve(GpPath* path, const(PointF)* points, int count);

@DllImport("gdiplus.dll")
Status GdipAddPathClosedCurve2(GpPath* path, const(PointF)* points, int count, float tension);

@DllImport("gdiplus.dll")
Status GdipAddPathRectangle(GpPath* path, float x, float y, float width, float height);

@DllImport("gdiplus.dll")
Status GdipAddPathRectangles(GpPath* path, const(RectF)* rects, int count);

@DllImport("gdiplus.dll")
Status GdipAddPathEllipse(GpPath* path, float x, float y, float width, float height);

@DllImport("gdiplus.dll")
Status GdipAddPathPie(GpPath* path, float x, float y, float width, float height, float startAngle, 
                      float sweepAngle);

@DllImport("gdiplus.dll")
Status GdipAddPathPolygon(GpPath* path, const(PointF)* points, int count);

@DllImport("gdiplus.dll")
Status GdipAddPathPath(GpPath* path, const(GpPath)* addingPath, BOOL connect);

@DllImport("gdiplus.dll")
Status GdipAddPathString(GpPath* path, const(PWSTR) string, int length, const(GpFontFamily)* family, int style, 
                         float emSize, const(RectF)* layoutRect, const(GpStringFormat)* format);

@DllImport("gdiplus.dll")
Status GdipAddPathStringI(GpPath* path, const(PWSTR) string, int length, const(GpFontFamily)* family, int style, 
                          float emSize, const(Rect)* layoutRect, const(GpStringFormat)* format);

@DllImport("gdiplus.dll")
Status GdipAddPathLineI(GpPath* path, int x1, int y1, int x2, int y2);

@DllImport("gdiplus.dll")
Status GdipAddPathLine2I(GpPath* path, const(Point)* points, int count);

@DllImport("gdiplus.dll")
Status GdipAddPathArcI(GpPath* path, int x, int y, int width, int height, float startAngle, float sweepAngle);

@DllImport("gdiplus.dll")
Status GdipAddPathBezierI(GpPath* path, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4);

@DllImport("gdiplus.dll")
Status GdipAddPathBeziersI(GpPath* path, const(Point)* points, int count);

@DllImport("gdiplus.dll")
Status GdipAddPathCurveI(GpPath* path, const(Point)* points, int count);

@DllImport("gdiplus.dll")
Status GdipAddPathCurve2I(GpPath* path, const(Point)* points, int count, float tension);

@DllImport("gdiplus.dll")
Status GdipAddPathCurve3I(GpPath* path, const(Point)* points, int count, int offset, int numberOfSegments, 
                          float tension);

@DllImport("gdiplus.dll")
Status GdipAddPathClosedCurveI(GpPath* path, const(Point)* points, int count);

@DllImport("gdiplus.dll")
Status GdipAddPathClosedCurve2I(GpPath* path, const(Point)* points, int count, float tension);

@DllImport("gdiplus.dll")
Status GdipAddPathRectangleI(GpPath* path, int x, int y, int width, int height);

@DllImport("gdiplus.dll")
Status GdipAddPathRectanglesI(GpPath* path, const(Rect)* rects, int count);

@DllImport("gdiplus.dll")
Status GdipAddPathEllipseI(GpPath* path, int x, int y, int width, int height);

@DllImport("gdiplus.dll")
Status GdipAddPathPieI(GpPath* path, int x, int y, int width, int height, float startAngle, float sweepAngle);

@DllImport("gdiplus.dll")
Status GdipAddPathPolygonI(GpPath* path, const(Point)* points, int count);

@DllImport("gdiplus.dll")
Status GdipFlattenPath(GpPath* path, Matrix* matrix, float flatness);

@DllImport("gdiplus.dll")
Status GdipWindingModeOutline(GpPath* path, Matrix* matrix, float flatness);

@DllImport("gdiplus.dll")
Status GdipWidenPath(GpPath* nativePath, GpPen* pen, Matrix* matrix, float flatness);

@DllImport("gdiplus.dll")
Status GdipWarpPath(GpPath* path, Matrix* matrix, const(PointF)* points, int count, float srcx, float srcy, 
                    float srcwidth, float srcheight, WarpMode warpMode, float flatness);

@DllImport("gdiplus.dll")
Status GdipTransformPath(GpPath* path, Matrix* matrix);

@DllImport("gdiplus.dll")
Status GdipGetPathWorldBounds(GpPath* path, RectF* bounds, const(Matrix)* matrix, const(GpPen)* pen);

@DllImport("gdiplus.dll")
Status GdipGetPathWorldBoundsI(GpPath* path, Rect* bounds, const(Matrix)* matrix, const(GpPen)* pen);

@DllImport("gdiplus.dll")
Status GdipIsVisiblePathPoint(GpPath* path, float x, float y, GpGraphics* graphics, BOOL* result);

@DllImport("gdiplus.dll")
Status GdipIsVisiblePathPointI(GpPath* path, int x, int y, GpGraphics* graphics, BOOL* result);

@DllImport("gdiplus.dll")
Status GdipIsOutlineVisiblePathPoint(GpPath* path, float x, float y, GpPen* pen, GpGraphics* graphics, 
                                     BOOL* result);

@DllImport("gdiplus.dll")
Status GdipIsOutlineVisiblePathPointI(GpPath* path, int x, int y, GpPen* pen, GpGraphics* graphics, BOOL* result);

@DllImport("gdiplus.dll")
Status GdipCreatePathIter(GpPathIterator** iterator, GpPath* path);

@DllImport("gdiplus.dll")
Status GdipDeletePathIter(GpPathIterator* iterator);

@DllImport("gdiplus.dll")
Status GdipPathIterNextSubpath(GpPathIterator* iterator, int* resultCount, int* startIndex, int* endIndex, 
                               BOOL* isClosed);

@DllImport("gdiplus.dll")
Status GdipPathIterNextSubpathPath(GpPathIterator* iterator, int* resultCount, GpPath* path, BOOL* isClosed);

@DllImport("gdiplus.dll")
Status GdipPathIterNextPathType(GpPathIterator* iterator, int* resultCount, ubyte* pathType, int* startIndex, 
                                int* endIndex);

@DllImport("gdiplus.dll")
Status GdipPathIterNextMarker(GpPathIterator* iterator, int* resultCount, int* startIndex, int* endIndex);

@DllImport("gdiplus.dll")
Status GdipPathIterNextMarkerPath(GpPathIterator* iterator, int* resultCount, GpPath* path);

@DllImport("gdiplus.dll")
Status GdipPathIterGetCount(GpPathIterator* iterator, int* count);

@DllImport("gdiplus.dll")
Status GdipPathIterGetSubpathCount(GpPathIterator* iterator, int* count);

@DllImport("gdiplus.dll")
Status GdipPathIterIsValid(GpPathIterator* iterator, BOOL* valid);

@DllImport("gdiplus.dll")
Status GdipPathIterHasCurve(GpPathIterator* iterator, BOOL* hasCurve);

@DllImport("gdiplus.dll")
Status GdipPathIterRewind(GpPathIterator* iterator);

@DllImport("gdiplus.dll")
Status GdipPathIterEnumerate(GpPathIterator* iterator, int* resultCount, PointF* points, ubyte* types, int count);

@DllImport("gdiplus.dll")
Status GdipPathIterCopyData(GpPathIterator* iterator, int* resultCount, PointF* points, ubyte* types, 
                            int startIndex, int endIndex);

@DllImport("gdiplus.dll")
Status GdipCreateMatrix(Matrix** matrix);

@DllImport("gdiplus.dll")
Status GdipCreateMatrix2(float m11, float m12, float m21, float m22, float dx, float dy, Matrix** matrix);

@DllImport("gdiplus.dll")
Status GdipCreateMatrix3(const(RectF)* rect, const(PointF)* dstplg, Matrix** matrix);

@DllImport("gdiplus.dll")
Status GdipCreateMatrix3I(const(Rect)* rect, const(Point)* dstplg, Matrix** matrix);

@DllImport("gdiplus.dll")
Status GdipCloneMatrix(Matrix* matrix, Matrix** cloneMatrix);

@DllImport("gdiplus.dll")
Status GdipDeleteMatrix(Matrix* matrix);

@DllImport("gdiplus.dll")
Status GdipSetMatrixElements(Matrix* matrix, float m11, float m12, float m21, float m22, float dx, float dy);

@DllImport("gdiplus.dll")
Status GdipMultiplyMatrix(Matrix* matrix, Matrix* matrix2, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipTranslateMatrix(Matrix* matrix, float offsetX, float offsetY, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipScaleMatrix(Matrix* matrix, float scaleX, float scaleY, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipRotateMatrix(Matrix* matrix, float angle, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipShearMatrix(Matrix* matrix, float shearX, float shearY, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipInvertMatrix(Matrix* matrix);

@DllImport("gdiplus.dll")
Status GdipTransformMatrixPoints(Matrix* matrix, PointF* pts, int count);

@DllImport("gdiplus.dll")
Status GdipTransformMatrixPointsI(Matrix* matrix, Point* pts, int count);

@DllImport("gdiplus.dll")
Status GdipVectorTransformMatrixPoints(Matrix* matrix, PointF* pts, int count);

@DllImport("gdiplus.dll")
Status GdipVectorTransformMatrixPointsI(Matrix* matrix, Point* pts, int count);

@DllImport("gdiplus.dll")
Status GdipGetMatrixElements(const(Matrix)* matrix, float* matrixOut);

@DllImport("gdiplus.dll")
Status GdipIsMatrixInvertible(const(Matrix)* matrix, BOOL* result);

@DllImport("gdiplus.dll")
Status GdipIsMatrixIdentity(const(Matrix)* matrix, BOOL* result);

@DllImport("gdiplus.dll")
Status GdipIsMatrixEqual(const(Matrix)* matrix, const(Matrix)* matrix2, BOOL* result);

@DllImport("gdiplus.dll")
Status GdipCreateRegion(GpRegion** region);

@DllImport("gdiplus.dll")
Status GdipCreateRegionRect(const(RectF)* rect, GpRegion** region);

@DllImport("gdiplus.dll")
Status GdipCreateRegionRectI(const(Rect)* rect, GpRegion** region);

@DllImport("gdiplus.dll")
Status GdipCreateRegionPath(GpPath* path, GpRegion** region);

@DllImport("gdiplus.dll")
Status GdipCreateRegionRgnData(const(ubyte)* regionData, int size, GpRegion** region);

@DllImport("gdiplus.dll")
Status GdipCreateRegionHrgn(HRGN hRgn, GpRegion** region);

@DllImport("gdiplus.dll")
Status GdipCloneRegion(GpRegion* region, GpRegion** cloneRegion);

@DllImport("gdiplus.dll")
Status GdipDeleteRegion(GpRegion* region);

@DllImport("gdiplus.dll")
Status GdipSetInfinite(GpRegion* region);

@DllImport("gdiplus.dll")
Status GdipSetEmpty(GpRegion* region);

@DllImport("gdiplus.dll")
Status GdipCombineRegionRect(GpRegion* region, const(RectF)* rect, CombineMode combineMode);

@DllImport("gdiplus.dll")
Status GdipCombineRegionRectI(GpRegion* region, const(Rect)* rect, CombineMode combineMode);

@DllImport("gdiplus.dll")
Status GdipCombineRegionPath(GpRegion* region, GpPath* path, CombineMode combineMode);

@DllImport("gdiplus.dll")
Status GdipCombineRegionRegion(GpRegion* region, GpRegion* region2, CombineMode combineMode);

@DllImport("gdiplus.dll")
Status GdipTranslateRegion(GpRegion* region, float dx, float dy);

@DllImport("gdiplus.dll")
Status GdipTranslateRegionI(GpRegion* region, int dx, int dy);

@DllImport("gdiplus.dll")
Status GdipTransformRegion(GpRegion* region, Matrix* matrix);

@DllImport("gdiplus.dll")
Status GdipGetRegionBounds(GpRegion* region, GpGraphics* graphics, RectF* rect);

@DllImport("gdiplus.dll")
Status GdipGetRegionBoundsI(GpRegion* region, GpGraphics* graphics, Rect* rect);

@DllImport("gdiplus.dll")
Status GdipGetRegionHRgn(GpRegion* region, GpGraphics* graphics, HRGN* hRgn);

@DllImport("gdiplus.dll")
Status GdipIsEmptyRegion(GpRegion* region, GpGraphics* graphics, BOOL* result);

@DllImport("gdiplus.dll")
Status GdipIsInfiniteRegion(GpRegion* region, GpGraphics* graphics, BOOL* result);

@DllImport("gdiplus.dll")
Status GdipIsEqualRegion(GpRegion* region, GpRegion* region2, GpGraphics* graphics, BOOL* result);

@DllImport("gdiplus.dll")
Status GdipGetRegionDataSize(GpRegion* region, uint* bufferSize);

@DllImport("gdiplus.dll")
Status GdipGetRegionData(GpRegion* region, ubyte* buffer, uint bufferSize, uint* sizeFilled);

@DllImport("gdiplus.dll")
Status GdipIsVisibleRegionPoint(GpRegion* region, float x, float y, GpGraphics* graphics, BOOL* result);

@DllImport("gdiplus.dll")
Status GdipIsVisibleRegionPointI(GpRegion* region, int x, int y, GpGraphics* graphics, BOOL* result);

@DllImport("gdiplus.dll")
Status GdipIsVisibleRegionRect(GpRegion* region, float x, float y, float width, float height, GpGraphics* graphics, 
                               BOOL* result);

@DllImport("gdiplus.dll")
Status GdipIsVisibleRegionRectI(GpRegion* region, int x, int y, int width, int height, GpGraphics* graphics, 
                                BOOL* result);

@DllImport("gdiplus.dll")
Status GdipGetRegionScansCount(GpRegion* region, uint* count, Matrix* matrix);

@DllImport("gdiplus.dll")
Status GdipGetRegionScans(GpRegion* region, RectF* rects, int* count, Matrix* matrix);

@DllImport("gdiplus.dll")
Status GdipGetRegionScansI(GpRegion* region, Rect* rects, int* count, Matrix* matrix);

@DllImport("gdiplus.dll")
Status GdipCloneBrush(GpBrush* brush, GpBrush** cloneBrush);

@DllImport("gdiplus.dll")
Status GdipDeleteBrush(GpBrush* brush);

@DllImport("gdiplus.dll")
Status GdipGetBrushType(GpBrush* brush, BrushType* type);

@DllImport("gdiplus.dll")
Status GdipCreateHatchBrush(HatchStyle hatchstyle, uint forecol, uint backcol, GpHatch** brush);

@DllImport("gdiplus.dll")
Status GdipGetHatchStyle(GpHatch* brush, HatchStyle* hatchstyle);

@DllImport("gdiplus.dll")
Status GdipGetHatchForegroundColor(GpHatch* brush, uint* forecol);

@DllImport("gdiplus.dll")
Status GdipGetHatchBackgroundColor(GpHatch* brush, uint* backcol);

@DllImport("gdiplus.dll")
Status GdipCreateTexture(GpImage* image, WrapMode wrapmode, GpTexture** texture);

@DllImport("gdiplus.dll")
Status GdipCreateTexture2(GpImage* image, WrapMode wrapmode, float x, float y, float width, float height, 
                          GpTexture** texture);

@DllImport("gdiplus.dll")
Status GdipCreateTextureIA(GpImage* image, const(GpImageAttributes)* imageAttributes, float x, float y, 
                           float width, float height, GpTexture** texture);

@DllImport("gdiplus.dll")
Status GdipCreateTexture2I(GpImage* image, WrapMode wrapmode, int x, int y, int width, int height, 
                           GpTexture** texture);

@DllImport("gdiplus.dll")
Status GdipCreateTextureIAI(GpImage* image, const(GpImageAttributes)* imageAttributes, int x, int y, int width, 
                            int height, GpTexture** texture);

@DllImport("gdiplus.dll")
Status GdipGetTextureTransform(GpTexture* brush, Matrix* matrix);

@DllImport("gdiplus.dll")
Status GdipSetTextureTransform(GpTexture* brush, const(Matrix)* matrix);

@DllImport("gdiplus.dll")
Status GdipResetTextureTransform(GpTexture* brush);

@DllImport("gdiplus.dll")
Status GdipMultiplyTextureTransform(GpTexture* brush, const(Matrix)* matrix, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipTranslateTextureTransform(GpTexture* brush, float dx, float dy, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipScaleTextureTransform(GpTexture* brush, float sx, float sy, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipRotateTextureTransform(GpTexture* brush, float angle, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipSetTextureWrapMode(GpTexture* brush, WrapMode wrapmode);

@DllImport("gdiplus.dll")
Status GdipGetTextureWrapMode(GpTexture* brush, WrapMode* wrapmode);

@DllImport("gdiplus.dll")
Status GdipGetTextureImage(GpTexture* brush, GpImage** image);

@DllImport("gdiplus.dll")
Status GdipCreateSolidFill(uint color, GpSolidFill** brush);

@DllImport("gdiplus.dll")
Status GdipSetSolidFillColor(GpSolidFill* brush, uint color);

@DllImport("gdiplus.dll")
Status GdipGetSolidFillColor(GpSolidFill* brush, uint* color);

@DllImport("gdiplus.dll")
Status GdipCreateLineBrush(const(PointF)* point1, const(PointF)* point2, uint color1, uint color2, 
                           WrapMode wrapMode, GpLineGradient** lineGradient);

@DllImport("gdiplus.dll")
Status GdipCreateLineBrushI(const(Point)* point1, const(Point)* point2, uint color1, uint color2, 
                            WrapMode wrapMode, GpLineGradient** lineGradient);

@DllImport("gdiplus.dll")
Status GdipCreateLineBrushFromRect(const(RectF)* rect, uint color1, uint color2, LinearGradientMode mode, 
                                   WrapMode wrapMode, GpLineGradient** lineGradient);

@DllImport("gdiplus.dll")
Status GdipCreateLineBrushFromRectI(const(Rect)* rect, uint color1, uint color2, LinearGradientMode mode, 
                                    WrapMode wrapMode, GpLineGradient** lineGradient);

@DllImport("gdiplus.dll")
Status GdipCreateLineBrushFromRectWithAngle(const(RectF)* rect, uint color1, uint color2, float angle, 
                                            BOOL isAngleScalable, WrapMode wrapMode, GpLineGradient** lineGradient);

@DllImport("gdiplus.dll")
Status GdipCreateLineBrushFromRectWithAngleI(const(Rect)* rect, uint color1, uint color2, float angle, 
                                             BOOL isAngleScalable, WrapMode wrapMode, GpLineGradient** lineGradient);

@DllImport("gdiplus.dll")
Status GdipSetLineColors(GpLineGradient* brush, uint color1, uint color2);

@DllImport("gdiplus.dll")
Status GdipGetLineColors(GpLineGradient* brush, uint* colors);

@DllImport("gdiplus.dll")
Status GdipGetLineRect(GpLineGradient* brush, RectF* rect);

@DllImport("gdiplus.dll")
Status GdipGetLineRectI(GpLineGradient* brush, Rect* rect);

@DllImport("gdiplus.dll")
Status GdipSetLineGammaCorrection(GpLineGradient* brush, BOOL useGammaCorrection);

@DllImport("gdiplus.dll")
Status GdipGetLineGammaCorrection(GpLineGradient* brush, BOOL* useGammaCorrection);

@DllImport("gdiplus.dll")
Status GdipGetLineBlendCount(GpLineGradient* brush, int* count);

@DllImport("gdiplus.dll")
Status GdipGetLineBlend(GpLineGradient* brush, float* blend, float* positions, int count);

@DllImport("gdiplus.dll")
Status GdipSetLineBlend(GpLineGradient* brush, const(float)* blend, const(float)* positions, int count);

@DllImport("gdiplus.dll")
Status GdipGetLinePresetBlendCount(GpLineGradient* brush, int* count);

@DllImport("gdiplus.dll")
Status GdipGetLinePresetBlend(GpLineGradient* brush, uint* blend, float* positions, int count);

@DllImport("gdiplus.dll")
Status GdipSetLinePresetBlend(GpLineGradient* brush, const(uint)* blend, const(float)* positions, int count);

@DllImport("gdiplus.dll")
Status GdipSetLineSigmaBlend(GpLineGradient* brush, float focus, float scale);

@DllImport("gdiplus.dll")
Status GdipSetLineLinearBlend(GpLineGradient* brush, float focus, float scale);

@DllImport("gdiplus.dll")
Status GdipSetLineWrapMode(GpLineGradient* brush, WrapMode wrapmode);

@DllImport("gdiplus.dll")
Status GdipGetLineWrapMode(GpLineGradient* brush, WrapMode* wrapmode);

@DllImport("gdiplus.dll")
Status GdipGetLineTransform(GpLineGradient* brush, Matrix* matrix);

@DllImport("gdiplus.dll")
Status GdipSetLineTransform(GpLineGradient* brush, const(Matrix)* matrix);

@DllImport("gdiplus.dll")
Status GdipResetLineTransform(GpLineGradient* brush);

@DllImport("gdiplus.dll")
Status GdipMultiplyLineTransform(GpLineGradient* brush, const(Matrix)* matrix, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipTranslateLineTransform(GpLineGradient* brush, float dx, float dy, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipScaleLineTransform(GpLineGradient* brush, float sx, float sy, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipRotateLineTransform(GpLineGradient* brush, float angle, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipCreatePathGradient(const(PointF)* points, int count, WrapMode wrapMode, GpPathGradient** polyGradient);

@DllImport("gdiplus.dll")
Status GdipCreatePathGradientI(const(Point)* points, int count, WrapMode wrapMode, GpPathGradient** polyGradient);

@DllImport("gdiplus.dll")
Status GdipCreatePathGradientFromPath(const(GpPath)* path, GpPathGradient** polyGradient);

@DllImport("gdiplus.dll")
Status GdipGetPathGradientCenterColor(GpPathGradient* brush, uint* colors);

@DllImport("gdiplus.dll")
Status GdipSetPathGradientCenterColor(GpPathGradient* brush, uint colors);

@DllImport("gdiplus.dll")
Status GdipGetPathGradientSurroundColorsWithCount(GpPathGradient* brush, uint* color, int* count);

@DllImport("gdiplus.dll")
Status GdipSetPathGradientSurroundColorsWithCount(GpPathGradient* brush, const(uint)* color, int* count);

@DllImport("gdiplus.dll")
Status GdipGetPathGradientPath(GpPathGradient* brush, GpPath* path);

@DllImport("gdiplus.dll")
Status GdipSetPathGradientPath(GpPathGradient* brush, const(GpPath)* path);

@DllImport("gdiplus.dll")
Status GdipGetPathGradientCenterPoint(GpPathGradient* brush, PointF* points);

@DllImport("gdiplus.dll")
Status GdipGetPathGradientCenterPointI(GpPathGradient* brush, Point* points);

@DllImport("gdiplus.dll")
Status GdipSetPathGradientCenterPoint(GpPathGradient* brush, const(PointF)* points);

@DllImport("gdiplus.dll")
Status GdipSetPathGradientCenterPointI(GpPathGradient* brush, const(Point)* points);

@DllImport("gdiplus.dll")
Status GdipGetPathGradientRect(GpPathGradient* brush, RectF* rect);

@DllImport("gdiplus.dll")
Status GdipGetPathGradientRectI(GpPathGradient* brush, Rect* rect);

@DllImport("gdiplus.dll")
Status GdipGetPathGradientPointCount(GpPathGradient* brush, int* count);

@DllImport("gdiplus.dll")
Status GdipGetPathGradientSurroundColorCount(GpPathGradient* brush, int* count);

@DllImport("gdiplus.dll")
Status GdipSetPathGradientGammaCorrection(GpPathGradient* brush, BOOL useGammaCorrection);

@DllImport("gdiplus.dll")
Status GdipGetPathGradientGammaCorrection(GpPathGradient* brush, BOOL* useGammaCorrection);

@DllImport("gdiplus.dll")
Status GdipGetPathGradientBlendCount(GpPathGradient* brush, int* count);

@DllImport("gdiplus.dll")
Status GdipGetPathGradientBlend(GpPathGradient* brush, float* blend, float* positions, int count);

@DllImport("gdiplus.dll")
Status GdipSetPathGradientBlend(GpPathGradient* brush, const(float)* blend, const(float)* positions, int count);

@DllImport("gdiplus.dll")
Status GdipGetPathGradientPresetBlendCount(GpPathGradient* brush, int* count);

@DllImport("gdiplus.dll")
Status GdipGetPathGradientPresetBlend(GpPathGradient* brush, uint* blend, float* positions, int count);

@DllImport("gdiplus.dll")
Status GdipSetPathGradientPresetBlend(GpPathGradient* brush, const(uint)* blend, const(float)* positions, 
                                      int count);

@DllImport("gdiplus.dll")
Status GdipSetPathGradientSigmaBlend(GpPathGradient* brush, float focus, float scale);

@DllImport("gdiplus.dll")
Status GdipSetPathGradientLinearBlend(GpPathGradient* brush, float focus, float scale);

@DllImport("gdiplus.dll")
Status GdipGetPathGradientWrapMode(GpPathGradient* brush, WrapMode* wrapmode);

@DllImport("gdiplus.dll")
Status GdipSetPathGradientWrapMode(GpPathGradient* brush, WrapMode wrapmode);

@DllImport("gdiplus.dll")
Status GdipGetPathGradientTransform(GpPathGradient* brush, Matrix* matrix);

@DllImport("gdiplus.dll")
Status GdipSetPathGradientTransform(GpPathGradient* brush, Matrix* matrix);

@DllImport("gdiplus.dll")
Status GdipResetPathGradientTransform(GpPathGradient* brush);

@DllImport("gdiplus.dll")
Status GdipMultiplyPathGradientTransform(GpPathGradient* brush, const(Matrix)* matrix, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipTranslatePathGradientTransform(GpPathGradient* brush, float dx, float dy, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipScalePathGradientTransform(GpPathGradient* brush, float sx, float sy, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipRotatePathGradientTransform(GpPathGradient* brush, float angle, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipGetPathGradientFocusScales(GpPathGradient* brush, float* xScale, float* yScale);

@DllImport("gdiplus.dll")
Status GdipSetPathGradientFocusScales(GpPathGradient* brush, float xScale, float yScale);

@DllImport("gdiplus.dll")
Status GdipCreatePen1(uint color, float width, Unit unit, GpPen** pen);

@DllImport("gdiplus.dll")
Status GdipCreatePen2(GpBrush* brush, float width, Unit unit, GpPen** pen);

@DllImport("gdiplus.dll")
Status GdipClonePen(GpPen* pen, GpPen** clonepen);

@DllImport("gdiplus.dll")
Status GdipDeletePen(GpPen* pen);

@DllImport("gdiplus.dll")
Status GdipSetPenWidth(GpPen* pen, float width);

@DllImport("gdiplus.dll")
Status GdipGetPenWidth(GpPen* pen, float* width);

@DllImport("gdiplus.dll")
Status GdipSetPenUnit(GpPen* pen, Unit unit);

@DllImport("gdiplus.dll")
Status GdipGetPenUnit(GpPen* pen, Unit* unit);

@DllImport("gdiplus.dll")
Status GdipSetPenLineCap197819(GpPen* pen, LineCap startCap, LineCap endCap, DashCap dashCap);

@DllImport("gdiplus.dll")
Status GdipSetPenStartCap(GpPen* pen, LineCap startCap);

@DllImport("gdiplus.dll")
Status GdipSetPenEndCap(GpPen* pen, LineCap endCap);

@DllImport("gdiplus.dll")
Status GdipSetPenDashCap197819(GpPen* pen, DashCap dashCap);

@DllImport("gdiplus.dll")
Status GdipGetPenStartCap(GpPen* pen, LineCap* startCap);

@DllImport("gdiplus.dll")
Status GdipGetPenEndCap(GpPen* pen, LineCap* endCap);

@DllImport("gdiplus.dll")
Status GdipGetPenDashCap197819(GpPen* pen, DashCap* dashCap);

@DllImport("gdiplus.dll")
Status GdipSetPenLineJoin(GpPen* pen, LineJoin lineJoin);

@DllImport("gdiplus.dll")
Status GdipGetPenLineJoin(GpPen* pen, LineJoin* lineJoin);

@DllImport("gdiplus.dll")
Status GdipSetPenCustomStartCap(GpPen* pen, GpCustomLineCap* customCap);

@DllImport("gdiplus.dll")
Status GdipGetPenCustomStartCap(GpPen* pen, GpCustomLineCap** customCap);

@DllImport("gdiplus.dll")
Status GdipSetPenCustomEndCap(GpPen* pen, GpCustomLineCap* customCap);

@DllImport("gdiplus.dll")
Status GdipGetPenCustomEndCap(GpPen* pen, GpCustomLineCap** customCap);

@DllImport("gdiplus.dll")
Status GdipSetPenMiterLimit(GpPen* pen, float miterLimit);

@DllImport("gdiplus.dll")
Status GdipGetPenMiterLimit(GpPen* pen, float* miterLimit);

@DllImport("gdiplus.dll")
Status GdipSetPenMode(GpPen* pen, PenAlignment penMode);

@DllImport("gdiplus.dll")
Status GdipGetPenMode(GpPen* pen, PenAlignment* penMode);

@DllImport("gdiplus.dll")
Status GdipSetPenTransform(GpPen* pen, Matrix* matrix);

@DllImport("gdiplus.dll")
Status GdipGetPenTransform(GpPen* pen, Matrix* matrix);

@DllImport("gdiplus.dll")
Status GdipResetPenTransform(GpPen* pen);

@DllImport("gdiplus.dll")
Status GdipMultiplyPenTransform(GpPen* pen, const(Matrix)* matrix, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipTranslatePenTransform(GpPen* pen, float dx, float dy, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipScalePenTransform(GpPen* pen, float sx, float sy, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipRotatePenTransform(GpPen* pen, float angle, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipSetPenColor(GpPen* pen, uint argb);

@DllImport("gdiplus.dll")
Status GdipGetPenColor(GpPen* pen, uint* argb);

@DllImport("gdiplus.dll")
Status GdipSetPenBrushFill(GpPen* pen, GpBrush* brush);

@DllImport("gdiplus.dll")
Status GdipGetPenBrushFill(GpPen* pen, GpBrush** brush);

@DllImport("gdiplus.dll")
Status GdipGetPenFillType(GpPen* pen, PenType* type);

@DllImport("gdiplus.dll")
Status GdipGetPenDashStyle(GpPen* pen, DashStyle* dashstyle);

@DllImport("gdiplus.dll")
Status GdipSetPenDashStyle(GpPen* pen, DashStyle dashstyle);

@DllImport("gdiplus.dll")
Status GdipGetPenDashOffset(GpPen* pen, float* offset);

@DllImport("gdiplus.dll")
Status GdipSetPenDashOffset(GpPen* pen, float offset);

@DllImport("gdiplus.dll")
Status GdipGetPenDashCount(GpPen* pen, int* count);

@DllImport("gdiplus.dll")
Status GdipSetPenDashArray(GpPen* pen, const(float)* dash, int count);

@DllImport("gdiplus.dll")
Status GdipGetPenDashArray(GpPen* pen, float* dash, int count);

@DllImport("gdiplus.dll")
Status GdipGetPenCompoundCount(GpPen* pen, int* count);

@DllImport("gdiplus.dll")
Status GdipSetPenCompoundArray(GpPen* pen, const(float)* dash, int count);

@DllImport("gdiplus.dll")
Status GdipGetPenCompoundArray(GpPen* pen, float* dash, int count);

@DllImport("gdiplus.dll")
Status GdipCreateCustomLineCap(GpPath* fillPath, GpPath* strokePath, LineCap baseCap, float baseInset, 
                               GpCustomLineCap** customCap);

@DllImport("gdiplus.dll")
Status GdipDeleteCustomLineCap(GpCustomLineCap* customCap);

@DllImport("gdiplus.dll")
Status GdipCloneCustomLineCap(GpCustomLineCap* customCap, GpCustomLineCap** clonedCap);

@DllImport("gdiplus.dll")
Status GdipGetCustomLineCapType(GpCustomLineCap* customCap, CustomLineCapType* capType);

@DllImport("gdiplus.dll")
Status GdipSetCustomLineCapStrokeCaps(GpCustomLineCap* customCap, LineCap startCap, LineCap endCap);

@DllImport("gdiplus.dll")
Status GdipGetCustomLineCapStrokeCaps(GpCustomLineCap* customCap, LineCap* startCap, LineCap* endCap);

@DllImport("gdiplus.dll")
Status GdipSetCustomLineCapStrokeJoin(GpCustomLineCap* customCap, LineJoin lineJoin);

@DllImport("gdiplus.dll")
Status GdipGetCustomLineCapStrokeJoin(GpCustomLineCap* customCap, LineJoin* lineJoin);

@DllImport("gdiplus.dll")
Status GdipSetCustomLineCapBaseCap(GpCustomLineCap* customCap, LineCap baseCap);

@DllImport("gdiplus.dll")
Status GdipGetCustomLineCapBaseCap(GpCustomLineCap* customCap, LineCap* baseCap);

@DllImport("gdiplus.dll")
Status GdipSetCustomLineCapBaseInset(GpCustomLineCap* customCap, float inset);

@DllImport("gdiplus.dll")
Status GdipGetCustomLineCapBaseInset(GpCustomLineCap* customCap, float* inset);

@DllImport("gdiplus.dll")
Status GdipSetCustomLineCapWidthScale(GpCustomLineCap* customCap, float widthScale);

@DllImport("gdiplus.dll")
Status GdipGetCustomLineCapWidthScale(GpCustomLineCap* customCap, float* widthScale);

@DllImport("gdiplus.dll")
Status GdipCreateAdjustableArrowCap(float height, float width, BOOL isFilled, GpAdjustableArrowCap** cap);

@DllImport("gdiplus.dll")
Status GdipSetAdjustableArrowCapHeight(GpAdjustableArrowCap* cap, float height);

@DllImport("gdiplus.dll")
Status GdipGetAdjustableArrowCapHeight(GpAdjustableArrowCap* cap, float* height);

@DllImport("gdiplus.dll")
Status GdipSetAdjustableArrowCapWidth(GpAdjustableArrowCap* cap, float width);

@DllImport("gdiplus.dll")
Status GdipGetAdjustableArrowCapWidth(GpAdjustableArrowCap* cap, float* width);

@DllImport("gdiplus.dll")
Status GdipSetAdjustableArrowCapMiddleInset(GpAdjustableArrowCap* cap, float middleInset);

@DllImport("gdiplus.dll")
Status GdipGetAdjustableArrowCapMiddleInset(GpAdjustableArrowCap* cap, float* middleInset);

@DllImport("gdiplus.dll")
Status GdipSetAdjustableArrowCapFillState(GpAdjustableArrowCap* cap, BOOL fillState);

@DllImport("gdiplus.dll")
Status GdipGetAdjustableArrowCapFillState(GpAdjustableArrowCap* cap, BOOL* fillState);

@DllImport("gdiplus.dll")
Status GdipLoadImageFromStream(IStream stream, GpImage** image);

@DllImport("gdiplus.dll")
Status GdipLoadImageFromFile(const(PWSTR) filename, GpImage** image);

@DllImport("gdiplus.dll")
Status GdipLoadImageFromStreamICM(IStream stream, GpImage** image);

@DllImport("gdiplus.dll")
Status GdipLoadImageFromFileICM(const(PWSTR) filename, GpImage** image);

@DllImport("gdiplus.dll")
Status GdipCloneImage(GpImage* image, GpImage** cloneImage);

@DllImport("gdiplus.dll")
Status GdipDisposeImage(GpImage* image);

@DllImport("gdiplus.dll")
Status GdipSaveImageToFile(GpImage* image, const(PWSTR) filename, const(GUID)* clsidEncoder, 
                           const(EncoderParameters)* encoderParams);

@DllImport("gdiplus.dll")
Status GdipSaveImageToStream(GpImage* image, IStream stream, const(GUID)* clsidEncoder, 
                             const(EncoderParameters)* encoderParams);

@DllImport("gdiplus.dll")
Status GdipSaveAdd(GpImage* image, const(EncoderParameters)* encoderParams);

@DllImport("gdiplus.dll")
Status GdipSaveAddImage(GpImage* image, GpImage* newImage, const(EncoderParameters)* encoderParams);

@DllImport("gdiplus.dll")
Status GdipGetImageGraphicsContext(GpImage* image, GpGraphics** graphics);

@DllImport("gdiplus.dll")
Status GdipGetImageBounds(GpImage* image, RectF* srcRect, Unit* srcUnit);

@DllImport("gdiplus.dll")
Status GdipGetImageDimension(GpImage* image, float* width, float* height);

@DllImport("gdiplus.dll")
Status GdipGetImageType(GpImage* image, ImageType* type);

@DllImport("gdiplus.dll")
Status GdipGetImageWidth(GpImage* image, uint* width);

@DllImport("gdiplus.dll")
Status GdipGetImageHeight(GpImage* image, uint* height);

@DllImport("gdiplus.dll")
Status GdipGetImageHorizontalResolution(GpImage* image, float* resolution);

@DllImport("gdiplus.dll")
Status GdipGetImageVerticalResolution(GpImage* image, float* resolution);

@DllImport("gdiplus.dll")
Status GdipGetImageFlags(GpImage* image, uint* flags);

@DllImport("gdiplus.dll")
Status GdipGetImageRawFormat(GpImage* image, GUID* format);

@DllImport("gdiplus.dll")
Status GdipGetImagePixelFormat(GpImage* image, int* format);

@DllImport("gdiplus.dll")
Status GdipGetImageThumbnail(GpImage* image, uint thumbWidth, uint thumbHeight, GpImage** thumbImage, 
                             ptrdiff_t callback, void* callbackData);

@DllImport("gdiplus.dll")
Status GdipGetEncoderParameterListSize(GpImage* image, const(GUID)* clsidEncoder, uint* size);

@DllImport("gdiplus.dll")
Status GdipGetEncoderParameterList(GpImage* image, const(GUID)* clsidEncoder, uint size, EncoderParameters* buffer);

@DllImport("gdiplus.dll")
Status GdipImageGetFrameDimensionsCount(GpImage* image, uint* count);

@DllImport("gdiplus.dll")
Status GdipImageGetFrameDimensionsList(GpImage* image, GUID* dimensionIDs, uint count);

@DllImport("gdiplus.dll")
Status GdipImageGetFrameCount(GpImage* image, const(GUID)* dimensionID, uint* count);

@DllImport("gdiplus.dll")
Status GdipImageSelectActiveFrame(GpImage* image, const(GUID)* dimensionID, uint frameIndex);

@DllImport("gdiplus.dll")
Status GdipImageRotateFlip(GpImage* image, RotateFlipType rfType);

@DllImport("gdiplus.dll")
Status GdipGetImagePalette(GpImage* image, ColorPalette* palette, int size);

@DllImport("gdiplus.dll")
Status GdipSetImagePalette(GpImage* image, const(ColorPalette)* palette);

@DllImport("gdiplus.dll")
Status GdipGetImagePaletteSize(GpImage* image, int* size);

@DllImport("gdiplus.dll")
Status GdipGetPropertyCount(GpImage* image, uint* numOfProperty);

@DllImport("gdiplus.dll")
Status GdipGetPropertyIdList(GpImage* image, uint numOfProperty, uint* list);

@DllImport("gdiplus.dll")
Status GdipGetPropertyItemSize(GpImage* image, uint propId, uint* size);

@DllImport("gdiplus.dll")
Status GdipGetPropertyItem(GpImage* image, uint propId, uint propSize, PropertyItem* buffer);

@DllImport("gdiplus.dll")
Status GdipGetPropertySize(GpImage* image, uint* totalBufferSize, uint* numProperties);

@DllImport("gdiplus.dll")
Status GdipGetAllPropertyItems(GpImage* image, uint totalBufferSize, uint numProperties, PropertyItem* allItems);

@DllImport("gdiplus.dll")
Status GdipRemovePropertyItem(GpImage* image, uint propId);

@DllImport("gdiplus.dll")
Status GdipSetPropertyItem(GpImage* image, const(PropertyItem)* item);

@DllImport("gdiplus.dll")
Status GdipFindFirstImageItem(GpImage* image, ImageItemData* item);

@DllImport("gdiplus.dll")
Status GdipFindNextImageItem(GpImage* image, ImageItemData* item);

@DllImport("gdiplus.dll")
Status GdipGetImageItemData(GpImage* image, ImageItemData* item);

@DllImport("gdiplus.dll")
Status GdipImageForceValidation(GpImage* image);

@DllImport("gdiplus.dll")
Status GdipCreateBitmapFromStream(IStream stream, GpBitmap** bitmap);

@DllImport("gdiplus.dll")
Status GdipCreateBitmapFromFile(const(PWSTR) filename, GpBitmap** bitmap);

@DllImport("gdiplus.dll")
Status GdipCreateBitmapFromStreamICM(IStream stream, GpBitmap** bitmap);

@DllImport("gdiplus.dll")
Status GdipCreateBitmapFromFileICM(const(PWSTR) filename, GpBitmap** bitmap);

@DllImport("gdiplus.dll")
Status GdipCreateBitmapFromScan0(int width, int height, int stride, int format, ubyte* scan0, GpBitmap** bitmap);

@DllImport("gdiplus.dll")
Status GdipCreateBitmapFromGraphics(int width, int height, GpGraphics* target, GpBitmap** bitmap);

@DllImport("gdiplus.dll")
Status GdipCreateBitmapFromDirectDrawSurface(IDirectDrawSurface7 surface, GpBitmap** bitmap);

@DllImport("gdiplus.dll")
Status GdipCreateBitmapFromGdiDib(const(BITMAPINFO)* gdiBitmapInfo, void* gdiBitmapData, GpBitmap** bitmap);

@DllImport("gdiplus.dll")
Status GdipCreateBitmapFromHBITMAP(HBITMAP hbm, HPALETTE hpal, GpBitmap** bitmap);

@DllImport("gdiplus.dll")
Status GdipCreateHBITMAPFromBitmap(GpBitmap* bitmap, HBITMAP* hbmReturn, uint background);

@DllImport("gdiplus.dll")
Status GdipCreateBitmapFromHICON(HICON hicon, GpBitmap** bitmap);

@DllImport("gdiplus.dll")
Status GdipCreateHICONFromBitmap(GpBitmap* bitmap, HICON* hbmReturn);

@DllImport("gdiplus.dll")
Status GdipCreateBitmapFromResource(HINSTANCE hInstance, const(PWSTR) lpBitmapName, GpBitmap** bitmap);

@DllImport("gdiplus.dll")
Status GdipCloneBitmapArea(float x, float y, float width, float height, int format, GpBitmap* srcBitmap, 
                           GpBitmap** dstBitmap);

@DllImport("gdiplus.dll")
Status GdipCloneBitmapAreaI(int x, int y, int width, int height, int format, GpBitmap* srcBitmap, 
                            GpBitmap** dstBitmap);

@DllImport("gdiplus.dll")
Status GdipBitmapLockBits(GpBitmap* bitmap, const(Rect)* rect, uint flags, int format, 
                          BitmapData* lockedBitmapData);

@DllImport("gdiplus.dll")
Status GdipBitmapUnlockBits(GpBitmap* bitmap, BitmapData* lockedBitmapData);

@DllImport("gdiplus.dll")
Status GdipBitmapGetPixel(GpBitmap* bitmap, int x, int y, uint* color);

@DllImport("gdiplus.dll")
Status GdipBitmapSetPixel(GpBitmap* bitmap, int x, int y, uint color);

@DllImport("gdiplus.dll")
Status GdipImageSetAbort(GpImage* pImage, GdiplusAbort pIAbort);

@DllImport("gdiplus.dll")
Status GdipGraphicsSetAbort(GpGraphics* pGraphics, GdiplusAbort pIAbort);

@DllImport("gdiplus.dll")
Status GdipBitmapConvertFormat(GpBitmap* pInputBitmap, int format, DitherType dithertype, PaletteType palettetype, 
                               ColorPalette* palette, float alphaThresholdPercent);

@DllImport("gdiplus.dll")
Status GdipInitializePalette(ColorPalette* palette, PaletteType palettetype, int optimalColors, 
                             BOOL useTransparentColor, GpBitmap* bitmap);

@DllImport("gdiplus.dll")
Status GdipBitmapApplyEffect(GpBitmap* bitmap, CGpEffect* effect, RECT* roi, BOOL useAuxData, void** auxData, 
                             int* auxDataSize);

@DllImport("gdiplus.dll")
Status GdipBitmapCreateApplyEffect(GpBitmap** inputBitmaps, int numInputs, CGpEffect* effect, RECT* roi, 
                                   RECT* outputRect, GpBitmap** outputBitmap, BOOL useAuxData, void** auxData, 
                                   int* auxDataSize);

@DllImport("gdiplus.dll")
Status GdipBitmapGetHistogram(GpBitmap* bitmap, HistogramFormat format, uint NumberOfEntries, uint* channel0, 
                              uint* channel1, uint* channel2, uint* channel3);

@DllImport("gdiplus.dll")
Status GdipBitmapGetHistogramSize(HistogramFormat format, uint* NumberOfEntries);

@DllImport("gdiplus.dll")
Status GdipBitmapSetResolution(GpBitmap* bitmap, float xdpi, float ydpi);

@DllImport("gdiplus.dll")
Status GdipCreateImageAttributes(GpImageAttributes** imageattr);

@DllImport("gdiplus.dll")
Status GdipCloneImageAttributes(const(GpImageAttributes)* imageattr, GpImageAttributes** cloneImageattr);

@DllImport("gdiplus.dll")
Status GdipDisposeImageAttributes(GpImageAttributes* imageattr);

@DllImport("gdiplus.dll")
Status GdipSetImageAttributesToIdentity(GpImageAttributes* imageattr, ColorAdjustType type);

@DllImport("gdiplus.dll")
Status GdipResetImageAttributes(GpImageAttributes* imageattr, ColorAdjustType type);

@DllImport("gdiplus.dll")
Status GdipSetImageAttributesColorMatrix(GpImageAttributes* imageattr, ColorAdjustType type, BOOL enableFlag, 
                                         const(ColorMatrix)* colorMatrix, const(ColorMatrix)* grayMatrix, 
                                         ColorMatrixFlags flags);

@DllImport("gdiplus.dll")
Status GdipSetImageAttributesThreshold(GpImageAttributes* imageattr, ColorAdjustType type, BOOL enableFlag, 
                                       float threshold);

@DllImport("gdiplus.dll")
Status GdipSetImageAttributesGamma(GpImageAttributes* imageattr, ColorAdjustType type, BOOL enableFlag, 
                                   float gamma);

@DllImport("gdiplus.dll")
Status GdipSetImageAttributesNoOp(GpImageAttributes* imageattr, ColorAdjustType type, BOOL enableFlag);

@DllImport("gdiplus.dll")
Status GdipSetImageAttributesColorKeys(GpImageAttributes* imageattr, ColorAdjustType type, BOOL enableFlag, 
                                       uint colorLow, uint colorHigh);

@DllImport("gdiplus.dll")
Status GdipSetImageAttributesOutputChannel(GpImageAttributes* imageattr, ColorAdjustType type, BOOL enableFlag, 
                                           ColorChannelFlags channelFlags);

@DllImport("gdiplus.dll")
Status GdipSetImageAttributesOutputChannelColorProfile(GpImageAttributes* imageattr, ColorAdjustType type, 
                                                       BOOL enableFlag, const(PWSTR) colorProfileFilename);

@DllImport("gdiplus.dll")
Status GdipSetImageAttributesRemapTable(GpImageAttributes* imageattr, ColorAdjustType type, BOOL enableFlag, 
                                        uint mapSize, const(ColorMap)* map);

@DllImport("gdiplus.dll")
Status GdipSetImageAttributesWrapMode(GpImageAttributes* imageAttr, WrapMode wrap, uint argb, BOOL clamp);

@DllImport("gdiplus.dll")
Status GdipGetImageAttributesAdjustedPalette(GpImageAttributes* imageAttr, ColorPalette* colorPalette, 
                                             ColorAdjustType colorAdjustType);

@DllImport("gdiplus.dll")
Status GdipFlush(GpGraphics* graphics, FlushIntention intention);

@DllImport("gdiplus.dll")
Status GdipCreateFromHDC(HDC hdc, GpGraphics** graphics);

@DllImport("gdiplus.dll")
Status GdipCreateFromHDC2(HDC hdc, HANDLE hDevice, GpGraphics** graphics);

@DllImport("gdiplus.dll")
Status GdipCreateFromHWND(HWND hwnd, GpGraphics** graphics);

@DllImport("gdiplus.dll")
Status GdipCreateFromHWNDICM(HWND hwnd, GpGraphics** graphics);

@DllImport("gdiplus.dll")
Status GdipDeleteGraphics(GpGraphics* graphics);

@DllImport("gdiplus.dll")
Status GdipGetDC(GpGraphics* graphics, HDC* hdc);

@DllImport("gdiplus.dll")
Status GdipReleaseDC(GpGraphics* graphics, HDC hdc);

@DllImport("gdiplus.dll")
Status GdipSetCompositingMode(GpGraphics* graphics, CompositingMode compositingMode);

@DllImport("gdiplus.dll")
Status GdipGetCompositingMode(GpGraphics* graphics, CompositingMode* compositingMode);

@DllImport("gdiplus.dll")
Status GdipSetRenderingOrigin(GpGraphics* graphics, int x, int y);

@DllImport("gdiplus.dll")
Status GdipGetRenderingOrigin(GpGraphics* graphics, int* x, int* y);

@DllImport("gdiplus.dll")
Status GdipSetCompositingQuality(GpGraphics* graphics, CompositingQuality compositingQuality);

@DllImport("gdiplus.dll")
Status GdipGetCompositingQuality(GpGraphics* graphics, CompositingQuality* compositingQuality);

@DllImport("gdiplus.dll")
Status GdipSetSmoothingMode(GpGraphics* graphics, SmoothingMode smoothingMode);

@DllImport("gdiplus.dll")
Status GdipGetSmoothingMode(GpGraphics* graphics, SmoothingMode* smoothingMode);

@DllImport("gdiplus.dll")
Status GdipSetPixelOffsetMode(GpGraphics* graphics, PixelOffsetMode pixelOffsetMode);

@DllImport("gdiplus.dll")
Status GdipGetPixelOffsetMode(GpGraphics* graphics, PixelOffsetMode* pixelOffsetMode);

@DllImport("gdiplus.dll")
Status GdipSetTextRenderingHint(GpGraphics* graphics, TextRenderingHint mode);

@DllImport("gdiplus.dll")
Status GdipGetTextRenderingHint(GpGraphics* graphics, TextRenderingHint* mode);

@DllImport("gdiplus.dll")
Status GdipSetTextContrast(GpGraphics* graphics, uint contrast);

@DllImport("gdiplus.dll")
Status GdipGetTextContrast(GpGraphics* graphics, uint* contrast);

@DllImport("gdiplus.dll")
Status GdipSetInterpolationMode(GpGraphics* graphics, InterpolationMode interpolationMode);

@DllImport("gdiplus.dll")
Status GdipGetInterpolationMode(GpGraphics* graphics, InterpolationMode* interpolationMode);

@DllImport("gdiplus.dll")
Status GdipSetWorldTransform(GpGraphics* graphics, Matrix* matrix);

@DllImport("gdiplus.dll")
Status GdipResetWorldTransform(GpGraphics* graphics);

@DllImport("gdiplus.dll")
Status GdipMultiplyWorldTransform(GpGraphics* graphics, const(Matrix)* matrix, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipTranslateWorldTransform(GpGraphics* graphics, float dx, float dy, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipScaleWorldTransform(GpGraphics* graphics, float sx, float sy, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipRotateWorldTransform(GpGraphics* graphics, float angle, MatrixOrder order);

@DllImport("gdiplus.dll")
Status GdipGetWorldTransform(GpGraphics* graphics, Matrix* matrix);

@DllImport("gdiplus.dll")
Status GdipResetPageTransform(GpGraphics* graphics);

@DllImport("gdiplus.dll")
Status GdipGetPageUnit(GpGraphics* graphics, Unit* unit);

@DllImport("gdiplus.dll")
Status GdipGetPageScale(GpGraphics* graphics, float* scale);

@DllImport("gdiplus.dll")
Status GdipSetPageUnit(GpGraphics* graphics, Unit unit);

@DllImport("gdiplus.dll")
Status GdipSetPageScale(GpGraphics* graphics, float scale);

@DllImport("gdiplus.dll")
Status GdipGetDpiX(GpGraphics* graphics, float* dpi);

@DllImport("gdiplus.dll")
Status GdipGetDpiY(GpGraphics* graphics, float* dpi);

@DllImport("gdiplus.dll")
Status GdipTransformPoints(GpGraphics* graphics, CoordinateSpace destSpace, CoordinateSpace srcSpace, 
                           PointF* points, int count);

@DllImport("gdiplus.dll")
Status GdipTransformPointsI(GpGraphics* graphics, CoordinateSpace destSpace, CoordinateSpace srcSpace, 
                            Point* points, int count);

@DllImport("gdiplus.dll")
Status GdipGetNearestColor(GpGraphics* graphics, uint* argb);

@DllImport("gdiplus.dll")
HPALETTE GdipCreateHalftonePalette();

@DllImport("gdiplus.dll")
Status GdipDrawLine(GpGraphics* graphics, GpPen* pen, float x1, float y1, float x2, float y2);

@DllImport("gdiplus.dll")
Status GdipDrawLineI(GpGraphics* graphics, GpPen* pen, int x1, int y1, int x2, int y2);

@DllImport("gdiplus.dll")
Status GdipDrawLines(GpGraphics* graphics, GpPen* pen, const(PointF)* points, int count);

@DllImport("gdiplus.dll")
Status GdipDrawLinesI(GpGraphics* graphics, GpPen* pen, const(Point)* points, int count);

@DllImport("gdiplus.dll")
Status GdipDrawArc(GpGraphics* graphics, GpPen* pen, float x, float y, float width, float height, float startAngle, 
                   float sweepAngle);

@DllImport("gdiplus.dll")
Status GdipDrawArcI(GpGraphics* graphics, GpPen* pen, int x, int y, int width, int height, float startAngle, 
                    float sweepAngle);

@DllImport("gdiplus.dll")
Status GdipDrawBezier(GpGraphics* graphics, GpPen* pen, float x1, float y1, float x2, float y2, float x3, float y3, 
                      float x4, float y4);

@DllImport("gdiplus.dll")
Status GdipDrawBezierI(GpGraphics* graphics, GpPen* pen, int x1, int y1, int x2, int y2, int x3, int y3, int x4, 
                       int y4);

@DllImport("gdiplus.dll")
Status GdipDrawBeziers(GpGraphics* graphics, GpPen* pen, const(PointF)* points, int count);

@DllImport("gdiplus.dll")
Status GdipDrawBeziersI(GpGraphics* graphics, GpPen* pen, const(Point)* points, int count);

@DllImport("gdiplus.dll")
Status GdipDrawRectangle(GpGraphics* graphics, GpPen* pen, float x, float y, float width, float height);

@DllImport("gdiplus.dll")
Status GdipDrawRectangleI(GpGraphics* graphics, GpPen* pen, int x, int y, int width, int height);

@DllImport("gdiplus.dll")
Status GdipDrawRectangles(GpGraphics* graphics, GpPen* pen, const(RectF)* rects, int count);

@DllImport("gdiplus.dll")
Status GdipDrawRectanglesI(GpGraphics* graphics, GpPen* pen, const(Rect)* rects, int count);

@DllImport("gdiplus.dll")
Status GdipDrawEllipse(GpGraphics* graphics, GpPen* pen, float x, float y, float width, float height);

@DllImport("gdiplus.dll")
Status GdipDrawEllipseI(GpGraphics* graphics, GpPen* pen, int x, int y, int width, int height);

@DllImport("gdiplus.dll")
Status GdipDrawPie(GpGraphics* graphics, GpPen* pen, float x, float y, float width, float height, float startAngle, 
                   float sweepAngle);

@DllImport("gdiplus.dll")
Status GdipDrawPieI(GpGraphics* graphics, GpPen* pen, int x, int y, int width, int height, float startAngle, 
                    float sweepAngle);

@DllImport("gdiplus.dll")
Status GdipDrawPolygon(GpGraphics* graphics, GpPen* pen, const(PointF)* points, int count);

@DllImport("gdiplus.dll")
Status GdipDrawPolygonI(GpGraphics* graphics, GpPen* pen, const(Point)* points, int count);

@DllImport("gdiplus.dll")
Status GdipDrawPath(GpGraphics* graphics, GpPen* pen, GpPath* path);

@DllImport("gdiplus.dll")
Status GdipDrawCurve(GpGraphics* graphics, GpPen* pen, const(PointF)* points, int count);

@DllImport("gdiplus.dll")
Status GdipDrawCurveI(GpGraphics* graphics, GpPen* pen, const(Point)* points, int count);

@DllImport("gdiplus.dll")
Status GdipDrawCurve2(GpGraphics* graphics, GpPen* pen, const(PointF)* points, int count, float tension);

@DllImport("gdiplus.dll")
Status GdipDrawCurve2I(GpGraphics* graphics, GpPen* pen, const(Point)* points, int count, float tension);

@DllImport("gdiplus.dll")
Status GdipDrawCurve3(GpGraphics* graphics, GpPen* pen, const(PointF)* points, int count, int offset, 
                      int numberOfSegments, float tension);

@DllImport("gdiplus.dll")
Status GdipDrawCurve3I(GpGraphics* graphics, GpPen* pen, const(Point)* points, int count, int offset, 
                       int numberOfSegments, float tension);

@DllImport("gdiplus.dll")
Status GdipDrawClosedCurve(GpGraphics* graphics, GpPen* pen, const(PointF)* points, int count);

@DllImport("gdiplus.dll")
Status GdipDrawClosedCurveI(GpGraphics* graphics, GpPen* pen, const(Point)* points, int count);

@DllImport("gdiplus.dll")
Status GdipDrawClosedCurve2(GpGraphics* graphics, GpPen* pen, const(PointF)* points, int count, float tension);

@DllImport("gdiplus.dll")
Status GdipDrawClosedCurve2I(GpGraphics* graphics, GpPen* pen, const(Point)* points, int count, float tension);

@DllImport("gdiplus.dll")
Status GdipGraphicsClear(GpGraphics* graphics, uint color);

@DllImport("gdiplus.dll")
Status GdipFillRectangle(GpGraphics* graphics, GpBrush* brush, float x, float y, float width, float height);

@DllImport("gdiplus.dll")
Status GdipFillRectangleI(GpGraphics* graphics, GpBrush* brush, int x, int y, int width, int height);

@DllImport("gdiplus.dll")
Status GdipFillRectangles(GpGraphics* graphics, GpBrush* brush, const(RectF)* rects, int count);

@DllImport("gdiplus.dll")
Status GdipFillRectanglesI(GpGraphics* graphics, GpBrush* brush, const(Rect)* rects, int count);

@DllImport("gdiplus.dll")
Status GdipFillPolygon(GpGraphics* graphics, GpBrush* brush, const(PointF)* points, int count, FillMode fillMode);

@DllImport("gdiplus.dll")
Status GdipFillPolygonI(GpGraphics* graphics, GpBrush* brush, const(Point)* points, int count, FillMode fillMode);

@DllImport("gdiplus.dll")
Status GdipFillPolygon2(GpGraphics* graphics, GpBrush* brush, const(PointF)* points, int count);

@DllImport("gdiplus.dll")
Status GdipFillPolygon2I(GpGraphics* graphics, GpBrush* brush, const(Point)* points, int count);

@DllImport("gdiplus.dll")
Status GdipFillEllipse(GpGraphics* graphics, GpBrush* brush, float x, float y, float width, float height);

@DllImport("gdiplus.dll")
Status GdipFillEllipseI(GpGraphics* graphics, GpBrush* brush, int x, int y, int width, int height);

@DllImport("gdiplus.dll")
Status GdipFillPie(GpGraphics* graphics, GpBrush* brush, float x, float y, float width, float height, 
                   float startAngle, float sweepAngle);

@DllImport("gdiplus.dll")
Status GdipFillPieI(GpGraphics* graphics, GpBrush* brush, int x, int y, int width, int height, float startAngle, 
                    float sweepAngle);

@DllImport("gdiplus.dll")
Status GdipFillPath(GpGraphics* graphics, GpBrush* brush, GpPath* path);

@DllImport("gdiplus.dll")
Status GdipFillClosedCurve(GpGraphics* graphics, GpBrush* brush, const(PointF)* points, int count);

@DllImport("gdiplus.dll")
Status GdipFillClosedCurveI(GpGraphics* graphics, GpBrush* brush, const(Point)* points, int count);

@DllImport("gdiplus.dll")
Status GdipFillClosedCurve2(GpGraphics* graphics, GpBrush* brush, const(PointF)* points, int count, float tension, 
                            FillMode fillMode);

@DllImport("gdiplus.dll")
Status GdipFillClosedCurve2I(GpGraphics* graphics, GpBrush* brush, const(Point)* points, int count, float tension, 
                             FillMode fillMode);

@DllImport("gdiplus.dll")
Status GdipFillRegion(GpGraphics* graphics, GpBrush* brush, GpRegion* region);

@DllImport("gdiplus.dll")
Status GdipDrawImageFX(GpGraphics* graphics, GpImage* image, RectF* source, Matrix* xForm, CGpEffect* effect, 
                       GpImageAttributes* imageAttributes, Unit srcUnit);

@DllImport("gdiplus.dll")
Status GdipDrawImage(GpGraphics* graphics, GpImage* image, float x, float y);

@DllImport("gdiplus.dll")
Status GdipDrawImageI(GpGraphics* graphics, GpImage* image, int x, int y);

@DllImport("gdiplus.dll")
Status GdipDrawImageRect(GpGraphics* graphics, GpImage* image, float x, float y, float width, float height);

@DllImport("gdiplus.dll")
Status GdipDrawImageRectI(GpGraphics* graphics, GpImage* image, int x, int y, int width, int height);

@DllImport("gdiplus.dll")
Status GdipDrawImagePoints(GpGraphics* graphics, GpImage* image, const(PointF)* dstpoints, int count);

@DllImport("gdiplus.dll")
Status GdipDrawImagePointsI(GpGraphics* graphics, GpImage* image, const(Point)* dstpoints, int count);

@DllImport("gdiplus.dll")
Status GdipDrawImagePointRect(GpGraphics* graphics, GpImage* image, float x, float y, float srcx, float srcy, 
                              float srcwidth, float srcheight, Unit srcUnit);

@DllImport("gdiplus.dll")
Status GdipDrawImagePointRectI(GpGraphics* graphics, GpImage* image, int x, int y, int srcx, int srcy, 
                               int srcwidth, int srcheight, Unit srcUnit);

@DllImport("gdiplus.dll")
Status GdipDrawImageRectRect(GpGraphics* graphics, GpImage* image, float dstx, float dsty, float dstwidth, 
                             float dstheight, float srcx, float srcy, float srcwidth, float srcheight, Unit srcUnit, 
                             const(GpImageAttributes)* imageAttributes, ptrdiff_t callback, void* callbackData);

@DllImport("gdiplus.dll")
Status GdipDrawImageRectRectI(GpGraphics* graphics, GpImage* image, int dstx, int dsty, int dstwidth, 
                              int dstheight, int srcx, int srcy, int srcwidth, int srcheight, Unit srcUnit, 
                              const(GpImageAttributes)* imageAttributes, ptrdiff_t callback, void* callbackData);

@DllImport("gdiplus.dll")
Status GdipDrawImagePointsRect(GpGraphics* graphics, GpImage* image, const(PointF)* points, int count, float srcx, 
                               float srcy, float srcwidth, float srcheight, Unit srcUnit, 
                               const(GpImageAttributes)* imageAttributes, ptrdiff_t callback, void* callbackData);

@DllImport("gdiplus.dll")
Status GdipDrawImagePointsRectI(GpGraphics* graphics, GpImage* image, const(Point)* points, int count, int srcx, 
                                int srcy, int srcwidth, int srcheight, Unit srcUnit, 
                                const(GpImageAttributes)* imageAttributes, ptrdiff_t callback, void* callbackData);

@DllImport("gdiplus.dll")
Status GdipEnumerateMetafileDestPoint(GpGraphics* graphics, const(GpMetafile)* metafile, const(PointF)* destPoint, 
                                      ptrdiff_t callback, void* callbackData, 
                                      const(GpImageAttributes)* imageAttributes);

@DllImport("gdiplus.dll")
Status GdipEnumerateMetafileDestPointI(GpGraphics* graphics, const(GpMetafile)* metafile, const(Point)* destPoint, 
                                       ptrdiff_t callback, void* callbackData, 
                                       const(GpImageAttributes)* imageAttributes);

@DllImport("gdiplus.dll")
Status GdipEnumerateMetafileDestRect(GpGraphics* graphics, const(GpMetafile)* metafile, const(RectF)* destRect, 
                                     ptrdiff_t callback, void* callbackData, 
                                     const(GpImageAttributes)* imageAttributes);

@DllImport("gdiplus.dll")
Status GdipEnumerateMetafileDestRectI(GpGraphics* graphics, const(GpMetafile)* metafile, const(Rect)* destRect, 
                                      ptrdiff_t callback, void* callbackData, 
                                      const(GpImageAttributes)* imageAttributes);

@DllImport("gdiplus.dll")
Status GdipEnumerateMetafileDestPoints(GpGraphics* graphics, const(GpMetafile)* metafile, 
                                       const(PointF)* destPoints, int count, ptrdiff_t callback, void* callbackData, 
                                       const(GpImageAttributes)* imageAttributes);

@DllImport("gdiplus.dll")
Status GdipEnumerateMetafileDestPointsI(GpGraphics* graphics, const(GpMetafile)* metafile, 
                                        const(Point)* destPoints, int count, ptrdiff_t callback, void* callbackData, 
                                        const(GpImageAttributes)* imageAttributes);

@DllImport("gdiplus.dll")
Status GdipEnumerateMetafileSrcRectDestPoint(GpGraphics* graphics, const(GpMetafile)* metafile, 
                                             const(PointF)* destPoint, const(RectF)* srcRect, Unit srcUnit, 
                                             ptrdiff_t callback, void* callbackData, 
                                             const(GpImageAttributes)* imageAttributes);

@DllImport("gdiplus.dll")
Status GdipEnumerateMetafileSrcRectDestPointI(GpGraphics* graphics, const(GpMetafile)* metafile, 
                                              const(Point)* destPoint, const(Rect)* srcRect, Unit srcUnit, 
                                              ptrdiff_t callback, void* callbackData, 
                                              const(GpImageAttributes)* imageAttributes);

@DllImport("gdiplus.dll")
Status GdipEnumerateMetafileSrcRectDestRect(GpGraphics* graphics, const(GpMetafile)* metafile, 
                                            const(RectF)* destRect, const(RectF)* srcRect, Unit srcUnit, 
                                            ptrdiff_t callback, void* callbackData, 
                                            const(GpImageAttributes)* imageAttributes);

@DllImport("gdiplus.dll")
Status GdipEnumerateMetafileSrcRectDestRectI(GpGraphics* graphics, const(GpMetafile)* metafile, 
                                             const(Rect)* destRect, const(Rect)* srcRect, Unit srcUnit, 
                                             ptrdiff_t callback, void* callbackData, 
                                             const(GpImageAttributes)* imageAttributes);

@DllImport("gdiplus.dll")
Status GdipEnumerateMetafileSrcRectDestPoints(GpGraphics* graphics, const(GpMetafile)* metafile, 
                                              const(PointF)* destPoints, int count, const(RectF)* srcRect, 
                                              Unit srcUnit, ptrdiff_t callback, void* callbackData, 
                                              const(GpImageAttributes)* imageAttributes);

@DllImport("gdiplus.dll")
Status GdipEnumerateMetafileSrcRectDestPointsI(GpGraphics* graphics, const(GpMetafile)* metafile, 
                                               const(Point)* destPoints, int count, const(Rect)* srcRect, 
                                               Unit srcUnit, ptrdiff_t callback, void* callbackData, 
                                               const(GpImageAttributes)* imageAttributes);

@DllImport("gdiplus.dll")
Status GdipPlayMetafileRecord(const(GpMetafile)* metafile, EmfPlusRecordType recordType, uint flags, uint dataSize, 
                              const(ubyte)* data);

@DllImport("gdiplus.dll")
Status GdipSetClipGraphics(GpGraphics* graphics, GpGraphics* srcgraphics, CombineMode combineMode);

@DllImport("gdiplus.dll")
Status GdipSetClipRect(GpGraphics* graphics, float x, float y, float width, float height, CombineMode combineMode);

@DllImport("gdiplus.dll")
Status GdipSetClipRectI(GpGraphics* graphics, int x, int y, int width, int height, CombineMode combineMode);

@DllImport("gdiplus.dll")
Status GdipSetClipPath(GpGraphics* graphics, GpPath* path, CombineMode combineMode);

@DllImport("gdiplus.dll")
Status GdipSetClipRegion(GpGraphics* graphics, GpRegion* region, CombineMode combineMode);

@DllImport("gdiplus.dll")
Status GdipSetClipHrgn(GpGraphics* graphics, HRGN hRgn, CombineMode combineMode);

@DllImport("gdiplus.dll")
Status GdipResetClip(GpGraphics* graphics);

@DllImport("gdiplus.dll")
Status GdipTranslateClip(GpGraphics* graphics, float dx, float dy);

@DllImport("gdiplus.dll")
Status GdipTranslateClipI(GpGraphics* graphics, int dx, int dy);

@DllImport("gdiplus.dll")
Status GdipGetClip(GpGraphics* graphics, GpRegion* region);

@DllImport("gdiplus.dll")
Status GdipGetClipBounds(GpGraphics* graphics, RectF* rect);

@DllImport("gdiplus.dll")
Status GdipGetClipBoundsI(GpGraphics* graphics, Rect* rect);

@DllImport("gdiplus.dll")
Status GdipIsClipEmpty(GpGraphics* graphics, BOOL* result);

@DllImport("gdiplus.dll")
Status GdipGetVisibleClipBounds(GpGraphics* graphics, RectF* rect);

@DllImport("gdiplus.dll")
Status GdipGetVisibleClipBoundsI(GpGraphics* graphics, Rect* rect);

@DllImport("gdiplus.dll")
Status GdipIsVisibleClipEmpty(GpGraphics* graphics, BOOL* result);

@DllImport("gdiplus.dll")
Status GdipIsVisiblePoint(GpGraphics* graphics, float x, float y, BOOL* result);

@DllImport("gdiplus.dll")
Status GdipIsVisiblePointI(GpGraphics* graphics, int x, int y, BOOL* result);

@DllImport("gdiplus.dll")
Status GdipIsVisibleRect(GpGraphics* graphics, float x, float y, float width, float height, BOOL* result);

@DllImport("gdiplus.dll")
Status GdipIsVisibleRectI(GpGraphics* graphics, int x, int y, int width, int height, BOOL* result);

@DllImport("gdiplus.dll")
Status GdipSaveGraphics(GpGraphics* graphics, uint* state);

@DllImport("gdiplus.dll")
Status GdipRestoreGraphics(GpGraphics* graphics, uint state);

@DllImport("gdiplus.dll")
Status GdipBeginContainer(GpGraphics* graphics, const(RectF)* dstrect, const(RectF)* srcrect, Unit unit, 
                          uint* state);

@DllImport("gdiplus.dll")
Status GdipBeginContainerI(GpGraphics* graphics, const(Rect)* dstrect, const(Rect)* srcrect, Unit unit, 
                           uint* state);

@DllImport("gdiplus.dll")
Status GdipBeginContainer2(GpGraphics* graphics, uint* state);

@DllImport("gdiplus.dll")
Status GdipEndContainer(GpGraphics* graphics, uint state);

@DllImport("gdiplus.dll")
Status GdipGetMetafileHeaderFromWmf(HMETAFILE hWmf, const(WmfPlaceableFileHeader)* wmfPlaceableFileHeader, 
                                    MetafileHeader* header);

@DllImport("gdiplus.dll")
Status GdipGetMetafileHeaderFromEmf(HENHMETAFILE hEmf, MetafileHeader* header);

@DllImport("gdiplus.dll")
Status GdipGetMetafileHeaderFromFile(const(PWSTR) filename, MetafileHeader* header);

@DllImport("gdiplus.dll")
Status GdipGetMetafileHeaderFromStream(IStream stream, MetafileHeader* header);

@DllImport("gdiplus.dll")
Status GdipGetMetafileHeaderFromMetafile(GpMetafile* metafile, MetafileHeader* header);

@DllImport("gdiplus.dll")
Status GdipGetHemfFromMetafile(GpMetafile* metafile, HENHMETAFILE* hEmf);

@DllImport("gdiplus.dll")
Status GdipCreateStreamOnFile(const(PWSTR) filename, uint access, IStream* stream);

@DllImport("gdiplus.dll")
Status GdipCreateMetafileFromWmf(HMETAFILE hWmf, BOOL deleteWmf, 
                                 const(WmfPlaceableFileHeader)* wmfPlaceableFileHeader, GpMetafile** metafile);

@DllImport("gdiplus.dll")
Status GdipCreateMetafileFromEmf(HENHMETAFILE hEmf, BOOL deleteEmf, GpMetafile** metafile);

@DllImport("gdiplus.dll")
Status GdipCreateMetafileFromFile(const(PWSTR) file, GpMetafile** metafile);

@DllImport("gdiplus.dll")
Status GdipCreateMetafileFromWmfFile(const(PWSTR) file, const(WmfPlaceableFileHeader)* wmfPlaceableFileHeader, 
                                     GpMetafile** metafile);

@DllImport("gdiplus.dll")
Status GdipCreateMetafileFromStream(IStream stream, GpMetafile** metafile);

@DllImport("gdiplus.dll")
Status GdipRecordMetafile(HDC referenceHdc, EmfType type, const(RectF)* frameRect, MetafileFrameUnit frameUnit, 
                          const(PWSTR) description, GpMetafile** metafile);

@DllImport("gdiplus.dll")
Status GdipRecordMetafileI(HDC referenceHdc, EmfType type, const(Rect)* frameRect, MetafileFrameUnit frameUnit, 
                           const(PWSTR) description, GpMetafile** metafile);

@DllImport("gdiplus.dll")
Status GdipRecordMetafileFileName(const(PWSTR) fileName, HDC referenceHdc, EmfType type, const(RectF)* frameRect, 
                                  MetafileFrameUnit frameUnit, const(PWSTR) description, GpMetafile** metafile);

@DllImport("gdiplus.dll")
Status GdipRecordMetafileFileNameI(const(PWSTR) fileName, HDC referenceHdc, EmfType type, const(Rect)* frameRect, 
                                   MetafileFrameUnit frameUnit, const(PWSTR) description, GpMetafile** metafile);

@DllImport("gdiplus.dll")
Status GdipRecordMetafileStream(IStream stream, HDC referenceHdc, EmfType type, const(RectF)* frameRect, 
                                MetafileFrameUnit frameUnit, const(PWSTR) description, GpMetafile** metafile);

@DllImport("gdiplus.dll")
Status GdipRecordMetafileStreamI(IStream stream, HDC referenceHdc, EmfType type, const(Rect)* frameRect, 
                                 MetafileFrameUnit frameUnit, const(PWSTR) description, GpMetafile** metafile);

@DllImport("gdiplus.dll")
Status GdipSetMetafileDownLevelRasterizationLimit(GpMetafile* metafile, uint metafileRasterizationLimitDpi);

@DllImport("gdiplus.dll")
Status GdipGetMetafileDownLevelRasterizationLimit(const(GpMetafile)* metafile, uint* metafileRasterizationLimitDpi);

@DllImport("gdiplus.dll")
Status GdipGetImageDecodersSize(uint* numDecoders, uint* size);

@DllImport("gdiplus.dll")
Status GdipGetImageDecoders(uint numDecoders, uint size, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ImageCodecInfo* decoders);

@DllImport("gdiplus.dll")
Status GdipGetImageEncodersSize(uint* numEncoders, uint* size);

@DllImport("gdiplus.dll")
Status GdipGetImageEncoders(uint numEncoders, uint size, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ImageCodecInfo* encoders);

@DllImport("gdiplus.dll")
Status GdipComment(GpGraphics* graphics, uint sizeData, const(ubyte)* data);

@DllImport("gdiplus.dll")
Status GdipCreateFontFamilyFromName(const(PWSTR) name, GpFontCollection* fontCollection, GpFontFamily** fontFamily);

@DllImport("gdiplus.dll")
Status GdipDeleteFontFamily(GpFontFamily* fontFamily);

@DllImport("gdiplus.dll")
Status GdipCloneFontFamily(GpFontFamily* fontFamily, GpFontFamily** clonedFontFamily);

@DllImport("gdiplus.dll")
Status GdipGetGenericFontFamilySansSerif(GpFontFamily** nativeFamily);

@DllImport("gdiplus.dll")
Status GdipGetGenericFontFamilySerif(GpFontFamily** nativeFamily);

@DllImport("gdiplus.dll")
Status GdipGetGenericFontFamilyMonospace(GpFontFamily** nativeFamily);

@DllImport("gdiplus.dll")
Status GdipGetFamilyName(const(GpFontFamily)* family, PWSTR name, ushort language);

@DllImport("gdiplus.dll")
Status GdipIsStyleAvailable(const(GpFontFamily)* family, int style, BOOL* IsStyleAvailable);

@DllImport("gdiplus.dll")
Status GdipGetEmHeight(const(GpFontFamily)* family, int style, ushort* EmHeight);

@DllImport("gdiplus.dll")
Status GdipGetCellAscent(const(GpFontFamily)* family, int style, ushort* CellAscent);

@DllImport("gdiplus.dll")
Status GdipGetCellDescent(const(GpFontFamily)* family, int style, ushort* CellDescent);

@DllImport("gdiplus.dll")
Status GdipGetLineSpacing(const(GpFontFamily)* family, int style, ushort* LineSpacing);

@DllImport("gdiplus.dll")
Status GdipCreateFontFromDC(HDC hdc, GpFont** font);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("gdiplus.dll")
Status GdipCreateFontFromLogfontA(HDC hdc, const(LOGFONTA)* logfont, GpFont** font);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("gdiplus.dll")
Status GdipCreateFontFromLogfontW(HDC hdc, const(LOGFONTW)* logfont, GpFont** font);

@DllImport("gdiplus.dll")
Status GdipCreateFont(const(GpFontFamily)* fontFamily, float emSize, int style, Unit unit, GpFont** font);

@DllImport("gdiplus.dll")
Status GdipCloneFont(GpFont* font, GpFont** cloneFont);

@DllImport("gdiplus.dll")
Status GdipDeleteFont(GpFont* font);

@DllImport("gdiplus.dll")
Status GdipGetFamily(GpFont* font, GpFontFamily** family);

@DllImport("gdiplus.dll")
Status GdipGetFontStyle(GpFont* font, int* style);

@DllImport("gdiplus.dll")
Status GdipGetFontSize(GpFont* font, float* size);

@DllImport("gdiplus.dll")
Status GdipGetFontUnit(GpFont* font, Unit* unit);

@DllImport("gdiplus.dll")
Status GdipGetFontHeight(const(GpFont)* font, const(GpGraphics)* graphics, float* height);

@DllImport("gdiplus.dll")
Status GdipGetFontHeightGivenDPI(const(GpFont)* font, float dpi, float* height);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("gdiplus.dll")
Status GdipGetLogFontA(GpFont* font, GpGraphics* graphics, LOGFONTA* logfontA);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("gdiplus.dll")
Status GdipGetLogFontW(GpFont* font, GpGraphics* graphics, LOGFONTW* logfontW);

@DllImport("gdiplus.dll")
Status GdipNewInstalledFontCollection(GpFontCollection** fontCollection);

@DllImport("gdiplus.dll")
Status GdipNewPrivateFontCollection(GpFontCollection** fontCollection);

@DllImport("gdiplus.dll")
Status GdipDeletePrivateFontCollection(GpFontCollection** fontCollection);

@DllImport("gdiplus.dll")
Status GdipGetFontCollectionFamilyCount(GpFontCollection* fontCollection, int* numFound);

@DllImport("gdiplus.dll")
Status GdipGetFontCollectionFamilyList(GpFontCollection* fontCollection, int numSought, GpFontFamily** gpfamilies, 
                                       int* numFound);

@DllImport("gdiplus.dll")
Status GdipPrivateAddFontFile(GpFontCollection* fontCollection, const(PWSTR) filename);

@DllImport("gdiplus.dll")
Status GdipPrivateAddMemoryFont(GpFontCollection* fontCollection, const(void)* memory, int length);

@DllImport("gdiplus.dll")
Status GdipDrawString(GpGraphics* graphics, const(PWSTR) string, int length, const(GpFont)* font, 
                      const(RectF)* layoutRect, const(GpStringFormat)* stringFormat, const(GpBrush)* brush);

@DllImport("gdiplus.dll")
Status GdipMeasureString(GpGraphics* graphics, const(PWSTR) string, int length, const(GpFont)* font, 
                         const(RectF)* layoutRect, const(GpStringFormat)* stringFormat, RectF* boundingBox, 
                         int* codepointsFitted, int* linesFilled);

@DllImport("gdiplus.dll")
Status GdipMeasureCharacterRanges(GpGraphics* graphics, const(PWSTR) string, int length, const(GpFont)* font, 
                                  const(RectF)* layoutRect, const(GpStringFormat)* stringFormat, int regionCount, 
                                  GpRegion** regions);

@DllImport("gdiplus.dll")
Status GdipDrawDriverString(GpGraphics* graphics, const(ushort)* text, int length, const(GpFont)* font, 
                            const(GpBrush)* brush, const(PointF)* positions, int flags, const(Matrix)* matrix);

@DllImport("gdiplus.dll")
Status GdipMeasureDriverString(GpGraphics* graphics, const(ushort)* text, int length, const(GpFont)* font, 
                               const(PointF)* positions, int flags, const(Matrix)* matrix, RectF* boundingBox);

@DllImport("gdiplus.dll")
Status GdipCreateStringFormat(int formatAttributes, ushort language, GpStringFormat** format);

@DllImport("gdiplus.dll")
Status GdipStringFormatGetGenericDefault(GpStringFormat** format);

@DllImport("gdiplus.dll")
Status GdipStringFormatGetGenericTypographic(GpStringFormat** format);

@DllImport("gdiplus.dll")
Status GdipDeleteStringFormat(GpStringFormat* format);

@DllImport("gdiplus.dll")
Status GdipCloneStringFormat(const(GpStringFormat)* format, GpStringFormat** newFormat);

@DllImport("gdiplus.dll")
Status GdipSetStringFormatFlags(GpStringFormat* format, int flags);

@DllImport("gdiplus.dll")
Status GdipGetStringFormatFlags(const(GpStringFormat)* format, int* flags);

@DllImport("gdiplus.dll")
Status GdipSetStringFormatAlign(GpStringFormat* format, StringAlignment align_);

@DllImport("gdiplus.dll")
Status GdipGetStringFormatAlign(const(GpStringFormat)* format, StringAlignment* align_);

@DllImport("gdiplus.dll")
Status GdipSetStringFormatLineAlign(GpStringFormat* format, StringAlignment align_);

@DllImport("gdiplus.dll")
Status GdipGetStringFormatLineAlign(const(GpStringFormat)* format, StringAlignment* align_);

@DllImport("gdiplus.dll")
Status GdipSetStringFormatTrimming(GpStringFormat* format, StringTrimming trimming);

@DllImport("gdiplus.dll")
Status GdipGetStringFormatTrimming(const(GpStringFormat)* format, StringTrimming* trimming);

@DllImport("gdiplus.dll")
Status GdipSetStringFormatHotkeyPrefix(GpStringFormat* format, int hotkeyPrefix);

@DllImport("gdiplus.dll")
Status GdipGetStringFormatHotkeyPrefix(const(GpStringFormat)* format, int* hotkeyPrefix);

@DllImport("gdiplus.dll")
Status GdipSetStringFormatTabStops(GpStringFormat* format, float firstTabOffset, int count, const(float)* tabStops);

@DllImport("gdiplus.dll")
Status GdipGetStringFormatTabStops(const(GpStringFormat)* format, int count, float* firstTabOffset, 
                                   float* tabStops);

@DllImport("gdiplus.dll")
Status GdipGetStringFormatTabStopCount(const(GpStringFormat)* format, int* count);

@DllImport("gdiplus.dll")
Status GdipSetStringFormatDigitSubstitution(GpStringFormat* format, ushort language, 
                                            StringDigitSubstitute substitute);

@DllImport("gdiplus.dll")
Status GdipGetStringFormatDigitSubstitution(const(GpStringFormat)* format, ushort* language, 
                                            StringDigitSubstitute* substitute);

@DllImport("gdiplus.dll")
Status GdipGetStringFormatMeasurableCharacterRangeCount(const(GpStringFormat)* format, int* count);

@DllImport("gdiplus.dll")
Status GdipSetStringFormatMeasurableCharacterRanges(GpStringFormat* format, int rangeCount, 
                                                    const(CharacterRange)* ranges);

@DllImport("gdiplus.dll")
Status GdipCreateCachedBitmap(GpBitmap* bitmap, GpGraphics* graphics, GpCachedBitmap** cachedBitmap);

@DllImport("gdiplus.dll")
Status GdipDeleteCachedBitmap(GpCachedBitmap* cachedBitmap);

@DllImport("gdiplus.dll")
Status GdipDrawCachedBitmap(GpGraphics* graphics, GpCachedBitmap* cachedBitmap, int x, int y);

@DllImport("gdiplus.dll")
uint GdipEmfToWmfBits(HENHMETAFILE hemf, uint cbData16, ubyte* pData16, int iMapMode, int eFlags);

@DllImport("gdiplus.dll")
Status GdipSetImageAttributesCachedBackground(GpImageAttributes* imageattr, BOOL enableFlag);

@DllImport("gdiplus.dll")
Status GdipTestControl(GpTestControlEnum control, void* param1);

@DllImport("gdiplus.dll")
Status GdiplusNotificationHook(size_t* token);

@DllImport("gdiplus.dll")
void GdiplusNotificationUnhook(size_t token);

@DllImport("gdiplus.dll")
Status GdipConvertToEmfPlus(const(GpGraphics)* refGraphics, GpMetafile* metafile, int* conversionFailureFlag, 
                            EmfType emfType, const(PWSTR) description, GpMetafile** out_metafile);

@DllImport("gdiplus.dll")
Status GdipConvertToEmfPlusToFile(const(GpGraphics)* refGraphics, GpMetafile* metafile, int* conversionFailureFlag, 
                                  const(PWSTR) filename, EmfType emfType, const(PWSTR) description, 
                                  GpMetafile** out_metafile);

@DllImport("gdiplus.dll")
Status GdipConvertToEmfPlusToStream(const(GpGraphics)* refGraphics, GpMetafile* metafile, 
                                    int* conversionFailureFlag, IStream stream, EmfType emfType, 
                                    const(PWSTR) description, GpMetafile** out_metafile);


// Interfaces

interface GdiplusAbort
{
    HRESULT Abort();
}

@GUID("025d1823-6c7d-447b-bbdb-a3cbc3dfa2fc")
interface IImageBytes : IUnknown
{
    HRESULT CountBytes(uint* pcb);
    HRESULT LockBytes(uint cb, uint ulOffset, const(void)** ppvBytes);
    HRESULT UnlockBytes(const(void)* pvBytes, uint cb, uint ulOffset);
}


// GUIDs


const GUID IID_IImageBytes = GUIDOF!IImageBytes;
