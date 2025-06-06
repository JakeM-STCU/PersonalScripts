$repo = $args[0]
$issueNumber = $args[1]

$config = Get-Content -Path ".\config.json" | ConvertFrom-Json

$repoDir = $config.stcuProjectsDir + $repo
$obsidianVault = $config.obsidianVaultDir

# Save the current directory
Push-Location

# Change to the repository directory
Set-Location $repoDir

# Call the GitHub command
$titleJson = gh issue view $issueNumber.ToString() --json title

# Return to the original directory
Pop-Location

# Create a new markdownFileNamemarkdown file
$jsonObject = ConvertFrom-Json -InputObject $titleJson

$issueTitle = $jsonObject.title

$filename = $repo + " " + $issueNumber.ToString()
$markdownFileName = $obsidianVault + $filename + ".md"
$issueLink = "https://github.com/stcu/" + $repo + "/issues/" + $issueNumber

$initialContent = ""
$initialContent += "---"
$initialContent += "`n"
$initialContent += "alias: [" + $issueTitle + "]"
$initialContent += "`n"
$initialContent += "---"
$initialContent += "`n"
$initialContent += "# " + "[" + $filename + "]"  + "(" + $issueLink + "): " + "[[" + $filename + "|" + $issueTitle + "]]"
$initialContent += "`n"
$initialContent += "## Log"
$initialContent += "`n`n"
$initialContent += "- "

New-Item -Path $markdownFileName -ItemType File -Value $initialContent


