terraform {

  required_version = ">= 1.3.7"

  required_providers {

    azurerm = {

      source = "hashicorp/azurerm"

      version = ">= 3.0"

    }

    random = {

      source = "hashicorp/random"

      version = ">= 3.0"

    }

    

  }

    backend "azurerm" {

    

  } 

}



#************************************************* Provider Block

provider "azurerm" {

 features {}

}



#*************************************************  variables

variable "resource_group_name" {

  description = "Resource Group Name"

  type = string

  default = "rg-default"

}



# Azure Resources Location

variable "resource_group_location" {

  description = "Region in which Azure Resources to be created"

  type = string

  default = "eastus2"

}

#*************************************************  Resources

resource "random_string" "myrandom" {

  length = 6

  upper = false

  special = false

  numeric = false

}



resource "azurerm_resource_group" "rg" {

  name = "${var.resource_group_name}-${random_string.myrandom.id}"

  location = var.resource_group_location



}



resource "azurerm_container_registry" "acr" {

  name                = "${random_string.myrandom.id}myacr"

  resource_group_name = azurerm_resource_group.rg.name

  location            = azurerm_resource_group.rg.location

  sku                 = "Standard"

  admin_enabled       = false

}