// Written in the D programming language.

module windows.win32.graphics.imaging;

public import windows.core;
public import windows.win32.foundation : BOOL, GENERIC_ACCESS_RIGHTS, HANDLE, HRESULT, PWSTR;
public import windows.win32.graphics.direct2d.common : D2D1_PIXEL_FORMAT;
public import windows.win32.graphics.dxgi.common : DXGI_FORMAT, DXGI_JPEG_AC_HUFFMAN_TABLE, DXGI_JPEG_DC_HUFFMAN_TABLE,
                                                   DXGI_JPEG_QUANTIZATION_TABLE;
public import windows.win32.graphics.gdi : HBITMAP, HPALETTE;
public import windows.win32.system.com : IEnumString, IEnumUnknown, IPersistStream, IStream, IUnknown;
public import windows.win32.system.com.structuredstorage : IPropertyBag2, PROPBAG2, PROPVARIANT;
public import windows.win32.ui.windowsandmessaging : HICON;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wiccolorcontexttype))], [])

enum WICColorContextType : int
{
    WICColorContextUninitialized  = 0x00000000,
    WICColorContextProfile        = 0x00000001,
    WICColorContextExifColorSpace = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicbitmapcreatecacheoption))], [])

enum WICBitmapCreateCacheOption : int
{
    WICBitmapNoCache       = 0x00000000,
    WICBitmapCacheOnDemand = 0x00000001,
    WICBitmapCacheOnLoad   = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicdecodeoptions))], [])

enum WICDecodeOptions : int
{
    WICDecodeMetadataCacheOnDemand = 0x00000000,
    WICDecodeMetadataCacheOnLoad   = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicbitmapencodercacheoption))], [])

enum WICBitmapEncoderCacheOption : int
{
    WICBitmapEncoderCacheInMemory = 0x00000000,
    WICBitmapEncoderCacheTempFile = 0x00000001,
    WICBitmapEncoderNoCache       = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wiccomponenttype))], [])

enum WICComponentType : int
{
    WICDecoder              = 0x00000001,
    WICEncoder              = 0x00000002,
    WICPixelFormatConverter = 0x00000004,
    WICMetadataReader       = 0x00000008,
    WICMetadataWriter       = 0x00000010,
    WICPixelFormat          = 0x00000020,
    WICAllComponents        = 0x0000003f,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wiccomponentenumerateoptions))], [])

enum WICComponentEnumerateOptions : int
{
    WICComponentEnumerateDefault     = 0x00000000,
    WICComponentEnumerateRefresh     = 0x00000001,
    WICComponentEnumerateDisabled    = 0x80000000,
    WICComponentEnumerateUnsigned    = 0x40000000,
    WICComponentEnumerateBuiltInOnly = 0x20000000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicbitmapinterpolationmode))], [])

enum WICBitmapInterpolationMode : int
{
    WICBitmapInterpolationModeNearestNeighbor  = 0x00000000,
    WICBitmapInterpolationModeLinear           = 0x00000001,
    WICBitmapInterpolationModeCubic            = 0x00000002,
    WICBitmapInterpolationModeFant             = 0x00000003,
    WICBitmapInterpolationModeHighQualityCubic = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicbitmappalettetype))], [])

enum WICBitmapPaletteType : int
{
    WICBitmapPaletteTypeCustom           = 0x00000000,
    WICBitmapPaletteTypeMedianCut        = 0x00000001,
    WICBitmapPaletteTypeFixedBW          = 0x00000002,
    WICBitmapPaletteTypeFixedHalftone8   = 0x00000003,
    WICBitmapPaletteTypeFixedHalftone27  = 0x00000004,
    WICBitmapPaletteTypeFixedHalftone64  = 0x00000005,
    WICBitmapPaletteTypeFixedHalftone125 = 0x00000006,
    WICBitmapPaletteTypeFixedHalftone216 = 0x00000007,
    WICBitmapPaletteTypeFixedWebPalette  = 0x00000007,
    WICBitmapPaletteTypeFixedHalftone252 = 0x00000008,
    WICBitmapPaletteTypeFixedHalftone256 = 0x00000009,
    WICBitmapPaletteTypeFixedGray4       = 0x0000000a,
    WICBitmapPaletteTypeFixedGray16      = 0x0000000b,
    WICBitmapPaletteTypeFixedGray256     = 0x0000000c,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicbitmapdithertype))], [])

enum WICBitmapDitherType : int
{
    WICBitmapDitherTypeNone           = 0x00000000,
    WICBitmapDitherTypeSolid          = 0x00000000,
    WICBitmapDitherTypeOrdered4x4     = 0x00000001,
    WICBitmapDitherTypeOrdered8x8     = 0x00000002,
    WICBitmapDitherTypeOrdered16x16   = 0x00000003,
    WICBitmapDitherTypeSpiral4x4      = 0x00000004,
    WICBitmapDitherTypeSpiral8x8      = 0x00000005,
    WICBitmapDitherTypeDualSpiral4x4  = 0x00000006,
    WICBitmapDitherTypeDualSpiral8x8  = 0x00000007,
    WICBitmapDitherTypeErrorDiffusion = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicbitmapalphachanneloption))], [])

enum WICBitmapAlphaChannelOption : int
{
    WICBitmapUseAlpha              = 0x00000000,
    WICBitmapUsePremultipliedAlpha = 0x00000001,
    WICBitmapIgnoreAlpha           = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicbitmaptransformoptions))], [])

enum WICBitmapTransformOptions : int
{
    WICBitmapTransformRotate0        = 0x00000000,
    WICBitmapTransformRotate90       = 0x00000001,
    WICBitmapTransformRotate180      = 0x00000002,
    WICBitmapTransformRotate270      = 0x00000003,
    WICBitmapTransformFlipHorizontal = 0x00000008,
    WICBitmapTransformFlipVertical   = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicbitmaplockflags))], [])

enum WICBitmapLockFlags : int
{
    WICBitmapLockRead  = 0x00000001,
    WICBitmapLockWrite = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicbitmapdecodercapabilities))], [])

enum WICBitmapDecoderCapabilities : int
{
    WICBitmapDecoderCapabilitySameEncoder          = 0x00000001,
    WICBitmapDecoderCapabilityCanDecodeAllImages   = 0x00000002,
    WICBitmapDecoderCapabilityCanDecodeSomeImages  = 0x00000004,
    WICBitmapDecoderCapabilityCanEnumerateMetadata = 0x00000008,
    WICBitmapDecoderCapabilityCanDecodeThumbnail   = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicprogressoperation))], [])

enum WICProgressOperation : int
{
    WICProgressOperationCopyPixels  = 0x00000001,
    WICProgressOperationWritePixels = 0x00000002,
    WICProgressOperationAll         = 0x0000ffff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicprogressnotification))], [])

enum WICProgressNotification : int
{
    WICProgressNotificationBegin    = 0x00010000,
    WICProgressNotificationEnd      = 0x00020000,
    WICProgressNotificationFrequent = 0x00040000,
    WICProgressNotificationAll      = 0xffff0000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wiccomponentsigning))], [])

enum WICComponentSigning : int
{
    WICComponentSigned   = 0x00000001,
    WICComponentUnsigned = 0x00000002,
    WICComponentSafe     = 0x00000004,
    WICComponentDisabled = 0x80000000,
}

enum WICBitmapToneMappingMode : int
{
    WICBitmapToneMappingMode_None    = 0x00000000,
    WICBitmapToneMappingMode_Default = 0x00000001,
    WICBitmapToneMappingMode_D2D     = 0x00000002,
    WICBitmapToneMappingMode_GainMap = 0x00000003,
}

enum WICBitmapChainType : int
{
    WICBitmapChainType_Alternate = 0x00000001,
    WICBitmapChainType_Layer     = 0x00000002,
    WICBitmapChainType_Preview   = 0x00000003,
    WICBitmapChainType_Thumbnail = 0x00000004,
    WICBitmapChainType_AlphaMap  = 0x00000005,
    WICBitmapChainType_DepthMap  = 0x00000006,
    WICBitmapChainType_GainMap   = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicgiflogicalscreendescriptorproperties))], [])

enum WICGifLogicalScreenDescriptorProperties : int
{
    WICGifLogicalScreenSignature                      = 0x00000001,
    WICGifLogicalScreenDescriptorWidth                = 0x00000002,
    WICGifLogicalScreenDescriptorHeight               = 0x00000003,
    WICGifLogicalScreenDescriptorGlobalColorTableFlag = 0x00000004,
    WICGifLogicalScreenDescriptorColorResolution      = 0x00000005,
    WICGifLogicalScreenDescriptorSortFlag             = 0x00000006,
    WICGifLogicalScreenDescriptorGlobalColorTableSize = 0x00000007,
    WICGifLogicalScreenDescriptorBackgroundColorIndex = 0x00000008,
    WICGifLogicalScreenDescriptorPixelAspectRatio     = 0x00000009,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicgifimagedescriptorproperties))], [])

enum WICGifImageDescriptorProperties : int
{
    WICGifImageDescriptorLeft                = 0x00000001,
    WICGifImageDescriptorTop                 = 0x00000002,
    WICGifImageDescriptorWidth               = 0x00000003,
    WICGifImageDescriptorHeight              = 0x00000004,
    WICGifImageDescriptorLocalColorTableFlag = 0x00000005,
    WICGifImageDescriptorInterlaceFlag       = 0x00000006,
    WICGifImageDescriptorSortFlag            = 0x00000007,
    WICGifImageDescriptorLocalColorTableSize = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicgifgraphiccontrolextensionproperties))], [])

enum WICGifGraphicControlExtensionProperties : int
{
    WICGifGraphicControlExtensionDisposal              = 0x00000001,
    WICGifGraphicControlExtensionUserInputFlag         = 0x00000002,
    WICGifGraphicControlExtensionTransparencyFlag      = 0x00000003,
    WICGifGraphicControlExtensionDelay                 = 0x00000004,
    WICGifGraphicControlExtensionTransparentColorIndex = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicgifapplicationextensionproperties))], [])

enum WICGifApplicationExtensionProperties : int
{
    WICGifApplicationExtensionApplication = 0x00000001,
    WICGifApplicationExtensionData        = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicgifcommentextensionproperties))], [])

enum WICGifCommentExtensionProperties : int
{
    WICGifCommentExtensionText = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicjpegcommentproperties))], [])

enum WICJpegCommentProperties : int
{
    WICJpegCommentText = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicjpegluminanceproperties))], [])

enum WICJpegLuminanceProperties : int
{
    WICJpegLuminanceTable = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicjpegchrominanceproperties))], [])

enum WICJpegChrominanceProperties : int
{
    WICJpegChrominanceTable = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wic8bimiptcproperties))], [])

