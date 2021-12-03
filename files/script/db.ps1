$anomaly_dir = 'C:\AnomalyDetectFiles'
$lb_port = '5000'
$db_user = 'cardabel'
$db_password = 'cardabel$'
$db_host = '34.107.46.66'
$db_port = '3386'
$db_name = 'bertil_new'
$cardabel_secure_passwd = ConvertTo-secureString $db_password -AsPlainText -Force

Start-Process C:\cardabel\cardabel-config\db\CreateDBCredentials.exe -NoNewWindow -ArgumentList "$db_user $db_password $db_host $db_port $db_name $anomaly_dir" -Wait

Start-Process yoyo.exe -NoNewWindow -ArgumentList "apply --batch -vvv --database mysql+mysqldb://${db_user}:${db_password}@${db_host}:${db_port}/${db_name} C:\cardabel\install" -Wait
