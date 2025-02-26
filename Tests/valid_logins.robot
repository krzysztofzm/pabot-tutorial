*** Settings ***
Resource    common.resource
Variables    users.yaml

# Suite Setup    common.Record Execution Start Time
#Suite Teardown    pabot.PabotLib.Run Teardown Only Once    Set the status of valid login tests

Test Teardown    Set the status of valid login tests

Test Template    Valid Login

*** Variables ***
${INVENTORY URL}    https://www.saucedemo.com/inventory.html


*** Test Cases ***               USERNAME                      PASSWORD
Standard user login              ${user.standard}              ${password.valid}
Problem user login               ${user.problem}               ${password.valid}
Performance glitch user login    ${user.performance_glitch}    ${password.valid}
Error user login                 ${user.error}                 ${password.valid}
Visual user login                ${user.visual}                ${password.valid}



*** Keywords ***
Valid Login
    [Arguments]    ${user}    ${password}
    [Setup]    common.Open Swag Labs
    common.Log in to Swag Labs    ${user}    ${password}
    Verify that the user did log in
    [Teardown]    Basic teardown

Verify that the user did log in
    Browser.Get Url    ==    ${INVENTORY URL}

Set the status of valid login tests
    [Documentation]    Sets the value of valid login tests to true if all test pass.
    Log   ${TEST_STATUS}
    IF    '${TEST_STATUS}' == 'FAIL'    pabot.PabotLib.Set Parallel Value For Key       valid_logins_status    ${False}
    