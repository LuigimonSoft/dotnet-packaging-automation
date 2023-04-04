Add-Type -Assembly 'System.IO.Compression.FileSystem'

$srcFolderPath = ""
$version = "1.0.0"

Get-ChildItem -Path $srcFolderPath -Recurse -Filter *.csproj | Where-Object { $_.Name -notlike '*.test.csproj' } | ForEach-Object {

    
    dotnet pack $_.FullName -o $_.DirectoryName --no-build

    
    $nupkgFilePath = $_.FullName -replace '\.csproj$', ".$($version).nupkg"
    $zipFilePath = $nupkgFilePath -replace '\.nupkg$', '.zip'
    Rename-Item $nupkgFilePath $zipFilePath

    
    
    $zipFile = [System.IO.Compression.ZipFile]::OpenRead($zipFilePath)
    $nuspecEntry = $zipFile.Entries | Where-Object { $_.Name -like '*.nuspec' }
    $nuspecFilePath =  "..\..\.nuget\$($nuspecEntry.Name)"
    $nuspecStream = $nuspecEntry.Open()
    $nuspecStream.CopyTo([System.IO.File]::Create($nuspecFilePath))
    $nuspecStream.Close()

    
    $zipFile.Dispose()
    Remove-Item $zipFilePath
}
