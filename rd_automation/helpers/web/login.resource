*** Settings ***
Resource    ${EXECDIR}/rd_automation/helpers/web/selenium.resource
Resource    ${EXECDIR}/rd_automation/elements/web/login.resource
Resource    ${EXECDIR}/rd_automation/elements/web/navbar.resource


*** Variables ***
${SESSION}      ${False}
${MAX_RETRY}    3


*** Keywords ***
Login RD
    [Arguments]
    ...    ${system}
    ...    ${alias}
    ...    ${username}
    ...    ${password}
    ...    ${call_method}=${None}
    ...    ${prefs}=${None}

    IF    "${system}" == "orange_hrm"
        ${url}    Set Variable    ${ORANGE_HRM_URL}
    END

    ${alias}    Catenate    SEPARATOR=_    ${system}    ${alias}

    FOR    ${retry}    IN RANGE    0    ${MAX_RETRY}
        TRY
            IF    ${SESSION} == ${False}
                TRY
                    Create Webdriver RD
                    ...    url=${url}
                    ...    alias=${alias}
                    ...    call_method=${call_method}
                    ...    prefs=${prefs}
                EXCEPT
                    Log RD    fail    Create Webdriver RD
                END

                VAR    ${ALIAS}    ${alias}    scope=SUITE
                VAR    ${SESSION}    ${True}    scope=SUITE

                Wait And Input Text    element=${login.input_username}    text=${username}
                Wait And Input Text    element=${login.input_password}    text=${password}
                Wait And Click Element    element=${login.button_login}
                Wait Element    element=${navbar.span_username}

                Log RD    success    Access ${system} with new session (${alias})
            ELSE
                Switch Browser And Go To    index_or_alias=${ALIAS}    url=${url}
                Log RD    success    Access ${system} with exist session (${alias})
            END

            BREAK
        EXCEPT
            Close Browser
            VAR    ${SESSION}    ${False}    scope=SUITE
            Log RD    warning    Access ${system} with retry (${retry})
        END
    END

    IF    ${SESSION} == ${False}    Log RD    fail    Access ${system} failed
