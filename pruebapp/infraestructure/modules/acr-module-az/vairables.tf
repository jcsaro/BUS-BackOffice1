
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

variable "sku" {
  type        = string
  description = "Level Price for ACR"
  default     = "Basic"
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