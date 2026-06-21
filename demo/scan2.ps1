Add-Type -AssemblyName System.Drawing
$bmp = New-Object System.Drawing.Bitmap('all_controls_test.bmp')
Write-Host "Image size: $($bmp.Width) x $($bmp.Height)"

# Scan center column
for ($y = 0; $y -lt 500; $y += 10) {
    $c = $bmp.GetPixel(100, $y)
    Write-Host ("x=100 y={0,3}: R={1,3} G={2,3} B={3,3}" -f $y,$c.R,$c.G,$c.B)
}

# Scan for TabWidget area (around y=250-400)
Write-Host "`n--- TabWidget area scan ---"
for ($y = 240; $y -lt 420; $y += 5) {
    $found = $false
    for ($x = 0; $x -lt $bmp.Width; $x += 5) {
        $c = $bmp.GetPixel($x, $y)
        if ($c.R -lt 200 -or $c.G -lt 200 -or $c.B -lt 200) {
            if (-not $found) {
                Write-Host "Non-white at y=$y :"
                $found = $true
            }
            Write-Host ("  x={0,4}: R={1,3} G={2,3} B={3,3}" -f $x,$c.R,$c.G,$c.B)
            $x += 20
        }
    }
}

$bmp.Dispose()
