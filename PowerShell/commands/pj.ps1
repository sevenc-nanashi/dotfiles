param(
    [parameter(ValueFromPipeline)]$string
)

$string | C:\develop\python\python.exe "$home\Documents\WindowsPowerShell\resources\pretty-json.py" @args
