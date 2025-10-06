@echo off
title Select folder
cls
echo Select folder
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; Add-Type -AssemblyName System.Windows.Forms; $fbd = New-Object System.Windows.Forms.FolderBrowserDialog; $fbd.RootFolder = 'MyComputer'; $fbd.SelectedPath = 'C:\'; if ($fbd.ShowDialog() -eq 'OK') { cls; echo 'Searching files...'; [console]::Title = 'Searching files...'; $path = $fbd.SelectedPath; $files = Get-ChildItem -Recurse $path | Where-Object { $_.Length -ge 1GB }; if ($files) { $files | Sort-Object Length -Descending | Select-Object FullName,@{Name='SizeGB';Expression={[math]::Round($_.Length/1GB,2)}} | Format-Table -AutoSize; $host.UI.RawUI.WindowTitle = \"$($files.Count) files found\" } else { Write-Host 'No files found.'; $host.UI.RawUI.WindowTitle = 'No files found' } } else { Write-Host 'No folder selected.'; $host.UI.RawUI.WindowTitle = 'Cancelled' }"
echo.
pause