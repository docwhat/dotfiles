### POWERSHELL CONFIGURATION ###

Set-PSDebug -Strict

Get-ChildItem -Path $PSScriptRoot/startup.d/*.ps1 |
ForEach-Object {
  & $_.FullName
}

# EOF
