
$ErrorActionPreference = 'Stop';

$packageName = 'postgresql'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://get.enterprisedb.com/postgresql/postgresql-9.6.2-1-windows.exe'
$url64       = 'https://get.enterprisedb.com/postgresql/postgresql-9.6.2-1-windows-x64.exe'

if (Get-ProcessorBits 64) {
  $servicename = "postgrsql-x64-9.6"
} else {
  $servicename = "postgrsql-9.6"
}

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  softwareName  = 'postgresql*'

  checksum      = 'c855ddae886d929649be412ee32525d3579740765aec97c183415afc2a756b59'
  checksumType  = 'sha256'
  checksum64    = 'c7f1dbb131e647eee7753d9245bee05ffd45c469dba3aeb283b2d8d50bf8a840'
  checksumType64= 'sha256'

  silentArgs = "--unattendedmodeui none --mode unattended --servicename ""$servicename"" --superpassword postgres --install_runtimes 0 --locale ""English, United States"" --disable-stackbuilder 1"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs


















