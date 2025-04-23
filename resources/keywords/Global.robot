*** Settings ***
Library           Browser    strict=false
Library           OperatingSystem
Library           String

*** Variables ***
${BROWSER}        chromium
${BASE_URL_ACC}       https://betatest.acc.taxatieweb.nl/inloggen
${BASE_URL_TEST}      https://aanvraag.test.digitaaltaxatierapport.nl
${LOGIN_URL}      ${EMPTY}  # Wordt geladen uit .env
${PASSWORD}       ${EMPTY}  # Wordt geladen uit .env
${HEADLESS}       true
${TIMEOUT}        0:00:30

*** Keywords ***
Setup Test Environment
    [Documentation]    Laadt de test-omgeving en opent de inlogpagina en weigert cookies. 
    Generate Random String
    Generate Random Digits
    Open Test Login Page

Open Acc Login Page
    [Documentation]    Opent acceptatie omgeving in een nieuwe browsersessie.
    New Browser    browser=${BROWSER}    headless=${HEADLESS}    timeout=${TIMEOUT}
    New Page       ${BASE_URL_ACC}
    Go To          ${LOGIN_URL}

Open Test Login Page
    [Documentation]    Opent test omgeving in een nieuwe browsersessie.
    New Browser    browser=${BROWSER}    headless=${HEADLESS}    timeout=${TIMEOUT}
    New Page       ${BASE_URL_TEST}

Cookies weigeren
    [Documentation]    Behandelt cookie- en authenticatiepop-ups.
    Wait For Elements State    css=button >> text="Weigeren"    visible
    Click    css=button >> text="Weigeren"

Generate Random String
    [Documentation]    Genereert een willekeurige tekenreeks van een opgegeven lengte.
    [Arguments]  ${length}=8
    ${random_string} =  Evaluate  ''.join(random.choices(string.ascii_letters + string.digits, k=${length}))  modules=random,string
    RETURN  ${random_string}

Generate Random Digits
    [Documentation]    Genereert een willekeurige reeks cijfers van een opgegeven lengte.
    [Arguments]  ${length}=10
    ${random_digits} =  Evaluate  ''.join(random.choices(string.digits, k=${length}))  modules=random,string
    RETURN  ${random_digits}

Tear Down Environment
    [Documentation]    Sluit de browser en verwijdert de omgevingsvariabelen.
    Close Browser