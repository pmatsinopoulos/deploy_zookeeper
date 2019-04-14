#!/usr/bin/env bash

./bin/create-vpc.sh config/vpc.cfg
./bin/create-subnet.sh config/subnet-1.cfg
./bin/create-subnet.sh config/subnet-2.cfg
./bin/create-subnet.sh config/subnet-3.cfg
