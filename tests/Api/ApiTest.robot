*** Settings ***
Library             RequestsLibrary
Test Setup      Create Session     ergastAPIf1      ${URL}
Test Teardown   Delete All Sessions

*** Variables ***
${URL}             http://ergast.com/api/f1/

*** Test Cases ***
Test basic functionality of the page
    ${response}=    GET On Session   ergastAPIf1     current/last/results.json      expected_status=200
    Log    ${response.json()}


Get season where x constructor wins
    ${response}=    GET On Session   ergastAPIf1     constructors/Red_Bull/constructorStandings/1/seasons.json      expected_status=200
    Log    ${response.json()}