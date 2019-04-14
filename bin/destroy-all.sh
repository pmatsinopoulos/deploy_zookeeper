#!/usr/bin/env bash

./bin/destroy-subnet.sh config/subnet-3.cfg
./bin/destroy-subnet.sh config/subnet-2.cfg
./bin/destroy-subnet.sh config/subnet-1.cfg
./bin/destroy-vpc.sh config/vpc.cfg

