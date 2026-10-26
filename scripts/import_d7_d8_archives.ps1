param(
    [Parameter(Mandatory = $true)]
    [string]$D7ZipPath,

    [Parameter(Mandatory = $true)]
    [string]$D8ZipPath
)

$ErrorActionPreference = "Stop"

function Resolve-ExistingFile([string]$Path, [string]$Label) {
    $resolved = Resolve-Path -LiteralPath $Path -ErrorAction Stop
    if (-not (Test-Path -LiteralPath $resolved.Path -PathType Leaf)) {
        throw "$Label is not a file: $Path"
    }
    return $resolved.Path
}

$D7ZipPath = Resolve-ExistingFile $D7ZipPath "D7 archive"
$D8ZipPath = Resolve-ExistingFile $D8ZipPath "D8 archive"

$repoRoot = (& git rev-parse --show-toplevel 2>$null).Trim()
if ($LASTEXITCODE -ne 0 -or -not $repoRoot) {
    throw "Run this script from inside a cloned D7D8 Git repository."
}
Set-Location $repoRoot

$packageDir = Join-Path $repoRoot "packages"
New-Item -ItemType Directory -Force -Path $packageDir | Out-Null

$d7Dest = Join-Path $packageDir "D7_Texit_Tpath_experiment.zip"
$d8Dest = Join-Path $packageDir "D8_queue_ablation_experiment.zip"

Copy-Item -LiteralPath $D7ZipPath -Destination $d7Dest -Force
Copy-Item -LiteralPath $D8ZipPath -Destination $d8Dest -Force

# Validate both ZIPs before staging them.
Add-Type -AssemblyName System.IO.Compression.FileSystem
foreach ($zipPath in @($d7Dest, $d8Dest)) {
    $archive = [System.IO.Compression.ZipFile]::OpenRead($zipPath)
    try {
        if ($archive.Entries.Count -eq 0) {
            throw "Archive is empty: $zipPath"
        }
        Write-Host ("Validated {0}: {1} entries, {2:N0} bytes" -f (Split-Path $zipPath -Leaf), $archive.Entries.Count, (Get-Item $zipPath).Length)
    }
    finally {
        $archive.Dispose()
    }
}

git add -- packages/D7_Texit_Tpath_experiment.zip packages/D8_queue_ablation_experiment.zip
if ($LASTEXITCODE -ne 0) { throw "git add failed." }

git diff --cached --quiet
if ($LASTEXITCODE -eq 0) {
    Write-Host "The archives are already committed; no new commit is needed."
    exit 0
}

git commit -m "Add complete D7 and D8 experiment archives"
if ($LASTEXITCODE -ne 0) { throw "git commit failed." }

git push origin HEAD
if ($LASTEXITCODE -ne 0) {
    throw "git push failed. Check GitHub authentication and retry: git push origin HEAD"
}

Write-Host "D7 and D8 archives were committed and pushed successfully."
