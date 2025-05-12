*** Settings ***
Resource         ../resources/Global.robot
Resource         ../resources/keywords/AanvraagStraatKeywords.resource
Test Setup       Setup Test Environment
Test Teardown    Teardown Environment  

*** Test Cases ***
Aanvraag gedwongen verkoop via intermediairsingang
    [Teardown]    Take Screenshot
    Ga naar de aanvraag pagina
    Kies aanvraag    Tussenpersoon
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