*** Settings ***
Resource            ${EXECDIR}/rd_automation/resources/mobile.resource
Resource            ${EXECDIR}/rd_automation/helpers/mobile/appium.resource

Suite Setup         Setup RD Automation
Suite Teardown      Teardown RD Automation


*** Keywords ***
Setup RD Automation
    Set Log Level    ${LOG_LEVEL}
    Set Appium Timeout    ${TIMEOUT}
    Open Application RD

Teardown RD Automation
    Close Application
