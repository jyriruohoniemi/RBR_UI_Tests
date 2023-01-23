*** Settings ***
Library           SeleniumLibrary
Library            pabot.pabotlib
Resource        ../resources/Generic.robot
Test Setup    Open Browser and accept cookies
Test Teardown    Close Browser
Documentation    This file contains the tests related to operations of the paddock page

*** Variables ***
${paddock_logo}     https://red-bull-racing.herokuapp.com/assets/paddock_logo-c360975fa06f95588e6c362794dd8919.svg
${redbull_social}   xpath=(//div[@class='rbr-paddock-login-social-provider is-redbull'])[1]
${login}    css:.button.button--clickable.button--dark.button--large
${navbar}   xpath=//section[@id='rbr-paddock-navigation']//nav
${navbar_activities}    xpath=(//a[contains(text(),'Activities')])[1]
${navbar_rewards}   xpath=(//a[contains(text(),'Rewards')])[1]
${navbar_content}   xpath=(//a[contains(text(),'Content')])[1]
${navbar_community}     xpath=(//a[contains(text(),'Community')])[1]
${navbar_profile}   xpath=(//a[contains(text(),'Profile')])[1]
${marquee}  xpath=(//div[@class='marquee'])[1]
${stream}   xpath=(//div[@id='rbr-paddock-homerun-stream'])[1]
${fan_story}    xpath=(//div[@class='rbr-paddock-fan-story false can-click'])[2]
${fan_image}    xpath=(//img[@alt='Story asset image'])[1]
${filter_story}     xpath=(//div[@class='rbr-paddock-filter-option false'][normalize-space()='Stories'])[1]
${toggle_filter}    xpath=(//div[@class='rbr-paddock-filter-option is-active'][normalize-space()='Stories'])[1]
${filter_images}    xpath=(//div[@class='rbr-paddock-filter-option false'][normalize-space()='Images'])[1]
${toggle_filter_images}     xpath=(//div[@class='rbr-paddock-filter-option is-active'][normalize-space()='Images'])[1]
@{profile_input_field}  xpath=(//input[contains(@type,'text')])[4]  xpath=(//input[contains(@type,'text')])[5]  xpath=(//input[contains(@type,'text')])[6]  xpath=(//input[contains(@type,'text')])[7]  xpath=(//input[contains(@type,'text')])[8]
${gender_dropdown}  xpath=(//div)[119]
@{marketing_toggle}     xpath=(//div[contains(@class,'rbr-paddock-profile-toggle-ui')])[1]   xpath=(//div[contains(@class,'rbr-paddock-profile-toggle-ui')])[2]     xpath=(//div[contains(@class,'rbr-paddock-profile-toggle-ui')])[3]
${garage}   xpath=(//p[normalize-space()='Garage'])[1]
${garage_input}     css:body > main:nth-child(1) > div:nth-child(1) > div:nth-child(5) > div:nth-child(1) > div:nth-child(1) > section:nth-child(2) > div:nth-child(3) > div:nth-child(1) > div:nth-child(3) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > div:nth-child(1) > input:nth-child(2)
${dropdown_showing}     css:.rbr-cosmos-select-dropdown.is-showing

*** Test Cases ***
Check that paddock page works
    [Tags]    Critical
    Navigate to paddock page
    Login to the paddock page   ${EMAIL}    ${PASSWORD}

Check that paddock navbar functions
    [Tags]    Primary
    Navigate To Paddock Page
    Check navbar functionality

Check the fan stories functionality
    [Tags]    Secondary
    Navigate To Paddock Page
    Check fan stories

Check the profile functionality
    [Tags]    Primary
    Navigate To Paddock Page
    Check profile page

Check the garage functionality
    [Tags]    Secondary
    Navigate To Paddock Page
    Check garage page

*** Keywords ***
Login to the paddock page
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Located    ${login}
    Click Element    ${login}
    Switch Window   NEW
    Wait Until Element Is Located    ${redbull_social}
    Click Element   ${redbull_social}
    Wait Until Element Is Located    id=email
    Input Text    id=email   ${username}
    Wait Until Element Is Enabled   css:button[type='submit']
    Click Element   css:button[type='submit']
    Wait Until Element Is Enabled   id=pw
    Input Password        id=pw   ${password}
    Wait Until Element Is Enabled   css:button[type='submit']
    Click Button    css:button[type='submit']
    Wait Until Element Is Located    ${navbar}


Check navbar functionality
    Login To The Paddock Page   ${EMAIL}    ${PASSWORD}
    Wait Until Element Is Located    ${navbar}
    Click Element    ${navbar_activities}
    Page Should Contain    Activities selected for you
    Click Element    ${navbar_rewards}
    Page Should Contain    Rewards selected for you
    Click Element    ${navbar_content}
    Page Should Contain Element        ${stream}
    Click Element    ${navbar_community}
    Page Should Contain Element         ${marquee}
    Click Element    ${navbar_profile}
    Page Should Contain    Details

Check fan stories
    Login To The Paddock Page   ${EMAIL}    ${PASSWORD}
    Wait Until Element Is Located    ${navbar}
    Click Element    ${navbar_community}
    Page Should Contain Element        ${marquee}
    Click Element    ${filter_story}
    Wait Until Element Is Visible    ${fan_story}
    Click Element    ${toggle_filter}
    Click Element    ${filter_images}
    Wait Until Element Is Visible    ${fan_image}

Check profile page
    Login To The Paddock Page   ${EMAIL}    ${PASSWORD}
    Wait Until Element Is Located    ${navbar}
    Click Element    ${navbar_profile}
    Page Should Contain    Details
    Page Should Contain    First Name
    Page Should Contain    Last Name
    Page Should Contain    Gender
    Click Element       ${gender_dropdown}
    Click Element    xpath=(//div[contains(@class,'rbr-cosmos-select-option')])[3]
    Click Element   ${marketing_toggle}[0]
    Click Element   ${marketing_toggle}[1]
    Click Element   ${marketing_toggle}[2]
    Click Element    xpath=(//button[contains(text(),'Save')])[1]
    Input Text    ${profile_input_field}[0]      SomeStreet 11
    Input Text    ${profile_input_field}[1]      SomeCity
    Input Text    ${profile_input_field}[2]      SomeState
    Input Text    ${profile_input_field}[3]      12345
    Input Text    ${profile_input_field}[4]      SomeCountry
    Wait Until Element Is Located    xpath=(//button[contains(text(),'Save')])[2]
    Click Element    xpath=(//button[contains(text(),'Save')])[2]
    Wait Until Keyword Succeeds    10s  1s  Page Should Contain    Saved!

Check garage page
    Login To The Paddock Page   ${EMAIL}    ${PASSWORD}
    Wait Until Element Is Located    ${navbar}
    Click Element    ${navbar_profile}
    Click Element    ${garage}
    Wait Until Keyword Succeeds    10s  1s  Page Should Contain    Garage
    Input Text    (//input[contains(@class,'false')])[1]    SomeGuy
    Input Text      ${garage_input}     99
    Click Element   (//p)[15]
    Wait Until Element Is Located    ${dropdown_showing}
    Click Element    (//div[contains(@class,'rbr-cosmos-select-option')])[4]
    Click Element    (//button[contains(text(),'Save')])[1]
    Page Should Contain    Saving...
    Click Element    (//p)[23]
    Wait Until Element Is Located    ${dropdown_showing}
    Click Element    (//p[normalize-space()='Circuit de Monaco'])[1]
    Click Element    (//p)[45]
    Wait Until Element Is Located    ${dropdown_showing}
    Click Element    (//p[normalize-space()='RB10'])[1]
    Click Element    (//button[contains(text(),'Save')])[1]
    Wait Until Keyword Succeeds    10s  1s  Page Should Contain    Saving...