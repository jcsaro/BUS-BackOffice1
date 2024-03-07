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
}
/*
variable "public_subnet_name" {
  description = "Name of the public subnet"
}

variable "public_subnet_prefixes" {
  description = "Address prefixes for the public subnet"
}*/


variable "private_subnet_names_types" {
  description = "Name of the private subnet"
  type = list(string)
  default = []
}

variable "private_subnet_prefixes" {
  description = "Address prefixes for the private subnet"
  type = list(string)
  default = []
}

variable "sku_name" {
  type        = string
  description = "capacity of the nat"
  default     = "standard"
}

variable "nat_gateway_id" {
  type        = string
  description = "ID of the nat"
}

variable "public_ip_address_id" {
  type = string
  description = "ID of the IP"
}

variable "allocation_method" {
  type = string
  description = "ALLOCATION METHOD"
  default     = "Static"
}

variable "subnet_id" {
  type = string
  description = "id of subnet"
}

variable "public_ip_address_id" {
  type = string
  description = "id of IP"
}