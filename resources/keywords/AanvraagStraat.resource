*** Settings ***
Resource    ../Global.robot

*** Variables ***
${HEADER}                   Woningtaxatie aanvragen
${PAGE_HEADER}              //h1[normalize-space()="${HEADER}"]
@{AANVRAGEN}                Consument    Taxateur    Geldverstrekker    Tussenpersoon    Woningcorporatie
${AANVRAG_NAAM}             ${EMPTY}
${AANVRAAG_TILE}            //h6[normalize-space()="${AANVRAG_NAAM}"]

*** Keywords ***
# Section: General Keywords
Ga naar de aanvraag pagina
    [Documentation]    Verifieert de aanwezigheid van de elementen op de Woningtaxatie aanvragen pagina.
    # Verifieert de titel van de pagina
    Get Text    ${PAGE_HEADER}    ==    ${HEADER}
    # Verifieert de aanvraag titels 
    FOR    ${naam}    IN    @{AANVRAGEN}
        Log    Verifying tile: ${naam}
        Get Text    //h6[normalize-space()="${naam}"]    ==    ${naam}
    END

Kies aanvraag
    [Arguments]    ${ingang}
    [Documentation]    Selecteert de ingang op basis van de opgegeven waarde.
    Click    //h6[normalize-space()="${ingang}"]

Type Rapport
    [Arguments]    ${rapporttype}
    [Documentation]    Selecteert het type rapport op de Nieuwe aanvraag pagina.
    Get Text    //h1[normalize-space()="Nieuwe aanvraag"]    ==    Nieuwe aanvraag
    Get Text    //h2[normalize-space()="Voor welk type rapport doet u een aanvraag?"]    ==    Voor welk type rapport doet u een aanvraag?
    Click    //label[normalize-space()="${rapporttype}"]
    
# Section: Address Keywords
Postcode Huisnummer
    [Arguments]    ${postcode}    ${huisnummer}
    [Documentation]    Voert postcode en huisnummer in.
    Type Text    //input[@id="searchPostcode"]    ${postcode} 
    Type Text    //input[@id="searchHouseNumber"]    ${huisnummer}

Click op
    [Documentation]    Klikt op de opgegeven knop.
    [Arguments]    ${button_text}
    Click    css=button >> text=${button_text}

Adres Selecteren Zonder Huisnummertoevoeging
    [Arguments]    ${straat}    ${huisnummer}
    [Documentation]    Selecteert een adres zonder huisnummertoevoeging.
    Hover    //span[normalize-space()="${straat} ${huisnummer}"]
    Click    //span[normalize-space()="${straat} ${huisnummer}"]
    Hover    css=button >> text=Selecteer

Adres Selecteren Met Huisnummertoevoeging
    [Arguments]    ${straat}    ${huisnummer}    ${huisnummertoevoeging}
    [Documentation]    Selecteert een adres met huisnummertoevoeging.
    Hover    //span[normalize-space()="${straat} ${huisnummer}-${huisnummertoevoeging}"]
    Click    //span[normalize-space()="${straat} ${huisnummer}-${huisnummertoevoeging}"]
    Hover    css=button >> text=Selecteer

Adres Nieuwbouw Selecteren
    Click    //a[normalize-space()="Postcode is niet bekend"]
    Get Text    //h2[normalize-space()="Wat is de locatie van de woning?"]    ==    Wat is de locatie van de woning?
    Get Text    //label[normalize-space()="Straat"]    ==    Straat
    Get Text    //small[contains(text(),"(indien onbekend: projectnaam bijvoorbeeld: De Parkwachter")]    ==    (indien onbekend: projectnaam bijvoorbeeld: De Parkwachter)
    Get Text    //label[normalize-space()="Plaats"]    ==   Plaats
    Get Text    //label[normalize-space()="Postcode"]    ==    Postcode  
    Get Text    //small[normalize-space()="(aanwijzen op bovenstaande kaart)"]    ==    (aanwijzen op bovenstaande kaart)
    Get Text    //label[normalize-space()="Huisnummer"]    ==    Huisnummer
    Get Text    //small[normalize-space()="(voor nieuwbouw project: bouw-/kavelnummer)"]    ==    (voor nieuwbouw project: bouw-/kavelnummer)
    Get Text    //label[normalize-space()="Huisnummertoevoeging"]    ==    Huisnummertoevoeging
    [Arguments]    ${straat}   ${plaats}      ${postcode}     ${huisnummer}    ${huisnummertoevoeging}
    Type Text    //input[@id="street"]         ${straat}
    Type Text    //input[@id="city"]           ${plaats}
    Type Text    //input[@id="postcode"]       ${postcode}
    Type Text    //input[@id="houseNumber"]    ${huisnummer}
    Type Text    //input[@id='houseNumberSuffix']    ${huisnummertoevoeging}

