$new_db = 'yes'
$db_migration_file = 'C:\sources\anomaly_ocbc.dump'
if ($new_db -eq 'yes') {
    if (-not $db_migration_file) {
	Start-Process "python" -NoNewWindow -ArgumentList "C:\cardabel\cardabel-config\create_db.py cardabel cardabel$ 34.107.64.214 3386 bertil2 C:\cardabel\install" -Wait}  

}
