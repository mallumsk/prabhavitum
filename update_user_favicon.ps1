Add-Type -AssemblyName System.Drawing

$src = 'C:\Users\USER\.gemini\antigravity\brain\6309c3ea-cb89-4dfe-a781-9a97aa525464\media__1785173855603.png'
$outDir = 'C:\Users\USER\.gemini\antigravity\scratch\prabhavitum_college_website\images'

$targetPng = Join-Path $outDir 'favicon.png'
$targetIco = Join-Path $outDir 'favicon.ico'

# Load uploaded icon
$img = [System.Drawing.Image]::FromFile($src)

# Create high quality square canvas with transparency
$size = [Math]::Max($img.Width, $img.Height)
$squareBmp = New-Object System.Drawing.Bitmap($size, $size)
$g = [System.Drawing.Graphics]::FromImage($squareBmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# Center image in square frame
$x = [int](($size - $img.Width) / 2)
$y = [int](($size - $img.Height) / 2)
$g.DrawImage($img, $x, $y, $img.Width, $img.Height)

# Save as PNG & ICO
$squareBmp.Save($targetPng, [System.Drawing.Imaging.ImageFormat]::Png)
$squareBmp.Save($targetIco, [System.Drawing.Imaging.ImageFormat]::Png)

$g.Dispose()
$img.Dispose()
$squareBmp.Dispose()

Write-Host "Updated favicon at $targetPng and $targetIco successfully!"