# Section: Building Keywords
Soort Bouw
    [Arguments]    ${soortbouw}
    [Documentation]    Selecteert het type bouw.
    Get Text    //h2[normalize-space()="Om welk type bouw gaat het?"]    ==    Om welk type bouw gaat het?
    Click    //label[normalize-space()="${soortbouw}"]

# Section: Purpose Keywords
Doel
    [Arguments]    ${doel}
    [Documentation]    Selecteert het doel van de taxatie.
    Get Text    //h2[normalize-space()="Doel van taxatie"]    ==    Doel van taxatie
    Run Keyword If    '${doel}' == 'Financiering'    Click    //label[normalize-space()="Een lening krijgen of aanpassen (financiering)"]
    ...    ELSE IF    '${doel}' == 'Aankoopbeslissing'    Click    //label[normalize-space()="U wilt de woning kopen (aankoopbeslissing)"]
    ...    ELSE IF    '${doel}' == 'Gedwongen Verkoop'    Click    //label[contains(text(),"De woning gedwongen verkopen (in opdracht van een afdeling Bijzonder Beheer)")]
    ...    ELSE IF    '${doel}' == 'Een Andere Reden'    Click    //label[contains(text(),"Een andere reden, namelijk (bijvoorbeeld voor een boedelscheiding of een vereffening van een erfenis")]
    ...    ELSE    Fail    "Invalid doel value: ${doel}"

