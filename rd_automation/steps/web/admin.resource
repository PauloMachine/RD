*** Settings ***
Resource    ${EXECDIR}/rd_automation/helpers/web/selenium.resource
Resource    ${EXECDIR}/rd_automation/elements/web/menu.resource
Resource    ${EXECDIR}/rd_automation/elements/web/navbar.resource
Resource    ${EXECDIR}/rd_automation/elements/web/admin.resource


*** Variables ***
${ADMIN_USER}       ${EMPTY}


*** Keywords ***
I am on the "Admin" page
    Wait And Click Element    element=${menu.li_admin}
    Wait Element    element=${navbar.span_title_admin_list}

I click on the "Add" button
    Wait And Click Element    element=${admin.button_add}

I add a new "Admin User"
    Run Keyword    Create Admin User Data

    Wait And Click Element    element=${admin.select_user_role}
    ${user_role}    Replace String RD
    ...    string=${admin.select_option}
    ...    search_for=option
    ...    replace_with=${ADMIN_USER.USER_ROLE}
    Wait And Click Element    element=${user_role}

    Wait And Click Element    element=${admin.input_employee_name}
    Wait And Input Text    element=${admin.input_employee_name}    text=${ADMIN_USER.EMPLOYEE_NAME}
    Wait And Press Keys    key=DOWN
    Wait And Press Keys    key=ENTER

    Wait And Click Element    element=${admin.select_status}
    Wait And Press Keys    key=DOWN
    Wait And Press Keys    key=ENTER

    Wait And Input Text    element=${admin.input_username}    text=${ADMIN_USER.USERNAME}
    Wait And Input Text    element=${admin.input_password}    text=${ADMIN_USER.PASSWORD}
    Wait And Input Text    element=${admin.input_confirm_password}    text=${ADMIN_USER.PASSWORD}

    Capture Page    admin    user_form
    Wait And Click Element    element=${admin.button_save}

the system should display the new "Admin User"
    Wait Element    element=${admin.toast_success}
    Run Keyword    the system should display the "Admin User"

I search for "Admin User"
    Wait And Input Text    element=${admin.input_search_username}    text=${ADMIN_USER.USERNAME}
    Wait And Click Element    element=${admin.button_search}

the system should display the "Admin User"
    ${username}    Replace String RD
    ...    string=${admin.div_list_username}
    ...    search_for=username
    ...    replace_with=${ADMIN_USER.USERNAME}
    Wait Element    element=${username}

    Capture Page    admin    user

I click on delete for the "Admin User"
    ${button_delete}    Replace String RD
    ...    string=${admin.button_delete_admin_user}
    ...    search_for=username
    ...    replace_with=${ADMIN_USER.USERNAME}

    Wait And Click Element    element=${button_delete}
    Wait And Click Element    element=${admin.button_yes_delete}
    Wait Element    element=${admin.toast_success}

the system should not display the "Admin User"
    TRY
        Run Keyword    the system should display the "Admin User"
        Log RD    fail    Admin User not deleted
    EXCEPT
        Log RD    info    Admin User deleted
    END

Create Admin User Data
    ${last_name}    FakerLibrary.Last Name
    ${password}    FakerLibrary.Sha 1
    ${employee_name}    Wait And Get Text    element=${navbar.p_username}

    ${admin_user}    Create Dictionary
    ...    USER_ROLE=Admin
    ...    EMPLOYEE_NAME=${employee_name}
    ...    STATUS=Enabled
    ...    USERNAME=Santiago ${last_name}
    ...    PASSWORD=${password}

    VAR    ${ADMIN_USER}    ${admin_user}    scope=TEST
