variable "number_exaple" {

    description = "and exaple of a number veriable in terraform"
    type = number
    default =42 
  
}

variable "list_exaple" {
  
  description = "and exaple of a list veriable in terraform"
  type = list
  default = ["a","b","c"]

}


variable "list_numeric_exaple" {
  
  description = "and exaple of a list numeric veriable in terraform"
  type = list
  default = [1,2,3]

}

variable "map_example" {
  
  description = "and exaple of a list numeric veriable in terraform"

  type = map(string)
  default = {
      key1 = "value1"
      key2 = "value2"
      key3 = "value3"
  }

  
}
