## Convert service testing

This project need to test onlyoffice documentserver via convert service

## Getting start

Add all keys to dockerfile

* S3_KEY - is a s3 public key
* S3_PRIVATE_KEY - is a s3 private key
* PALLADIUM_TOKEN - token for write result to palladium

Do not forget to change documentserver version from docker-compose file (default - **4testing-documentserver-ie:latest**)

Run tests: 

`docker-compose up -d`

## How it work

File will be downloaded from s3 to `file_tmp`. This folder is a same for `testing_project` and `nginx`.
After it, `testing_project` will send request to documentserver with link to file from nginx. After conversion, response will parsed, and result will send to palladium
