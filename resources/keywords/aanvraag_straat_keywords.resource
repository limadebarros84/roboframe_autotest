*** Settings ***
Resource         ./Global.robot
Resource         ./aanvraag_straat.resource

*** Keywords ***
Nieuwbouw Selecteren
    [Arguments]    ${straat}    ${plaats}    ${postcode}    ${huisnummer}    ${huisnummertoevoeging}
    [Documentation]    Vul de gegevens in voor een nieuwbouwselectie.
    Adres Nieuwbouw Selecteren    ${straat}    ${plaats}    ${postcode}    ${huisnummer}    ${huisnummertoevoeging}
    Volgende

Vul Adresgegevens
    [Arguments]    ${postcode}    ${huisnummer}    ${straatnaam}
    [Documentation]    Vul de adresgegevens in.
    Postcode Huisnummer    ${postcode}    ${huisnummer}
    Zoeken
    Adres Selecteren Zonder Huisnummertoevoeging    ${straatnaam}    ${huisnummer}

Selecteer Adres
    Selecteer

Vul Bouwgegevens
    [Arguments]    ${soort_bouw}
    [Documentation]    Vul de bouwgegevens in.
    Soort Bouw    ${soort_bouw}
    Volgende

Vul Doelgegevens
    [Arguments]    ${doel}
    [Documentation]    Vul het doel van de aanvraag in.
    Doel    ${doel}
    Volgende

Beantwoord Vragen
    [Arguments]    ${vraag1}    ${vraag2}    ${vraag3}
    [Documentation]    Beantwoord de vragen met Ja of Nee.
    Klik Ja Of Nee    ${vraag1}    1
    Klik Ja Of Nee    ${vraag2}    2
    Klik Ja Of Nee    ${vraag3}    3
    Volgende

Vul Tussenpersoongegevens
    [Arguments]    ${tussenpersoon}
    Tussenpersoon
    Opvoeren Tekst Combobox    ${tussenpersoon}
    Bevestig Keuze Combobox
    Volgende

Vul Geldverstrekkergegevens
    [Arguments]    ${geldverstrekker}
    Geldverstrekker Opvoeren
    Opvoeren Tekst Combobox    ${geldverstrekker}
    Bevestig Keuze Combobox
    Volgende

Vul Opdrachtgever Relatie
    Opdrachtgever Relatie
    Volgende

Vul Opdrachtvoorwaarden
    Opdrachtvoorwaarden Vullen Anders    Bijzonderbeheerrapport ref      niet bekend is wie de woning hoe gebruikt.    anders, namelijk:     waarschijnlijk naar de veiling brengen
    # Huurovereenkomst    Nee

Vul Waardepeildatum
    [Arguments]    ${datum}
    Selecteer Waardepeildatum    ${datum}

Vul Vervolg Opdrachtvoorwaarden
    [Arguments]    ${aanvullende_afspraken}    ${bemiddelingskosten}    ${kosten}    ${btw}
    Vullen Opdrachtvoorwaarden Vervolg    ${aanvullende_afspraken}
    Opdrachtvoorwaarden Vervolg Bemiddelingskosten    ${bemiddelingskosten}
    Opdrachtvoorwaarden Vervolg Kosten    ${kosten}    ${btw}
    Volgende

Vul Opdrachtgevergegevens
    [Arguments]    ${aanhef}    ${voorletter}    ${tussenvoegsel}    ${achternaam}    ${email}
    [Documentation]    Vul de gegevens van de opdrachtgever in.
    Opdrachtgever een Opvoeren    ${aanhef}    ${voorletter}    ${tussenvoegsel}    ${achternaam}
    Adresgegevens 1    ${email}
    Volgende

Vul Taxateurgegevens
    [Arguments]    ${taxateur}
    Taxateur Opvoeren Lokaal
    Opvoeren Tekst Combobox    ${taxateur}
    Bevestig Keuze Combobox
    Volgende

Controleer En Verstuur Aanvraag
    Overzicht Aanvraag
    Akkoord Voorwaarden    acceptAgreement
    Verzenden
    Bedankt