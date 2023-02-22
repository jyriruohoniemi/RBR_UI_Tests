*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library           String
Library           Collections
Test Setup      Open Browser and accept cookies
Test Teardown    Close Browser
Resource        ../resources/Generic.robot
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
${sponsor_banner}   xpath=(//cosmos-title-4-4-0[@class='sponsors__title'])[1]
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

Test the partner links
    [Tags]    Primary
    Verify the functionality of the partner links

*** Keywords ***
Join the mailing list
    [Arguments]    ${email}
    Wait Until Element Is Located   ${email_field}
    Input Text   ${email_field}     ${email}
    Wait Until Completion    Click Element           ${checkbox}[0]
    Wait Until Completion    Click Element           ${checkbox}[1]
    Wait Until Completion    Click Element           ${checkbox}[2]
    Wait Until Element Is Enabled   ${submit_button}
    Wait Until Completion    Click Button    ${submit_button}
    Wait Until Completion       Page Should Contain    Thanks for joining the Oracle Red Bull Racing charge.

Check the podcast functionality
    Wait Until Element Is Located    ${podcast_banner}
    Wait Until Completion    Click Element        ${view_podcast}
    Wait Until Completion      Page Should Contain    Talking Bull

Verify social media links
    Wait Until Element Is Located   ${social_media_container}
    Wait Until Completion    Click Element    ${social_media_links}[0]
    Switch Window    NEW
    Wait Until Completion      Title Should Be    Page not found • Instagram    #This link might be broken
    Switch Window   MAIN
    Wait Until Completion    Click Element    ${social_media_links}[1]
    Switch Window    NEW
    Wait Until Completion       Title Should Be    Oracle Red Bull Racing - Home | Facebook
    Switch Window   MAIN
    Wait Until Completion    Click Element    ${social_media_links}[2]
    Switch Window    NEW
    Wait Until Completion       Title Should Be    Oracle Red Bull Racing (@redbullracing) / Twitter


Verify the functionality of the partner links
    ${index}=   Set Variable    0
    ${contents}=    Get File    ${CURDIR}${/}..\\resources\\sponsors.txt
    @{lines}=    Split to Lines   ${contents}
    Wait Until Element Is Located    ${sponsor_banner}
    ${sponsorcontent}=  Get WebElements    ${sponsor_items}
    Create List    ${sponsorcontent}
    FOR    ${sponsor}    IN    @{sponsorcontent}
        Wait Until Completion    Click Element    ${sponsor}
        Switch Window    NEW
        ${title}=   Get Title
        Title Should Be          ${title}        ${lines}[${index}]
        ${index}=   Evaluate    ${index} + 1
        Close Window
        Switch Window   MAIN
    END