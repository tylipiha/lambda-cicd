# Lambda CI/CD

This repository deploy an AWS SAM application using GitHub Actions.

## Steps to reproduce

This sections will list how this repository was built.

### 1. Create a new GitHub repository

The repository was created using GitHub Web console and cloned to local laptop.

### 2. Create new SAM application
The first thing we did was initialize a new AWS SAM application using the
SAM tool and its *hello_world* Python3.9 template.

```sh
sam init
```

At this point, we push the initial SAM application to the GitHub:

```sh
git add .
git commit -m "Initialized the SAM Application"
git push
```
### 3. Create AWS IAM User for the CICD

Through AWS Console, a new IAM User was created and granted an AdministratorAccess. The User
was created with only programmatic access. The *AWS_ACCESS_KEY_ID* and *AWS_SECRET_ACCESS_KEY*
were copied and stored into the [GitHub Encrypted secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets) in the GitHub repository.


### 4. Create GitHub actions

The GitHub actions were created using [Quickstart for GitHub Actions](https://docs.github.com/en/actions/quickstart). This way we get a nice initial set of Actions we can now commit and
push to GitHub:

```sh
git add .
git commit -m "Added initial GitHub Actions"
git push
```

After this, we can see the Actions pipeline being run under the *Actions* tab. This pipeline
doesn't still deploy anything into AWS, but by first running the Quickstart pipeline we can
ensure the pipeline itself is being run.

### 5. Modify the GitHub Actions

At this point, we want the pipeline to actually deploy our SAM application to AWS. We will
therefore need to modify the Quickstart pipeline by adding new *steps* to it.

#### Step 1: Add SAM CLI Action

We start by adding [Setup SAM](https://github.com/aws-actions/setup-sam) helper action to
the pipeline steps. This action will install and configure the SAM CLI for us.

#### Step 2: Add AWS Credentials Helper Action

Next we add [Configure AWS Credentials](https://github.com/aws-actions/configure-aws-credentials) helper action. This action will configure our AWS and SAM CLI
which we need for the deployment.

We also configure the action to read the IAM User credentials, *AWS_ACCESS_KEY_ID* and *AWS_SECRET_ACCESS_KEY*, from GitHub Secrets where we stored them earlier. We will also
specify the AWS Region we want to use, in this case eu-west-1.

#### Step 3: Add step to build and deploy SAM

Now we're ready to add a *step* that runs the `sam build` and `sam deploy` commands.
These are the same commands we can use from our own laptop, with exception that we 
cannot use the guided version of `sam deploy`, but instead must use the non-interactive
version of it, see the workflow for example.

#### Push the changes

Our pipeline is now ready. We just need to add and commit everything:

```sh
git add .
git commit -m "Modified GitHub Actions to deploy the application using SAM"
git push
```