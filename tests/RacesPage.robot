*** Settings ***
Library           SeleniumLibrary
Resource        ../resources/Generic.robot
Test Setup    Open Browser and accept cookies
Test Teardown    Close Browser
Documentation    This test suite is used to test the functionality of the Races page and its features.



*** Variables ***
${read_race_report}     xpath=(//a[@class='button button--clickable'])
${calendar}     xpath=(//div[@class='content-hub-event-series-panel'])[1]
${race_map}     xpath=(//h3[normalize-space()='Race map'])[1]
${race_tab_fp}  xpath=(//a[normalize-space()='Free Practice'])[1]
${race_tab_quali}   xpath=(//a[normalize-space()='Qualifying'])[1]
${race_tab_race}    xpath=(//a[normalize-space()='Race'])[1]
${navigation_arrow_left}    xpath=(//div[@class='event-series-rail__navigation-arrow-box event-series-rail__navigation-arrow-box--left'])[1]
${race_card}    xpath=(//div[@class='hub-event-card-collapsed'])[3]
${heading}  css:div[class='rbr-event-hero-content'] h1
${view_event_info}      css:div[class='event-series-rail__expanded-item'] a[class='button button--clickable']
${news_card}    css:cosmos-story-card-4-4-0[data-cosmos-component='cosmos-story-card']
${news_title}   xpath=//h1[normalize-space()='Trackside News']
${arrow}    xpath=//div[@class='event-series-rail__navigation-arrow event-series-rail__navigation-arrow--right']

*** Test Cases ***
Check the races page
    [Tags]    Misc
    Navigate to races page

Check calendar and a race
    [Tags]    Secondary
    Navigate to races page
    Check the calendar functionality and check another race

Check the news tab
    [Tags]    Secondary
    Navigate to races page
    Check news

*** Keywords ***
Check the calendar functionality and check another race
    Wait Until Element Is Located   ${calendar}
    Wait Until Completion    Scroll Element Into View    ${calendar}
    Wait Until Element Is Located    ${arrow}
    Wait Until Completion    Scroll Element Into View    ${arrow}
    Wait Until Completion    Click Element        ${arrow}
    Wait Until Element Is Located    ${race_card}
    Wait Until Completion    Scroll Element Into View    ${race_card}
    Wait Until Completion    Click Element   ${race_card}
    Wait Until Element Is Located    ${view_event_info}
    Wait Until Completion    Click Element   ${view_event_info}
    Wait Until Element Is Located    ${heading}
    Wait Until Element Is Located     ${race_tab_fp}
    Wait Until Completion    Click Element   ${race_tab_fp}
    Page Should Contain    Published on
    Wait Until Element Is Located     ${race_tab_quali}
    Wait Until Completion    Click Element    ${race_tab_quali}
    Page Should Contain     Published on
    Wait Until Element Is Located   ${race_tab_race}
    Wait Until Completion    Click Element    ${race_tab_race}
    Page Should Contain     Published on


Check news
    Wait Until Element Is Located    ${news_title}
    Wait Until Completion    Scroll Element Into View    ${news_title}
    Wait Until Element Is Located   ${news_card}
    Wait Until Completion    Scroll Element Into View    ${news_card}
    Wait Until Completion    Click Element    ${news_card}
    Page should Contain     Published on