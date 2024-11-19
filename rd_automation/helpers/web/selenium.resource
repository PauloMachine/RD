*** Settings ***
Resource    ${EXECDIR}/rd_automation/resources/web.resource


*** Keywords ***
Capture Page
    [Arguments]    ${directory}=error    ${name}=error

    IF    ${CAPTURE_EVIDENCE} == ${True}
        TRY
            ${window_status}    Get Window Titles

            IF    ${window_status} != ['undefined']
                ${seg}    Get Time    epoch

                IF    "${directory}" != "error"
                    ${directory}    Set Variable    success/${directory}
                ELSE
                    Log Variables
                END

                Capture Page Screenshot    ${OUTPUT_DIR}/${directory}/${name}_${seg}.png
            ELSE
                Log RD    warning    No browser is open
            END
        EXCEPT
            Log RD    warning    No browser is open
        END
    END

Create Webdriver RD
    [Arguments]
    ...    ${url}
    ...    ${alias}
    ...    ${redirect_url}=${None}
    ...    ${call_method}=${None}
    ...    ${prefs}=${None}

    ${fake_audio}    Set Variable    ${EXECDIR}${/}RD_automation${/}steps${/}utils${/}audio.wav
    ${fake_video}    Set Variable    ${EXECDIR}${/}RD_automation${/}steps${/}utils${/}webcam.mjpeg
    ${default_directory}    Set Variable    ${EXECDIR}${/}RD_automation${/}results

    ${chrome_options}    Evaluate
    ...    sys.modules['selenium.webdriver'].ChromeOptions()
    ...    sys, selenium.webdriver

    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage

    ${language}    Set Variable    pt
    Call Method    ${chrome_options}    add_argument    --lang\=${language}

    ${timezone}    Set Variable    America/Sao_Paulo
    Call Method    ${chrome_options}    add_argument    --timezone\=${timezone}
    Set Environment Variable    TZ    ${timezone}

    IF    "${call_method}" == "${None}"
        Call Method    ${chrome_options}    add_argument    --use-fake-ui-for-media-stream
        Call Method    ${chrome_options}    add_argument    --use-fake-device-for-media-stream
        Call Method    ${chrome_options}    add_argument    --use-file-for-fake-audio-capture\=${fake_audio}
        Call Method    ${chrome_options}    add_argument    --use-file-for-fake-video-capture\=${fake_video}
    ELSE
        FOR    ${cd}    IN    @${call_method}
            Call Method    ${chrome_options}    add_argument    ${cd}
        END
    END

    IF    ${HEADLESS} == ${True}
        Call Method    ${chrome_options}    add_argument    --headless\=new
    END

    ${prefs_options}    Create Dictionary

    IF    "${prefs}" == "download_default_directory"
        Set To Dictionary    ${prefs_options}
        ...    download.default_directory=${default_directory}
        ...    profile.default_content_setting_values.automatic_downloads=${1}
    END

    IF    "${prefs}" == "media_permission_denied"
        Set To Dictionary    ${prefs_options}
        ...    profile.default_content_setting_values.media_stream_mic=${2}
        ...    profile.default_content_setting_values.media_stream_camera=${2}
        ...    profile.default_content_setting_values.geolocation=${2}
        ...    profile.default_content_setting_values.notifications=${2}
    END

    IF    "${call_method}" != "no_call_method_special"
        Set To Dictionary    ${prefs_options}
        ...    profile.default_content_setting_values.media_stream_mic=${1}
        ...    profile.default_content_setting_values.media_stream_camera=${1}
        ...    profile.default_content_setting_values.geolocation=${1}
        ...    profile.default_content_setting_values.notifications=${1}
    END

    Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs_options}
    Create Webdriver    driver_name=Chrome    alias=${alias}    options=${chrome_options}
    Switch Browser And Go To    index_or_alias=${alias}    url=${url}

    IF    ${HEADLESS} == ${True}
        Set Window Size    width=1920    height=3000
    ELSE
        Maximize Browser Window
    END

    IF    "${redirect_url}" != "${None}"    Go To    ${redirect_url}

Dictionary Properties
    [Arguments]    ${dictionary}

    ${dictionary_length}    Get Length    ${dictionary}
    RETURN    ${dictionary}    ${dictionary_length}

