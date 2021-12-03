python -m pip install --upgrade pip
python -m pip install -r C:\cardabel\python\requirements.txt
python -m pip install --no-index --find-links C:\cardabel\python\library -r C:\cardabel\python\requirements.txt
foreach($line in Get-Content -Path C:\cardabel\install\scripts\roles.csv){Add-WindowsCapability -Online -Name $line}
