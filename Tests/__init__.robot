*** Settings ***
Library        pabot.pabotlib

Suite Setup    Run Setup Only Once    Prepare shared variables

*** Keywords ***
Prepare shared variables
    [Documentation]    Prepares values that control the test flow
    pabot.pabotlib.Set Parallel Value For Key    valid_logins_status    ${True}
