*** Settings ***
Resource     common.resource
Resource     inventory.resource
Resource     cart.resource

Variables    users.yaml

Suite Setup    common.Record Execution Start Time

Test Template    Buy something


*** Test Cases ***              USERNAME                      PASSWORD             ITEM
Standard user buys              ${user.standard}              ${password.valid}    backpack
Problem user buys               ${user.problem}               ${password.valid}    backpack
Performance glitch user buys    ${user.performance_glitch}    ${password.valid}    backpack
Error user buys                 ${user.error}                 ${password.valid}    backpack
Visual user buys                ${user.visual}                ${password.valid}    backpack

*** Keywords ***
Buy something
    [Arguments]    ${user}    ${password}    ${item}
    [Setup]    Open page and login    ${user}    ${password}
    inventory.Add ${item} to cart
    inventory.Go to cart
    cart.Check if item is in cart    ${item}
    cart.Checkout cart
    cart.Fill checkout form and finalize the purchase
    cart.Check if purchase is successful
    [Teardown]    common.Basic teardown

Open page and login
    [Arguments]    ${user}    ${password}
    common.Open Swag Labs
    common.Log in to Swag Labs    ${user}    ${password}
