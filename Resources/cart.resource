***Settings***
Library      Browser
Library      String

Variables    cart_page.yaml

*** Keywords ***
Check if item is in cart
    [Arguments]    ${item name}
    ${cart item}=    Browser.Get Text    xpath=${cart.item_name}
    ${cart item}=    String.Convert To Lower Case     ${cart item}
    Should Contain    ${cart item}    ${item name}

Checkout cart
    Browser.Click    id=${cart.checkout_id}

Fill checkout form and finalize the purchase
    [Arguments]    ${first name}=Dummy    ${last name}=Test    ${zip}=12345
    Browser.Fill Text    id=${cart.checkout_form.first_name_id}    ${first name}
    Browser.Fill Text    id=${cart.checkout_form.last_name_id}    ${last name}
    Browser.Fill Text    id=${cart.checkout_form.zip_id}    ${zip}
    Browser.Click    id=${cart.checkout_form.continue_btn_id}
    Browser.Click    id=${cart.checkout_form.finish_btn_id}

Check if purchase is successful
    Browser.Get Text    xpath=${cart.checkout_form.status}    ==    Thank you for your order!
