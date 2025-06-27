variable "rg_name" {
  description = "The name of the Resource Group"
  type        = string
}

variable "location" {
  description = "The location of the Resource Group"
  type        = string
}

variable "tags" {
  description = "The tags for the Resource Group"
  type        = map(string)
  default     = {}
}