enum WIC8BIMIptcProperties : int
{
    WIC8BIMIptcPString      = 0x00000000,
    WIC8BIMIptcEmbeddedIPTC = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wic8bimresolutioninfoproperties))], [])

enum WIC8BIMResolutionInfoProperties : int
{
    WIC8BIMResolutionInfoPString         = 0x00000001,
    WIC8BIMResolutionInfoHResolution     = 0x00000002,
    WIC8BIMResolutionInfoHResolutionUnit = 0x00000003,
    WIC8BIMResolutionInfoWidthUnit       = 0x00000004,
    WIC8BIMResolutionInfoVResolution     = 0x00000005,
    WIC8BIMResolutionInfoVResolutionUnit = 0x00000006,
    WIC8BIMResolutionInfoHeightUnit      = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wic8bimiptcdigestproperties))], [])

enum WIC8BIMIptcDigestProperties : int
{
    WIC8BIMIptcDigestPString    = 0x00000001,
    WIC8BIMIptcDigestIptcDigest = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpnggamaproperties))], [])

enum WICPngGamaProperties : int
{
    WICPngGamaGamma = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpngbkgdproperties))], [])

enum WICPngBkgdProperties : int
{
    WICPngBkgdBackgroundColor = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpngitxtproperties))], [])

enum WICPngItxtProperties : int
{
    WICPngItxtKeyword           = 0x00000001,
    WICPngItxtCompressionFlag   = 0x00000002,
    WICPngItxtLanguageTag       = 0x00000003,
    WICPngItxtTranslatedKeyword = 0x00000004,
    WICPngItxtText              = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpngchrmproperties))], [])

enum WICPngChrmProperties : int
{
    WICPngChrmWhitePointX = 0x00000001,
    WICPngChrmWhitePointY = 0x00000002,
    WICPngChrmRedX        = 0x00000003,
    WICPngChrmRedY        = 0x00000004,
    WICPngChrmGreenX      = 0x00000005,
    WICPngChrmGreenY      = 0x00000006,
    WICPngChrmBlueX       = 0x00000007,
    WICPngChrmBlueY       = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpnghistproperties))], [])

enum WICPngHistProperties : int
{
    WICPngHistFrequencies = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpngiccpproperties))], [])

enum WICPngIccpProperties : int
{
    WICPngIccpProfileName = 0x00000001,
    WICPngIccpProfileData = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpngsrgbproperties))], [])

enum WICPngSrgbProperties : int
{
    WICPngSrgbRenderingIntent = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpngtimeproperties))], [])

enum WICPngTimeProperties : int
{
    WICPngTimeYear   = 0x00000001,
    WICPngTimeMonth  = 0x00000002,
    WICPngTimeDay    = 0x00000003,
    WICPngTimeHour   = 0x00000004,
    WICPngTimeMinute = 0x00000005,
    WICPngTimeSecond = 0x00000006,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicheifproperties))], [])

enum WICHeifProperties : int
{
    WICHeifOrientation                = 0x00000001,
    WICHeifLayeredImageCanvasColor    = 0x00000002,
    WICHeifLayeredImageLayerPositions = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicheifhdrproperties))], [])

enum WICHeifHdrProperties : int
{
    WICHeifHdrMaximumLuminanceLevel                 = 0x00000001,
    WICHeifHdrMaximumFrameAverageLuminanceLevel     = 0x00000002,
    WICHeifHdrMinimumMasteringDisplayLuminanceLevel = 0x00000003,
    WICHeifHdrMaximumMasteringDisplayLuminanceLevel = 0x00000004,
    WICHeifHdrCustomVideoPrimaries                  = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicwebpanimproperties))], [])

enum WICWebpAnimProperties : int
{
    WICWebpAnimLoopCount = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicwebpanmfproperties))], [])

enum WICWebpAnmfProperties : int
{
    WICWebpAnmfFrameDuration = 0x00000001,
}

enum WICJpegXLAnimProperties : int
{
    WICJpegXLAnimLoopCount                      = 0x00000001,
    WICJpegXLAnimFrameTicksPerSecondNumerator   = 0x00000002,
    WICJpegXLAnimFrameTicksPerSecondDenominator = 0x00000003,
}

enum WICJpegXLAnimFrameProperties : int
{
    WICJpegXLAnimFrameDurationInTicks = 0x00000001,
    WICJpegXLAnimFrameName            = 0x00000002,
}

enum WICGainMapProperties : int
{
    WICGainMapMetadata = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicsectionaccesslevel))], [])

enum WICSectionAccessLevel : int
{
    WICSectionAccessLevelRead      = 0x00000001,
    WICSectionAccessLevelReadWrite = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpixelformatnumericrepresentation))], [])

enum WICPixelFormatNumericRepresentation : int
{
    WICPixelFormatNumericRepresentationUnspecified     = 0x00000000,
    WICPixelFormatNumericRepresentationIndexed         = 0x00000001,
    WICPixelFormatNumericRepresentationUnsignedInteger = 0x00000002,
    WICPixelFormatNumericRepresentationSignedInteger   = 0x00000003,
    WICPixelFormatNumericRepresentationFixed           = 0x00000004,
    WICPixelFormatNumericRepresentationFloat           = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicplanaroptions))], [])

enum WICPlanarOptions : int
{
    WICPlanarOptionsDefault             = 0x00000000,
    WICPlanarOptionsPreserveSubsampling = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicjpegindexingoptions))], [])

enum WICJpegIndexingOptions : int
{
    WICJpegIndexingOptionsGenerateOnDemand = 0x00000000,
    WICJpegIndexingOptionsGenerateOnLoad   = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicjpegtransfermatrix))], [])

enum WICJpegTransferMatrix : int
{
    WICJpegTransferMatrixIdentity = 0x00000000,
    WICJpegTransferMatrixBT601    = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicjpegscantype))], [])

enum WICJpegScanType : int
{
    WICJpegScanTypeInterleaved      = 0x00000000,
    WICJpegScanTypePlanarComponents = 0x00000001,
    WICJpegScanTypeProgressive      = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wictiffcompressionoption))], [])

enum WICTiffCompressionOption : int
{
    WICTiffCompressionDontCare         = 0x00000000,
    WICTiffCompressionNone             = 0x00000001,
    WICTiffCompressionCCITT3           = 0x00000002,
    WICTiffCompressionCCITT4           = 0x00000003,
    WICTiffCompressionLZW              = 0x00000004,
    WICTiffCompressionRLE              = 0x00000005,
    WICTiffCompressionZIP              = 0x00000006,
    WICTiffCompressionLZWHDifferencing = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicjpegycrcbsubsamplingoption))], [])

enum WICJpegYCrCbSubsamplingOption : int
{
    WICJpegYCrCbSubsamplingDefault = 0x00000000,
    WICJpegYCrCbSubsampling420     = 0x00000001,
    WICJpegYCrCbSubsampling422     = 0x00000002,
    WICJpegYCrCbSubsampling444     = 0x00000003,
    WICJpegYCrCbSubsampling440     = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicpngfilteroption))], [])

enum WICPngFilterOption : int
{
    WICPngFilterUnspecified = 0x00000000,
    WICPngFilterNone        = 0x00000001,
    WICPngFilterSub         = 0x00000002,
    WICPngFilterUp          = 0x00000003,
    WICPngFilterAverage     = 0x00000004,
    WICPngFilterPaeth       = 0x00000005,
    WICPngFilterAdaptive    = 0x00000006,
}

enum WICHeifCompressionOption : int
{
    WICHeifCompressionDontCare = 0x00000000,
    WICHeifCompressionNone     = 0x00000001,
    WICHeifCompressionHEVC     = 0x00000002,
    WICHeifCompressionAV1      = 0x00000003,
    WICHeifCompressionJpegXL   = 0x00000004,
    WICHeifCompressionBrotli   = 0x00000005,
    WICHeifCompressionDeflate  = 0x00000006,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicnamedwhitepoint))], [])

enum WICNamedWhitePoint : int
{
    WICWhitePointDefault          = 0x00000001,
    WICWhitePointDaylight         = 0x00000002,
    WICWhitePointCloudy           = 0x00000004,
    WICWhitePointShade            = 0x00000008,
    WICWhitePointTungsten         = 0x00000010,
    WICWhitePointFluorescent      = 0x00000020,
    WICWhitePointFlash            = 0x00000040,
    WICWhitePointUnderwater       = 0x00000080,
    WICWhitePointCustom           = 0x00000100,
    WICWhitePointAutoWhiteBalance = 0x00000200,
    WICWhitePointAsShot           = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicrawcapabilities))], [])

enum WICRawCapabilities : int
{
    WICRawCapabilityNotSupported   = 0x00000000,
    WICRawCapabilityGetSupported   = 0x00000001,
    WICRawCapabilityFullySupported = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicrawrotationcapabilities))], [])

enum WICRawRotationCapabilities : int
{
    WICRawRotationCapabilityNotSupported           = 0x00000000,
    WICRawRotationCapabilityGetSupported           = 0x00000001,
    WICRawRotationCapabilityNinetyDegreesSupported = 0x00000002,
    WICRawRotationCapabilityFullySupported         = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicrawparameterset))], [])

enum WICRawParameterSet : int
{
    WICAsShotParameterSet       = 0x00000001,
    WICUserAdjustedParameterSet = 0x00000002,
    WICAutoAdjustedParameterSet = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicrawrendermode))], [])

enum WICRawRenderMode : int
{
    WICRawRenderModeDraft       = 0x00000001,
    WICRawRenderModeNormal      = 0x00000002,
    WICRawRenderModeBestQuality = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicddsdimension))], [])

enum WICDdsDimension : int
{
    WICDdsTexture1D   = 0x00000000,
    WICDdsTexture2D   = 0x00000001,
    WICDdsTexture3D   = 0x00000002,
    WICDdsTextureCube = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ne-wincodec-wicddsalphamode))], [])

enum WICDdsAlphaMode : int
{
    WICDdsAlphaModeUnknown       = 0x00000000,
    WICDdsAlphaModeStraight      = 0x00000001,
    WICDdsAlphaModePremultiplied = 0x00000002,
    WICDdsAlphaModeOpaque        = 0x00000003,
    WICDdsAlphaModeCustom        = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/ne-wincodecsdk-wicmetadatacreationoptions))], [])

enum WICMetadataCreationOptions : int
{
    WICMetadataCreationDefault      = 0x00000000,
    WICMetadataCreationAllowUnknown = 0x00000000,
    WICMetadataCreationFailUnknown  = 0x00010000,
    WICMetadataCreationMask         = 0xffff0000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/ne-wincodecsdk-wicpersistoptions))], [])

