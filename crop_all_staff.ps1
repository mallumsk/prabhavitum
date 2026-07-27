Add-Type -AssemblyName System.Drawing

$outDir = 'C:\Users\USER\.gemini\antigravity\scratch\prabhavitum_college_website\images\faculty'
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir }

# 1. Commerce Staff Cropping
$commPath = 'C:\Users\USER\.gemini\antigravity\brain\6309c3ea-cb89-4dfe-a781-9a97aa525464\media__1785165055231.png'
$imgComm = [System.Drawing.Image]::FromFile($commPath)
$w1 = $imgComm.Width
$h1 = $imgComm.Height
Write-Host "Commerce Image: ${w1}x${h1}"

$x1 = [int]($w1 * 0.915)
$cropW1 = [int]($w1 * 0.08)

function CropComm($rowIdx, $fileName) {
    # 7 rows spanning Y = 0.09 to Y = 0.99
    $rowH = (0.99 - 0.09) / 7.0
    $yStartRatio = 0.09 + ($rowIdx * $rowH)
    $yEndRatio = $yStartRatio + $rowH
    $topY = [int]($h1 * $yStartRatio)
    $cropH = [int]($h1 * ($yEndRatio - $yStartRatio))
    
    $rect = New-Object System.Drawing.Rectangle($x1, $topY, $cropW1, $cropH)
    $bmp = New-Object System.Drawing.Bitmap($cropW1, $cropH)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.DrawImage($imgComm, (New-Object System.Drawing.Rectangle(0, 0, $cropW1, $cropH)), $rect, [System.Drawing.GraphicsUnit]::Pixel)
    $g.Dispose()
    $targetPath = Join-Path $outDir $fileName
    $bmp.Save($targetPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Host "Saved Commerce Photo: $targetPath"
}

CropComm 0 'siddappa.png'
CropComm 1 'chetana.png'
CropComm 2 'sharada.png'
CropComm 3 'alim_pasha.png'
CropComm 4 'malappa.png'
CropComm 5 'deep_shettar.png'
CropComm 6 'niveditha_bulla.png'

$imgComm.Dispose()

# 2. Non-Teaching Staff Cropping
$nonPath = 'C:\Users\USER\.gemini\antigravity\brain\6309c3ea-cb89-4dfe-a781-9a97aa525464\media__1785165104011.png'
$imgNon = [System.Drawing.Image]::FromFile($nonPath)
$w2 = $imgNon.Width
$h2 = $imgNon.Height
Write-Host "Non-Teaching Image: ${w2}x${h2}"

$x2 = [int]($w2 * 0.915)
$cropW2 = [int]($w2 * 0.08)

function CropNon($rowIdx, $fileName) {
    # 4 rows spanning Y = 0.12 to Y = 0.99
    $rowH = (0.99 - 0.12) / 4.0
    $yStartRatio = 0.12 + ($rowIdx * $rowH)
    $yEndRatio = $yStartRatio + $rowH
    $topY = [int]($h2 * $yStartRatio)
    $cropH = [int]($h2 * ($yEndRatio - $yStartRatio))
    
    $rect = New-Object System.Drawing.Rectangle($x2, $topY, $cropW2, $cropH)
    $bmp = New-Object System.Drawing.Bitmap($cropW2, $cropH)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.DrawImage($imgNon, (New-Object System.Drawing.Rectangle(0, 0, $cropW2, $cropH)), $rect, [System.Drawing.GraphicsUnit]::Pixel)
    $g.Dispose()
    $targetPath = Join-Path $outDir $fileName
    $bmp.Save($targetPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Host "Saved Non-Teaching Photo: $targetPath"
}

CropNon 0 'prashanth_indi.png'
CropNon 1 'saraswathi.png'
CropNon 2 'jayashree.png'
CropNon 3 'rajamma.png'

$imgNon.Dispose()
Write-Host "Cropped all 11 new staff photos successfully!"
