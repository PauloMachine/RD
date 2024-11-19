*** Settings ***
Resource            ${EXECDIR}/rd_automation/resources/web.resource

Suite Setup         Setup RD Automation
Suite Teardown      Teardown RD Automation


*** Keywords ***
Setup RD Automation
    Set Log Level    ${LOG_LEVEL}
    Set Selenium Timeout    ${TIMEOUT}
    Set Selenium Speed    ${SPEED}
    Register Keyword To Run On Failure    Capture Page

Teardown RD Automation
    Close All Browsers
