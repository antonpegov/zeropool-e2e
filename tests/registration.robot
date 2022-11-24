*** Settings ***
Resource            ../resources/common.robot
Resource            ../pages/welcome-page.robot
Resource            ../pages/demo-page.robot

Suite Setup         Init Test Sute Variables
Test Setup          common.Open test browser
Test Teardown       common.Close test browser


*** Test Cases ***
Register new zeropool account
    [Timeout]    ${TIMEOUT}
    User is on the Wellcome Screen
    Click button    data:testid:Welcome-CreateButton
    User is on the Register Phase 1 Screen
    Click Button    data:testid:StepOne-Generate
    User is on the Register Phase 2 Screen
    @{seed}=    Read seed on the Register Phase 2 Screen
    Click Button    data:testid:StepTwo-Submit
    User is on the Register Phase 3 Screen
    Enter seed phrase on the Register Phase 3 Screen    @{seed}
    Click Button    data:testid:StepThree-Confirm
    User is on the Register Phase 4 Screen
    Input Password    data:testid:StepFour-Password    1234pass
    Input Password    data:testid:StepFour-Confirm    1234pass
    Click Button    data:testid:StepFour-Submit
    User is on the Demo Page
    ${private_address}=    Get Text    css:span#Private
    Should Not Be Empty    item=${private_address}
