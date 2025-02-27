*** Settings ***
Resource     common.resource
Resource     inventory.resource
Resource     cart.resource

Test Template    Buy something


*** Test Cases ***              USER TAG              ITEM
Standard user buys              standard              backpack
Problem user buys               problem               backpack
Performance glitch user buys    performance_glitch    backpack
Error user buys                 error                 backpack
Visual user buys                visual                backpack

*** Keywords ***
Buy something
    [Arguments]    ${user tag}    ${item}
    [Setup]    Setup purchase test
    ${credentials}=    pabot.PabotLib.Acquire Value Set    ${user tag}
    ${user}=    pabot.PabotLib.Get Value From Set    user
    ${password}=    pabot.PabotLib.Get Value From Set    password
    common.Log in to Swag Labs    ${user}    ${password}
    inventory.Add ${item} to cart
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
