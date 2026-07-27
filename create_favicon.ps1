Add-Type -AssemblyName System.Drawing

$imgDir = 'C:\Users\USER\.gemini\antigravity\scratch\prabhavitum_college_website\images'
$faviconPath = Join-Path $imgDir 'favicon.png'

# Create a high-res 128x128 rounded emblem favicon with brand blue background & logo graphics
$bmp = New-Object System.Drawing.Bitmap(128, 128)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.TextRenderingHint]::AntiAlias

# Deep Navy Blue Background Circle (#1E2B78)
$blueBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml("#1E2B78"))
$g.FillEllipse($blueBrush, 4, 4, 120, 120)

# Emerald Green Ring Accent (#2E8B46)
$greenPen = New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#2E8B46"), 6)
$g.DrawEllipse($greenPen, 7, 7, 114, 114)

# DNA Rose Accent Circle (#D94857)
$rosePen = New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml("#D94857"), 3)
$g.DrawEllipse($rosePen, 18, 18, 92, 92)

# Central Lettering "P" in Bold White Outfit Font
$font = New-Object System.Drawing.Font("Arial", 56, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
$whiteBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)

$sf = New-Object System.Drawing.StringFormat
$sf.Alignment = [System.Drawing.StringAlignment]::Center
$sf.LineAlignment = [System.Drawing.StringAlignment]::Center

$rect = New-Object System.Drawing.RectangleF(0, 4, 128, 128)
$g.DrawString("P", $font, $whiteBrush, $rect, $sf)

$bmp.Save($faviconPath, [System.Drawing.Imaging.ImageFormat]::Png)

$g.Dispose()
$bmp.Dispose()

Write-Host "Favicon created at $faviconPath"
