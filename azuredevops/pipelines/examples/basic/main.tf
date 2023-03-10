terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 0.3"
    }
  }
}

provider "azuredevops" {
  org_service_url       = "https://dev.azure.com/ORG-NAME/"
  personal_access_token = "XXXXXXXXXX" // PAT token generated by ADO.
}

module "ado-pipelines" {
  source = "../"

  repo_name    = "Example Repo"
  project_name = "Example Project"
  pipelines = [
    {
      pipeline_name = "Example Pipeline - Production"
      pipeline_path = "\\terraform-configs\\company\\example" // Path where you want your pipeline to be created in - This is somewhat arbitrary 
      config_path   = "company/example/prod"                  // No trailling slash here
    },
    {
      pipeline_name = "Example Pipeline - UAT"
      pipeline_path = "\\terraform-configs\\company\\example"
      config_path   = "company/example/uat"
      branch_name   = "UAT"
    }
  ]
}