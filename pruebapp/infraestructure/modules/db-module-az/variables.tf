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
  default     = "GP_Gen5_2"
}

variable "version" {
  type        = string
  default     = "11"
}

variable "admin_username" {
  type        = string
  
}

variable "admin_password" {
  type        = string
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
  type        = bool
  default     = "true"
}

