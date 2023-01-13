*** Settings ***
Documentation    This file features all the generics and variables used in the test suites
Library    SeleniumLibrary

*** Variables ***
${URL}     https://www.redbullracing.com/int-en
${BROWSER}      Chrome

*** Keywords ***
Open Browser
    Create Webdriver    ${BROWSER}   executable_path=/resources/${BROWSER}
    Set Selenium Speed    0.25 seconds
    Set Window Size    1920    1080
    Go To        ${URL}


Close Browser
    Close All Browsers

Wait until element is located
    [Arguments]    ${page_locator}
    Wait Until Element Is Visible        ${page_locator}    timeout=10s