variable "buses" {
  type        = list(string)
  default     = ["arn:aws:events:us-east-1:768827764971:event-bus/Inventory", "arn:aws:events:us-east-1:768827764971:event-bus/Orders", "arn:aws:events:us-west-2:768827764971:event-bus/eventBus1"]
  description = "Name of the first EventBus"
}

variable "centralEB" {
  type        = string
  default     = "centralEB"
  description = "Name of central EventBus"
}

variable "names" {
  type  = set(string)
  default = [ "eb1","eb2" ]
  
}

