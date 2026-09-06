<#
    Nen video bai giang xuong 720p de vua gioi han cua GitHub Pages
    (1 file toi da 100MB, ca site 1GB).

    Cach dung:
        .\nen-video.ps1 -InputFile "D:\quay\bai5.mp4" -Output "videos\chuong3-bai5.mp4"

    Nen ca thu muc:
        Get-ChildItem D:\quay\*.mp4 | ForEach-Object {
            .\nen-video.ps1 -InputFile $_.FullName -Output "videos\$($_.BaseName).mp4"
        }
#>
param(
    [Parameter(Mandatory = $true)][string]$InputFile,
    [Parameter(Mandatory = $true)][string]$Output,
    # CRF cang cao file cang nhe va cang mo. 28 la muc can bang cho bai giang.
    [int]$Crf = 28,
    [int]$Height = 720
)

$ffmpeg = (Get-Command ffmpeg -ErrorAction SilentlyContinue).Source
if (-not $ffmpeg) {
    Write-Error "Chua co ffmpeg. Cai bang: winget install Gyan.FFmpeg"
    exit 1
}
if (-not (Test-Path $InputFile)) {
    Write-Error "Khong thay file: $InputFile"
    exit 1
}

$dir = Split-Path $Output -Parent
if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }

$truoc = [math]::Round((Get-Item $InputFile).Length / 1MB, 1)
Write-Host "Dang nen $InputFile ($truoc MB)..."

# -movflags +faststart: day phan header len dau file de video chay duoc ngay
# khi moi tai duoc mot phan, khong phai doi tai het.
& $ffmpeg -y -loglevel error -stats -i $InputFile `
    -vf "scale=-2:$Height" `
    -c:v libx264 -preset slow -crf $Crf -pix_fmt yuv420p -movflags +faststart `
    -c:a aac -b:a 96k `
    $Output

if (-not $?) { Write-Error "ffmpeg loi"; exit 1 }

$sau = [math]::Round((Get-Item $Output).Length / 1MB, 1)
Write-Host ""
Write-Host "Xong: $Output"
Write-Host "  $truoc MB  ->  $sau MB"

if ($sau -gt 100) {
    Write-Warning "File van tren 100MB, GitHub se tu choi. Chay lai voi -Crf 32 hoac -Height 540."
} elseif ($sau -gt 40) {
    Write-Warning "File hoi nang ($sau MB). Ca site chi duoc 1GB cho 33 bai."
}
