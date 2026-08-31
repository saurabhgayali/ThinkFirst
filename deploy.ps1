#
# ThinkFirst Automated Deployment Script (Windows PowerShell)
# Deploys ThinkFirst to the target directory on Windows
#
# Usage:
#   .\deploy.ps1                           # Deploy to current directory
#   $env:TARGET_DIR='C:\path'; .\deploy.ps1  # Deploy to specific directory
#
# Note: You may need to set execution policy:
#   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
#

param(
    [string]$TargetDir = "."
)

# Override with environment variable if set
if ($env:TARGET_DIR) {
    $TargetDir = $env:TARGET_DIR
}

# Colors for output (using different approach for Windows)
function Write-Status {
    param([string]$Message)
    Write-Host "[ThinkFirst] $Message" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Write-Error-Custom {
    param([string]$Message)
    Write-Host "✗ $Message" -ForegroundColor Red
}

function Write-Warning-Custom {
    param([string]$Message)
    Write-Host "! $Message" -ForegroundColor Yellow
}

# Resolve full path
$TargetDir = Resolve-Path $TargetDir -ErrorAction SilentlyContinue
if (-not $TargetDir) {
    Write-Status "Creating target directory: $TargetDir"
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
    $TargetDir = Resolve-Path $TargetDir
}

# Configuration
$Repo = "saurabhgayali/ThinkFirst"
$Branch = "main"
$TempDir = Join-Path ([System.IO.Path]::GetTempPath()) "thinkfirst_$(Get-Random)"

Write-Status "Starting ThinkFirst deployment..."
Write-Status "Target directory: $TargetDir"

# Create temp directory
New-Item -ItemType Directory -Path $TempDir -Force | Out-Null

try {
    # Download the repository archive
    Write-Status "Downloading ThinkFirst from GitHub..."
    $ArchiveUrl = "https://github.com/$Repo/archive/refs/heads/$Branch.zip"
    $ArchivePath = Join-Path $TempDir "archive.zip"
    
    try {
        Invoke-WebRequest -Uri $ArchiveUrl -OutFile $ArchivePath -ErrorAction Stop
    } catch {
        Write-Error-Custom "Failed to download archive: $_"
        exit 1
    }
    
    Write-Success "Archive downloaded"
    
    # Extract the archive
    Write-Status "Extracting archive..."
    $ExtractPath = Join-Path $TempDir "extracted"
    New-Item -ItemType Directory -Path $ExtractPath -Force | Out-Null
    
    try {
        Expand-Archive -Path $ArchivePath -DestinationPath $ExtractPath -Force -ErrorAction Stop
    } catch {
        Write-Error-Custom "Failed to extract archive: $_"
        exit 1
    }
    
    Write-Success "Archive extracted"
    
    # Find the extracted directory (it will be named ThinkFirst-main or similar)
    $ExtractedDir = Get-ChildItem -Path $ExtractPath -Directory | Select-Object -First 1 | Select-Object -ExpandProperty FullName
    
    if (-not $ExtractedDir) {
        Write-Error-Custom "Could not find extracted ThinkFirst directory"
        exit 1
    }
    
    Write-Status "Copying files to target directory..."
    
    # Define files and directories to copy
    $FilesToCopy = @("SKILL.md", "README.md", "CHANGELOG.md", "LICENSE", "rules", "examples", "tests")
    
    foreach ($item in $FilesToCopy) {
        $Src = Join-Path $ExtractedDir $item
        $Dest = Join-Path $TargetDir $item
        
        if (-not (Test-Path $Src)) {
            Write-Warning-Custom "Source not found: $item"
            continue
        }
        
        if (Test-Path $Dest) {
            Write-Warning-Custom "File/directory already exists, comparing: $item"
            
            # Simple comparison: check if source and dest have same structure
            $SrcHash = Get-FileHash -Path $Src -Algorithm SHA256 -ErrorAction SilentlyContinue
            $DestHash = Get-FileHash -Path $Dest -Algorithm SHA256 -ErrorAction SilentlyContinue
            
            if ($SrcHash -and $DestHash -and $SrcHash.Hash -eq $DestHash.Hash) {
                Write-Status "No changes detected in: $item"
            } else {
                Write-Warning-Custom "Files differ for: $item. Keeping existing version."
                Write-Warning-Custom "To update, remove or backup the existing $item and rerun deploy.ps1"
            }
        } else {
            Copy-Item -Path $Src -Destination $Dest -Recurse -Force
            Write-Success "Copied: $item"
        }
    }
    
    Write-Status "Verifying installation..."
    
    # Verify essential files exist
    $EssentialFiles = @("SKILL.md", "README.md")
    $InstallationOK = $true
    
    foreach ($file in $EssentialFiles) {
        $FilePath = Join-Path $TargetDir $file
        if (-not (Test-Path $FilePath -PathType Leaf)) {
            Write-Error-Custom "Essential file missing: $file"
            $InstallationOK = $false
        }
    }
    
    # Verify rules directory exists and contains files
    $RulesDir = Join-Path $TargetDir "rules"
    if (-not (Test-Path $RulesDir -PathType Container)) {
        Write-Error-Custom "Rules directory is missing"
        $InstallationOK = $false
    } else {
        $RulesFiles = Get-ChildItem -Path $RulesDir -File -ErrorAction SilentlyContinue
        if (-not $RulesFiles) {
            Write-Error-Custom "Rules directory is empty"
            $InstallationOK = $false
        }
    }
    
    if ($InstallationOK) {
        Write-Success "ThinkFirst successfully deployed!"
        Write-Status "Location: $TargetDir"
        Write-Status ""
        Write-Status "Next steps:"
        Write-Host "  1. SKILL.md is ready to use as your AI system prompt"
        Write-Host "  2. rules\ folder contains detailed behavioral documentation"
        Write-Host "  3. examples\ folder contains usage examples"
        Write-Host "  4. See README.md for complete documentation"
    } else {
        Write-Error-Custom "Installation verification failed"
        exit 1
    }

} finally {
    # Cleanup
    Write-Status "Cleaning up temporary files..."
    Remove-Item -Path $TempDir -Recurse -Force -ErrorAction SilentlyContinue
}
