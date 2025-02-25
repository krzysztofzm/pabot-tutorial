***Settings***
Library      pabot.PabotLib
Library      Browser

Variables    login_page.yaml

***Variables***
${EXECUTION_START_TIME}    ${None}
${BROWSER}    chromium

***Keywords***
Record Execution Start Time
    [Documentation]    Records the start time of the test execution. Runs only once.
    Run Setup Only Once    Set Start Time

Set Start Time
    [Documentation]    Sets the execution start time using the `Set Global Variable` keyword.
    ${start_time}    Get Time
    VAR    ${EXECUTION_START_TIME}    ${start_time}    scope=GLOBAL
    Log    Execution start time recorded: ${start_time}

Open Swag Labs
    [Documentation]    opens the .
    [Tags]    browserlibrary
    [Arguments]
    ...    ${timeout}=0:00:30
    ...    ${browser}=${BROWSER}
    ...    ${headless}=${False}
    ...    ${slowMo}=0:00:01
    ...    ${window height}=750
    ...    ${window width}=1200
    ...    ${domain suffix}=${EMPTY}
    ...    ${executable_path}=${None}
    Browser.New Browser
    ...    browser=${browser}
    ...    headless=${headless}
    ...    slowMo=${slowMo}
    ...    executablePath=${executable_path}
    Browser.Set browser timeout    ${timeout}
    VAR    ${URL}=    https://www.saucedemo.com/
    Browser.New context
    ...    viewport={'width': ${window width}, 'height': ${window height}}
    Browser.New page
    ...    url=${URL}


Log in to Swag Labs
    [Documentation]    Perform login with given user's login and password.
    [Arguments]    ${user}    ${password}
    Browser.Fill text    id=${login_page.login_field_id}    ${user}
    Browser.Fill secret    id=${login_page.password_field_id}    $password
    # Browser.Get text    id=${login_page.login_field_id}    equal    ${user}
    Browser.Click    id=${login_page.login_button_id}

Basic teardown
    [Documentation]    Close browser upon end of test during teardown.
    Browser.Close Browser    ALL
