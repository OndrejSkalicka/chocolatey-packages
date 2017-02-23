$ErrorActionPreference = 'Stop';

$packageName = 'r-base'
$version     = '3.3.2'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "https://cran.r-project.org/bin/windows/base/R-$version-win.exe"
$url64       = $url

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  softwareName  = 'r-base*'

  checksum      = '2e16180226268b9b07fa8668a3ac80f9bea25ec82a2275150b2f3e2ca1c1fc14'
  checksumType  = 'sha256'
  checksum64    = '2e16180226268b9b07fa8668a3ac80f9bea25ec82a2275150b2f3e2ca1c1fc14'
  checksumType64= 'sha256'
 
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

$installPath = (Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\R-core\R\$version).InstallPath
Install-ChocolateyEnvironmentVariable "R_HOME" $installPath 

if (Get-ProcessorBits 64) {
  Install-ChocolateyPath "$installPath\bin\x64"
} else {
  Install-ChocolateyPath "$installPath\bin"
}

Update-SessionEnvironment