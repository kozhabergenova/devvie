# What steps I need to complete to use S3 bucket in AWS as Terraform Remote state 

1. If you don't have an account in AWS, [sign in](https://docs.aws.amazon.com/signin/latest/userguide/account-root-user-type.html).
2. [Add Identity Provider](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services) for OpenID Connect.
3. [Create S3 bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/creating-bucket.html) to store TF state.
4. [Create a role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-custom.html) that we’ll assume from GitHub. You can find the body of the role [here](https://github.com/kozhabergenova/devvie/aws_policies/iam_trust_policy.json).
5. Create Policy to allow the role access to the S3 Bucket. Link to the policy goes [here](https://github.com/kozhabergenova/devvie/aws_policies/iam_policy_for_s3.json).
6. Attach Policies to the Role.
7. Add secrets inside the GitHub repo: Settings -> Secrets -> Actions.