enum WICPersistOptions : int
{
    WICPersistOptionDefault       = 0x00000000,
    WICPersistOptionLittleEndian  = 0x00000000,
    WICPersistOptionBigEndian     = 0x00000001,
    WICPersistOptionStrictFormat  = 0x00000002,
    WICPersistOptionNoCacheStream = 0x00000004,
    WICPersistOptionPreferUTF8    = 0x00000008,
    WICPersistOptionMask          = 0x0000ffff,
}

// Constants


enum : uint
{
    WINCODEC_SDK_VERSION1 = 0x00000236,
    WINCODEC_SDK_VERSION2 = 0x00000237,
    WINCODEC_SDK_VERSION  = 0x00000237,
}

enum uint WIC_JPEG_MAX_TABLE_INDEX = 0x00000003;

enum : uint
{
    WIC_JPEG_SAMPLE_FACTORS_THREE_420 = 0x00111122,
    WIC_JPEG_SAMPLE_FACTORS_THREE_422 = 0x00111121,
    WIC_JPEG_SAMPLE_FACTORS_THREE_440 = 0x00111112,
    WIC_JPEG_SAMPLE_FACTORS_THREE_444 = 0x00111111,
}

enum uint WIC_JPEG_QUANTIZATION_BASELINE_THREE = 0x00010100;
enum uint WIC_JPEG_HUFFMAN_BASELINE_THREE = 0x00111100;
enum uint WINCODEC_ERR_BASE = 0x00002000;

enum : int
{
    WINCODEC_ERR_INVALIDPARAMETER = 0x80070057,
    WINCODEC_ERR_OUTOFMEMORY      = 0x8007000e,
    WINCODEC_ERR_NOTIMPLEMENTED   = 0x80004001,
    WINCODEC_ERR_ABORTED          = 0x80004004,
    WINCODEC_ERR_ACCESSDENIED     = 0x80070005,
}

enum : uint
{
    WICRawChangeNotification_NamedWhitePoint         = 0x00000002,
    WICRawChangeNotification_KelvinWhitePoint        = 0x00000004,
    WICRawChangeNotification_RGBWhitePoint           = 0x00000008,
    WICRawChangeNotification_Contrast                = 0x00000010,
    WICRawChangeNotification_Gamma                   = 0x00000020,
    WICRawChangeNotification_Sharpness               = 0x00000040,
    WICRawChangeNotification_Saturation              = 0x00000080,
    WICRawChangeNotification_Tint                    = 0x00000100,
    WICRawChangeNotification_NoiseReduction          = 0x00000200,
    WICRawChangeNotification_DestinationColorContext = 0x00000400,
    WICRawChangeNotification_ToneCurve               = 0x00000800,
    WICRawChangeNotification_Rotation                = 0x00001000,
    WICRawChangeNotification_RenderMode              = 0x00002000,
}

// Callbacks

alias PFNProgressNotification = HRESULT function(void* pvData, uint uFrameNum, WICProgressOperation operation, 
                                                 double dblProgress);

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicrect))], [])
struct WICRect
{
    int X;
    int Y;
    int Width;
    int Height;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicbitmappattern))], [])
struct WICBitmapPattern
{
    ulong  Position;
    uint   Length;
    ubyte* Pattern;
    ubyte* Mask;
    BOOL   EndOfStream;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicimageparameters))], [])
struct WICImageParameters
{
    D2D1_PIXEL_FORMAT PixelFormat;
    float             DpiX;
    float             DpiY;
    float             Top;
    float             Left;
    uint              PixelWidth;
    uint              PixelHeight;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicbitmapplanedescription))], [])
struct WICBitmapPlaneDescription
{
    GUID Format;
    uint Width;
    uint Height;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicbitmapplane))], [])
struct WICBitmapPlane
{
    GUID   Format;
    ubyte* pbBuffer;
    uint   cbStride;
    uint   cbBufferSize;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicjpegframeheader))], [])
struct WICJpegFrameHeader
{
    uint            Width;
    uint            Height;
    WICJpegTransferMatrix TransferMatrix;
    WICJpegScanType ScanType;
    uint            cComponents;
    uint            ComponentIdentifiers;
    uint            SampleFactors;
    uint            QuantizationTableIndices;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicjpegscanheader))], [])
struct WICJpegScanHeader
{
    uint  cComponents;
    uint  RestartInterval;
    uint  ComponentSelectors;
    uint  HuffmanTableIndices;
    ubyte StartSpectralSelection;
    ubyte EndSpectralSelection;
    ubyte SuccessiveApproximationHigh;
    ubyte SuccessiveApproximationLow;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicrawcapabilitiesinfo))], [])
struct WICRawCapabilitiesInfo
{
    uint               cbSize;
    uint               CodecMajorVersion;
    uint               CodecMinorVersion;
    WICRawCapabilities ExposureCompensationSupport;
    WICRawCapabilities ContrastSupport;
    WICRawCapabilities RGBWhitePointSupport;
    WICRawCapabilities NamedWhitePointSupport;
    uint               NamedWhitePointSupportMask;
    WICRawCapabilities KelvinWhitePointSupport;
    WICRawCapabilities GammaSupport;
    WICRawCapabilities TintSupport;
    WICRawCapabilities SaturationSupport;
    WICRawCapabilities SharpnessSupport;
    WICRawCapabilities NoiseReductionSupport;
    WICRawCapabilities DestinationColorProfileSupport;
    WICRawCapabilities ToneCurveSupport;
    WICRawRotationCapabilities RotationSupport;
    WICRawCapabilities RenderModeSupport;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicrawtonecurvepoint))], [])
struct WICRawToneCurvePoint
{
    double Input;
    double Output;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicrawtonecurve))], [])
struct WICRawToneCurve
{
    uint cPoints;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/WICRawToneCurvePoint[1] aPoints;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicddsparameters))], [])
struct WICDdsParameters
{
    uint            Width;
    uint            Height;
    uint            Depth;
    uint            MipLevels;
    uint            ArraySize;
    DXGI_FORMAT     DxgiFormat;
    WICDdsDimension Dimension;
    WICDdsAlphaMode AlphaMode;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/ns-wincodec-wicddsformatinfo))], [])
struct WICDdsFormatInfo
{
    DXGI_FORMAT DxgiFormat;
    uint        BytesPerBlock;
    uint        BlockWidth;
    uint        BlockHeight;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/ns-wincodecsdk-wicmetadatapattern))], [])
struct WICMetadataPattern
{
    ulong  Position;
    uint   Length;
    ubyte* Pattern;
    ubyte* Mask;
    ulong  DataOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/ns-wincodecsdk-wicmetadataheader))], [])
struct WICMetadataHeader
{
    ulong  Position;
    uint   Length;
    ubyte* Header;
    ulong  DataOffset;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-wicconvertbitmapsource))], [])
@DllImport("WindowsCodecs.dll")
HRESULT WICConvertBitmapSource(GUID* dstFormat, IWICBitmapSource pISrc, IWICBitmapSource* ppIDst);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-wiccreatebitmapfromsection))], [])
@DllImport("WindowsCodecs.dll")
HRESULT WICCreateBitmapFromSection(uint width, uint height, GUID* pixelFormat, HANDLE hSection, uint stride, 
                                   uint offset, IWICBitmap* ppIBitmap);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-wiccreatebitmapfromsectionex))], [])
@DllImport("WindowsCodecs.dll")
HRESULT WICCreateBitmapFromSectionEx(uint width, uint height, GUID* pixelFormat, HANDLE hSection, uint stride, 
                                     uint offset, WICSectionAccessLevel desiredAccessLevel, IWICBitmap* ppIBitmap);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-wicmapguidtoshortname))], [])
@DllImport("WindowsCodecs.dll")
HRESULT WICMapGuidToShortName(const(GUID)* guid, uint cchName, PWSTR wzName, uint* pcchActual);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-wicmapshortnametoguid))], [])
@DllImport("WindowsCodecs.dll")
HRESULT WICMapShortNameToGuid(const(PWSTR) wzName, GUID* pguid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-wicmapschematoname))], [])
@DllImport("WindowsCodecs.dll")
HRESULT WICMapSchemaToName(const(GUID)* guidMetadataFormat, PWSTR pwzSchema, uint cchName, PWSTR wzName, 
                           uint* pcchActual);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-wicmatchmetadatacontent))], [])
@DllImport("WindowsCodecs.dll")
HRESULT WICMatchMetadataContent(const(GUID)* guidContainerFormat, const(GUID)* pguidVendor, IStream pIStream, 
                                GUID* pguidMetadataFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-wicserializemetadatacontent))], [])
@DllImport("WindowsCodecs.dll")
HRESULT WICSerializeMetadataContent(const(GUID)* guidContainerFormat, IWICMetadataWriter pIWriter, 
                                    uint dwPersistOptions, IStream pIStream);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-wicgetmetadatacontentsize))], [])
@DllImport("WindowsCodecs.dll")
HRESULT WICGetMetadataContentSize(const(GUID)* guidContainerFormat, IWICMetadataWriter pIWriter, ulong* pcbSize);


// Interfaces

@GUID("00000040-a8f2-4877-ba0a-fd2b6645fb94")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicpalette))], [])
interface IWICPalette : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-initializepredefined))], [])
    HRESULT InitializePredefined(WICBitmapPaletteType ePaletteType, BOOL fAddTransparentColor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-initializecustom))], [])
    HRESULT InitializeCustom(uint* pColors, uint cCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-initializefrombitmap))], [])
    HRESULT InitializeFromBitmap(IWICBitmapSource pISurface, uint cCount, BOOL fAddTransparentColor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-initializefrompalette))], [])
    HRESULT InitializeFromPalette(IWICPalette pIPalette);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-gettype))], [])
    HRESULT GetType(WICBitmapPaletteType* pePaletteType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-getcolorcount))], [])
    HRESULT GetColorCount(uint* pcCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-getcolors))], [])
    HRESULT GetColors(uint cCount, uint* pColors, uint* pcActualColors);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-isblackwhite))], [])
    HRESULT IsBlackWhite(BOOL* pfIsBlackWhite);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-isgrayscale))], [])
    HRESULT IsGrayscale(BOOL* pfIsGrayscale);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpalette-hasalpha))], [])
    HRESULT HasAlpha(BOOL* pfHasAlpha);
}

