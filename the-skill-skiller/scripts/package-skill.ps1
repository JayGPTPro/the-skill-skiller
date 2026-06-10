# package-skill.ps1 - packages a built skill into a zip file for sharing (Windows)
# Usage: powershell -ExecutionPolicy Bypass -File package-skill.ps1 <skill-name>
# Assumes the skill is already installed at %USERPROFILE%\.claude\skills\<skill-name>\
param(
    [Parameter(Mandatory=$true)]
    [string]$SkillName
)

$ErrorActionPreference = "Stop"

$SkillsDir = Join-Path $env:USERPROFILE ".claude\skills"
$Src = Join-Path $SkillsDir $SkillName
if (-not (Test-Path $Src)) {
    Write-Error "Error: skill '$SkillName' not found at $Src"
    exit 1
}

$OutDir = Join-Path ([Environment]::GetFolderPath("Desktop")) "the-skill-skiller-packages"
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
$ZipPath = Join-Path $OutDir "$SkillName.zip"

if (Test-Path $ZipPath) { Remove-Item $ZipPath -Force }
Compress-Archive -Path $Src -DestinationPath $ZipPath -Force

Write-Host "✅ Created: $ZipPath"
Write-Output $ZipPath
