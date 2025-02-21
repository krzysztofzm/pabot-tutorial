***Settings***
Library      Browser
Library      String

Variables    inventory_page.yaml

*** Keywords ***
Add ${item} to cart
    ${item to add}=     String.Format String    ${inventory.add_item_to_cart_id}    ${item}
    Browser.Click    id=${item to add}

Go to cart
    Browser.Click    id=${inventory.go_to_cart_id}