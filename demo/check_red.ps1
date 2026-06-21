Add-Type -AssemblyName System.Drawing
$bmp = New-Object System.Drawing.Bitmap('d:\code\guiA4\demo\all_controls_test.bmp')
Write-Host "Image size: $($bmp.Width) x $($bmp.Height)"

# Check for red pixels (R > 200, G < 100, B < 100)
$redCount = 0
for ($y = 0; $y -lt $bmp.Height; $y++) {
    for ($x = 0; $x -lt $bmp.Width; $x++) {
        $c = $bmp.GetPixel($x, $y)
        if ($c.R -gt 200 -and $c.G -lt 100 -and $c.B -lt 100) {
            $redCount++
            if ($redCount -le 20) {
                Write-Host ("Red pixel at ({0,4},{1,4}): R={2,3} G={3,3} B={4,3}" -f $x,$y,$c.R,$c.G,$c.B)
            }
        }
    }
}
Write-Host "Total red pixels: $redCount"

# Also check some specific positions where Label should be
$positions = @( @(16,16), @(50,30), @(100,30), @(200,30), @(400,30), @(16,300), @(50,315), @(100,315) )
foreach ($pt in $positions) {
    $x = $pt[0]
    $y = $pt[1]
    if ($x -lt $bmp.Width -and $y -lt $bmp.Height) {
        $c = $bmp.GetPixel($x, $y)
        Write-Host ("Position ({0,4},{1,4}): R={2,3} G={3,3} B={4,3}" -f $x,$y,$c.R,$c.G,$c.B)
    }
}

$bmp.Dispose()
