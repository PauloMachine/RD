*** Settings ***
Library     Collections
Library     FakerLibrary    locale=pt_BR
Library     OperatingSystem
Library     SeleniumLibrary
Library     String


*** Variables ***
# Application
${CAPTURE_EVIDENCE}     ${EMPTY}
${HEADLESS}             ${EMPTY}
${TIMEOUT}              ${EMPTY}
${SPEED}                ${EMPTY}

# URL
${ORANGE_HRM_URL}       ${EMPTY}
