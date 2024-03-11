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

variable "server_numberid" {
  description = "NUMBERID DB"
  type = list(string)
  default = []
}

variable "sku_name" {
  type        = string
  description = "capacity of DB"
  default     = "GP_Gen5_2_D2ds_v5"
}

variable "db_version" {
  type        = number
  default     = "12"
}

variable "admin_username" {
  type        = list(string)
  default = []
  }

variable "admin_password" {
  type        = list(string)
  default = []
}

variable "public_network_access_enabled" {
  type        = string
  default     = "false"
}

variable "storage_mb" {
  type        = string
  default     = "500000"
}

variable "ssl_enforcement_enabled" {
  type        = string
  default     = "true"
}

variable "delegated_subnet_id" {
  type = string
  description = "ID_Subnet"
  
}