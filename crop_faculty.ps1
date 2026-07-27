Add-Type -AssemblyName System.Drawing
$imgPath = 'C:\Users\USER\.gemini\antigravity\brain\6309c3ea-cb89-4dfe-a781-9a97aa525464\media__1785164854769.png'
$img = [System.Drawing.Image]::FromFile($imgPath)
$w = $img.Width
$h = $img.Height
Write-Host "Image Dimensions: ${w}x${h}"

$outDir = 'C:\Users\USER\.gemini\antigravity\scratch\prabhavitum_college_website\images\faculty'
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir }

$x1 = [int]($w * 0.915)
$cropW = [int]($w * 0.08)

function CropAndSave($yStartRatio, $yEndRatio, $fileName) {
    $topY = [int]($h * $yStartRatio)
    $cropH = [int]($h * ($yEndRatio - $yStartRatio))
    $rect = New-Object System.Drawing.Rectangle($x1, $topY, $cropW, $cropH)
    $bmp = New-Object System.Drawing.Bitmap($cropW, $cropH)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.DrawImage($img, (New-Object System.Drawing.Rectangle(0, 0, $cropW, $cropH)), $rect, [System.Drawing.GraphicsUnit]::Pixel)
    $g.Dispose()
    $targetPath = Join-Path $outDir $fileName
    $bmp.Save($targetPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Host "Saved: $targetPath"
}

CropAndSave 0.125 0.335 'krishnakumar_myala.png'
CropAndSave 0.340 0.555 'santhosh_kumar_goudar.png'
CropAndSave 0.560 0.775 'manjunath.png'
CropAndSave 0.780 0.985 'ranganath.png'

$img.Dispose()
Write-Host "Cropping finished cleanly!"
