*** Settings ***
Library     SeleniumLibrary
Library     Collections
Library     String
# Strategy    |    Match based on    |    Example
# class    -    Element    class.    -    class:example
# data    -    Element data-* attr    -    data:id:my_id
# id    -    Element id.    -    -    id:example
# name    -    name attribute.    -    name:example
# identifier    Either id or name.    -    identifier:example
# tag    -    Tag name.    -    -    tag:div
# xpath    -    XPath expression.    -    xpath://div[@id="example"]
# css    -    CSS selector.    -    -    css:div#example
# dom    -    DOM expression.    -    dom:document.images[5]
# link    -    Exact text a link has.    -    link:The example
# jquery    -    jQuery expression. -    jquery:div.example


*** Keywords ***
User is on the Wellcome Screen
    Wait Until Element Is Visible    class:Welcome-Button
    Page should contain element    xpath://button[@data-testid='Welcome-CreateButton']
    Page should contain element    data:testid:Welcome-ImportButton
    Page should contain element    css:button[data-testid=Welcome-AboutButton]

User is on the Register Phase 1 Screen
    Wait Until Element Is Visible    data:testid:StepOne-Back
    Page should contain element    data:testid:StepOne-Generate
    Page should contain element    data:testid:SeedPanel
    Element Text Should Be    css:div.Perl_Active>div.Perl-Number    1

User is on the Register Phase 2 Screen
    Wait Until Element Is Visible    data:testid:StepTwo-Back
    Page should contain element    data:testid:StepTwo-Submit
    Page should contain element    data:testid:SeedPanel
    Element Text Should Be    css:div.Perl_Active>div.Perl-Number    2

User is on the Register Phase 3 Screen
    Wait Until Element Is Visible    data:testid:StepThree-Back
    Page should contain element    data:testid:StepThree-Confirm
    Page should contain element    data:testid:SeedPanel
    Element Text Should Be    css:div.Perl_Active>div.Perl-Number    3

User is on the Register Phase 4 Screen
    Wait Until Element Is Visible    data:testid:StepFour-Back
    Page should contain element    data:testid:StepFour-Submit
    Page should contain element    data:testid:StepFour-Password
    Page should contain element    data:testid:StepFour-Confirm
    Element Text Should Be    css:div.Perl_Active>div.Perl-Number    4

Read seed on the Register Phase 2 Screen
    @{seed}=    Create List
    @{elements}=    Get WebElements    css:div.SeedTag-Text
    FOR    ${element}    IN    @{elements}
        ${word}=    Get Text    ${element}
        Append To List    ${seed}    ${word}
    END
    RETURN    @{seed}

Enter seed phrase on the Register Phase 3 Screen
    [Arguments]    @{seed}
    FOR    ${word}    IN    @{seed}
        Click Element    xpath://div[text()='${word}']
    END
