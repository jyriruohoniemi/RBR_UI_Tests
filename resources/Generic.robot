*** Settings ***
Documentation    This file features all the generics and variables used in the test suites
Library    SeleniumLibrary

*** Variables ***
${EMAIL_TEST}    godakal422@tingn.com
${URL}     https://www.redbullracing.com/int-en
${BROWSER}      Chrome
${EMAIL}    doysuhjhtyhjrjqffd@tmmwj.com
${PASSWORD}     Eqjt37KWA7MjfVB9iNE7
${RACES_PAGE}           xpath=//div[normalize-space()='Races']
${PADDOCK_PAGE}     xpath=//div[normalize-space()='The Paddock']
${ESPORTS_PAGE}     xpath=//div[normalize-space()='Esports']
${NFT_PAGE}     xpath=//div[normalize-space()='NFTs']

*** Keywords ***
Open Browser and accept cookies
    Create Webdriver    ${BROWSER}   executable_path=/resources/${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.25
    Go To        ${URL}
    Accept Cookies

Accept cookies
    Wait Until Element Is Located   id=onetrust-accept-btn-handler
    Click Element   id=onetrust-accept-btn-handler

Navigate to races page
    Click Element   ${RACES_PAGE}
    Title Should Be    2022 FIA Formula One World Championship Race Calendar
    Wait Until Keyword Succeeds    10x  1s  Title Should Be    2022 FIA Formula One World Championship Race Calendar

Navigate to paddock page
    Click Element   ${paddock_page}
    Title Should Be    The Oracle Red Bull Racing Paddock
    Wait Until Keyword Succeeds    10x  1s  Title Should Be    The Oracle Red Bull Racing Paddock

Navigate to esports page
    Click Element   ${esports_page}
    Title Should Be    Oracle Red Bull Racing Esports
    Wait Until Keyword Succeeds    10x  1s  Title Should Be    Oracle Red Bull Racing Esports

Navigate to nft page
    Click Element   ${nft_page}
    Title Should Be    Discover Oracle Red Bull Racing NFTs
    Wait Until Keyword Succeeds    10x  1s  Title Should Be    Discover Oracle Red Bull Racing NFTs

Close Browser
    Close All Browsers

Wait until element is located
    [Arguments]    ${page_locator}
    Wait Until Element Is Visible        ${page_locator}    timeout=10s