Klik Ja Of Nee
    [Arguments]    ${waarde}    ${index}
    [Documentation]    Klikt op de knop "Ja" of "Nee" op basis van de opgegeven waarde en index.
    Click    (//label[normalize-space()='${waarde}'])[${index}]

Verbouwing opvoeren
    Type Text    //textarea[@id='isRenovationDescription']    Badkamer
    Get Text    //a[normalize-space()='Uniforme verbouwingsspecificatie']    ==    Uniforme verbouwingsspecificatie
    Get Text    //a[normalize-space()='Toelichting uniforme verbouwingsspecificatie']    ==    Toelichting uniforme verbouwingsspecificatie

Tussenpersoon
    Get Text    //h2[normalize-space()="Tussenpersoon"]     ==       Tussenpersoon

Klik Ja Of Nee Tussenpersoon
    [Arguments]    ${waarde}
    [Documentation]    Klikt op de knop "Ja" of "Nee" voor de tussenpersoon op basis van de opgegeven waarde.
    Click    //label[normalize-space()="${waarde}"]

Woningcorporatie
    Get Text    //h2[normalize-space()="Woningcorporatie"]    ==        Woningcorporatie
       
Opvoeren Tekst Combobox
    [Arguments]   ${comboboxtekst}    
    Type Text    css=[id^="headlessui-combobox-input-:"]    ${comboboxtekst}

Bevestig Keuze Combobox
    Click    css=[id^="headlessui-combobox-option-:"]

Taxateur Identificatie
    Get Text    //div[@class="nwwi-rounded nwwi-p-5 nwwi-bg-cta-blue-200"]    ==    Omdat u niet hoeft in te loggen voor het aanvragen van een taxatie, dient u hier tijdelijk uw eigen bedrijfsnaam te selecteren.

Opdrachtverstrekker Opvoeren
    Get Text    //label[normalize-space()="Selecteer uw eigen bedrijf"]    ==    Selecteer uw eigen bedrijf

Geldverstrekker Opvoeren
    Get Text    //label[normalize-space()="Selecteer een geldverstrekker"]    ==    Selecteer een geldverstrekker

Kies Type Opdrachtgever         #default is Consument
    [Arguments]      ${opdrachtgevertype}
    Get Text    //label[normalize-space()="Type opdrachtgever"]    ==    Type opdrachtgever
    Click    //label[normalize-space()="${opdrachtgevertype}"]

Opvoeren Organisatie         
    [Arguments]      ${companyName}        ${kvkNumber}
    Type Text    //input[@id='clients.0.companyName']       ${companyName}
    Type Text    //input[@id='clients.0.kvkNumber']          ${kvkNumber}

Opdrachtgever een Opvoeren
    #Wait For Condition  Url  should end with     https://aanvraag.acc.nwwi.nl/taxateur/taxatie/opdrachtgever
    [Arguments]      ${geslacht}    ${initialen}    ${tussenvoegsel}    ${achternaam}
    Click   //label[normalize-space()="${geslacht}"]
    Type Text    //input[@id="clients.0.initials"]    ${initialen}
    Type Text    //input[@id="clients.0.familyAffix"]    ${tussenvoegsel}
    Type Text    //input[@id="clients.0.surname"]    ${achternaam}
    
Adresgegevens Provadie1  
    [Arguments]    ${emailopdrachtgever1}      
    Click    //span[normalize-space()="Adres te taxeren object overnemen"]
    Hover    //label[normalize-space()="E-mailadres"]
    ${my_random_digits} =  Generate Random Digits
    Type Text    //input[@id="clients.0.email"]                ${emailopdrachtgever1}
    Get Text    //p[@id='clients.0.email-error']    ==    Deze e-maildomeinnaam is niet toegestaan. Gebruik een ander e-mailadres.
    Type Text    //input[@id="clients.0.telephoneNumber"]      ${my_random_digits}

Openklikken Opdrachtgever Twee
    Click    (//*[name()='svg'][@class='lucide lucide-square-plus'])[1]

Opdrachtgever Twee Opvoeren
    #Wait For Condition  Url  should end with     https://aanvraag.acc.nwwi.nl/taxateur/taxatie/opdrachtgever
    #Get Text    //label[normalize-space()="Type opdrachtgever"]    ==    Type opdrachtgever
    [Arguments]      ${geslacht2}    ${initialen2}    ${tussenvoegsel2}    ${achternaam2}
    Click    (//label[contains(text(),'${geslacht2}')])[2]
    #Click   (//label[@class='nwwi-mb-2 nwwi-block nwwi-text-base nwwi-font-bold nwwi-leading-tight nwwi-text-russianViolet nwwi-ml-2 !nwwi-mb-0 nwwi-block nwwi-font-normal nwwi-cursor-pointer nwwi-text-russianViolet'][normalize-space()='${geslacht2}'])[2]
    Type Text    (//input[@id='clients.1.initials'])[1]    ${initialen2}
    Type Text    (//input[@id='clients.1.familyAffix'])[1]    ${tussenvoegsel2}
    Type Text    (//input[@id='clients.1.surname'])[1]    ${achternaam2}

Adresgegevens Provadie2  
    [Arguments]    ${emailopdrachtgever2}      
    Click    (//span[@class='nwwi-inline-flex nwwi-items-center'][normalize-space()='Adres te taxeren object overnemen'])[2]
    Hover    //label[@for="clients.1.email"]
    ${my_random_digits} =  Generate Random Digits
    Type Text    (//input[@id='clients.1.email'])[1]                ${emailopdrachtgever2}
    Get Text    //p[@id='clients.1.email-error']    ==    Deze e-maildomeinnaam is niet toegestaan. Gebruik een ander e-mailadres.
    Type Text    (//input[@id='clients.1.telephoneNumber'])[1]      ${my_random_digits}

Adresgegevens 1  
    [Arguments]    ${emailopdrachtgever1}      
    Click    //span[normalize-space()="Adres te taxeren object overnemen"]
    Hover    //label[normalize-space()="E-mailadres"]
    ${my_random_digits} =  Generate Random Digits
    Type Text    //input[@id="clients.0.email"]                ${emailopdrachtgever1}
    Type Text    //input[@id="clients.0.telephoneNumber"]      ${my_random_digits}

Adresgegevens 2  
    [Arguments]    ${emailopdrachtgever2}      
    Click    (//span[@class='nwwi-inline-flex nwwi-items-center'][normalize-space()='Adres te taxeren object overnemen'])[2]
    Hover    //label[@for="clients.1.email"]
    ${my_random_digits} =  Generate Random Digits
    Type Text    (//input[@id='clients.1.email'])[1]                ${emailopdrachtgever2}
    Type Text    (//input[@id='clients.1.telephoneNumber'])[1]      ${my_random_digits}

Opdrachtgever Relatie
    Get Text    //h3[normalize-space()="Gegevens contactpersoon"]    ==        Gegevens contactpersoon

Opdrachtvoorwaarden Vullen
    [Arguments]      ${referentietekst}      ${huidig_gebruik}     ${toekomstig_gebruik}
    ${my_random_string} =  Generate Random String
    Type Text    //input[@id="referenceRequest"]           ${referentietekst} ${my_random_string}        
    Click    //label[contains(text(),"${huidig_gebruik}")]
    Click    //label[contains(text(),"${toekomstig_gebruik}")]

Opdrachtvoorwaarden Vullen Anders
    [Arguments]      ${referentietekst}      ${huidig_gebruik}     ${toekomstig_gebruik}    ${futureSituationExplanation}     
    ${my_random_string} =  Generate Random String
    Type Text    //input[@id="referenceRequest"]           ${referentietekst} ${my_random_string}        
    Click    //label[contains(text(),"${huidig_gebruik}")]
    Click    //label[contains(text(),"${toekomstig_gebruik}")]
    Type Text    //textarea[@id="futureSituationExplanation"]     ${futureSituationExplanation}

Huurovereenkomst
    [Arguments]        ${huurovereenkomst}        
    Click    //label[normalize-space()="${huurovereenkomst}"]

Selecteer Waardepeildatum     
    [Arguments]     ${Waardepeildatum}
    Type Text    //input[@placeholder="Selecteer een datum"]        ${Waardepeildatum}

Opdrachtvoorwaarden Aanvulling Bureauwaardering
    [Arguments]    ${woningtype}        ${perceel-janee}        
    Type Text    css=[id^="headlessui-combobox-input-:"]        ${woningtype}        #tussenwoning    #woningtype aanklikken in combobox
    Hover    css=[id^="headlessui-combobox-option-:"]
    Click    css=[id^="headlessui-combobox-option-:"] 
    Click    //label[normalize-space()="${perceel-janee}"]        
   
Gevraagd Hypotheekbedrag
   [Arguments]        ${requestedMortgageAmount}
    Type Text    //input[@id="requestedMortgageAmount"]        ${requestedMortgageAmount}


Vullen Opdrachtvoorwaarden Vervolg    
    [Arguments]       ${Specifiek_afspraken}      
    Type Text    //textarea[@id="additionalAppointments"]     ${Specifiek_afspraken} 

Opdrachtvoorwaarden Vervolg Bureauwaardering
    Wait For Condition  Url  should end with     https://aanvraag.acc.nwwi.nl/taxateur/taxatie/opdrachtvoorwaarden-vervolg
    Get Text    //h2[normalize-space()="Opdrachtvoorwaarden (vervolg)"]    ==    Opdrachtvoorwaarden (vervolg)

Opdrachtvoorwaarden Vervolg Bemiddelingskosten
    Get Text    //label[normalize-space()="Bemiddelingskosten:"]    ==       Bemiddelingskosten: 
    Get Text    //small[@class="text-slateGray"]    ==    Vul de met de taxateur afgesproken bemiddelingskosten voor de taxatie in of vul '0' in indien u hiervoor geen bemiddelingskosten in rekening brengt bij de taxateur.
    [Arguments]        ${costMediation}
    Type Text    //input[@name="costMediation"]    ${costMediation}

Opdrachtvoorwaarden Vervolg Kosten 
    [Arguments]        ${costAppraiser}        ${costOther}
    Type Text    //input[contains(@name,"costAppraiser")]    ${costAppraiser}
    Type Text    //input[@name="costOther"]    ${costOther}

Taxateur Opvoeren Preselect
    [Arguments]        ${taxatiebedrijf}  
    Click    //label[normalize-space()='${taxatiebedrijf}']

Taxateur Opvoeren Lokaal
    Get Text    //p[contains(text(),"Indien het taxatiebedrijf van uw voorkeur hier niet is vermeld, heeft dat één van de volgende redenen:")]    ==    Indien het taxatiebedrijf van uw voorkeur hier niet is vermeld, heeft dat één van de volgende redenen:
    Get Text    //li[contains(text(),"Er is geen enkele taxateur van dit bedrijf aangesloten bij het NWWI")]    ==    Er is geen enkele taxateur van dit bedrijf aangesloten bij het NWWI
    Get Text     //li[contains(text(),"Er is wel een taxateur via dit bedrijf aangesloten, maar deze mag het betreffende object niet voor de gekozen geldverstrekker taxeren.")]    ==    Er is wel een taxateur via dit bedrijf aangesloten, maar deze mag het betreffende object niet voor de gekozen geldverstrekker taxeren.
    Get Text    //li[contains(text(),"Alle bij het NWWI aangesloten taxateurs van dit taxatiebedrijf hebben aangegeven niet aanwezig te zijn.")]    ==    Alle bij het NWWI aangesloten taxateurs van dit taxatiebedrijf hebben aangegeven niet aanwezig te zijn.
    Click    (//label[contains(text(),'Ik wil lokaal zoeken naar een taxatiebedrijf in de buurt van het te taxeren object.')])[1]

Taxateur Opvoeren Heel Nederland
    Get Text    //p[contains(text(),"Indien het taxatiebedrijf van uw voorkeur hier niet is vermeld, heeft dat één van de volgende redenen:")]    ==    Indien het taxatiebedrijf van uw voorkeur hier niet is vermeld, heeft dat één van de volgende redenen:
    Get Text    //li[contains(text(),"Er is geen enkele taxateur van dit bedrijf aangesloten bij het NWWI")]    ==    Er is geen enkele taxateur van dit bedrijf aangesloten bij het NWWI
    Get Text     //li[contains(text(),"Er is wel een taxateur via dit bedrijf aangesloten, maar deze mag het betreffende object niet voor de gekozen geldverstrekker taxeren.")]    ==    Er is wel een taxateur via dit bedrijf aangesloten, maar deze mag het betreffende object niet voor de gekozen geldverstrekker taxeren.
    Get Text    //li[contains(text(),"Alle bij het NWWI aangesloten taxateurs van dit taxatiebedrijf hebben aangegeven niet aanwezig te zijn.")]    ==    Alle bij het NWWI aangesloten taxateurs van dit taxatiebedrijf hebben aangegeven niet aanwezig te zijn.
    Click    //label[contains(text(),'Ik wil in heel Nederland zoeken naar een taxatiebedrijf.')]

Overslaan Doe Ik In Taxatieweb 
     Click    //label[normalize-space()="Overslaan, dit doe ik in Taxatieweb"]

Overzicht Aanvraag    
    Get Text    //h5[normalize-space()="Adresgegevens object"]    ==    Adresgegevens object
    Get Text    (//h5[@class='nwwi-text-russianViolet'][contains(text(),'Gegevens')])[1]       ==    Gegevens opdrachtgever
    Get Text    //h5[normalize-space()="Gegevens taxatiebedrijf"]    ==    Gegevens taxatiebedrijf
Overzicht Aanvraag Doel Taxatie
    Get Text    //h5[normalize-space()='Bijzonderheden']    ==    Bijzonderheden
    Get Text    //div[normalize-space()='Doel Taxatie']    ==    Doel Taxatie
    Get Text    //div[normalize-space()='U wilt een lening krijgen of aanpassen (financiering)']    ==    U wilt een lening krijgen of aanpassen (financiering)

Overzicht Aanvraag Nieuwbouw
    Get Text    //div[normalize-space()='Is er sprake van (nog niet opgeleverde) nieuwbouw?']    ==    Is er sprake van (nog niet opgeleverde) nieuwbouw?
    Get Text    (//div[@class='nwwi-break-words nwwi-text-base nwwi-text-russianViolet'][normalize-space()='Ja'])[2]    ==    Ja
    Get Text    //div[normalize-space()='Marktwaarde na bouw van de woning taxeren']    ==    Marktwaarde na bouw van de woning taxeren

# Section: Submission Keywords
Akkoord Voorwaarden
    [Arguments]    ${accepteer_voorwaarden}
    [Documentation]    Accepteert de voorwaarden.
    Scroll To Element    //label[@for="acceptAgreement"]
    Click    (//label[@for='${accepteer_voorwaarden}'])[1]

Bedankt
    [Documentation]    Controleert de "Bedankt" pagina.
    Get Text    //h1[normalize-space()="Bedankt voor uw aanvraag"]    ==    Bedankt voor uw aanvraag
    ${attr}=    Get Text    //h2[contains(text(),"Uw aanvraagnummer is:")]
    Log     ${attr}

Bedankt Bureauwaardering        
    Wait For Condition  Url  should end with       https://aanvraag.acc.nwwi.nl/taxateur/taxatie/bedankt
    Get Text      //h1[normalize-space()="Bedankt voor uw aanvraag"]        ==        Bedankt voor uw aanvraag
