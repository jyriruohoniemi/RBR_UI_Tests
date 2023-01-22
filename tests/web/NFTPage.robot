*** Settings ***
Library       SeleniumLibrary
Resource      ../../resources/Generic.robot
Test Setup    Open Browser And Accept Cookies
Test Teardown    Close Browser

*** Variables ***
${navbar}   xpath=(//div[@class='page-tabs__content-wrapper'])[1]
${navbar_nft}   xpath=(//a[normalize-space()='#8494'])[1]
${heading}      css:.inline-heading.inline-heading__title.inline-heading--level-1
${navbar_about}   xpath=//a[normalize-space()='About']
${navbar_videos}    xpath=(//a[normalize-space()='Videos'])[1]
${navbar_faqs}    xpath=(//a[normalize-space()='FAQs'])[1]
${heading2}     xpath=//h2[@id='1-what-are-nfts']
${video_player}   xpath=(//div[@class='inline-video-preview__content'])[1]
${page_summary}     xpath=(//div[@class='inline-content-index'])[1]


*** Test Cases ***
Test Navbar
    [Tags]    Misc
    Navigate To Nft Page
    Check That The Navbar Works


*** Keywords ***
Check that the navbar works
    Wait until element is located   ${navbar}
    Click element   ${navbar_nft}
    Wait Until Element Is Located    ${heading}
    Click element   ${navbar_about}
    Page Should Contain    Innovation lies at the heart of Oracle Red Bull Racing
    Wait Until Keyword Succeeds    15x    1s    Page Should Contain    Innovation lies at the heart of Oracle Red Bull Racing
    Click element   ${navbar_videos}
    Wait Until Element Is Visible    ${video_player}
    Click Element    ${navbar_faqs}
    Wait Until Element Is Located    ${page_summary}


