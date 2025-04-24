*** Settings ***
Resource         ../resources/keywords/Global.robot
Resource         ../resources/keywords/aanvraag_straat_keywords.resource
Test Setup       Setup Test Environment
Test Teardown    Teardown Environment  

*** Test Cases ***
Aanvraag gedwongen verkoop via intermediairsingang
    [Teardown]    Take Screenshot
    Sleep    10s
    Wait For Elements State    //h1[normalize-space()="Woningtaxatie aanvragen"]    visible    timeout=30s
    Woningtaxatie Aanvragen
    Kies Ingang    Tussenpersoon
    Vul Adresgegevens    5398JJ    57    Provincialeweg
    Selecteer Adres
    Vul Bouwgegevens    Bestaande bouw
    Vul Doelgegevens    Gedwongen Verkoop
    Vul Tussenpersoongegevens    Redert Advies
    Vul Geldverstrekkergegevens    AEGON Bijzonder Beheer
    Vul Opdrachtgever Relatie
    Vul Opdrachtvoorwaarden
    Vul Waardepeildatum    01-04-2025
    Vul Vervolg Opdrachtvoorwaarden    Geen aanvullende afspraken    0    561,99    89,49
    Vul Taxateurgegevens    NWWI Test Kantoor
    Controleer En Verstuur Aanvraag