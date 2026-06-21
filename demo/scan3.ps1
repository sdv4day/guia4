Add-Type -AssemblyName System.Drawing
$bmp = New-Object System.Drawing.Bitmap('all_controls_test.bmp')
Write-Host "Image size: $($bmp.Width) x $($bmp.Height)"

# Scan x=50 to x=550 at specific Y ranges
for ($y = 280; $y -lt 340; $y += 2) {
    $c = $bmp.GetPixel(50, $y)
    Write-Host ("x=50  y={0,3}: R={1,3} G={2,3} B={3,3}" -f $y,$c.R,$c.G,$c.B)
}

Write-Host ""
for ($y = 280; $y -lt 340; $y += 2) {
    $c = $bmp.GetPixel(200, $y)
    Write-Host ("x=200 y={0,3}: R={1,3} G={2,3} B={3,3}" -f $y,$c.R,$c.G,$c.B)
}

Write-Host ""
for ($y = 280; $y -lt 340; $y += 2) {
    $c = $bmp.GetPixel(400, $y)
    Write-Host ("x=400 y={0,3}: R={1,3} G={2,3} B={3,3}" -f $y,$c.R,$c.G,$c.B)
}

# Check if any pixel in y=280-340 has R<240 or G<240 or B<240
Write-Host "`n--- Searching for non-background pixels in y=280-340 ---"
for ($y = 280; $y -lt 340; $y++) {
    for ($x = 0; $x -lt $bmp.Width; $x++) {
        $c = $bmp.GetPixel($x, $y)
        if ($c.R -lt 240 -or $c.G -lt 240 -or $c.B -lt 240) {
            Write-Host ("Found at x={0,4} y={1,3}: R={2,3} G={3,3} B={4,3}" -f $x,$y,$c.R,$c.G,$c.B)
            break
        }
    }
}

$bmp.Dispose()
