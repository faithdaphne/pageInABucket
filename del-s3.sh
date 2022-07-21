#!/bin/bash

BNAME=$1
CONTENT=$2

aws s3 rm s3://$BNAME/$CONTENT --recursive
aws s3 rb s3://$BNAME --force