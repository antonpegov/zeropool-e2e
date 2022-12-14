*** Settings ***
Resource            ../resources/common.robot

# Suite Setup    Init Test Sute Variables
Suite Setup         common.Init Test Sute Variables
Test Setup          common.Open test browser
Test Teardown       common.Close test browser


*** Test Cases ***
Example of connecting to Lambdatest via Robot Framework
    [Timeout]    ${TIMEOUT}
    Page should contain element    name:li1
    Page should contain element    name:li2

    Click button    name:li1
    Click button    name:li2

    Input text    id:sampletodotext    Yey Let's add it to list
    Click button    id:addbutton
    ${response}    Get Text    xpath=/html/body/div/div/div/ul/li[6]/span
    Should Be Equal As Strings    ${response}    Yey Let's add it to list
