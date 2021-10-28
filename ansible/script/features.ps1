Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebserverRole -NoRestart
python -m pip install --upgrade pip
python -m pip install -r C:\cardabel_dir\python\requirements.txt
Import-Csv C:\cardabel\install\scripts\Roles.csv | foreach { Install-WindowsFeature $_name}
