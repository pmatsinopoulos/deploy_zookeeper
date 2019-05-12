# WIP

This is still work in progress.

## AWS Credentials

A `.env` file exporting the following should exist in the root folder of this project:

```bash
AWS_DEFAULT_REGION=<region>
AWS_ACCESS_KEY_ID=<aws access key id>
AWS_SECRET_ACCESS_KEY=<aws secret access key>
```

# TODO: Write what privileges the user should have in order to run the scripts.
# TODO: Think about using "Fn::Base64" instead of doing the encoding offline. 

## The Whole Creation Sequence

``` bash
$ ./bin/create-all.sh
```

## The Whole Destroy Sequence

```bash
$ ./bin/destroy-all.sh
```

## EC2 Launch Template

The VPC creation process creates an EC2 Launch Template. This includes user data. It is a long string which comes out
of the base64 encoding of the script `cloudformation/user_data.sh`.

## TODO: ...

Automate the process of the generation of the EC2 Launch Template User Data value.

## Next Step

- Can I create a series of EC2 machines, each one on different subnet? 
-- For example, create 1 EC2 machine on subnet-1,
                       1 EC2 machine on subnet-2,
                       1 EC2 machine on subnet-3,

Later:
- Can I create a series of EC2 machines in an auto-scaling group using cloud formation?

When using the UI to launch a template:

1. I have to define the instance type, otherwise, the launch template will not succeed to launch.
2. I also have to define the subnet because this will put the machine into a subnet.
3. The template assign a public IP address automatically. However, this is renewed every time the instance restarts.
4. However, I can have a private IP address stick to the EC2 instance and every time it restarts in takes the same
instance.
5. If I want public IP address to be stick then I might have to use EIP.
6. Or I may need to use a DNS service that would resolve private names to private ips.
7. Maybe, I should use an EC2 Launch Template that would install puppet-agent.

### Next Steps:

1. (Not Sure whether I want this) - Use 1 cloud formation stack for all the zookeeper nodes.
1. [DONE] Add Node on specific subnet so that I can add many nodes on same subnet.
1. [Will not do now] Do I have to have public IPs for Zookeeper nodes? Or is it enough to have a node facing Public internet
and allow ssh only from this node to Zookeeper nodes and allow public ssh access only to the node that
is facing public internet. Yes. We can use a bastion host. But wwill not do it now.
1. [DONE] Allow addition and deletion of nodes out of order. For example add node 2, then node 1, then node 4, then node 3. 
 --- Almost done. The problem is that the zoo.cfg created has the wrong `server.XXXXX` key name. The value is correct.
     For example if we add the node with id "2" first, it creates: `server.1=zookeepernode-2.zookeepers.demo`, which
     has wrong id in `server.XXXX`. Note that the "myid" is created correctly with value `2`.
     So, we need to sort that out.
1. [] Shell script arguments. Need to check and also add a --help argument that would print information.     
1. Webhooks for Github - Hence will be able to update immediately.
