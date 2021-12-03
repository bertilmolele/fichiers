$cardabel_dir = 'C:\cardabel'
$anomaly_dir = 'C:\AnomalyDetectFiles'
$cardabel_site = 'cardabel'
$cardabel_url = 'localhost'
$site_port = '80'
$lb_port = '5000'
$python_ports = @('5001','5002')
$db_user = 'cardabel'
$db_passwd = 'cardabel$'
$db_host = '34.107.46.66'
$db_port = '3386'
$db_name = 'bertil_new'
$db_migration_file = 'C:\sources\anomaly_ocbc.dump'
$new_db = 'yes'
$cardabel_user_name = $null
$cardabel_passwd = 'C@rdabel2020$'
$cardabel_secure_passwd = ConvertTo-SecureString $cardabel_passwd -AsPlainText -Force
$multi_process_cpu = 2
$ssl = 'no'
$with_cyphers = 'no'
$new_server = 'yes'

if ($cardabel_user_name){
	$user = Get-LocalUser | Where-Object {$_.Name -eq $cardabel_user_name}
	if (-Not $user){
		New-LocalUser $cardabel_user_name -Password $cardabel_secure_passwd -Description "user for cardabel app."
			}
	if (-Not ((Get-LocalGroupMember "users").Name -contains "$env:UserDomain\$cardabel_user_name")){
		Add-LocalGroupMember -Group "users" -Member $cardabel_user_name
			}
	if (-Not ((Get-LocalGroupMember "IIS_IUSRS").Name -contains "$env:UserDomain\$cardabel_user_name")){
		Add-LocalGroupMember -Group "IIS_IUSRS" -Member $cardabel_user_name
			}
}

$current_user = Get-LocalUser | Where-Object {$_.Name -eq $env:Username}
if (-Not ((Get-LocalGroupMember "IIS_IUSRS").Name -contains "$env:UserDomain\$env:UserName")){
	Add-LocalGroupMember -Group "IIS_IUSRS" -Member $current_user
	}

if (Test-Path $anomaly_dir)
{
	Remove-Item $anomaly_dir -Recurse -Force
}
New-Item -ItemType Directory -Force -Path $anomaly_dir

If (Test-Path C:\cardabel-site)
{
	Copy-Item -Path C:\cardabel-site\cardabel-site\* -Destination C:\cardabel\cardabel-site -Recurse
}
Remove-Item -Path C:\cardabel-site -Recurse


Copy-Item -Path C:\cardabel\client-files\* -Destination C:\AnomalyDetectFiles -recurse
Copy-Item -Path C:\cardabel\cardabel-config\local-conf\default\settings.* -Destination C:\cardabel\csharp\Properties -recurse
Copy-Item -Path C:\cardabel\cardabel-config\local-conf\default\csharp-web.config -Destination C:\cardabel\csharp\Web.config
Copy-Item -Path C:\cardabel\cardabel-config\local-conf\default\cardabel.yaml -Destination C:\cardabel\cardabel-config
Copy-Item -Path C:\cardabel\cardabel-config\local-conf\default\net-logging.json -Destination C:\cardabel\cardabel-config
Copy-Item -Path C:\cardabel\cardabel-config\local-cong\default\python-logging.yaml -Destination C:\cardabel\cardabel-config

$acl = Get-Acl -Path $cardabel_dir
$ar = New-Object system.security.accesscontrol.filesystemaccessrule("BUILTIN\IIS_IUSRS","FullControl","ContainerInherit,ObjectInherit","None","Allow")
$acl.setAccessRule($ar)
$acl | Set-Acl

if (Get-Website -Name 'Default Web Site')
{
	Remove-Website -Name 'Default Web Site'
}

if (Get-Website -Name $cardabel_site)
{
	Remove-Website -Name $cardabel_site
}

New-website -Name $cardabel_site -Port $site_port -PhysicalPath "${cardabel_dir}\cardabel-site"
New-WebApplicationPool DefaultAppPool
