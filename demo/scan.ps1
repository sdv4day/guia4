Add-Type -AssemblyName System.Drawing
$bmp = New-Object System.Drawing.Bitmap('all_controls_test.bmp')
Write-Host "Image size: $($bmp.Width) x $($bmp.Height)"

for ($y = 0; $y -lt 400; $y += 20) {
    $c = $bmp.GetPixel(50, $y)
    Write-Host ("y={0,3}: R={1,3} G={2,3} B={3,3}" -f $y,$c.R,$c.G,$c.B)
}

# Check specific rows for non-white pixels
for ($y = 0; $y -lt 400; $y += 5) {
    $found = $false
    for ($x = 0; $x -lt $bmp.Width; $x += 10) {
        $c = $bmp.GetPixel($x, $y)
        if ($c.R -lt 240 -or $c.G -lt 240 -or $c.B -lt 240) {
            if (-not $found) {
                Write-Host "Non-white at y=$y : "
                $found = $true
            }
            Write-Host ("  x={0,4}: R={1,3} G={2,3} B={3,3}" -f $x,$c.R,$c.G,$c.B)
            break
        }
    }
}

$bmp.Dispose()
