# tf-gcp-infra
Terraform templates


## Running and Executing Terraform
* Inside your terminal, open the directory where your .tf extension files are located and then type the below commands one after the other

```
terraform init
```

* We shall now authenticate our CLI for GCP. To do that, run the below command and finish up the process

```
gcloud auth application-default login
```

```
terraform plan -var-file="./dev.tfvars"
```

* or as per your need, you could use

```
terraform plan -var-file="./prod.tfvars"
```

```
terraform apply -var-file="dev.tfvars"
```

## GCP with Terraform
###### Questions!
* Do we need to specify subnet regions?
