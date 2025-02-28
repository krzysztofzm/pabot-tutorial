*** Settings ***
Resource    common.resource

# Suite Teardown    pabot.PabotLib.Run Teardown Only Once    common.Prompt that the suite has finished
Test Teardown    Set the status of valid login tests

Test Template    Valid Login

*** Variables ***
${INVENTORY URL}    https://www.saucedemo.com/inventory.html


*** Test Cases ***               USER TAG
Standard user login              standard
Problem user login               problem
Performance glitch user login    performance_glitch
Error user login                 error
Visual user login                visual



*** Keywords ***
Valid Login
    [Arguments]    ${user tag}
    [Setup]    common.Open Swag Labs
    ${valueset name}=    pabot.PabotLib.Acquire Value Set    ${user tag}
    ${user}=    pabot.PabotLib.Get Value From Set    user
    ${password}=    pabot.PabotLib.Get Value From Set    password
    common.Log in to Swag Labs    ${user}    ${password}
    Verify that the user did log in
    pabot.PabotLib.Release Value Set
    [Teardown]    common.Basic teardown

Verify that the user did log in
    Browser.Get Url    ==    ${INVENTORY URL}

Set the status of valid login tests
    [Documentation]    Sets the value of valid login tests to true if all test pass.
    Log   ${TEST_STATUS}
    IF    '${TEST_STATUS}' == 'FAIL'    pabot.PabotLib.Set Parallel Value For Key       valid_logins_status    ${False}
