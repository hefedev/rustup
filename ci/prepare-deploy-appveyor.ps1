if ($env:APPVEYOR_PULL_REQUEST_NUMBER) {
   exit 0
}

if ($env:APPVEYOR_REPO_BRANCH -eq "auto") {
   exit 0
}

# Copy rustup-init to rustup-setup for backwards compatibility
cp target\release\rustup-init.exe target\release\rustup-setup.exe

# Generate hashes
Get-FileHash .\target\release\* | ForEach-Object {[io.file]::WriteAllText($_.Path + ".sha256", $_.Hash.ToLower() + "`n")}

# Prepare bins for upload
$dest = "dist\$env:TARGET"
md -Force "$dest"
cp target\release\rustup-init.exe "$dest/"
cp target\release\rustup-init.exe.sha256 "$dest/"
cp target\release\rustup-setup.exe "$dest/"
cp target\release\rustup-setup.exe.sha256 "$dest/"

ls "$dest"