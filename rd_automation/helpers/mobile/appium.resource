*** Settings ***
Resource    ${EXECDIR}/rd_automation/resources/mobile.resource


*** Keywords ***
Open Application RD
    [Arguments]
    ...    ${remote_url}=${REMOTE_URL}
    ...    ${automationName}=${AUTOMATION_NAME}
    ...    ${platformName}=${PLATFORM_NAME}
    ...    ${deviceName}=${DEVICE_NAME}
    ...    ${app}=${APP}

    Open Application
    ...    remote_url=${remote_url}
    ...    automationName=${automationName}
    ...    platformName=${platformName}
    ...    deviceName=${deviceName}
    ...    app=${app}
    ...    disableSSLVerification=${True}
    ...    acceptSslCerts=${True}
    ...    disableIdLocatorAutocompletion=${True}

Log RD
    [Arguments]    ${type_log}=success    ${message}=${EMPTY}

    IF    "${type_log}" == "fail"
        TRY
            ${url}    Get Activity
        EXCEPT
            ${url}    Set Variable    No browser is open
        END

        Fail    Log Error: ${message} | ${url}
    ELSE IF    "${type_log}" == "success"
        Log    Log Success: ${message}
    ELSE IF    "${type_log}" == "warning"
        Log    Log Warning: ${message}
    ELSE IF    "${type_log}" == "info"
        Log    Log Info: ${message}
    END

Wait And Click Element
    [Arguments]    ${element}    ${timeout}=${TIMEOUT}

    Wait Element    ${element}    ${timeout}

    TRY
        Click Element    ${element}
    EXCEPT
        Log RD    fail    Element ${element} Is Not Clicked
    END

Wait And Input Text
    [Arguments]    ${element}    ${text}    ${timeout}=${TIMEOUT}

    Log RD    info    Arguments: ${element} ${text}
    Wait Element    ${element}    ${timeout}

    TRY
        Input Text    ${element}    ${text}
    EXCEPT
        Log RD    fail    Element ${element} ${text} Is Not Inputed
    END

Wait Element
    [Arguments]    ${element}    ${timeout}=${TIMEOUT}

    Log RD    info    Arguments: ${element}

    TRY
        Wait Until Element Is Visible    ${element}    ${timeout}
    EXCEPT
        Log RD    fail    Element ${element} Is Not Visible
    END
