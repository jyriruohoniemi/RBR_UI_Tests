*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library           String
Library           Collections
Test Setup      Open Browser and accept cookies
Test Teardown    Close Browser
Resource          ../../resources/Generic.robot
Documentation     This file contains all the keywords, tests and variables related to the operations of the main page

*** Variables ***
${email_field}          xpath=//input[@placeholder='Your email:']
@{checkbox}             //div[@class='rbr-lite-account-presignup false']//div[1]//div[1]  //div[@class='rbr-lite-account-presignup false']//div[2]//div[1]    //div[@class='rbr-lite-account-presignup false']//div[3]//div[1]
${submit_button}        xpath=//button[normalize-space()='Submit']
${podcast_banner}       xpath=//div[@id='crsd-rbracing-debrief-panel']//div[@class='editors-pick__wrapper']
${view_podcast}         xpath=//cosmos-text-3-22-1[contains(text(),'Talking Bull is the official podcast of the Oracle')]
${handle}               xpath=//div[@class='splitview skewed d-none d-lg-flex']
${social_media_container}   xpath=//div[@class='social-follow__buttons social-follow__buttons--3']
@{social_media_links}   xpath=(//div[@class='social-follow__button'])[1]  xpath=(//div[@class='social-follow__button'])[2]  xpath=(//div[@class='social-follow__button'])[3]
${sponsor_banner}   xpath=//cosmos-title-3-22-1[@class='sponsors__title']
${sponsor_items}    xpath=(//div[@class='sponsors__item'])[@class='sponsors__item']

*** Test Cases ***
Check the mailing list functionality
    [Tags]    Test
    Join the mailing list  ${EMAIL_TEST}

Check the podcast functionality
    [Tags]    Misc
    Check the podcast functionality

Check social media
    [Tags]      Secondary
    Verify social media links

Verify draggable handle works
    [Tags]    Misc
    Drag the handle

Test the partner links
    [Tags]    Primary
    Verify the functionality of the partner links

*** Keywords ***
Join the mailing list
    [Arguments]    ${email}
    Wait Until Element Is Located   ${email_field}
    Input Text   ${email_field}     ${email}
    Click Element           ${checkbox}[0]
    Click Element           ${checkbox}[1]
    Click Element           ${checkbox}[2]
    Wait Until Element Is Enabled   ${submit_button}
    Click Button    ${submit_button}
    Page Should Contain    Thanks for joining the Oracle Red Bull Racing charge.

Check the podcast functionality
    Wait Until Element Is Located    ${podcast_banner}
    Click Element        ${view_podcast}
    Page Should Contain    Talking Bull

Drag the handle
    Click Element At Coordinates    ${handle}   126   254
    Click Element At Coordinates    ${handle}   939   277

Verify social media links
    Wait Until Element Is Located   ${social_media_container}
    Click Element    ${social_media_links}[0]
    Switch Window    NEW
    Title Should Be    Oracle Red Bull Racing (@redbullracing) • Instagram photos and videos
    Switch Window   MAIN
    Click Element    ${social_media_links}[1]
    Switch Window    NEW
    Title Should Be    Oracle Red Bull Racing - Home | Facebook
    Switch Window   MAIN
    Click Element    ${social_media_links}[2]
    Switch Window    NEW
    Title Should Be    Oracle Red Bull Racing (@redbullracing) / Twitter


Verify the functionality of the partner links
    ${index}=   Set Variable    1
    ${contents}=    Get File    ../resources/sponsors.txt
    @{lines}=    Split to Lines   ${contents}
    Wait Until Element Is Located    ${sponsor_banner}
    ${sponsorcontent}=  Get WebElements    ${sponsor_items}
    Create List    ${sponsorcontent}
    FOR    ${sponsor}    IN    @{sponsorcontent}
        Click Element    ${sponsor}
        Switch Window    NEW
        ${title}=   Get Title
        Title Should Be          ${title}        ${lines}[${index}]
        ${index}=   Evaluate    ${index} + 1
        Close Window
        Switch Window   MAIN
    END