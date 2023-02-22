*** Settings ***
Documentation    This file contains the keywords and tests pertaining to the drivers page.
Library           SeleniumLibrary
Library           Collections
Resource        ../resources/Generic.robot
Test Setup    Open Browser and accept cookies
Test Teardown    Close Browser

*** Variables ***
${driver_image}=    css:img[title='Sergio Perez']
${specs_button}=      xpath=//span[normalize-space()='View Specs']
${navigation_arrow}     xpath=//div[@id='rbr-drivers-panel']//div[@class='track_controls']//button[1]
${read_more}    xpath=//div[@class='description-text__read-more']//button[@class='button button--clickable']
${view_more}    xpath=//button[@class='button button--clickable']
@{info_pin}     xpath=//div[@id='pin-1']    xpath=//div[@id='pin-2']    xpath=//div[@id='pin-3']    xpath=//div[@id='pin-4']
${social_container}     css:.social-follow__buttons.social-follow__buttons--3
@{social_handles}   xpath=(//div[@class='social-follow__button'])[1]    (//div[@class='social-follow__button'])[2]  xpath=(//div[@class='social-follow__button'])[3]



*** Test Cases ***
Check that max verstappen info is correct
    [Tags]    Primary
    Select Max Verstappen
    Check that Max info is correct
    Check Social Media Links Of Max

Check that Sergio Perez info is correct
     [Tags]    Primary
    Select Sergio Perez
    Check that Sergio info is correct
    Check Social Media Links Of Sergio

Check that car info is correct
     [Tags]    Primary
    Select the car
    Check that car info is correct
    Verify technical specs


*** Keywords ***
Select Max Verstappen
    Wait Until Element Is Located  xpath=//a[@href='/int-en/drivers/max-verstappen/']
    Wait Until Completion   Click Element    xpath=//a[@href='/int-en/drivers/max-verstappen/']

Select Sergio Perez
    Wait Until Element Is Located   ${navigation_arrow}
    Wait Until Completion     Click Element       ${navigation_arrow}
    Wait Until Element Is Located   ${driver_image}
    Wait Until Completion    Click Element    xpath=//div[@class='glide__slide hero-slide glide__slide--active']//span[@class='button__label'][normalize-space()='View profile']

Select the car
    Wait Until Element Is Located   ${specs_button}
    Wait Until Completion    Click Element   ${specs_button}

Check that Max info is correct
    Wait Until Keyword Succeeds    10s    1s    Page Should Contain    Netherlands
    Wait Until Completion      Click Element    ${read_more}
    Page Should Contain     23,000 laps raced
    Wait Until Completion      Click Element    ${view_more}
    Page Should Contain    Pole Position: Brazilian Grand Prix
    Wait Until Completion   Click Element    ${view_more}

Check that Sergio info is correct
    Wait Until Completion    Page Should Contain    Mexico
    Wait Until Element Is Located    ${read_more}
    Wait Until Completion    Click Element    ${read_more}
    Wait Until Completion    Page Should Contain     Force India/Racing Point
    Wait Until Completion    Click Element    ${view_more}
    Wait Until Completion    Page Should Contain    Wins the Sakhir Grand Prix
    Wait Until Completion    Click Element    ${view_more}

Check that car info is correct
    Page Should Contain    696
    Wait Until Completion    Page Should Contain    696
    Wait Until Element Is Located    ${info_pin}[1]
    Wait Until Completion    Mouse Over    ${info_pin}[0]
    Page Should Contain    A four-element wing
    Wait Until Completion    Mouse Over    ${info_pin}[1]
    Page Should Contain    The rear wing is also vastly different to previous generations
    Wait Until Completion    Mouse Over    ${info_pin}[2]
    Page Should Contain    After more than half a century of 13-inch tyres
    Wait Until Completion    Mouse Over    ${info_pin}[3]
    Page Should Contain    A major area of aero development for teams in recent years has been using airflow through the wheels to generate downforce

Verify technical specs
    @{expected_specs}=   Create List    6       4 per cylinder      Mobil 1     1,600cc     90-degrees      150kg       15,000RPM       900HP
    ${specs}=   Get Webelements    css:span.title-bold
    @{actual_specs}=    Create List
    FOR    ${spec}    IN    @{specs}
        Log    ${spec.text}
        Append To List    ${actual_specs}    ${spec.text}
    END
    Lists Should Be Equal    ${expected_specs}    ${actual_specs}
    Log    ${actual_specs}
    Log    ${expected_specs}


Check social media links of max
    Wait Until Element Is Located   ${social_container}
    Wait Until Completion    Scroll Element Into View    ${social_handles}[0]
    Click Element    ${social_handles}[0]
    Switch Window    NEW
    Wait Until Completion    Title Should Be    Max Verstappen | Facebook
    Switch Window   MAIN
    Click Element    ${social_handles}[1]
    Switch Window    NEW
    Wait Until Completion        Title Should Be    Max Verstappen (@Max33Verstappen) / Twitter
    Switch Window   MAIN
    Click Element    ${social_handles}[2]
    Switch Window    NEW
    Wait Until Completion   Title Should Be    Max Verstappen (@maxverstappen1) • Instagram photos and videos


Check social media links of sergio
    Wait Until Element Is Located   ${social_container}
    Wait Until Completion    Scroll Element Into View    ${social_handles}[0]
    Click Element    ${social_handles}[0]
    Switch Window    NEW
    Wait Until Completion    Title Should Be    Sergio Perez | Facebook
    Switch Window   MAIN
    Click Element    ${social_handles}[1]
    Switch Window    NEW
    Wait Until Completion    Title Should Be    Checo Pérez (@schecoperez) • Instagram photos and videos
    Switch Window   MAIN
    Click Element    ${social_handles}[2]
    Switch Window    NEW
    Wait Until Completion    Title Should Be    Sergio Pérez (@SChecoPerez) / Twitter