variable "location" {
  description = "Location Resource Name"
  default     = "South Central US"
}
variable "short_company" {
  type        = string
  description = "Short Name for Company"
  default     = "OX"
}
variable "short_cloud" {
  type        = string
  description = "Short Name for Cloud Environment"
  default     = "Z"
}
variable "resource_number" {
  type        = string
  description = "Resource Number"
  default     = "01"
}

variable "rg_reference" {
  type = object({
    name     = string,
    location = string
  })
}


variable "short_env" {
  type        = string
  description = "Short Name for Cloud Environment"
  default     = "D"
}

variable "short_project" {
  type        = string
  description = "Short Name for Cloud Environment"
  default     = "OXH"
}

variable "address_space" {
  description = "Address space for the virtual network"
  type = list(string)
  default = [ "10.0.0.0/8" ]
}
/*
variable "public_subnet_name" {
  description = "Name of the public subnet"
}

variable "public_subnet_prefixes" {
  description = "Address prefixes for the public subnet"
}*/


variable "private_subnet_names_types" {
  type = list(string)
  description = "Name of the private subnet"
  default = []
}

variable "private_subnet_prefixes" {
  type = list(string)
  description = "Address prefixes for the private subnet"
  default = []
}

variable "sku_name" {
  type        = string
  description = "capacity of the nat"
  default     = "standard"
}

variable "public_ip_name" {
  type        = list(string)
  description = "capacity of the nat"
  default     = []
}
variable "public_ip_name_bastion" {
  type        = list(string)
  description = "capacity of the nat"
  default     = []
}

variable "allocation_method" {
  type = string
  description = "ALLOCATION METHOD"
  default     = "Static"
}


variable "bastion_private_subnet_names_types"{
  type = list(string)
  description = "Bastion names Types" 
  default = []
} 