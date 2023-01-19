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



*** Test Cases ***
#TODO: Check social media links of drivers

Check that max verstappen info is correct
    [Tags]    Primary
    Select Max Verstappen
    Check that Max info is correct

Check that Sergio Perez info is correct
     [Tags]    Primary
    Select Sergio Perez
    Check that Sergio info is correct

Check that car info is correct
     [Tags]    Primary
    Select the car
    Check that car info is correct
    Verify technical specs


*** Keywords ***
Select Max Verstappen
    Click Element    xpath=//a[@href='/int-en/drivers/max-verstappen/']//span[@class='button__label'][normalize-space()='View profile']

Select Sergio Perez
    Wait Until Element Is Located   ${navigation_arrow}
    Click Element    ${navigation_arrow}
    Wait Until Element Is Located   ${driver_image}
    Click Element    xpath=//div[@class='glide__slide hero-slide glide__slide--active']//span[@class='button__label'][normalize-space()='View profile']

Select the car
    Wait Until Element Is Located   ${specs_button}
    Click Element   ${specs_button}

Check that Max info is correct
    Page Should Contain     Netherlands
    Wait Until Keyword Succeeds    15x    1s    Page Should Contain    Netherlands
    Click Element    ${read_more}
    Page Should Contain     23,000 laps raced
    Click Element    ${view_more}
    Page Should Contain    Pole Position: Brazilian Grand Prix
    Click Element    ${view_more}

Check that Sergio info is correct
    Page Should Contain     Mexico
    Wait Until Keyword Succeeds    15x    1s    Page Should Contain    Mexico
    Wait Until Element Is Located    ${read_more}
    Click Element    ${read_more}
    Page Should Contain     Force India/Racing Point
    Click Element    ${view_more}
    Page Should Contain    Wins the Sakhir Grand Prix
    Click Element    ${view_more}

Check that car info is correct
    Page Should Contain    696
    Wait Until Keyword Succeeds    10x    1s    Page Should Contain    696
    Wait Until Element Is Located    ${info_pin}[1]
    Mouse Over    ${info_pin}[0]
    Page Should Contain    A four-element wing
    Mouse Over    ${info_pin}[1]
    Page Should Contain    The rear wing is also vastly different to previous generations
    Mouse Over    ${info_pin}[2]
    Page Should Contain    After more than half a century of 13-inch tyres
    Mouse Over    ${info_pin}[3]
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