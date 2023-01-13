*** Settings ***
Library           SeleniumLibrary
Resource        ../Generic.robot



*** Variables ***
${latest_race}     xpath=//div[@class='previous-race-section-title']
${read_race_report}     xpath=//a[normalize-space()='Read Race Reports']
${calendar}     xpath=//body[1]/main[1]/div[1]/div[9]/div[1]/cosmos-mode-3-22-1[1]
${race_tab_fp}  xpath=//a[normalize-space()='Free Practice']
${race_tab_quali}   xpath=//a[normalize-space()='Qualifying']
${race_tab_race}    xpath=//a[normalize-space()='Race']

*** Keywords ***
Check the latest race
    Wait Until Element Is Located    ${latest_race}
    Click Element    ${read_race_report}
    Click Element   ${race_tab_fp}
    Page Should Contain    Published on     What The Bulls Said
    Click Element    ${race_tab_quali}
    Page Should Contain     Q3    What The Bulls Said
    Click Element    ${race_tab_race}
    Page Should Contain     Race Results    What The Bulls Said



Check the race info cards

Check the calendar functionality
    Wait Until Element Is Located   ${calendar}

#TODO
#Check that the calendar is interactable
#Check that news articles load