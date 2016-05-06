SET modulespath="%homedrive%%homepath%\Documents\WindowsPowerShell\Modules\Get-Lines"
rd /s /q %modulespath%
md %modulespath%
copy *.ps?1 %modulespath%