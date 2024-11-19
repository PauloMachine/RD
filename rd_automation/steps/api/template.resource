*** Settings ***
Resource    ${EXECDIR}/rd_automation/resources/api.resource


*** Variables ***
${API}              ${EMPTY}
${JSON}             ${EMPTY}
${RESPONSE}         ${EMPTY}
${STATUS_CODE}      ${EMPTY}


*** Keywords ***
I am connected to the "${api}" API
    IF    "${api}" == "VIACEP"
        VAR    ${base_url}    ${VIACEP_URL}    scope=TEST
    END

    Create Session    alias=${api}    url=${base_url}    verify=${False}
    VAR    ${API}    ${api}    scope=TEST

I send a "${method}" request to the "${endpoint}" endpoint
    IF    "${method}" == "GET"
        ${response}    GET On Session
        ...    alias=${API}
        ...    url=${endpoint}
        ...    expected_status=any
    ELSE IF    "${method}" == "POST"
        ${response}    POST On Session
        ...    alias=${API}
        ...    url=${endpoint}
        ...    json=${JSON}
        ...    expected_status=any
    END

    VAR    ${RESPONSE}    ${response}    scope=TEST
    VAR    ${ENDPOINT}    ${endpoint}    scope=TEST
    Log    ${RESPONSE.json()}

the API should respond with a status code of "${status_code}"
    TRY
        Should Be Equal As Strings    first=${RESPONSE.status_code}    second=${status_code}
    EXCEPT
        Fail    Status expected: ${status_code} | Status returned: ${RESPONSE.status_code}
    END
