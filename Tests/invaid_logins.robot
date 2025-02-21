*** Settings ***
Resource     common.resource
Variables    users.yaml

Suite Setup    common.Record Execution Start Time

Test Template    Invalid Login

*** Test Cases ***                  USERNAME              PASSWORD
Invalid user name                   some_user             ${password.valid}
Invalid password                    ${user.standard}      ${password.invalid}
Invalid user name and password      some_user             ${password.invalid}
Locked out user                     ${user.locked_out}    ${password.valid}
Empty user                          ${EMPTY}              ${password.valid}
Empty password                      ${user.standard}      ${EMPTY}
Empty user and password             ${EMPTY}              ${EMPTY}



*** Keywords ***
Invalid Login
    [Arguments]    ${user}    ${password}
    [Setup]    common.Open Swag Labs
    common.Log in to Swag Labs    ${user}    ${password}
    Verify that the user didn't log in
    [Teardown]    Basic teardown

Verify that the user didn't log in
    Browser.Get Element States    id=${login_page.login_button_id}    *=    visible
    