Dictionaries Should Contain Dictionary
    [Arguments]    ${dictionaires}    ${dictionary}

    Log    ${dictionaires}
    Log    ${dictionary}

    ${match}    Set Variable    ${True}
    ${dictionaires_length}    Get Length    ${dictionaires}

    FOR    ${i}    IN RANGE    0    ${dictionaires_length}
        TRY
            Dictionaries Should Be Equal    dict1=${dictionary}    dict2=${dictionaires}[${i}]
            ${match}    Set Variable    ${True}
            BREAK
        EXCEPT
            Log    not match dictionary
            ${match}    Set Variable    ${False}
        END
    END

    IF    ${match} == ${False}
        Log RD    fail    not found dictionary ${dictionary}
    END

Log RD
    [Arguments]    ${type_log}=success    ${message}=${EMPTY}

    IF    "${type_log}" == "fail"
        TRY
            ${url}    Get Location
        EXCEPT
            ${url}    Set Variable    No browser is open
        END

        Fail    Log Error: ${message} | ${url}
    ELSE IF    "${type_log}" == "success"
        Log    Log Success: ${message}
    ELSE IF    "${type_log}" == "warning"
        Log    Log Warning: ${message}
    ELSE IF    "${type_log}" == "info"
        Log    Log Info: ${message}
    END

Replace String RD
    [Arguments]    ${string}    ${search_for}    ${replace_with}

    TRY
        ${replace_with}    Convert To String    ${replace_with}
        ${replace_string}    Replace String
        ...    ${string}
        ...    ${search_for}
        ...    ${replace_with}

        RETURN    ${replace_string}
    EXCEPT
        Log RD    fail    Problem with Replace String RD ${string} ${search_for} ${replace_with}
    END

Replace String With Dictionary
    [Arguments]    ${string}    ${dictionary}

    ${result}    Set Variable    ${string}
    FOR    ${key}    ${value}    IN    &{dictionary}
        ${result}    Replace String RD    ${result}    ${key}    ${value}
    END

    RETURN    ${result}

Switch Browser And Go To
    [Arguments]    ${index_or_alias}    ${url}

    Log RD    info    Arguments: ${index_or_alias} ${url}
    Switch Browser    index_or_alias=${index_or_alias}
    Go To    url=${url}

Switch Browser And Window
    [Arguments]    ${index_or_alias}    ${window_locator}    ${timeout}=${TIMEOUT}

    Log RD    info    Arguments: ${index_or_alias} ${window_locator}
    Switch Browser    index_or_alias=${index_or_alias}
    Switch Window    locator=${window_locator}    timeout=${timeout}

Wait Element
    [Arguments]    ${element}    ${timeout}=${TIMEOUT}

    Log RD    info    Arguments: ${element}

    TRY
        Wait Until Element Is Visible    ${element}    ${timeout}
    EXCEPT
        Log RD    fail    Element ${element} Is Not Visible
    END

Wait And Click Element
    [Arguments]    ${element}    ${timeout}=${TIMEOUT}

    Wait Element    ${element}    ${timeout}

    TRY
        Click Element    ${element}
    EXCEPT
        Log RD    fail    Element ${element} Is Not Clicked
    END

Wait And Double Click Element
    [Arguments]    ${element}    ${timeout}=${TIMEOUT}

    Wait Element    ${element}    ${timeout}

    TRY
        Double Click Element    ${element}
    EXCEPT
        Log RD    fail    Element ${element} Is Not Clicked
    END

Wait And Input Text
    [Arguments]    ${element}    ${text}    ${timeout}=${TIMEOUT}

    Log RD    info    Arguments: ${element} ${text}
    Wait Element    ${element}    ${timeout}

    TRY
        Input Text    ${element}    ${text}
    EXCEPT
        Log RD    fail    Element ${element} ${text} Is Not Inputed
    END

Wait And Get Text
    [Arguments]    ${element}    ${timeout}=${TIMEOUT}

    Wait Element    ${element}    ${timeout}

    TRY
        ${text}    Get Text    ${element}
        RETURN    ${text}
    EXCEPT
        Log RD    fail    Element ${element} Is Not Searchable Text
    END

Wait Status And Scroll Element
    [Arguments]    ${element}    ${repeat}=100

    FOR    ${count}    IN RANGE    1    ${repeat}
        ${status}    Run Keyword And Return Status
        ...    Scroll Element Into View
        ...    ${element}

        IF    ${status} == ${True}    BREAK
        Execute JavaScript    window.scrollTo(0, ${count}00)
    END

Wait And Press Keys
    [Arguments]    ${key}    ${repeat}=1

    Sleep    5s
    FOR    ${count}    IN RANGE    0    ${repeat}
        Press Keys    none    ${key}
    END
