terraform {
    required_providers {
       azuredevops = {
        source = "microsoft/azuredevops"
        version = ">=0.1.0"
       }
    }
}
provider "azuredevops" {
  
}
# $env:AZDO_PERSONAL_ACCESS_TOKEN="bmh3ssfqxtp44uqojnza72jtxh5f373pfmkyfs4yfrgcr4i463bq"
# $env:AZDO_ORG_SERVICE_URL="https://dev.azure.com/darylvandenberg"