*** Settings ***
Resource    ${EXECDIR}/rd_automation/resources/api.resource


*** Keywords ***
Get Expected ZIPCODE
    ${json}    Get File    path=${EXECDIR}/rd_automation/helpers/api/cep/cep.json
    ${json}    Evaluate    json.loads('''${json}''')    json
    ${zipcode}    Convert To Dictionary    item=${json}
    RETURN    ${ZIPCODE}
