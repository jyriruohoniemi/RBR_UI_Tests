*** Settings ***
Documentation    This file contains the keywords and tests pertaining to the esports page.
Library         SeleniumLibrary
Resource        ../../resources/Generic.robot
Test Setup    Open Browser and accept cookies
Test Teardown    Close Browser

*** Variables ***
${email_field}          xpath=//input[@placeholder='Your email:']
@{checkbox}             //div[@class='rbr-lite-account-presignup false']//div[1]//div[1]  //div[@class='rbr-lite-account-presignup false']//div[2]//div[1]    //div[@class='rbr-lite-account-presignup false']//div[3]//div[1]
${submit_button}        xpath=//button[normalize-space()='Submit']
${tab_team}     xpath=(//a[normalize-space()='Team'])[1]
${tab_races}    css:a[href='/int-en/red-bull-racing-esports/race-schedule']
${tab_partners}     xpath=(//a[normalize-space()='Partners'])[1]
${tab_shop}     xpath=(//a[normalize-space()='Shop'])[1]
${shop_item}    xpath=(//a)[14]
${newsletter_container}     css:.rbr-esports-lite-account
@{checkboxes}   xpath=//div[@class='rbr-lite-account-presignup false']//div[1]//label[1]  xpath=//div[@class='rbr-lite-account-presignup false']//div[2]//label[1]
${submit_button}    xpath=//button[normalize-space()='Submit']
${confirm_message}  css:.rbr-paragraph.lite-account-message.is-showing
${social_container}     css:.social-follow__buttons.social-follow__buttons--3
@{social_handles}   xpath=(//div[@class='social-follow__button'])[1]    (//div[@class='social-follow__button'])[2]  xpath=(//div[@class='social-follow__button'])[3]
@{shop_items}   xpath=(//div[@class='asset-info-rail__item'])[1]    xpath=(//div[@class='asset-info-rail__item'])[2]    xpath=(//div[@class='asset-info-rail__item'])[3]    xpath=(//div[@class='asset-info-rail__item'])[4]
${event_panel}  css:.content-hub-event-series-panel__caption
${event_view_more}    css:div[class='event-series-rail__expanded-item'] a[class='button button--clickable']
${race_card}    css:div[class='event-series-rail__expanded-item'] div[class='hub-event-card']


*** Test Cases ***
#TODO: Test the partner links
Check the functionality of the navbar
    [Tags]   Primary
    Navigate to esports page
    Check that all tabs work

Check the functionality of the newsletter
    [Tags]   Misc
    Navigate to esports page
    Sign up for the free Newsletter     ${EMAIL_TEST}

Check the functionality of the social handles
    [Tags]   Secondary
    Navigate to esports page
    Check socials

Check the functionality of the shop
    [Tags]   Secondary
    Navigate to esports page
    Verify shop page functionality

Check the functionality of the events
    [Tags]   Secondary
    Navigate to esports page
    Test calendar functionality

*** Keywords ***
Check that all tabs work
    Wait Until Element Is Located    ${tab_team}
    Click Element    ${tab_team}
    Page Should Contain Element    css:.description-text__summary__text
    Wait Until Keyword Succeeds    15x    1s    Page Should Contain Element    css:.description-text__summary__text
    Wait Until Element Is Located    ${tab_races}
    Click Element    ${tab_races}
    Page Should Contain Element    css:.description-text__summary__text
    Wait Until Keyword Succeeds    15x    1s    Page Should Contain Element    css:.description-text__summary__text
    Wait Until Element Is Located    ${tab_partners}
    Click Element    ${tab_partners}
    Page Should Contain Element    css:.description-text__summary__text
    Wait Until Keyword Succeeds    15x    1s    Page Should Contain Element    css:.description-text__summary__text
    Wait Until Element Is Located    ${tab_shop}
    Click Element    ${tab_shop}
    Wait Until Element Is Located    ${shop_item}

Sign up for the free Newsletter
    [Arguments]    ${email}
    Wait Until Element Is Located   ${newsletter_container}
    Input Text   ${email_field}     ${email}
    Click Element           ${checkbox}[0]
    Click Element           ${checkbox}[1]
    Wait Until Element Is Enabled   ${submit_button}
    Click Button    ${submit_button}
    Wait Until Element Is Located    ${confirm_message}

Check socials
    Wait Until Element Is Located   ${social_container}
    Scroll Element Into View    ${social_handles}[0]
    Click Element    ${social_handles}[0]
    Switch Window    NEW
    Title Should Be    Oracle Red Bull Racing Esports (@redbullracingES) / Twitter
    Switch Window   MAIN
    Click Element    ${social_handles}[1]
    Switch Window    NEW
    #Page removed?
    Title Should Be    Page not found • Instagram
    Switch Window   MAIN
    Click Element    ${social_handles}[2]
    Switch Window    NEW
    Title Should Be    Red Bull Racing Esports - Home | Facebook
    Wait Until Keyword Succeeds    10x    1s    Page Should Contain    Red Bull Racing Esports - Home | Facebook



Verify shop page functionality
    Wait Until Element Is Located    ${tab_shop}
    Click Element    ${tab_shop}
    Wait Until Element Is Located    ${shop_items}[0]
    Click Element    ${shop_items}[0]
    Switch Window    NEW
    Title Should Be    Oracle Red Bull Racing Shop: Esports Driver Cap 2022 | only here at redbullshop.com
    Switch Window   MAIN
    Click Element    ${shop_items}[1]
    Switch Window    NEW
    Title Should Be    Playseat® Evolution PRO Red Bull Racing Esports - PlayseatStore - Game Seats and Racing & Flying Simulation Cockpits
    Switch Window   MAIN
    Click Element    ${shop_items}[2]
    Switch Window    NEW
    Title Should Be    PlayseatStore - Game Seats and Racing & Flying Simulation Cockpits
    Switch Window   MAIN
    Click Element    ${shop_items}[3]
    Switch Window    NEW
    Title Should Be    PlayseatStore - Game Seats and Racing & Flying Simulation Cockpits



Test calendar functionality
    Wait Until Element Is Located    ${tab_races}
    Click Element    ${tab_races}
    Wait Until Element Is Located   ${event_panel}
    Wait Until Element Is Located    ${race_card}
    Scroll Element Into View    ${race_card}
    Wait Until Element Is Located    ${event_view_more}
    Click Element    ${event_view_more}
    Page Should Contain    2022/23 Le Mans Virtual Series Finale
    Wait Until Keyword Succeeds    10x    1s    Page Should Contain    2022/23 Le Mans Virtual Series Finale



