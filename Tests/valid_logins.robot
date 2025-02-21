*** Settings ***
Resource    common.resource

Suite Setup    common.Record Execution Start Time

Test Template    Valid Login

*** Variables ***
${STANDARD USER}    standard_user
${PASSWORD}         secret_sauce
${INVENTORY URL}    https://www.saucedemo.com/inventory.html


*** Test Cases ***               USERNAME                   PASSWORD
Standard user login              ${STANDARD USER}           ${PASSWORD}
Problem user login               problem_user               ${PASSWORD}
Performance glitch user login    performance_glitch_user    ${PASSWORD}
Error user login                 error_user                 ${PASSWORD}
Visual user login                visual_user                ${PASSWORD}



*** Keywords ***
Valid Login
    [Arguments]    ${user}    ${password}
    [Setup]    common.Open Swag Labs
    common.Log in to Swag Labs    ${user}    ${password}
    Verify that the user did log in
    [Teardown]    Basic teardown

Verify that the user did log in
    Browser.Get Url    ==    ${INVENTORY URL}
    