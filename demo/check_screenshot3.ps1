Add-Type -AssemblyName System.Drawing
$bmp = New-Object System.Drawing.Bitmap('d:\code\guiA4\demo\all_controls_test.bmp')
Write-Host "Image size: $($bmp.Width) x $($bmp.Height)"

# Find non-white pixels and show first 50
$count = 0
$threshold = 240
for ($y = 0; $y -lt $bmp.Height; $y++) {
    for ($x = 0; $x -lt $bmp.Width; $x++) {
        $c = $bmp.GetPixel($x, $y)
        if ($c.R -lt $threshold -or $c.G -lt $threshold -or $c.B -lt $threshold) {
            $count++
            if ($count -le 50) {
                Write-Host ("Non-white at ({0,4},{1,4}): R={2,3} G={3,3} B={4,3}" -f $x,$y,$c.R,$c.G,$c.B)
            }
        }
    }
}
Write-Host "Total non-white pixels: $count"

# Check specific rows to understand content distribution
for ($y = 0; $y -lt 300; $y += 20) {
    $rowColors = @()
    for ($x = 0; $x -lt $bmp.Width; $x += 20) {
        $c = $bmp.GetPixel($x, $y)
        if ($c.R -lt 240 -or $c.G -lt 240 -or $c.B -lt 240) {
            $rowColors += "($x,$y,R=$($c.R))"
        }
    }
    if ($rowColors.Length -gt 0) {
        Write-Host "Row $y : $($rowColors -join ', ')"
    }
}

$bmp.Dispose()
