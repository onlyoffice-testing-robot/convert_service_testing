## Convert service testing

This project need to test onlyoffice documentserver via convert service

At first, change dockerfile
* DOCUMENTSERVER - is a documentserver for testing. exemple: "https://doc-linux.teamlab.info"
* S3_KEY - is a s3 public key
* S3_PRIVATE_KEY - is a s3 private key
* PALLADIUM_TOKEN - token for write result to palladium
* DOCUMENTSERVER_JWT - documentserver jwt key(optional. comment it for no using jwt)

And run tests: 

`docker run -it $(docker build -q .) rspec`

## Run documentserver and tests:

At first, you need to change Dockerfile
* S3_KEY - is a s3 public key
* S3_PRIVATE_KEY - is a s3 private key
* PALLADIUM_TOKEN - token for write result to palladium

Change `docker-compose.yml` to specify correct version of DocumentServer

And run docker compose

`docker-compose up -d`
