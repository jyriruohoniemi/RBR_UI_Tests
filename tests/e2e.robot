*** Settings ***
Library           SeleniumLibrary
Library           Collections
Test Setup      Open Browser
Test Teardown    Close Browser
Resource        ../resources/Generic.robot
Resource        ../resources/PO/MainPage.robot
Resource        ../resources/PO/DriversPage.robot
Resource        ../resources/PO/RacesPage.robot
Resource        ../resources/PO/PaddockPage.robot
Resource        ../resources/PO/EsportsPage.robot
#TODO
#SPLIT E2E TESTS TO INDIVIDUAL TESTS
#FIX PABOT
*** Test Cases ***