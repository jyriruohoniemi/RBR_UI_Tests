*** Settings ***
Documentation    This file contains the keywords and tests pertaining to the esports page.
Library         SeleniumLibrary
Resource        ../resources/Generic.robot
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
@{esport_partners}      Oracle      Bybit - Principal Team Partner      HyperX™ - Red Bull Racing Esports Peripherals Partner   Playseat® - Red Bull Racing Esports Partner   AOC - Red Bull Racing Esports Gaming Monitor Partner      Blenders - Eyewear Partner      Fanatec® - Red Bull Racing Esports Partner     Mobil 1   Pirelli


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

Verify partner links
   [Tags]   Test1
   Navigate to esports page
   Check partner link functionality    ${esport_partners}

*** Keywords ***
Check that all tabs work
    Wait Until Element Is Located    ${tab_team}
    Wait Until Completion    Click Element    ${tab_team}
    Wait Until Completion        Page Should Contain Element    css:.description-text__summary__text
    Wait Until Element Is Located    ${tab_races}
    Wait Until Completion    Click Element    ${tab_races}
    Wait Until Completion        Page Should Contain Element    css:.description-text__summary__text
    Wait Until Element Is Located    ${tab_partners}
    Wait Until Completion    Click Element    ${tab_partners}
    Wait Until Completion        Page Should Contain Element    css:.description-text__summary__text
    Wait Until Element Is Located    ${tab_shop}
    Wait Until Completion    Click Element    ${tab_shop}
    Wait Until Element Is Located    ${shop_item}

Sign up for the free Newsletter
    [Arguments]    ${email}
    Wait Until Element Is Located   ${newsletter_container}
    Wait Until Keyword Succeeds  20s    1s  Input Text   ${email_field}     ${email}
    Wait Until Completion    Click Element           ${checkbox}[0]
    Wait Until Completion    Click Element           ${checkbox}[1]
    Wait Until Element Is Enabled   ${submit_button}
    Wait Until Completion    Click Button    ${submit_button}
    Wait Until Element Is Located    ${confirm_message}

Check socials
    Wait Until Element Is Located   ${social_container}
    Wait Until Completion    Scroll Element Into View    ${social_handles}[0]
    Click Element    ${social_handles}[0]
    Switch Window    NEW
    Wait Until Completion         Title Should Be    Oracle Red Bull Racing Esports (@redbullracingES) / Twitter
    Switch Window   MAIN
    Click Element    ${social_handles}[1]
    Switch Window    NEW
    #Page removed?
    Wait Until Completion       Title Should Be    Page not found • Instagram
    Switch Window   MAIN
    Click Element    ${social_handles}[2]
    Switch Window    NEW
    Wait Until Completion        Page Should Contain    Red Bull Racing Esports - Home | Facebook

Verify shop page functionality
    Wait Until Element Is Located    ${tab_shop}
    Click Element    ${tab_shop}
    Wait Until Element Is Located    ${shop_items}[0]
    Click Element    ${shop_items}[0]
    Switch Window    NEW
    Wait Until Completion       Title Should Be    Oracle Red Bull Racing Shop: Esports Driver Cap 2022 | only here at redbullshop.com
    Switch Window   MAIN
    Click Element    ${shop_items}[1]
    Switch Window    NEW
    Wait Until Completion       Title Should Be    Playseat® Evolution PRO Red Bull Racing Esports - PlayseatStore - Game Seats and Racing & Flying Simulation Cockpits
    Switch Window   MAIN
    Click Element    ${shop_items}[2]
    Switch Window    NEW
    Wait Until Completion       Title Should Be    PlayseatStore - Game Seats and Racing & Flying Simulation Cockpits
    Switch Window   MAIN
    Click Element    ${shop_items}[3]
    Switch Window    NEW
    Wait Until Completion       Title Should Be    PlayseatStore - Game Seats and Racing & Flying Simulation Cockpits

Test calendar functionality
    Wait Until Element Is Located    ${tab_races}
    Click Element    ${tab_races}
    Wait Until Element Is Located   ${event_panel}
    Wait Until Element Is Located    ${race_card}
    Wait Until Completion    Scroll Element Into View    ${race_card}
    Wait Until Element Is Located    ${event_view_more}
    Click Element    ${event_view_more}
    Wait Until Completion        Page Should Contain Element    css:.event-hero__series-and-title__title

Check partner link functionality
    [Arguments]    ${esport_partners}
    ${index}=   Set Variable    -1
    Wait Until Element Is Located    ${tab_partners}
    Click Element    ${tab_partners}
    Wait Until Completion    Page Should Contain Element    css:.rbr-paddock-partner-card
    Wait Until Completion    Scroll Element Into View    css:.rbr-paddock-partner-card
    ${partner_items}=   Get Webelements    css:a.rbr-paddock-partner-card
    Create List     ${partner_items}
    Log   ${partner_items}
    FOR    ${partner}    IN    @{partner_items}
        ${visible}=   Run Keyword And Return Status    Element Should Be Visible    ${partner}
        Run Keyword If    ${visible} == False    Link not visible
        Wait Until Completion    Scroll Element Into View    ${partner}
        Click Element  ${partner}   CTRL
        Switch Window    NEW
        ${title}=   Get Title
        Title Should Be    ${title}     ${esport_partners}[${index}]
        ${index}=   Evaluate    ${index} + 1
        Switch Window   MAIN
    END

Link not visible
    Wait Until Element Is Located    css:div[aria-label='Next']
    Wait Until Completion    Scroll Element Into View    css:div[aria-label='Next']
    Wait Until Completion    Click Element        css:div[aria-label='Next']

