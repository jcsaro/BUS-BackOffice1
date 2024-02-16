terraform {
    required_version = "1.7.3"

      cloud {
          organization = "mily-sigue"

	      workspaces {
	            name = "integration-dev"
		        }
			  }

			    required_providers {
			        azurerm = {
				      source = "hashicorp/azurerm"
				            version = "3.91.0"
					        }
						  }
						  }

						  provider "azurerm" {
						    features {}
						    }
