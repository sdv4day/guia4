Add-Type -AssemblyName System.Drawing
$bmp = New-Object System.Drawing.Bitmap('d:\code\guiA4\demo\all_controls_test.bmp')
Write-Host "Image size: $($bmp.Width) x $($bmp.Height)"

# Check specific regions where controls should be
# StringGrid section should be around y=16 (padding), label at y=16, grid at y=44
# TabWidget section should be below StringGrid

$regions = @(
    @(16, 16, "StringGrid label top-left"),
    @(100, 30, "StringGrid label"),
    @(400, 30, "StringGrid label center"),
    @(16, 50, "StringGrid top-left"),
    @(100, 100, "StringGrid cell"),
    @(400, 150, "StringGrid center"),
    @(16, 250, "Below StringGrid"),
    @(16, 300, "TabWidget label"),
    @(16, 350, "TabWidget"),
    @(100, 400, "Tab content"),
    @(500, 500, "Lower area"),
    @(800, 700, "Bottom-right")
)

foreach ($r in $regions) {
    $x = $r[0]
    $y = $r[1]
    $desc = $r[2]
    if ($x -lt $bmp.Width -and $y -lt $bmp.Height) {
        $c = $bmp.GetPixel($x, $y)
        Write-Host ("{0,-25} at ({1,3},{2,3}): R={3,3} G={4,3} B={5,3}" -f $desc,$x,$y,$c.R,$c.G,$c.B)
    }
}

# Count non-white pixels in the image
$nonWhite = 0
$threshold = 250
for ($y = 0; $y -lt $bmp.Height; $y += 5) {
    for ($x = 0; $x -lt $bmp.Width; $x += 5) {
        $c = $bmp.GetPixel($x, $y)
        if ($c.R -lt $threshold -or $c.G -lt $threshold -or $c.B -lt $threshold) {
            $nonWhite++
        }
    }
}
Write-Host "Non-white pixel count (sampled every 5px): $nonWhite"

$bmp.Dispose()
