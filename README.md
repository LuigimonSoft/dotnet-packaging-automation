# dotnet-packaging-automation
## Automating .NET project packaging and distribution

This repository contains a PowerShell script that automates the process of packaging and distributing .NET projects in NuGet format. The script uses the dotnet pack cmdlet to generate .nupkg files and then compresses them into .zip format. Additionally, the script extracts the .nuspec file from the .zip file and saves it in the project's .nuget folder. With this script, the packaging and distribution process can be performed with just a few commands, saving time and reducing the chance of errors.
