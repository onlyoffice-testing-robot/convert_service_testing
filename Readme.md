## Convert service testing

This project need to test onlyoffice documentserver via convert service

At first, change dockerfile
* S3_KEY - is a s3 public key
* S3_PRIVATE_KEY - is a s3 private key
* PALLADIUM_TOKEN - token for write result to palladium
* DOCUMENTSERVER_JWT - documentserver jwt key(optional)

## And run tests: `docker run -it $(docker build -q .) rspec`