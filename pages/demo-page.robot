*** Settings ***
Library     SeleniumLibrary


*** Keywords ***
User is on the Demo Page
    Wait Until Element Is Visible    data:testid:DemoHeader