@GUID("00000120-a8f2-4877-ba0a-fd2b6645fb94")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapsource))], [])
interface IWICBitmapSource : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapsource-getsize))], [])
    HRESULT GetSize(uint* puiWidth, uint* puiHeight);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapsource-getpixelformat))], [])
    HRESULT GetPixelFormat(GUID* pPixelFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapsource-getresolution))], [])
    HRESULT GetResolution(double* pDpiX, double* pDpiY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapsource-copypalette))], [])
    HRESULT CopyPalette(IWICPalette pIPalette);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapsource-copypixels))], [])
    HRESULT CopyPixels(const(WICRect)* prc, uint cbStride, uint cbBufferSize, ubyte* pbBuffer);
}

@GUID("00000301-a8f2-4877-ba0a-fd2b6645fb94")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicformatconverter))], [])
interface IWICFormatConverter : IWICBitmapSource
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicformatconverter-initialize))], [])
    HRESULT Initialize(IWICBitmapSource pISource, GUID* dstFormat, WICBitmapDitherType dither, 
                       IWICPalette pIPalette, double alphaThresholdPercent, WICBitmapPaletteType paletteTranslate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicformatconverter-canconvert))], [])
    HRESULT CanConvert(GUID* srcPixelFormat, GUID* dstPixelFormat, BOOL* pfCanConvert);
}

@GUID("bebee9cb-83b0-4dcc-8132-b0aaa55eac96")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicplanarformatconverter))], [])
interface IWICPlanarFormatConverter : IWICBitmapSource
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicplanarformatconverter-initialize))], [])
    HRESULT Initialize(IWICBitmapSource* ppPlanes, uint cPlanes, GUID* dstFormat, WICBitmapDitherType dither, 
                       IWICPalette pIPalette, double alphaThresholdPercent, WICBitmapPaletteType paletteTranslate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicplanarformatconverter-canconvert))], [])
    HRESULT CanConvert(const(GUID)* pSrcPixelFormats, uint cSrcPlanes, GUID* dstPixelFormat, BOOL* pfCanConvert);
}

@GUID("00000302-a8f2-4877-ba0a-fd2b6645fb94")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapscaler))], [])
interface IWICBitmapScaler : IWICBitmapSource
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapscaler-initialize))], [])
    HRESULT Initialize(IWICBitmapSource pISource, uint uiWidth, uint uiHeight, WICBitmapInterpolationMode mode);
}

@GUID("e4fbcf03-223d-4e81-9333-d635556dd1b5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapclipper))], [])
interface IWICBitmapClipper : IWICBitmapSource
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapclipper-initialize))], [])
    HRESULT Initialize(IWICBitmapSource pISource, const(WICRect)* prc);
}

@GUID("5009834f-2d6a-41ce-9e1b-17c5aff7a782")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapfliprotator))], [])
interface IWICBitmapFlipRotator : IWICBitmapSource
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapfliprotator-initialize))], [])
    HRESULT Initialize(IWICBitmapSource pISource, WICBitmapTransformOptions options);
}

@GUID("44728ded-1edf-4fe9-b50b-c89a264c9439")
interface IWICBitmapToneMapper : IWICBitmapSource
{
    HRESULT InitializeForHdrTarget(IWICBitmapSource pISource, GUID* guidDstFormat, float fLuminanceInNits, 
                                   float fWhiteLevelInNits, WICBitmapToneMappingMode mode);
    HRESULT InitializeForSdrTarget(IWICBitmapSource pISource, GUID* guidDstFormat, WICBitmapToneMappingMode mode);
}

@GUID("00000123-a8f2-4877-ba0a-fd2b6645fb94")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmaplock))], [])
interface IWICBitmapLock : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmaplock-getsize))], [])
    HRESULT GetSize(uint* puiWidth, uint* puiHeight);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmaplock-getstride))], [])
    HRESULT GetStride(uint* pcbStride);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmaplock-getdatapointer))], [])
    HRESULT GetDataPointer(uint* pcbBufferSize, ubyte** ppbData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmaplock-getpixelformat))], [])
    HRESULT GetPixelFormat(GUID* pPixelFormat);
}

@GUID("00000121-a8f2-4877-ba0a-fd2b6645fb94")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmap))], [])
interface IWICBitmap : IWICBitmapSource
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmap-lock))], [])
    HRESULT Lock(const(WICRect)* prcLock, uint flags, IWICBitmapLock* ppILock);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmap-setpalette))], [])
    HRESULT SetPalette(IWICPalette pIPalette);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmap-setresolution))], [])
    HRESULT SetResolution(double dpiX, double dpiY);
}

@GUID("3c613a02-34b2-44ea-9a7c-45aea9c6fd6d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwiccolorcontext))], [])
interface IWICColorContext : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccolorcontext-initializefromfilename))], [])
    HRESULT InitializeFromFilename(const(PWSTR) wzFilename);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccolorcontext-initializefrommemory))], [])
    HRESULT InitializeFromMemory(const(ubyte)* pbBuffer, uint cbBufferSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccolorcontext-initializefromexifcolorspace))], [])
    HRESULT InitializeFromExifColorSpace(uint value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccolorcontext-gettype))], [])
    HRESULT GetType(WICColorContextType* pType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccolorcontext-getprofilebytes))], [])
    HRESULT GetProfileBytes(uint cbBuffer, ubyte* pbBuffer, uint* pcbActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccolorcontext-getexifcolorspace))], [])
    HRESULT GetExifColorSpace(uint* pValue);
}

@GUID("b66f034f-d0e2-40ab-b436-6de39e321a94")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwiccolortransform))], [])
interface IWICColorTransform : IWICBitmapSource
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccolortransform-initialize))], [])
    HRESULT Initialize(IWICBitmapSource pIBitmapSource, IWICColorContext pIContextSource, 
                       IWICColorContext pIContextDest, GUID* pixelFmtDest);
}

@GUID("b84e2c09-78c9-4ac4-8bd3-524ae1663a2f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicfastmetadataencoder))], [])
interface IWICFastMetadataEncoder : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicfastmetadataencoder-commit))], [])
    HRESULT Commit();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicfastmetadataencoder-getmetadataquerywriter))], [])
    HRESULT GetMetadataQueryWriter(IWICMetadataQueryWriter* ppIMetadataQueryWriter);
}

@GUID("135ff860-22b7-4ddf-b0f6-218f4f299a43")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicstream))], [])
interface IWICStream : IStream
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicstream-initializefromistream))], [])
    HRESULT InitializeFromIStream(IStream pIStream);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicstream-initializefromfilename))], [])
    HRESULT InitializeFromFilename(const(PWSTR) wzFileName, uint dwDesiredAccess);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicstream-initializefrommemory))], [])
    HRESULT InitializeFromMemory(ubyte* pbBuffer, uint cbBufferSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicstream-initializefromistreamregion))], [])
    HRESULT InitializeFromIStreamRegion(IStream pIStream, ulong ulOffset, ulong ulMaxSize);
}

@GUID("dc2bb46d-3f07-481e-8625-220c4aedbb33")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicenummetadataitem))], [])
interface IWICEnumMetadataItem : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicenummetadataitem-next))], [])
    HRESULT Next(uint celt, PROPVARIANT* rgeltSchema, PROPVARIANT* rgeltId, PROPVARIANT* rgeltValue, 
                 uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicenummetadataitem-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicenummetadataitem-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicenummetadataitem-clone))], [])
    HRESULT Clone(IWICEnumMetadataItem* ppIEnumMetadataItem);
}

@GUID("30989668-e1c9-4597-b395-458eedb808df")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicmetadataqueryreader))], [])
interface IWICMetadataQueryReader : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicmetadataqueryreader-getcontainerformat))], [])
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicmetadataqueryreader-getlocation))], [])
    HRESULT GetLocation(uint cchMaxLength, PWSTR wzNamespace, uint* pcchActualLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicmetadataqueryreader-getmetadatabyname))], [])
    HRESULT GetMetadataByName(const(PWSTR) wzName, PROPVARIANT* pvarValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicmetadataqueryreader-getenumerator))], [])
    HRESULT GetEnumerator(IEnumString* ppIEnumString);
}

@GUID("a721791a-0def-4d06-bd91-2118bf1db10b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicmetadataquerywriter))], [])
interface IWICMetadataQueryWriter : IWICMetadataQueryReader
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicmetadataquerywriter-setmetadatabyname))], [])
    HRESULT SetMetadataByName(const(PWSTR) wzName, const(PROPVARIANT)* pvarValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicmetadataquerywriter-removemetadatabyname))], [])
    HRESULT RemoveMetadataByName(const(PWSTR) wzName);
}

@GUID("00000103-a8f2-4877-ba0a-fd2b6645fb94")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapencoder))], [])
interface IWICBitmapEncoder : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-initialize))], [])
    HRESULT Initialize(IStream pIStream, WICBitmapEncoderCacheOption cacheOption);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-getcontainerformat))], [])
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-getencoderinfo))], [])
    HRESULT GetEncoderInfo(IWICBitmapEncoderInfo* ppIEncoderInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-setcolorcontexts))], [])
    HRESULT SetColorContexts(uint cCount, IWICColorContext* ppIColorContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-setpalette))], [])
    HRESULT SetPalette(IWICPalette pIPalette);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-setthumbnail))], [])
    HRESULT SetThumbnail(IWICBitmapSource pIThumbnail);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-setpreview))], [])
    HRESULT SetPreview(IWICBitmapSource pIPreview);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-createnewframe))], [])
    HRESULT CreateNewFrame(IWICBitmapFrameEncode* ppIFrameEncode, IPropertyBag2* ppIEncoderOptions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-commit))], [])
    HRESULT Commit();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoder-getmetadataquerywriter))], [])
    HRESULT GetMetadataQueryWriter(IWICMetadataQueryWriter* ppIMetadataQueryWriter);
}

@GUID("00000105-a8f2-4877-ba0a-fd2b6645fb94")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapframeencode))], [])
interface IWICBitmapFrameEncode : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-initialize))], [])
    HRESULT Initialize(IPropertyBag2 pIEncoderOptions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-setsize))], [])
    HRESULT SetSize(uint uiWidth, uint uiHeight);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-setresolution))], [])
    HRESULT SetResolution(double dpiX, double dpiY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-setpixelformat))], [])
    HRESULT SetPixelFormat(GUID* pPixelFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-setcolorcontexts))], [])
    HRESULT SetColorContexts(uint cCount, IWICColorContext* ppIColorContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-setpalette))], [])
    HRESULT SetPalette(IWICPalette pIPalette);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-setthumbnail))], [])
    HRESULT SetThumbnail(IWICBitmapSource pIThumbnail);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-writepixels))], [])
    HRESULT WritePixels(uint lineCount, uint cbStride, uint cbBufferSize, ubyte* pbPixels);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-writesource))], [])
    HRESULT WriteSource(IWICBitmapSource pIBitmapSource, WICRect* prc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-commit))], [])
    HRESULT Commit();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframeencode-getmetadataquerywriter))], [])
    HRESULT GetMetadataQueryWriter(IWICMetadataQueryWriter* ppIMetadataQueryWriter);
}

