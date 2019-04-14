# WIP

This is still work in progress.

## AWS Credentials

A `.env` file exporting the following should exist in the root folder of this project:

```bash
AWS_DEFAULT_REGION=<region>
AWS_ACCESS_KEY_ID=<aws access key id>
AWS_SECRET_ACCESS_KEY=<aws secret access key>
```

## Create VPC 

The following creates the VPC stack with stack name `vpc-zookeepers` on `development` environment.

```bash
$ ./scripts/create-vpc.sh config/vpc-stack-configuration.cfg
```

This creates the VPC together with the following:

1. 1 Route Table
1. 1 Network ACLs
1. 1 Security Group

## Destroy VPC

``` bash
$ ./scripts/destroy-vpc.sh config/vpc-stack-configuration.cfg
```

