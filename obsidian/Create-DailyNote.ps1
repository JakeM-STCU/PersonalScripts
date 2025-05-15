$config = Get-Content -Path ".\config.json" | ConvertFrom-Json
$obsidianVault = $config.obsidianVaultDir

echo "VAULT"
echo $obsidianVault

$filename = Get-Date -Format "yyyy-MM-dd"
$markdownFileName = $obsidianVault + $filename + ".md"
$naturalLanguageDate = Get-Date -Format "dddd, MMMM dd, yyyy"

$initialContent = ""
$initialContent += "---"
$initialContent += "`n"
$initialContent += "alias:"
$initialContent += "`n"
$initialContent += "  - " + $naturalLanguageDate
$initialContent += "`n"
$initialContent += "---"
$initialContent += "`n"
$initialContent += "# " + "[[" + $filename + "|" + $naturalLanguageDate + "]]"
$initialContent += "`n`n"
$initialContent += "## Log"
$initialContent += "`n`n"
$initialContent += "- "

New-Item -Path $markdownFileName -ItemType File -Value $initialContent