@GUID("f928b7b8-2221-40c1-b72e-7e82f1974d1a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicplanarbitmapframeencode))], [])
interface IWICPlanarBitmapFrameEncode : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicplanarbitmapframeencode-writepixels))], [])
    HRESULT WritePixels(uint lineCount, WICBitmapPlane* pPlanes, uint cPlanes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicplanarbitmapframeencode-writesource))], [])
    HRESULT WriteSource(IWICBitmapSource* ppPlanes, uint cPlanes, WICRect* prcSource);
}

@GUID("9edde9e7-8dee-47ea-99df-e6faf2ed44bf")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapdecoder))], [])
interface IWICBitmapDecoder : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-querycapability))], [])
    HRESULT QueryCapability(IStream pIStream, uint* pdwCapability);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-initialize))], [])
    HRESULT Initialize(IStream pIStream, WICDecodeOptions cacheOptions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-getcontainerformat))], [])
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-getdecoderinfo))], [])
    HRESULT GetDecoderInfo(IWICBitmapDecoderInfo* ppIDecoderInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-copypalette))], [])
    HRESULT CopyPalette(IWICPalette pIPalette);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-getmetadataqueryreader))], [])
    HRESULT GetMetadataQueryReader(IWICMetadataQueryReader* ppIMetadataQueryReader);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-getpreview))], [])
    HRESULT GetPreview(IWICBitmapSource* ppIBitmapSource);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-getcolorcontexts))], [])
    HRESULT GetColorContexts(uint cCount, IWICColorContext* ppIColorContexts, uint* pcActualCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-getthumbnail))], [])
    HRESULT GetThumbnail(IWICBitmapSource* ppIThumbnail);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-getframecount))], [])
    HRESULT GetFrameCount(uint* pCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoder-getframe))], [])
    HRESULT GetFrame(uint index, IWICBitmapFrameDecode* ppIBitmapFrame);
}

@GUID("3b16811b-6a43-4ec9-b713-3d5a0c13b940")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapsourcetransform))], [])
interface IWICBitmapSourceTransform : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapsourcetransform-copypixels))], [])
    HRESULT CopyPixels(const(WICRect)* prc, uint uiWidth, uint uiHeight, GUID* pguidDstFormat, 
                       WICBitmapTransformOptions dstTransform, uint nStride, uint cbBufferSize, ubyte* pbBuffer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapsourcetransform-getclosestsize))], [])
    HRESULT GetClosestSize(uint* puiWidth, uint* puiHeight);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapsourcetransform-getclosestpixelformat))], [])
    HRESULT GetClosestPixelFormat(GUID* pguidDstFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapsourcetransform-doessupporttransform))], [])
    HRESULT DoesSupportTransform(WICBitmapTransformOptions dstTransform, BOOL* pfIsSupported);
}

@GUID("c3373fdf-6d39-4e5f-8e79-bf40c0b7ed77")
interface IWICBitmapSourceTransform2 : IWICBitmapSourceTransform
{
    HRESULT GetColorContextsForPixelFormat(GUID* pPixelFormat, uint cCount, IWICColorContext* ppIColorContexts, 
                                           uint* pcActualCount);
}

@GUID("3aff9cce-be95-4303-b927-e7d16ff4a613")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicplanarbitmapsourcetransform))], [])
interface IWICPlanarBitmapSourceTransform : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicplanarbitmapsourcetransform-doessupporttransform))], [])
    HRESULT DoesSupportTransform(uint* puiWidth, uint* puiHeight, WICBitmapTransformOptions dstTransform, 
                                 WICPlanarOptions dstPlanarOptions, const(GUID)* pguidDstFormats, 
                                 WICBitmapPlaneDescription* pPlaneDescriptions, uint cPlanes, BOOL* pfIsSupported);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicplanarbitmapsourcetransform-copypixels))], [])
    HRESULT CopyPixels(const(WICRect)* prcSource, uint uiWidth, uint uiHeight, 
                       WICBitmapTransformOptions dstTransform, WICPlanarOptions dstPlanarOptions, 
                       const(WICBitmapPlane)* pDstPlanes, uint cPlanes);
}

@GUID("3b16811b-6a43-4ec9-a813-3d930c13b940")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapframedecode))], [])
interface IWICBitmapFrameDecode : IWICBitmapSource
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframedecode-getmetadataqueryreader))], [])
    HRESULT GetMetadataQueryReader(IWICMetadataQueryReader* ppIMetadataQueryReader);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframedecode-getcolorcontexts))], [])
    HRESULT GetColorContexts(uint cCount, IWICColorContext* ppIColorContexts, uint* pcActualCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapframedecode-getthumbnail))], [])
    HRESULT GetThumbnail(IWICBitmapSource* ppIThumbnail);
}

@GUID("0c599495-a120-4222-9130-a8c29410bd0b")
interface IWICBitmapFrameChainReader : IUnknown
{
    HRESULT GetChainedFrameCount(WICBitmapChainType chainType, uint* pCount);
    HRESULT GetChainedFrame(WICBitmapChainType chainType, uint index, IWICBitmapFrameDecode* ppIBitmapFrame);
}

@GUID("40d9ea28-4768-47b3-8c12-558a48e98e38")
interface IWICBitmapFrameChainWriter : IUnknown
{
    HRESULT AppendFrameToChain(WICBitmapChainType chainType, IWICBitmapFrameEncode* ppIFrameEncode, 
                               IPropertyBag2* ppIEncoderOptions);
    HRESULT DoesSupportChainType(WICBitmapChainType chainType, BOOL* pfIsSupported);
}

@GUID("daac296f-7aa5-4dbf-8d15-225c5976f891")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicprogressivelevelcontrol))], [])
interface IWICProgressiveLevelControl : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicprogressivelevelcontrol-getlevelcount))], [])
    HRESULT GetLevelCount(uint* pcLevels);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicprogressivelevelcontrol-getcurrentlevel))], [])
    HRESULT GetCurrentLevel(uint* pnLevel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicprogressivelevelcontrol-setcurrentlevel))], [])
    HRESULT SetCurrentLevel(uint nLevel);
}

@GUID("de9d91d2-70b4-4f41-836c-25fcd39626d3")
interface IWICDisplayAdaptationControl : IUnknown
{
    HRESULT DoesSupportChangingMaxLuminance(GUID* pguidDstFormat, BOOL* pfIsSupported);
    HRESULT SetDisplayMaxLuminance(float fLuminanceInNits);
    HRESULT GetDisplayMaxLuminance(float* pfLuminanceInNits);
}

@GUID("d7508d29-3ab7-447e-a676-4d80d7de726b")
interface IWICDisplayAdaptationControl2 : IWICDisplayAdaptationControl
{
    HRESULT SetSdrWhiteLevel(float fWhiteLevelInNits);
    HRESULT GetSdrWhiteLevel(float* pfWhiteLevelInNits);
    HRESULT SetToneMappingMode(WICBitmapToneMappingMode mode);
    HRESULT GetToneMappingMode(WICBitmapToneMappingMode* mode);
    HRESULT DoesSupportToneMappingMode(WICBitmapToneMappingMode mode, BOOL* pfIsSupported);
}

@GUID("caf65cc4-8ebe-4718-a21f-8dbf40bb7e25")
interface IWICD3DTextureSource : IUnknown
{
    HRESULT GetTexture(IUnknown pD3DDevice, IPropertyBag2 pID3DTextureOptions, const(GUID)* riid, void** ppTexture);
    HRESULT GetTransformedTexture(const(WICRect)* prc, uint uiWidth, uint uiHeight, const(GUID)* pguidDstFormat, 
                                  WICBitmapTransformOptions dstTransform, IUnknown pD3DDevice, 
                                  IPropertyBag2 pID3DTextureOptions, const(GUID)* riid, void** ppTexture);
    HRESULT DoesSupportD3DDeviceType(const(GUID)* riid, BOOL* pfIsSupported);
    HRESULT GetD3DTextureOptions(IPropertyBag2* ppID3DTextureOptions);
}

@GUID("4776f9cd-9517-45fa-bf24-e89c5ec5c60c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicprogresscallback))], [])
interface IWICProgressCallback : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicprogresscallback-notify))], [])
    HRESULT Notify(uint uFrameNum, WICProgressOperation operation, double dblProgress);
}

@GUID("64c1024e-c3cf-4462-8078-88c2b11c46d9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapcodecprogressnotification))], [])
interface IWICBitmapCodecProgressNotification : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecprogressnotification-registerprogressnotification))], [])
    HRESULT RegisterProgressNotification(PFNProgressNotification pfnProgressNotification, void* pvData, 
                                         uint dwProgressFlags);
}

@GUID("23bc3f0a-698b-4357-886b-f24d50671334")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwiccomponentinfo))], [])
interface IWICComponentInfo : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccomponentinfo-getcomponenttype))], [])
    HRESULT GetComponentType(WICComponentType* pType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccomponentinfo-getclsid))], [])
    HRESULT GetCLSID(GUID* pclsid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccomponentinfo-getsigningstatus))], [])
    HRESULT GetSigningStatus(uint* pStatus);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccomponentinfo-getauthor))], [])
    HRESULT GetAuthor(uint cchAuthor, PWSTR wzAuthor, uint* pcchActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccomponentinfo-getvendorguid))], [])
    HRESULT GetVendorGUID(GUID* pguidVendor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccomponentinfo-getversion))], [])
    HRESULT GetVersion(uint cchVersion, PWSTR wzVersion, uint* pcchActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccomponentinfo-getspecversion))], [])
    HRESULT GetSpecVersion(uint cchSpecVersion, PWSTR wzSpecVersion, uint* pcchActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwiccomponentinfo-getfriendlyname))], [])
    HRESULT GetFriendlyName(uint cchFriendlyName, PWSTR wzFriendlyName, uint* pcchActual);
}

@GUID("9f34fb65-13f4-4f15-bc57-3726b5e53d9f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicformatconverterinfo))], [])
interface IWICFormatConverterInfo : IWICComponentInfo
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicformatconverterinfo-getpixelformats))], [])
    HRESULT GetPixelFormats(uint cFormats, GUID* pPixelFormatGUIDs, uint* pcActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicformatconverterinfo-createinstance))], [])
    HRESULT CreateInstance(IWICFormatConverter* ppIConverter);
}

