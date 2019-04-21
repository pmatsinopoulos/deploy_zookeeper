# WIP

This is still work in progress.

## AWS Credentials

A `.env` file exporting the following should exist in the root folder of this project:

```bash
AWS_DEFAULT_REGION=<region>
AWS_ACCESS_KEY_ID=<aws access key id>
AWS_SECRET_ACCESS_KEY=<aws secret access key>
```

## The Whole Creation Sequence

``` bash
$ ./bin/create-all.sh
```

## The Whole Destroy Sequence

```bash
$ ./bin/destroy-all.sh
```

## Next Step

- Can I create a series of EC2 machines, each one on different subnet? 
-- For example, create 2 EC2 machines on subnet-1,
                       2 EC2 machines on subnet-2,
                       2 EC2 machines on subnet-3,

Later:
- Can I create a series of EC2 machines in an auto-scaling group using cloud formation?

When using the UI to launch a template:

ACTION: TODO: I need to assign a public IP to the instance?

1. I have to define the instance type, otherwise, the launch template will not succeed to launch.
2. I also have to define the subnet because this will put the machine into a subnet.
3. The template assign a public IP address automatically. However, this is renewed every time the instance restarts.
4. However, I can have a private IP address stick to the EC2 instance and every time it restarts in takes the same
instance.
5. If I want public IP address to be stick then I might have to use EIP.


