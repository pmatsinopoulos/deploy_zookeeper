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
$ ./bin/create-vpc.sh config/vpc.cfg
```

This creates the VPC together with the following:

1. 1 Route Table
1. 1 Network ACLs
1. 1 Security Group

## Destroy VPC

``` bash
$ ./bin/destroy-vpc.sh config/vpc.cfg
```

## The Whole Creation Sequence

``` bash
$ ./bin/create-vpc.sh config/vpc.cfg
$ ./bin/create-subnet.sh config/subnet-1.cfg
```

## The Whole Destroy Sequence

```bash
$ ./bin/destroy-subnet.sh config/subnet-1.cfg
$ ./bin/destroy-vpc.sh config/vpc.cfg

```
