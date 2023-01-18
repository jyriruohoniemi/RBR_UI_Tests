*** Settings ***
Library           SeleniumLibrary
Resource        ../resources/Generic.robot
Test Setup    Open Browser and accept cookies
Test Teardown    Close Browser



*** Variables ***
${latest_race}     xpath=//div[@class='previous-race-section-title']
${read_race_report}     xpath=(//a[normalize-space()='Read Race Reports'])[1]
${calendar}     xpath=//body[1]/main[1]/div[1]/div[9]/div[1]/cosmos-mode-3-22-1[1]
${race_tab_fp}  xpath=(//a[normalize-space()='Free Practice'])[1]
${race_tab_quali}   xpath=(//a[normalize-space()='Qualifying'])[1]
${race_tab_race}    xpath=(//a[normalize-space()='Race'])[1]
${navigation_arrow_left}    xpath=(//div[@class='event-series-rail__navigation-arrow-box event-series-rail__navigation-arrow-box--left'])[1]
${race_card}    xpath=(//div[@class='hub-event-card-collapsed'])[18]
${view_event_info}      css:div[class='event-series-rail__expanded-item'] a[class='button button--clickable']
${news_card}    xpath=(//cosmos-story-card-3-22-1[@href='/int-en/max-verstappen-the-road-to-the-title'])[1]
${news_title}   xpath=//h1[normalize-space()='Trackside News']

*** Test Cases ***
Check the races page
    [Tags]    Secondary
    Navigate to races page

Check the latest race
    Navigate to races page
    Check the latest race

Check calendar and another race
    Navigate to races page
    RacesPage.Check the calendar functionality and check another race

Check the news tab
    Navigate to races page
    RacesPage.Check news
*** Keywords ***
Check the latest race
    Wait Until Element Is Located    ${latest_race}
    Click Element    ${read_race_report}
    Page Should Contain Element    (//h3[normalize-space()='Race map'])[1]
    Wait Until Element Is Located   ${race_tab_fp}
    Click Element   ${race_tab_fp}
    Page Should Contain        Published on
    Wait Until Element Is Located    ${race_tab_quali}
    Click Element    ${race_tab_quali}
    Page Should Contain     Published on
    Wait Until Element Is Located    ${race_tab_race}
    Click Element    ${race_tab_race}
    Page Should Contain     Published on

Check the calendar functionality and check another race
    Wait Until Element Is Located   ${calendar}
    Click Element    ${navigation_arrow_left}
    Click Element   ${race_card}
    Click Element   ${view_event_info}
    Page Should Contain Element     (//h3[normalize-space()='Race map'])[1]
    Click Element   ${race_tab_fp}
    Page Should Contain    Published on
    Click Element    ${race_tab_quali}
    Page Should Contain     Published on
    Click Element    ${race_tab_race}
    Page Should Contain     Published on


Check news
    Wait Until Element Is Located    ${news_title}
    Scroll Element Into View    ${news_title}
    Wait Until Element Is Located   ${news_card}
    Click Element    ${news_card}
    Page should Contain     Published on