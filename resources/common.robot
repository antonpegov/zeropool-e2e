*** Settings ***
Library     SeleniumLibrary
Library     LambdaTestStatus.py


*** Variables ***
${TIMEOUT}          3000
# ${DEBUG_BROWSER}    headlesschrome
${DEBUG_BROWSER}    chrome
${USER}             %{LT_USERNAME=}
${KEY}              %{LT_ACCESS_KEY=}
${TEST_URL}         https://lambdatest.github.io/sample-todo-app/


*** Keywords ***
Open test browser
    [Timeout]    ${TIMEOUT}
    [Arguments]    ${url}=${TEST_URL}
    Log To Console    message=User: ${USER}
    Log To Console    message=Debug: ${DEBUG}
    Log To Console    message=Capabilities: ${CAPABILITIES}

    IF    ${DEBUG}
        Log To Console    message=Debug Browser: ${DEBUG_BROWSER}
        Open Browser    ${url}    ${DEBUG_BROWSER}
    ELSE
        Log To Console    message=Test Browser: ${robotBrowser}
        Log To Console    message=Remote URL: ${REMOTE_URL}
        Open Browser
        ...    url=${url}
        ...    browser=${robotBrowser}
        ...    remote_url=${REMOTE_URL}
        ...    desired_capabilities=${CAPABILITIES}
    END

Close test browser
    IF    ${DEBUG}
        Close browser
    ELSE
        Report Lambdatest Status    ${TEST_NAME}    ${TEST_STATUS}
        Close all browsers
    END

# Init Test Sute Variables
    # ${VARIABLES}=    Get Variables    no_decoration=Yes

    # Set Suite Variable    ${VARIABLES}
    # Set Suite Variable    ${BROWSER}
    # Set Suite Variable    ${DEBUG}

    # ${browserName}=    Get From Dictionary    ${variables}    'browserName'    ''
    # ${platform}=    Get From Dictionary    ${variables}    'platform'    ''
    # ${version}=    Get From Dictionary    ${variables}    'version'    ''
    # ${visual}=    Get From Dictionary    ${variables}    'visual'    ''
    # ${network}=    Get From Dictionary    ${variables}    'network'    ''
    # ${console}=    Get From Dictionary    ${variables}    'console'    ''

Init Test Sute Variables
    ${VARIABLES}=    Get Variables    no_decoration=Yes

    ${browserName}=    Evaluate    $VARIABLES.get('browserName', '')
    ${platform}=    Evaluate    $VARIABLES.get('platform', '')
    ${version}=    Evaluate    $VARIABLES.get('version', '')
    ${visual}=    Evaluate    $VARIABLES.get('visual', '')
    ${network}=    Evaluate    $VARIABLES.get('network', '')
    ${console}=    Evaluate    $VARIABLES.get('console', '')
    ${robotBrowser}=    Evaluate    $VARIABLES.get('ROBOT_BROWSER', '')

    @{_tmp}=    Create List
    ...    browserName: ${browserName},
    ...    platform: ${platform},
    ...    version: ${version},
    ...    network: ${network},
    ...    visual: ${visual},
    ...    console: ${console},
    ...    name: Zeropool e2e on LambdaTest

    ${CAPABILITIES}=    Set Variable    ${EMPTY.join(${_tmp})}
    ${REMOTE_URL}=    Set Variable    https://${USER}:${KEY}@hub.lambdatest.com/wd/hub
    ${DEBUG}=    Evaluate    '${USER}' == ''

    Set Suite Variable    ${DEBUG}
    Set Suite Variable    ${REMOTE_URL}
    Set Suite Variable    ${CAPABILITIES}
    Set Suite Variable    ${robotBrowser}
