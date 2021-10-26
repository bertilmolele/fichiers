if ($null){
        
    	$user = Get-LocalUser | Where-Object {$_.Name -eq $null}
    	if (-Not $user) {
    		New-LocalUser $null -Password "ConvertTo-SecureString 'C@rdabel2020$' -AsPlainText -Force" -Description "user for cardabel app."
    	}
    	else {
    		Write-Host "User $null already defined."
        }
        If ( -Not((Get-LocalGroupMember "users").Name -contains "$env:UserDomain\$null")){
            Add-LocalGroupMember -Group "users" -Member $null
        }
        If ( -Not((Get-LocalGroupMember "IIS_IUSRS").Name -contains "$env:UserDomain\$null")){
            Add-LocalGroupMember -Group "IIS_IUSRS" -Member $null
        }
       
    }
$current_user = Get-LocalUser | Where-Object {$_.Name -eq $env:UserName}
If ( -Not((Get-LocalGroupMember "IIS_IUSRS").Name -contains "$env:UserDomain\$env:UserName")){
    Add-LocalGroupMember -Group "IIS_IUSRS" -Member $current_user
    }


If (Test-Path C:\carabel\AnomalyDetectFiles)
{
    Remove-Item C:\cardabel\AnomalyDetectFiles -Recurse -Force
}
New-Item -ItemType Directory -Force -Path C:\cardabel\AnomalyDetectFiles

If (Test-Path C:\cardabel\cardabel)
{
    Remove-Item C:\cardabel\cardabel -Recurse -Force
}
New-Item -ItemType Directory -Force -Path C:\cardabel\cardabel

Copy-Item -Path C:\cardabel\cardabel\client-files\* -Destination C:\cardabel\AnomalyDetectFiles -Recurse

$acl=Get-Acl -Path C:\cardabel\AnomalyDetectFiles
$ar = New-Object  system.security.accesscontrol.filesystemaccessrule("BUILTIN\IIS_IUSRS","FullControl","ContainerInherit,ObjectInherit","None","Allow")
$acl.SetAccessRule($ar)
$acl | Set-Acl

$acl=Get-Acl -Path C:\cardabel\cardabel
$ar = New-Object  system.security.accesscontrol.filesystemaccessrule("BUILTIN\IIS_IUSRS","FullControl","ContainerInherit,ObjectInherit","None","Allow")
$acl.SetAccessRule($ar)
$acl | Set-Acl

