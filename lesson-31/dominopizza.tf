terraform {
  required_providers {
    dominos = {
      source  = "dominos.com/myorg/dominos" # ~/.terraform.d/plugins/dominos.com/myorg/dominos/1.0/linux_amd64/
      version = "~>1.0"
    }
  }
}

provider "dominos" {
  first_name    = "My"
  last_name     = "Name"
  email_address = "my@name.com"
  phone_number  = "15555555555"

  credit_card {
    number = 123456789101112
    cvv    = 1314
    date   = "15/16"
    zip    = 18192
  }
}

data "dominos_address" "addr" {
  street = "123 Main St"
  city   = "Anytown"
  state  = "WA"
  zip    = "02122"
}

data "dominos_store" "store" {
  address_url_object = data.dominos_address.addr.url_object
}

data "dominos_menu_item" "item" {
  store_id     = data.dominos_store.store.store_id
  query_string = ["philly", "medium"]
}


resource "dominos_order" "order" {
  address_api_object = data.dominos_address.addr.api_object
  store_id           = data.dominos_store.store.store_id
  item_codes         = ["PBKIREZA", "D20BZRO"]

}


output "dominos_address" {
  value = data.dominos_address.addr.url_object
}


output "dominos_store_id" {
  value = data.dominos_store.store.store_id
}

output "dominos_store_delivery" {
  value = data.dominos_store.store.delivery_minutes
}

output "dominos_menu" {
  value = data.dominos_menu_item.item
}

output "dominos_order" {
  value = dominos_order.order
}