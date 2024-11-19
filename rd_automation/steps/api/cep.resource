*** Settings ***
Resource    ${EXECDIR}/rd_automation/steps/api/template.resource
Resource    ${EXECDIR}/rd_automation/helpers/api/cep/get_expected_zipcode.resource


*** Keywords ***
the response should contain cep information
    ${expected_zipcode}    Get Expected ZIPCODE
    VAR    ${zipcode_returned}    ${RESPONSE.json()}

    Dictionaries Should Be Equal
    ...    dict1=${expected_zipcode}
    ...    dict2=${zipcode_returned}
