*** Comments ***
This test suite validates the functionality of the ViaCEP API, specifically for querying CEP (postal code)
information via a GET request. The test ensures that the API responds correctly when a valid CEP is queried,
and that the returned data contains the expected information.


*** Settings ***
Resource    ${EXECDIR}/rd_automation/steps/api/cep.resource


*** Test Cases ***
GET CEP
    [Documentation]
    ...    This test case validates the behavior of the ViaCEP API
    ...    when a GET request is sent to the CEP query endpoint
    [Tags]    tc0001    get    cep
    Given I am connected to the "VIACEP" API
    When I send a "GET" request to the "/ws/01153000/json/" endpoint
    And the API should respond with a status code of "200"
    Then the response should contain cep information
