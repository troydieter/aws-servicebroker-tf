# aws-servicebroker-tf
This is a Terraform v0.12 version of https://github.com/awslabs/aws-servicebroker/blob/master/setup/prerequisites.yaml

### Instructions
1. Create a provider file for [your backend](https://www.terraform.io/docs/backends/index.html)
2. Set the values in terraform.tfvars
3. `terraform apply`
4. The output you are looking for upon the `terraform apply` is the `pcf_serv-broker` value:


> Outputs:
> 
> pcf_serv-broker = serv-broker-user-31231e0430z7


Note: You may need to provide the IAM user, in our example case: `serv-broker-user-31231e0430z7` an access key and and a secret access key. This can be provided using the [create-login-profile](https://docs.aws.amazon.com/cli/latest/reference/iam/create-login-profile.html) and [create-access-key](https://docs.aws.amazon.com/cli/latest/reference/iam/create-access-key.html) AWS CLI mechanisms.

### Compliance

[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/troydieter/aws-servicebroker-tf/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=troydieter%2Faws-servicebroker-tf&benchmark=INFRASTRUCTURE+SECURITY)<p>
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/troydieter/aws-servicebroker-tf/pci)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=troydieter%2Faws-servicebroker-tf&benchmark=PCI-DSS+V3.2)<p>
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/troydieter/aws-servicebroker-tf/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=troydieter%2Faws-servicebroker-tf&benchmark=CIS+AWS+V1.2)<p>
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/troydieter/aws-servicebroker-tf/soc2)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=troydieter%2Faws-servicebroker-tf&benchmark=SOC2)<p>
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/troydieter/aws-servicebroker-tf/iso)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=troydieter%2Faws-servicebroker-tf&benchmark=ISO27001)<p>
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/troydieter/aws-servicebroker-tf/nist)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=troydieter%2Faws-servicebroker-tf&benchmark=NIST-800-53)<p>
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/troydieter/aws-servicebroker-tf/hipaa)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=troydieter%2Faws-servicebroker-tf&benchmark=HIPAA)