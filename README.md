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