@GUID("e87a44c4-b76e-4c47-8b09-298eb12a2714")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapcodecinfo))], [])
interface IWICBitmapCodecInfo : IWICComponentInfo
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-getcontainerformat))], [])
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-getpixelformats))], [])
    HRESULT GetPixelFormats(uint cFormats, GUID* pguidPixelFormats, uint* pcActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-getcolormanagementversion))], [])
    HRESULT GetColorManagementVersion(uint cchColorManagementVersion, PWSTR wzColorManagementVersion, 
                                      uint* pcchActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-getdevicemanufacturer))], [])
    HRESULT GetDeviceManufacturer(uint cchDeviceManufacturer, PWSTR wzDeviceManufacturer, uint* pcchActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-getdevicemodels))], [])
    HRESULT GetDeviceModels(uint cchDeviceModels, PWSTR wzDeviceModels, uint* pcchActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-getmimetypes))], [])
    HRESULT GetMimeTypes(uint cchMimeTypes, PWSTR wzMimeTypes, uint* pcchActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-getfileextensions))], [])
    HRESULT GetFileExtensions(uint cchFileExtensions, PWSTR wzFileExtensions, uint* pcchActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-doessupportanimation))], [])
    HRESULT DoesSupportAnimation(BOOL* pfSupportAnimation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-doessupportchromakey))], [])
    HRESULT DoesSupportChromakey(BOOL* pfSupportChromakey);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-doessupportlossless))], [])
    HRESULT DoesSupportLossless(BOOL* pfSupportLossless);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-doessupportmultiframe))], [])
    HRESULT DoesSupportMultiframe(BOOL* pfSupportMultiframe);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapcodecinfo-matchesmimetype))], [])
    HRESULT MatchesMimeType(const(PWSTR) wzMimeType, BOOL* pfMatches);
}

@GUID("94c9b4ee-a09f-4f92-8a1e-4a9bce7e76fb")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapencoderinfo))], [])
interface IWICBitmapEncoderInfo : IWICBitmapCodecInfo
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapencoderinfo-createinstance))], [])
    HRESULT CreateInstance(IWICBitmapEncoder* ppIBitmapEncoder);
}

@GUID("d8cd007f-d08f-4191-9bfc-236ea7f0e4b5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicbitmapdecoderinfo))], [])
interface IWICBitmapDecoderInfo : IWICBitmapCodecInfo
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoderinfo-getpatterns))], [])
    HRESULT GetPatterns(uint cbSizePatterns, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/WICBitmapPattern* pPatterns, 
                        uint* pcPatterns, uint* pcbPatternsActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoderinfo-matchespattern))], [])
    HRESULT MatchesPattern(IStream pIStream, BOOL* pfMatches);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicbitmapdecoderinfo-createinstance))], [])
    HRESULT CreateInstance(IWICBitmapDecoder* ppIBitmapDecoder);
}

@GUID("e8eda601-3d48-431a-ab44-69059be88bbe")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicpixelformatinfo))], [])
interface IWICPixelFormatInfo : IWICComponentInfo
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpixelformatinfo-getformatguid))], [])
    HRESULT GetFormatGUID(GUID* pFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpixelformatinfo-getcolorcontext))], [])
    HRESULT GetColorContext(IWICColorContext* ppIColorContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpixelformatinfo-getbitsperpixel))], [])
    HRESULT GetBitsPerPixel(uint* puiBitsPerPixel);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpixelformatinfo-getchannelcount))], [])
    HRESULT GetChannelCount(uint* puiChannelCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpixelformatinfo-getchannelmask))], [])
    HRESULT GetChannelMask(uint uiChannelIndex, uint cbMaskBuffer, ubyte* pbMaskBuffer, uint* pcbActual);
}

@GUID("a9db33a2-af5f-43c7-b679-74f5984b5aa4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicpixelformatinfo2))], [])
interface IWICPixelFormatInfo2 : IWICPixelFormatInfo
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpixelformatinfo2-supportstransparency))], [])
    HRESULT SupportsTransparency(BOOL* pfSupportsTransparency);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicpixelformatinfo2-getnumericrepresentation))], [])
    HRESULT GetNumericRepresentation(WICPixelFormatNumericRepresentation* pNumericRepresentation);
}

@GUID("ec5ec8a9-c395-4314-9c77-54d7a935ff70")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicimagingfactory))], [])
interface IWICImagingFactory : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createdecoderfromfilename))], [])
    HRESULT CreateDecoderFromFilename(const(PWSTR) wzFilename, const(GUID)* pguidVendor, 
                                      GENERIC_ACCESS_RIGHTS dwDesiredAccess, WICDecodeOptions metadataOptions, 
                                      IWICBitmapDecoder* ppIDecoder);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createdecoderfromstream))], [])
    HRESULT CreateDecoderFromStream(IStream pIStream, const(GUID)* pguidVendor, WICDecodeOptions metadataOptions, 
                                    IWICBitmapDecoder* ppIDecoder);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createdecoderfromfilehandle))], [])
    HRESULT CreateDecoderFromFileHandle(size_t hFile, const(GUID)* pguidVendor, WICDecodeOptions metadataOptions, 
                                        IWICBitmapDecoder* ppIDecoder);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createcomponentinfo))], [])
    HRESULT CreateComponentInfo(const(GUID)* clsidComponent, IWICComponentInfo* ppIInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createdecoder))], [])
    HRESULT CreateDecoder(const(GUID)* guidContainerFormat, const(GUID)* pguidVendor, 
                          IWICBitmapDecoder* ppIDecoder);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createencoder))], [])
    HRESULT CreateEncoder(const(GUID)* guidContainerFormat, const(GUID)* pguidVendor, 
                          IWICBitmapEncoder* ppIEncoder);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createpalette))], [])
    HRESULT CreatePalette(IWICPalette* ppIPalette);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createformatconverter))], [])
    HRESULT CreateFormatConverter(IWICFormatConverter* ppIFormatConverter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createbitmapscaler))], [])
    HRESULT CreateBitmapScaler(IWICBitmapScaler* ppIBitmapScaler);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createbitmapclipper))], [])
    HRESULT CreateBitmapClipper(IWICBitmapClipper* ppIBitmapClipper);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createbitmapfliprotator))], [])
    HRESULT CreateBitmapFlipRotator(IWICBitmapFlipRotator* ppIBitmapFlipRotator);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createstream))], [])
    HRESULT CreateStream(IWICStream* ppIWICStream);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createcolorcontext))], [])
    HRESULT CreateColorContext(IWICColorContext* ppIWICColorContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createcolortransformer))], [])
    HRESULT CreateColorTransformer(IWICColorTransform* ppIWICColorTransform);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createbitmap))], [])
    HRESULT CreateBitmap(uint uiWidth, uint uiHeight, GUID* pixelFormat, WICBitmapCreateCacheOption option, 
                         IWICBitmap* ppIBitmap);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createbitmapfromsource))], [])
    HRESULT CreateBitmapFromSource(IWICBitmapSource pIBitmapSource, WICBitmapCreateCacheOption option, 
                                   IWICBitmap* ppIBitmap);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createbitmapfromsourcerect))], [])
    HRESULT CreateBitmapFromSourceRect(IWICBitmapSource pIBitmapSource, uint x, uint y, uint width, uint height, 
                                       IWICBitmap* ppIBitmap);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createbitmapfrommemory))], [])
    HRESULT CreateBitmapFromMemory(uint uiWidth, uint uiHeight, GUID* pixelFormat, uint cbStride, 
                                   uint cbBufferSize, ubyte* pbBuffer, IWICBitmap* ppIBitmap);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createbitmapfromhbitmap))], [])
    HRESULT CreateBitmapFromHBITMAP(HBITMAP hBitmap, HPALETTE hPalette, WICBitmapAlphaChannelOption options, 
                                    IWICBitmap* ppIBitmap);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createbitmapfromhicon))], [])
    HRESULT CreateBitmapFromHICON(HICON hIcon, IWICBitmap* ppIBitmap);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createcomponentenumerator))], [])
    HRESULT CreateComponentEnumerator(uint componentTypes, uint options, IEnumUnknown* ppIEnumUnknown);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createfastmetadataencoderfromdecoder))], [])
    HRESULT CreateFastMetadataEncoderFromDecoder(IWICBitmapDecoder pIDecoder, 
                                                 IWICFastMetadataEncoder* ppIFastEncoder);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createfastmetadataencoderfromframedecode))], [])
    HRESULT CreateFastMetadataEncoderFromFrameDecode(IWICBitmapFrameDecode pIFrameDecoder, 
                                                     IWICFastMetadataEncoder* ppIFastEncoder);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createquerywriter))], [])
    HRESULT CreateQueryWriter(const(GUID)* guidMetadataFormat, const(GUID)* pguidVendor, 
                              IWICMetadataQueryWriter* ppIQueryWriter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicimagingfactory-createquerywriterfromreader))], [])
    HRESULT CreateQueryWriterFromReader(IWICMetadataQueryReader pIQueryReader, const(GUID)* pguidVendor, 
                                        IWICMetadataQueryWriter* ppIQueryWriter);
}

@GUID("95c75a6e-3e8c-4ec2-85a8-aebcc551e59b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicdeveloprawnotificationcallback))], [])
interface IWICDevelopRawNotificationCallback : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdeveloprawnotificationcallback-notify))], [])
    HRESULT Notify(uint NotificationMask);
}

