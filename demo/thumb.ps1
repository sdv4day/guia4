Add-Type -AssemblyName System.Drawing
$bmp = New-Object System.Drawing.Bitmap('all_controls_test.bmp')
$thumb = New-Object System.Drawing.Bitmap(472, 380)
$g = [System.Drawing.Graphics]::FromImage($thumb)
$g.DrawImage($bmp, 0, 0, 472, 380)
$thumb.Save('all_controls_test_thumb.bmp')
$g.Dispose()
$bmp.Dispose()
$thumb.Dispose()
