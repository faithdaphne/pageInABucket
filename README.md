# Page in a Bucket

## Story

You've heard from a friend that with S3 you can host websites easily without the usual pain of installing a webserver, configuring it and so on. You decide to check this feature out.

## What are you going to learn?

* Using S3 from the AWS Management Console
* Hosting website from S3
* Configuring access to S3 buckets
* Interacting with S3 buckets via the AWS CLI

## Tasks

1. Create an S3 bucket in the AWS Management Console.
    - Created an S3 bucket (its name should contain the first part of your private email address)
    - Made sure that the bucket is _not_ versioned

2. Create a simple webpage and host it on Amazon S3 without running any servers.
    - Created an `index.html` that contains `Hello, World!` (or something more creative)
    - Uploaded `index.html` to the S3 bucket created earlier
    - Enabled _Static website hosting_ under the S3 bucket's _Properties_, chose _Host static website_ and configure `index.html` to be the the _Index document_
    - Disabled _Block all public access_ under the S3 bucket's _Permissions_ (e.g. made possible to make objects in the bucket to be public) and made the `index.html` object public
    - Visiting http://YOURBUCKET.s3-website.eu-central-1.amazonaws.com/ loads your website

3. Generate credentials for CLI access via the AWS Management Console's [_My Security Credentials_](https://console.aws.amazon.com/iam/home#/security_credentials) page.
    - Created a new access key
    - Downloaded the `.csv` file containing the _Access key ID_ and the _Secret access key_

4. To interact with AWS's API one must _always_ provide access/secret keys with _every_ command. It's a pain in the knee to specify these credentials with every AWS CLI command. CLI profiles to the rescue!
    - `aws --version` outputs something like `aws-cli/2.1.27 ...` (the version number can be higher, but should start with 2)
    - Used `aws configure` to configure the `[default]` profile
    - `~/.aws/config` contains

```ini
[default]
region = eu-central-1
```
    - `~/.aws/credentials` contains

```ini
[default]
aws_access_key_id = <Your access key ID>
aws_secret_access_key = <Your secret access key>
```

5. To see first hand whether it's easier to manage S3 buckets via the commandline or not first delete everything you've set up until now _from the commandline_ then recreate the whole shebang again via the `aws` CLI tool.
    - Deleted the previously created bucket and its contents using `aws s3 rb`
    - Created a new bucket (using the same name as before) using `aws s3 mb`
    - Copied the existig `index.html` to the bucket using `aws s3 cp` (add `--acl public read` to make the copied object public)
    - Enabled static webhosting using `aws s3 website` (make sure to specify `--index-document index.html` too)
    - Configured bucket to allow making objects in it public, e.g.

```sh
aws s3api put-public-access-block --bucket YOURBUCKET --public-access-block-configuration BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false
```
    - Running `curl http://YOURBUCKET.s3-website.eu-central-1.amazonaws.com/` works and displays your webpage's content

## General requirements

None

## Hints

- Typing `help` after AWS CLI commands (e.g. `aws ec2 describe-instances help`) opens up the command's manual in a _pager_, to quit press `q`
- After using `aws configure` your credentials and profile configuration will be available at `~/.aws/credentials` and `~/.aws/config`
- Use `aws s3` (not `aws s3`) to interact with existing S3 buckets and objects, type `aws s3 help` to see the available commands (you'll see familiar things like `ls` and `cp`)
- Most of the time you must use S3 URIs (e.g. _s3://somebucketname/someobjectname_) when using the `aws s3` tool
- To create a new bucket use `aws s3 mb` (`mb` as in _make bucket_), you must use an `s3://` prefix for the name (similar to using `http://` for websites)
- S3 doesn't understand the concepts of _folders_, there are only buckets and objects (which are named with _keys_ that look like _file\ paths_)
- `aws s3 rb` can be used to delete buckets (`rb` stands for _remove bucket_), the `--force` is quite useful to delete non-empty buckets
- Sometimes you need to use the `aws s3api` command to do certain things instead of just using `aws s3`
- Specify an AWS region using the `--region` flag or configure a profile to use a specific region and use `--profile`
- S3 bucket names are globally unique instead of being tied to a region, however they are always stored physically in the specific region where you create them
- You can use the `--debug` flag when your command doesn't work to see what's going on (the output might be cryptic tho')

## Background materials

* [Introduction to S3](project/curriculum/materials/tutorials/introduction-to-aws-s3.md)
* [S3 Static Website](https://docs.aws.amazon.com/AmazonS3/latest/userguide/HostingWebsiteOnS3Setup.html)
* [`aws s3`](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/index.html)
* [`aws s3api put-public-access-block`](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/put-public-access-block.html)
