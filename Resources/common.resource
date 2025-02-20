***Settings***
Library    pabot.PabotLib
Library    BuiltIn

***Variables***
${EXECUTION_START_TIME}    ${None}

***Keywords***
Record Execution Start Time
    [Documentation]    Records the start time of the test execution. Runs only once.
    Run Setup Only Once    Set Start Time

Set Start Time
    [Documentation]    Sets the execution start time using the `Set Global Variable` keyword.
    ${start_time}    Get Time    epoch
    VAR    ${EXECUTION_START_TIME}    ${start_time}    scope=GLOBAL
    Log    Execution start time recorded: ${start_time}