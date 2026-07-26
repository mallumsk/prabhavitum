Add-Type -AssemblyName System.Drawing
$src = "C:\Users\USER\.gemini\antigravity\scratch\prabhavitum_college_website\images\college_building.png"
$dst = "C:\Users\USER\.gemini\antigravity\scratch\prabhavitum_college_website\images\college_building.jpg"

if (Test-Path $src) {
    $img = [System.Drawing.Image]::FromFile($src)
    $img.Save($dst, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $img.Dispose()
    Write-Host "Successfully converted college_building.png to college_building.jpg"
} else {
    Write-Host "Source file not found: $src"
}
