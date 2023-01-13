*** Settings ***
Library           SeleniumLibrary
Resource        ../Generic.robot
Documentation    This file contains all the keywords and variables related to the operations of the main page

*** Variables ***
${driver_image}=    css:img[title='Sergio Perez']
${specs_button}=      xpath=//span[normalize-space()='View Specs']
${navigation_arrow}     xpath=//div[@id='rbr-drivers-panel']//div[@class='track_controls']//button[1]
${email_field}          xpath=//input[@placeholder='Your email:']
@{checkbox}             xpath=//div[@class='rbr-lite-account-presignup false']//div[1]//div[1]  //div[@class='rbr-lite-account-presignup false']//div[2]//div[1]    //div[@class='rbr-lite-account-presignup false']//div[3]//div[1]
${submit_button}        xpath=//button[normalize-space()='Submit']
${podcast_banner}       xpath=//div[@id='crsd-rbracing-debrief-panel']//div[@class='editors-pick__wrapper']
${view_podcast}         xpath=//cosmos-text-3-22-1[contains(text(),'Talking Bull is the official podcast of the Oracle')]
${handle}               xpath=//div[@class='splitview skewed d-none d-lg-flex']
${races_link}           xpath=//div[normalize-space()='Races']
${social_media_container}   xpath=//div[@class='social-follow__buttons social-follow__buttons--3']
@{social_media_links}       css:body > main:nth-child(1) > div:nth-child(1) > div:nth-child(16) > div:nth-child(1) > cosmos-mode-3-22-1:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1)    css:body > main:nth-child(1) > div:nth-child(1) > div:nth-child(16) > div:nth-child(1) > cosmos-mode-3-22-1:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(2)    css:body > main:nth-child(1) > div:nth-child(1) > div:nth-child(16) > div:nth-child(1) > cosmos-mode-3-22-1:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(3)



*** Keywords ***
Accept cookies
    Click Button    id=onetrust-accept-btn-handler

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

Join the mailing list
    [Arguments]    ${email}
    Wait Until Element Is Located   ${email_field}
    Input Text   ${email_field}     ${email}
    Click Element           ${checkbox}[0]
    Click Element           ${checkbox}[1]
    Click Element           ${checkbox}[2]
    Wait Until Element Is Enabled   ${submit_button}
    Click Button    ${submit_button}
    Page Should Contain    Thanks for joining the Oracle Red Bull Racing charge.

Check the podcast functionality
    Wait Until Element Is Located    ${podcast_banner}
    Click Element        ${view_podcast}
    Page Should Contain    Talking Bull

Drag the handle
    Click Element At Coordinates    ${handle}   126   254
    Click Element At Coordinates    ${handle}   939   277

Navigate to races page
    Click Element   ${races_link}

Verify social media links
    Wait Until Element Is Located   ${social_media_container}
    Click Element    ${social_media_links}[0]
    Switch Window    NEW
    Title Should Be    Oracle Red Bull Racing (@redbullracing) • Instagram photos and videos
    Switch Window   MAIN
    Click Element    ${social_media_links}[1]
    Switch Window    NEW
    Title Should Be    Oracle Red Bull Racing - Home | Facebook
    Switch Window   MAIN
    Click Element    ${social_media_links}[2]
    Switch Window    NEW
    Title Should Be    Oracle Red Bull Racing (@redbullracing) / Twitter

#TODO
#Verify the functionality of the partner links
#Verify the functionality of the footer links