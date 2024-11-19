*** Comments ***
This test suite focuses on verifying the functionality related to the creation, search, and deletion of admin users
within the system. The tests are designed to validate the core actions that an admin user can perform in the
orange_hrm system, ensuring that the functionalities work as expected.


*** Settings ***
Resource            ${EXECDIR}/rd_automation/steps/web/admin.resource
Resource            ${EXECDIR}/rd_automation/helpers/web/login.resource
Resource            ${EXECDIR}/rd_automation/helpers/web/logout.resource
Resource            ${EXECDIR}/rd_automation/helpers/web/admin/create_admin_user.resource
Resource            ${EXECDIR}/rd_automation/helpers/web/admin/search_admin_user.resource

Suite Setup         Login RD
...                     system=orange_hrm
...                     alias=admin
...                     username=Admin
...                     password=admin123
# Test Teardown    TODO: Delete Admin Users (API)
Suite Teardown      Logout RD

Test Tags           orange_hrm_live    admin


*** Test Cases ***
Add admin user
    [Documentation]
    ...    This test case verifies that a new admin user
    ...    can be created successfully in the system
    [Tags]    tc0001
    Given I am on the "Admin" page
    When I click on the "Add" button
    And I add a new "Admin User"
    Then the system should display the new "Admin User"

Search admin user
    [Documentation]
    ...    This test case verifies that an admin user
    ...    can be searched and displayed in the system
    [Tags]    tc0002
    [Setup]    Create Admin User
    Given I search for "Admin User"
    Then the system should display the "Admin User"

Delete admin user
    [Documentation]
    ...    This test case ensures that an admin user
    ...    can be deleted successfully
    [Tags]    tc0003
    [Setup]    Run Keywords
    ...    Create Admin User
    ...    AND    Search Admin User
    Given I click on delete for the "Admin User"
    Then the system should not display the "Admin User"
