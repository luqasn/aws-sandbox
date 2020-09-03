# aws-sandbox
Transparent sandbox for integration testing against AWS services using LocalStack. Test your infrastructure without changes to your Terraform files or your application code/config

## How it works
This project combines 5 components:
- LocalStack for providing a (mostly) working mock of AWS services
- Traefik in front of LocalStack and possibly your own services to allow them all to offer their services on localhost:80 to the host (not strictly necessary)
- mitmproxy as an external entrypoint into the sandbox (so that you can point things at the AWS running inside the sandbox without needing to mess with the host's DNS settings)
  - additionally, this contains a workaround for missing "subdomain-style" s3 access in LocalStack (see [](s3-url-hack.py))
- CoreDNS for wildcard DNS resolution for both AWS services and your own ones (ending on .test)
- cert-helper takes the auto-generated proxy CA cert and packages it in Debian CA format so you can inject it into containers

In order to make default AWS SDK connections work, the sandbox needs to support SSL. In order to do that, you can let it automatically inject the auto-generated CA cert into your containers (see [](docker-compose.example-service.yaml))

## How to use
First, start localstack and helper services
```
docker-compose up -d
```

Execute command against dockered environment (from inside docker)
```
docker-compose -f docker-compose.yaml -f docker-compose.aws-cli.yaml run --rm aws-cli s3api list-buckets
```

Execute command against dockered environment (from the host). This example assumes you want to configure your fake AWS env with Terraform:
```
HTTP_PROXY=http://proxy:8888 HTTPS_PROXY=http://proxy:8888 terraform plan
```

Run example service accessing AWS sandbox:
```
docker-compose -f docker-compose.yaml  -f docker-compose.example-service.yaml run example-service
```
and then access it via your browser at http://example-service.test/ (need to set your proxy to localhost:8888) to create S3 buckets and upload files.


See requests made to AWS sandbox: http://localhost:8082/