If (Test-Path C:\cardabel)
{
	Remove-Item -Path C:\cardabel -Recurse 
}

If (Test-Path C:\cardabelgui)
{
	Remove-Item -Path C:\cardabelgui -Recurse 
}

