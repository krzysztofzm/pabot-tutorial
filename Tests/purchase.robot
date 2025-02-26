*** Settings ***
Resource     common.resource
Resource     inventory.resource
Resource     cart.resource

Variables    users.yaml

# Suite Setup    common.Record Execution Start Time

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
    [Setup]    Setup purchase test    ${user}    ${password}
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

Check if skip this test
    [Documentation]    Checks if the precondition for the test are met, if not test will be skipped.
    ${valid test status}=    pabot.PabotLib.Get Parallel Value For Key    valid_logins_status
    Skip If    $valid_test_status == False    The valid login tests failed, for that reason this test is skipped.

Setup purchase test
    [Arguments]    ${user}    ${password}
    Check if skip this test
    Open page and login    ${user}    ${password}