@GUID("fbec5e44-f7be-4b65-b7f8-c0c81fef026d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicdevelopraw))], [])
interface IWICDevelopRaw : IWICBitmapFrameDecode
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-queryrawcapabilitiesinfo))], [])
    HRESULT QueryRawCapabilitiesInfo(WICRawCapabilitiesInfo* pInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-loadparameterset))], [])
    HRESULT LoadParameterSet(WICRawParameterSet ParameterSet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getcurrentparameterset))], [])
    HRESULT GetCurrentParameterSet(IPropertyBag2* ppCurrentParameterSet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setexposurecompensation))], [])
    HRESULT SetExposureCompensation(double ev);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getexposurecompensation))], [])
    HRESULT GetExposureCompensation(double* pEV);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setwhitepointrgb))], [])
    HRESULT SetWhitePointRGB(uint Red, uint Green, uint Blue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getwhitepointrgb))], [])
    HRESULT GetWhitePointRGB(uint* pRed, uint* pGreen, uint* pBlue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setnamedwhitepoint))], [])
    HRESULT SetNamedWhitePoint(WICNamedWhitePoint WhitePoint);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getnamedwhitepoint))], [])
    HRESULT GetNamedWhitePoint(WICNamedWhitePoint* pWhitePoint);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setwhitepointkelvin))], [])
    HRESULT SetWhitePointKelvin(uint WhitePointKelvin);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getwhitepointkelvin))], [])
    HRESULT GetWhitePointKelvin(uint* pWhitePointKelvin);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getkelvinrangeinfo))], [])
    HRESULT GetKelvinRangeInfo(uint* pMinKelvinTemp, uint* pMaxKelvinTemp, uint* pKelvinTempStepValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setcontrast))], [])
    HRESULT SetContrast(double Contrast);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getcontrast))], [])
    HRESULT GetContrast(double* pContrast);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setgamma))], [])
    HRESULT SetGamma(double Gamma);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getgamma))], [])
    HRESULT GetGamma(double* pGamma);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setsharpness))], [])
    HRESULT SetSharpness(double Sharpness);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getsharpness))], [])
    HRESULT GetSharpness(double* pSharpness);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setsaturation))], [])
    HRESULT SetSaturation(double Saturation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getsaturation))], [])
    HRESULT GetSaturation(double* pSaturation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-settint))], [])
    HRESULT SetTint(double Tint);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-gettint))], [])
    HRESULT GetTint(double* pTint);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setnoisereduction))], [])
    HRESULT SetNoiseReduction(double NoiseReduction);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getnoisereduction))], [])
    HRESULT GetNoiseReduction(double* pNoiseReduction);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setdestinationcolorcontext))], [])
    HRESULT SetDestinationColorContext(IWICColorContext pColorContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-settonecurve))], [])
    HRESULT SetToneCurve(uint cbToneCurveSize, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/const(WICRawToneCurve)* pToneCurve);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-gettonecurve))], [])
    HRESULT GetToneCurve(uint cbToneCurveBufferSize, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/WICRawToneCurve* pToneCurve, 
                         uint* pcbActualToneCurveBufferSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setrotation))], [])
    HRESULT SetRotation(double Rotation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getrotation))], [])
    HRESULT GetRotation(double* pRotation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setrendermode))], [])
    HRESULT SetRenderMode(WICRawRenderMode RenderMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-getrendermode))], [])
    HRESULT GetRenderMode(WICRawRenderMode* pRenderMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicdevelopraw-setnotificationcallback))], [])
    HRESULT SetNotificationCallback(IWICDevelopRawNotificationCallback pCallback);
}

@GUID("409cd537-8532-40cb-9774-e2feb2df4e9c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicddsdecoder))], [])
interface IWICDdsDecoder : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicddsdecoder-getparameters))], [])
    HRESULT GetParameters(WICDdsParameters* pParameters);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicddsdecoder-getframe))], [])
    HRESULT GetFrame(uint arrayIndex, uint mipLevel, uint sliceIndex, IWICBitmapFrameDecode* ppIBitmapFrame);
}

@GUID("5cacdb4c-407e-41b3-b936-d0f010cd6732")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicddsencoder))], [])
interface IWICDdsEncoder : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicddsencoder-setparameters))], [])
    HRESULT SetParameters(WICDdsParameters* pParameters);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicddsencoder-getparameters))], [])
    HRESULT GetParameters(WICDdsParameters* pParameters);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicddsencoder-createnewframe))], [])
    HRESULT CreateNewFrame(IWICBitmapFrameEncode* ppIFrameEncode, uint* pArrayIndex, uint* pMipLevel, 
                           uint* pSliceIndex);
}

@GUID("3d4c0c61-18a4-41e4-bd80-481a4fc9f464")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicddsframedecode))], [])
interface IWICDdsFrameDecode : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicddsframedecode-getsizeinblocks))], [])
    HRESULT GetSizeInBlocks(uint* pWidthInBlocks, uint* pHeightInBlocks);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicddsframedecode-getformatinfo))], [])
    HRESULT GetFormatInfo(WICDdsFormatInfo* pFormatInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicddsframedecode-copyblocks))], [])
    HRESULT CopyBlocks(const(WICRect)* prcBoundsInBlocks, uint cbStride, uint cbBufferSize, ubyte* pbBuffer);
}

@GUID("8939f66e-c46a-4c21-a9d1-98b327ce1679")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicjpegframedecode))], [])
interface IWICJpegFrameDecode : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframedecode-doessupportindexing))], [])
    HRESULT DoesSupportIndexing(BOOL* pfIndexingSupported);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframedecode-setindexing))], [])
    HRESULT SetIndexing(WICJpegIndexingOptions options, uint horizontalIntervalSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframedecode-clearindexing))], [])
    HRESULT ClearIndexing();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframedecode-getachuffmantable))], [])
    HRESULT GetAcHuffmanTable(uint scanIndex, uint tableIndex, DXGI_JPEG_AC_HUFFMAN_TABLE* pAcHuffmanTable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframedecode-getdchuffmantable))], [])
    HRESULT GetDcHuffmanTable(uint scanIndex, uint tableIndex, DXGI_JPEG_DC_HUFFMAN_TABLE* pDcHuffmanTable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframedecode-getquantizationtable))], [])
    HRESULT GetQuantizationTable(uint scanIndex, uint tableIndex, DXGI_JPEG_QUANTIZATION_TABLE* pQuantizationTable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframedecode-getframeheader))], [])
    HRESULT GetFrameHeader(WICJpegFrameHeader* pFrameHeader);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframedecode-getscanheader))], [])
    HRESULT GetScanHeader(uint scanIndex, WICJpegScanHeader* pScanHeader);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframedecode-copyscan))], [])
    HRESULT CopyScan(uint scanIndex, uint scanOffset, uint cbScanData, ubyte* pbScanData, uint* pcbScanDataActual);
    HRESULT CopyMinimalStream(uint streamOffset, uint cbStreamData, ubyte* pbStreamData, uint* pcbStreamDataActual);
}

@GUID("2f0c601f-d2c6-468c-abfa-49495d983ed1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nn-wincodec-iwicjpegframeencode))], [])
interface IWICJpegFrameEncode : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframeencode-getachuffmantable))], [])
    HRESULT GetAcHuffmanTable(uint scanIndex, uint tableIndex, DXGI_JPEG_AC_HUFFMAN_TABLE* pAcHuffmanTable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframeencode-getdchuffmantable))], [])
    HRESULT GetDcHuffmanTable(uint scanIndex, uint tableIndex, DXGI_JPEG_DC_HUFFMAN_TABLE* pDcHuffmanTable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframeencode-getquantizationtable))], [])
    HRESULT GetQuantizationTable(uint scanIndex, uint tableIndex, DXGI_JPEG_QUANTIZATION_TABLE* pQuantizationTable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodec/nf-wincodec-iwicjpegframeencode-writescan))], [])
    HRESULT WriteScan(uint cbScanData, const(ubyte)* pbScanData);
}

@GUID("feaa2a8d-b3f3-43e4-b25c-d1de990a1ae1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwicmetadatablockreader))], [])
interface IWICMetadataBlockReader : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatablockreader-getcontainerformat))], [])
    HRESULT GetContainerFormat(GUID* pguidContainerFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatablockreader-getcount))], [])
    HRESULT GetCount(uint* pcCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatablockreader-getreaderbyindex))], [])
    HRESULT GetReaderByIndex(uint nIndex, IWICMetadataReader* ppIMetadataReader);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatablockreader-getenumerator))], [])
    HRESULT GetEnumerator(IEnumUnknown* ppIEnumMetadata);
}

@GUID("08fb9676-b444-41e8-8dbe-6a53a542bff1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwicmetadatablockwriter))], [])
interface IWICMetadataBlockWriter : IWICMetadataBlockReader
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatablockwriter-initializefromblockreader))], [])
    HRESULT InitializeFromBlockReader(IWICMetadataBlockReader pIMDBlockReader);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatablockwriter-getwriterbyindex))], [])
    HRESULT GetWriterByIndex(uint nIndex, IWICMetadataWriter* ppIMetadataWriter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatablockwriter-addwriter))], [])
    HRESULT AddWriter(IWICMetadataWriter pIMetadataWriter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatablockwriter-setwriterbyindex))], [])
    HRESULT SetWriterByIndex(uint nIndex, IWICMetadataWriter pIMetadataWriter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatablockwriter-removewriterbyindex))], [])
    HRESULT RemoveWriterByIndex(uint nIndex);
}

@GUID("9204fe99-d8fc-4fd5-a001-9536b067a899")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwicmetadatareader))], [])
interface IWICMetadataReader : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatareader-getmetadataformat))], [])
    HRESULT GetMetadataFormat(GUID* pguidMetadataFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatareader-getmetadatahandlerinfo))], [])
    HRESULT GetMetadataHandlerInfo(IWICMetadataHandlerInfo* ppIHandler);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatareader-getcount))], [])
    HRESULT GetCount(uint* pcCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatareader-getvaluebyindex))], [])
    HRESULT GetValueByIndex(uint nIndex, PROPVARIANT* pvarSchema, PROPVARIANT* pvarId, PROPVARIANT* pvarValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatareader-getvalue))], [])
    HRESULT GetValue(const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId, PROPVARIANT* pvarValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatareader-getenumerator))], [])
    HRESULT GetEnumerator(IWICEnumMetadataItem* ppIEnumMetadata);
}

@GUID("f7836e16-3be0-470b-86bb-160d0aecd7de")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwicmetadatawriter))], [])
interface IWICMetadataWriter : IWICMetadataReader
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatawriter-setvalue))], [])
    HRESULT SetValue(const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId, const(PROPVARIANT)* pvarValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatawriter-setvaluebyindex))], [])
    HRESULT SetValueByIndex(uint nIndex, const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId, 
                            const(PROPVARIANT)* pvarValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatawriter-removevalue))], [])
    HRESULT RemoveValue(const(PROPVARIANT)* pvarSchema, const(PROPVARIANT)* pvarId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatawriter-removevaluebyindex))], [])
    HRESULT RemoveValueByIndex(uint nIndex);
}

@GUID("449494bc-b468-4927-96d7-ba90d31ab505")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwicstreamprovider))], [])
interface IWICStreamProvider : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicstreamprovider-getstream))], [])
    HRESULT GetStream(IStream* ppIStream);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicstreamprovider-getpersistoptions))], [])
    HRESULT GetPersistOptions(uint* pdwPersistOptions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicstreamprovider-getpreferredvendorguid))], [])
    HRESULT GetPreferredVendorGUID(GUID* pguidPreferredVendor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicstreamprovider-refreshstream))], [])
    HRESULT RefreshStream();
}

@GUID("00675040-6908-45f8-86a3-49c7dfd6d9ad")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwicpersiststream))], [])
interface IWICPersistStream : IPersistStream
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicpersiststream-loadex))], [])
    HRESULT LoadEx(IStream pIStream, const(GUID)* pguidPreferredVendor, uint dwPersistOptions);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicpersiststream-saveex))], [])
    HRESULT SaveEx(IStream pIStream, uint dwPersistOptions, BOOL fClearDirty);
}

