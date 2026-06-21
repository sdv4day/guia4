Add-Type -AssemblyName System.Drawing
$bmp = New-Object System.Drawing.Bitmap('d:\code\guiA4\demo\all_controls_test.bmp')
Write-Host "Image size: $($bmp.Width) x $($bmp.Height)"
$pts = @( @(20,50), @(100,100), @(200,150), @(300,200), @(400,250), @(500,300), @(600,400), @(700,500), @(800,600) )
foreach ($pt in $pts) {
    $c = $bmp.GetPixel($pt[0], $pt[1])
    Write-Host ("({0},{1}): R={2} G={3} B={4}" -f $pt[0],$pt[1],$c.R,$c.G,$c.B)
}
# Check if all pixels are white or very close to white
$allWhite = $true
for ($y = 0; $y -lt [Math]::Min(100, $bmp.Height); $y += 10) {
    for ($x = 0; $x -lt [Math]::Min(200, $bmp.Width); $x += 10) {
        $c = $bmp.GetPixel($x, $y)
        if ($c.R -lt 240 -or $c.G -lt 240 -or $c.B -lt 240) {
            $allWhite = $false
            Write-Host "Non-white pixel at ($x,$y): R=$($c.R) G=$($c.G) B=$($c.B)"
        }
    }
}
if ($allWhite) {
    Write-Host "WARNING: Image appears to be blank (all white/light)"
} else {
    Write-Host "Image contains non-white content"
}
$bmp.Dispose()
