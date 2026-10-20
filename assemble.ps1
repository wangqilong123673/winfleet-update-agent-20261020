$ErrorActionPreference = 'Stop'
$dir = $PSScriptRoot
if (-not $dir) { $dir = Get-Location }
$parts = Get-ChildItem (Join-Path $dir 'part_*.b64') | Sort-Object Name
if ($parts.Count -lt 15) { throw "need 15 part_*.b64, have $($parts.Count)" }
$ms = New-Object IO.MemoryStream
foreach ($p in $parts) {
  $b64 = [IO.File]::ReadAllText($p.FullName).Trim()
  $bytes = [Convert]::FromBase64String($b64)
  $ms.Write($bytes, 0, $bytes.Length)
}
$gzPath = Join-Path $dir 'winfleet-server.exe.gz'
$exePath = Join-Path $dir 'winfleet-server.exe'
[IO.File]::WriteAllBytes($gzPath, $ms.ToArray())
$gzMd5 = (Get-FileHash $gzPath -Algorithm MD5).Hash
if ($gzMd5 -ne 'FB185FAD4FA8BB68EA1F0A72779AF7C3') { throw "gz md5 $gzMd5" }
$fs = [IO.File]::OpenRead($gzPath)
$gz = New-Object IO.Compression.GZipStream($fs, [IO.Compression.CompressionMode]::Decompress)
$out = [IO.File]::Create($exePath)
$gz.CopyTo($out); $gz.Close(); $fs.Close(); $out.Close()
$exeMd5 = (Get-FileHash $exePath -Algorithm MD5).Hash
$len = (Get-Item $exePath).Length
Write-Output "OK exe_md5=$exeMd5 size=$len"
if ($exeMd5 -ne '9873F7EC552E0789CF96EF61D852F5BA') { throw "exe md5 mismatch" }
if ($len -ne 22698496) { throw "size mismatch" }
Write-Output "ASSEMBLE_OK"