@GUID("aba958bf-c672-44d1-8d61-ce6df2e682c2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwicmetadatahandlerinfo))], [])
interface IWICMetadataHandlerInfo : IWICComponentInfo
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatahandlerinfo-getmetadataformat))], [])
    HRESULT GetMetadataFormat(GUID* pguidMetadataFormat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatahandlerinfo-getcontainerformats))], [])
    HRESULT GetContainerFormats(uint cContainerFormats, GUID* pguidContainerFormats, uint* pcchActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatahandlerinfo-getdevicemanufacturer))], [])
    HRESULT GetDeviceManufacturer(uint cchDeviceManufacturer, PWSTR wzDeviceManufacturer, uint* pcchActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatahandlerinfo-getdevicemodels))], [])
    HRESULT GetDeviceModels(uint cchDeviceModels, PWSTR wzDeviceModels, uint* pcchActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatahandlerinfo-doesrequirefullstream))], [])
    HRESULT DoesRequireFullStream(BOOL* pfRequiresFullStream);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatahandlerinfo-doessupportpadding))], [])
    HRESULT DoesSupportPadding(BOOL* pfSupportsPadding);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatahandlerinfo-doesrequirefixedsize))], [])
    HRESULT DoesRequireFixedSize(BOOL* pfFixedSize);
}

@GUID("eebf1f5b-07c1-4447-a3ab-22acaf78a804")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwicmetadatareaderinfo))], [])
interface IWICMetadataReaderInfo : IWICMetadataHandlerInfo
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatareaderinfo-getpatterns))], [])
    HRESULT GetPatterns(const(GUID)* guidContainerFormat, uint cbSize, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/WICMetadataPattern* pPattern, 
                        uint* pcCount, uint* pcbActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatareaderinfo-matchespattern))], [])
    HRESULT MatchesPattern(const(GUID)* guidContainerFormat, IStream pIStream, BOOL* pfMatches);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatareaderinfo-createinstance))], [])
    HRESULT CreateInstance(IWICMetadataReader* ppIReader);
}

@GUID("b22e3fba-3925-4323-b5c1-9ebfc430f236")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwicmetadatawriterinfo))], [])
interface IWICMetadataWriterInfo : IWICMetadataHandlerInfo
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatawriterinfo-getheader))], [])
    HRESULT GetHeader(const(GUID)* guidContainerFormat, uint cbSize, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/WICMetadataHeader* pHeader, 
                      uint* pcbActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwicmetadatawriterinfo-createinstance))], [])
    HRESULT CreateInstance(IWICMetadataWriter* ppIWriter);
}

@GUID("412d0c3a-9650-44fa-af5b-dd2a06c8e8fb")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nn-wincodecsdk-iwiccomponentfactory))], [])
interface IWICComponentFactory : IWICImagingFactory
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwiccomponentfactory-createmetadatareader))], [])
    HRESULT CreateMetadataReader(const(GUID)* guidMetadataFormat, const(GUID)* pguidVendor, uint dwOptions, 
                                 IStream pIStream, IWICMetadataReader* ppIReader);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwiccomponentfactory-createmetadatareaderfromcontainer))], [])
    HRESULT CreateMetadataReaderFromContainer(const(GUID)* guidContainerFormat, const(GUID)* pguidVendor, 
                                              uint dwOptions, IStream pIStream, IWICMetadataReader* ppIReader);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwiccomponentfactory-createmetadatawriter))], [])
    HRESULT CreateMetadataWriter(const(GUID)* guidMetadataFormat, const(GUID)* pguidVendor, uint dwMetadataOptions, 
                                 IWICMetadataWriter* ppIWriter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwiccomponentfactory-createmetadatawriterfromreader))], [])
    HRESULT CreateMetadataWriterFromReader(IWICMetadataReader pIReader, const(GUID)* pguidVendor, 
                                           IWICMetadataWriter* ppIWriter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwiccomponentfactory-createqueryreaderfromblockreader))], [])
    HRESULT CreateQueryReaderFromBlockReader(IWICMetadataBlockReader pIBlockReader, 
                                             IWICMetadataQueryReader* ppIQueryReader);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwiccomponentfactory-createquerywriterfromblockwriter))], [])
    HRESULT CreateQueryWriterFromBlockWriter(IWICMetadataBlockWriter pIBlockWriter, 
                                             IWICMetadataQueryWriter* ppIQueryWriter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wincodecsdk/nf-wincodecsdk-iwiccomponentfactory-createencoderpropertybag))], [])
    HRESULT CreateEncoderPropertyBag(PROPBAG2* ppropOptions, uint cCount, IPropertyBag2* ppIPropertyBag);
}


// GUIDs


const GUID IID_IWICBitmap                          = GUIDOF!IWICBitmap;
const GUID IID_IWICBitmapClipper                   = GUIDOF!IWICBitmapClipper;
const GUID IID_IWICBitmapCodecInfo                 = GUIDOF!IWICBitmapCodecInfo;
const GUID IID_IWICBitmapCodecProgressNotification = GUIDOF!IWICBitmapCodecProgressNotification;
const GUID IID_IWICBitmapDecoder                   = GUIDOF!IWICBitmapDecoder;
const GUID IID_IWICBitmapDecoderInfo               = GUIDOF!IWICBitmapDecoderInfo;
const GUID IID_IWICBitmapEncoder                   = GUIDOF!IWICBitmapEncoder;
const GUID IID_IWICBitmapEncoderInfo               = GUIDOF!IWICBitmapEncoderInfo;
const GUID IID_IWICBitmapFlipRotator               = GUIDOF!IWICBitmapFlipRotator;
const GUID IID_IWICBitmapFrameChainReader          = GUIDOF!IWICBitmapFrameChainReader;
const GUID IID_IWICBitmapFrameChainWriter          = GUIDOF!IWICBitmapFrameChainWriter;
const GUID IID_IWICBitmapFrameDecode               = GUIDOF!IWICBitmapFrameDecode;
const GUID IID_IWICBitmapFrameEncode               = GUIDOF!IWICBitmapFrameEncode;
const GUID IID_IWICBitmapLock                      = GUIDOF!IWICBitmapLock;
const GUID IID_IWICBitmapScaler                    = GUIDOF!IWICBitmapScaler;
const GUID IID_IWICBitmapSource                    = GUIDOF!IWICBitmapSource;
const GUID IID_IWICBitmapSourceTransform           = GUIDOF!IWICBitmapSourceTransform;
const GUID IID_IWICBitmapSourceTransform2          = GUIDOF!IWICBitmapSourceTransform2;
const GUID IID_IWICBitmapToneMapper                = GUIDOF!IWICBitmapToneMapper;
const GUID IID_IWICColorContext                    = GUIDOF!IWICColorContext;
const GUID IID_IWICColorTransform                  = GUIDOF!IWICColorTransform;
const GUID IID_IWICComponentFactory                = GUIDOF!IWICComponentFactory;
const GUID IID_IWICComponentInfo                   = GUIDOF!IWICComponentInfo;
const GUID IID_IWICD3DTextureSource                = GUIDOF!IWICD3DTextureSource;
const GUID IID_IWICDdsDecoder                      = GUIDOF!IWICDdsDecoder;
const GUID IID_IWICDdsEncoder                      = GUIDOF!IWICDdsEncoder;
const GUID IID_IWICDdsFrameDecode                  = GUIDOF!IWICDdsFrameDecode;
const GUID IID_IWICDevelopRaw                      = GUIDOF!IWICDevelopRaw;
const GUID IID_IWICDevelopRawNotificationCallback  = GUIDOF!IWICDevelopRawNotificationCallback;
const GUID IID_IWICDisplayAdaptationControl        = GUIDOF!IWICDisplayAdaptationControl;
const GUID IID_IWICDisplayAdaptationControl2       = GUIDOF!IWICDisplayAdaptationControl2;
const GUID IID_IWICEnumMetadataItem                = GUIDOF!IWICEnumMetadataItem;
const GUID IID_IWICFastMetadataEncoder             = GUIDOF!IWICFastMetadataEncoder;
const GUID IID_IWICFormatConverter                 = GUIDOF!IWICFormatConverter;
const GUID IID_IWICFormatConverterInfo             = GUIDOF!IWICFormatConverterInfo;
const GUID IID_IWICImagingFactory                  = GUIDOF!IWICImagingFactory;
const GUID IID_IWICJpegFrameDecode                 = GUIDOF!IWICJpegFrameDecode;
const GUID IID_IWICJpegFrameEncode                 = GUIDOF!IWICJpegFrameEncode;
const GUID IID_IWICMetadataBlockReader             = GUIDOF!IWICMetadataBlockReader;
const GUID IID_IWICMetadataBlockWriter             = GUIDOF!IWICMetadataBlockWriter;
const GUID IID_IWICMetadataHandlerInfo             = GUIDOF!IWICMetadataHandlerInfo;
const GUID IID_IWICMetadataQueryReader             = GUIDOF!IWICMetadataQueryReader;
const GUID IID_IWICMetadataQueryWriter             = GUIDOF!IWICMetadataQueryWriter;
const GUID IID_IWICMetadataReader                  = GUIDOF!IWICMetadataReader;
const GUID IID_IWICMetadataReaderInfo              = GUIDOF!IWICMetadataReaderInfo;
const GUID IID_IWICMetadataWriter                  = GUIDOF!IWICMetadataWriter;
const GUID IID_IWICMetadataWriterInfo              = GUIDOF!IWICMetadataWriterInfo;
const GUID IID_IWICPalette                         = GUIDOF!IWICPalette;
const GUID IID_IWICPersistStream                   = GUIDOF!IWICPersistStream;
const GUID IID_IWICPixelFormatInfo                 = GUIDOF!IWICPixelFormatInfo;
const GUID IID_IWICPixelFormatInfo2                = GUIDOF!IWICPixelFormatInfo2;
const GUID IID_IWICPlanarBitmapFrameEncode         = GUIDOF!IWICPlanarBitmapFrameEncode;
const GUID IID_IWICPlanarBitmapSourceTransform     = GUIDOF!IWICPlanarBitmapSourceTransform;
const GUID IID_IWICPlanarFormatConverter           = GUIDOF!IWICPlanarFormatConverter;
const GUID IID_IWICProgressCallback                = GUIDOF!IWICProgressCallback;
const GUID IID_IWICProgressiveLevelControl         = GUIDOF!IWICProgressiveLevelControl;
const GUID IID_IWICStream                          = GUIDOF!IWICStream;
const GUID IID_IWICStreamProvider                  = GUIDOF!IWICStreamProvider;
