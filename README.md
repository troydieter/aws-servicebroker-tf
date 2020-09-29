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
