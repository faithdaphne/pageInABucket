#!/bin/bash

BNAME=$1
aws s3 mb s3://$BNAME
# aws s3 ls s3://$BNAME
aws s3 cp index.html s3://$BNAME --acl public-read
aws s3 website s3://$BNAME/ --index-document index.html
aws s3api put-public-access-block --bucket $BNAME --public-access-block-configuration BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false

# curl http://faithdaphne.s3-website.eu-central-1.amazonaws.com/