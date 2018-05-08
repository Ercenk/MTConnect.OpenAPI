mkdir %temp%\input
copy .\openAPI_1.3.1.yaml %temp%\input
docker run --rm --name autorest -v "%cd%"/out:/out -v "%temp%"/input/:/input azuresdk/autorest autorest --input-file=/input/openAPI_1.3.1.yaml --csharp --output-folder=/out --namespace=MTConnect.Client
rmdir /s /q %temp%\input

