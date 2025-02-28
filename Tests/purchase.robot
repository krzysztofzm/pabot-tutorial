*** Settings ***
Resource     common.resource
Resource     inventory.resource
Resource     cart.resource

Test Template    Buy something

*** Variables ***
@{ITEMS}    backpack    bolt t-shirt    onesie    bike light


*** Test Cases ***              USER TAG
Standard user buys              standard
Problem user buys               problem
Performance glitch user buys    performance_glitch
Error user buys                 error
Visual user buys                visual

*** Keywords ***
Buy something
    [Arguments]    ${user tag}
    [Setup]    Setup purchase test
    ${credentials}=    pabot.PabotLib.Acquire Value Set    ${user tag}
    ${user}=    pabot.PabotLib.Get Value From Set    user
    ${password}=    pabot.PabotLib.Get Value From Set    password
    common.Log in to Swag Labs    ${user}    ${password}

    pabot.PabotLib.Acquire Lock   get item
    ${item}=    Dialogs.Get Selections From User    Select item for "${TEST_NAME}"    @{ITEMS}
    VAR    ${item}    ${item}[0]    
    inventory.Add ${item} to cart
    pabot.PabotLib.Release Lock    get item

    inventory.Go to cart
    cart.Check if item is in cart    ${item}
    cart.Checkout cart
    cart.Fill checkout form and finalize the purchase

    cart.Check if purchase is successful
    pabot.PabotLib.Release Value Set
    [Teardown]    common.Basic teardown

Check if skip this test
    [Documentation]    Checks if the precondition for the test are met, if not test will be skipped.
    ${valid test status}=    pabot.PabotLib.Get Parallel Value For Key    valid_logins_status
    Skip If    $valid_test_status == False    The valid login tests failed, for that reason this test is skipped.

Setup purchase test
    Check if skip this test
    common.Open Swag Labs
