*** Settings ***
Library           SeleniumLibrary
Library           Collections
Test Setup      Open Browser
Test Teardown    Close Browser
Resource        ../resources/Generic.robot
Resource        ../resources/PO/MainPage.robot
Resource        ../resources/PO/DriversPage.robot
Resource        ../resources/PO/RacesPage.robot

*** Variables ***
${EMAIL}    godakal422@tingn.com



*** Test Cases ***
Check that driver and car specs are correct
    [Tags]    Primary
    MainPage.Accept cookies
    MainPage.Select Max Verstappen
    DriversPage.Check that Max info is correct
    Go Back
    MainPage.Select Sergio Perez
    DriversPage.Check that Sergio info is correct
    Go Back
    MainPage.Select the car
    DriversPage.Check that car info is correct
    DriversPage.Verify technical specs
    Go Back

Check the mailing list functionality
    [Tags]    Secondary
    MainPage.Accept cookies
    MainPage.Join the mailing list  ${EMAIL}

Check the podcast functionality
    [Tags]    Secondary
    MainPage.Accept cookies
    MainPage.Check the podcast functionality

Verify draggable handle works
    [Tags]    Secondary
    MainPage.Accept cookies
    MainPage.Drag the handle

Check the races page
    [Tags]    Secondary
    MainPage.Accept cookies
    MainPage.Navigate to races page
    RacesPage.Check the latest race

Check social media
    [Tags]      Secondary
    MainPage.Accept cookies
    MainPage.Verify social media links

