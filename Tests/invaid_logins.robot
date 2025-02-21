*** Settings ***
Resource    common.resource

Suite Setup    common.Record Execution Start Time

Test Template    Invalid Login

*** Test Cases ***                  USERNAME           PASSWORD
Invalid user name                   some_user          secret_sauce
Invalid password                    standard_user      some_password
Invalid user name and password      some_user          some_password
Locked out user                     locked_out_user    secret_sauce
Empty user                          ${EMPTY}           secret_sauce
Empty password                      standard_user      ${EMPTY}
Empty user and password             ${EMPTY}           ${EMPTY}



*** Keywords ***
Invalid Login
    [Arguments]    ${user}    ${password}
    [Setup]    common.Open Swag Labs
    common.Log in to Swag Labs    ${user}    ${password}
    Verify that the user didn't log in
    [Teardown]    Basic teardown

Verify that the user didn't log in
    Browser.Get Element States    id=${login_page.login_button_id}    *=    visible
    