##################################################
# HelloID-Conn-Prov-Target-Magister-Employee-Delete
# PowerShell V2
# Version: 1.0.0
##################################################

# Enable TLS1.2
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12

#region functions
function Resolve-MagisterEmployeeToken {
    [CmdletBinding()]
    param (
    )

    try {
        $xml = [xml]('<?xml version="1.0" encoding="utf-8"?>
        <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
            xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tns="urn:MediusServer_Soap"
            xmlns:types="urn:MediusServer_Soap/encodedTypes"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <soap:Body soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
                <q1:Login xmlns:q1="urn:MediusServer_Soap-Algemeen">
                    <UserName xsi:type="xsd:string">{0}</UserName>
                    <Password xsi:type="xsd:string">{1}</Password>
                </q1:Login>
            </soap:Body>
        </soap:Envelope>' -f $($actionContext.Configuration.UserName), $($actionContext.Configuration.Password))


        $splatParams = @{
            Uri         = "$($actionContext.Configuration.BaseUrl)/soap/algemeen?service=Algemeen"
            Method      = 'POST'
            Body        = $xml
            ContentType = 'text/xml; charset=utf-8'
            Headers     = @{
                "SOAPAction" = 'urn:MediusServer_Soap-Algemeen#Login'
            }
        }
        $response = Invoke-RestMethod @splatParams
        if ($null -ne $response.Envelope.Body.LoginResponse.SessionToken.'#text') {
            Write-Output $response.Envelope.Body.LoginResponse.SessionToken.'#text'
        } elseif ($null -ne $response.Envelope.Body.LoginResponse.ResultMessage.'#text') {
            throw $response.Envelope.Body.LoginResponse.ResultMessage.'#text'
        }
    } catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
}

function Set-MagisterEmployee {
    [CmdletBinding()]
    param (
        [Parameter()]
        $SessionToken,

        [Parameter()]
        $PersoneelsNummer,

        [Parameter()]
        $Roepnaam,

        [Parameter()]
        $Geboortenaam,

        [Parameter()]
        $Geslacht,

        [Parameter()]
        $Voorletters,

        [Parameter()]
        $Voornamen,

        [Parameter()]
        $Tussenvoegsel,

        [Parameter()]
        $Achternaam,

        [Parameter()]
        $Tussenvoegsel_meisjesnaam,

        [Parameter()]
        $Meisjesnaam,

        [Parameter()]
        $GeboorteDatum,

        [Parameter()]
        $DatumOverlijden,

        [Parameter()]
        $Geboorteplaats,

        [Parameter()]
        $Geboorteland,

        [Parameter()]
        $Nationaliteit,

        [Parameter()]
        $Huis_Straat,

        [Parameter()]
        $Huis_Huisnummer,

        [Parameter()]
        $Huis_Huisnummer_toevoeging,

        [Parameter()]
        $Huis_Postcode,

        [Parameter()]
        $Huis_Woonplaats,

        [Parameter()]
        $Huis_Woonland,

        [Parameter()]
        $Post_Straat,

        [Parameter()]
        $Post_Huisnummer,

        [Parameter()]
        $Post_Huisnummer_toevoeging,

        [Parameter()]
        $Post_Postcode,

        [Parameter()]
        $Post_Woonplaats,

        [Parameter()]
        $Post_Woonland,

        [Parameter()]
        $DatumInDienst,

        [Parameter()]
        $DatumUitDienst,

        [Parameter()]
        $Telefoon_Prive,

        [Parameter()]
        $Telefoon_Prive_Mobiel,

        [Parameter()]
        $Telefoon_Werk,

        [Parameter()]
        $Email_Prive,

        [Parameter()]
        $Email_Werk,

        [Parameter()]
        $Functie
    )

    try {
        $xml = [xml]('<?xml version="1.0" encoding="utf-8"?>
        <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
            xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tns="urn:MediusServer_Soap"
            xmlns:types="urn:MediusServer_Soap/encodedTypes"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <soap:Body soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
                <q1:UpdateMedewerker xmlns:q1="urn:MediusServer_Soap-Personeel">
                    <SessionToken xsi:type="xsd:string">{0}</SessionToken>
                    <PersoneelsNummer xsi:type="xsd:int">{1}</PersoneelsNummer>
                    <Roepnaam xsi:type="xsd:string">{2}</Roepnaam>
                    <Geboortenaam xsi:type="xsd:string">{3}</Geboortenaam>
                    <Geslacht xsi:type="xsd:string">{4}</Geslacht>
                    <Voorletters xsi:type="xsd:string">{5}</Voorletters>
                    <Voornamen xsi:type="xsd:string">{6}</Voornamen>
                    <Tussenvoegsel xsi:type="xsd:string">{7}</Tussenvoegsel>
                    <Achternaam xsi:type="xsd:string">{8}</Achternaam>
                    <Tussenvoegsel_meisjesnaam xsi:type="xsd:string">{9}</Tussenvoegsel_meisjesnaam>
                    <Meisjesnaam xsi:type="xsd:string">{10}</Meisjesnaam>
                    <GeboorteDatum xsi:type="xsd:dateTime">{11}</GeboorteDatum>
                    <DatumOverlijden xsi:type="xsd:dateTime">{12}</DatumOverlijden>
                    <Geboorteplaats xsi:type="xsd:string">{13}</Geboorteplaats>
                    <Geboorteland xsi:type="xsd:string">{14}</Geboorteland>
                    <Nationaliteit xsi:type="xsd:string">{15}</Nationaliteit>
                    <Huis_Straat xsi:type="xsd:string">{16}</Huis_Straat>
                    <Huis_Huisnummer xsi:type="xsd:string">{17}</Huis_Huisnummer>
                    <Huis_Huisnummer_toevoeging xsi:type="xsd:string">{18}</Huis_Huisnummer_toevoeging>
                    <Huis_Postcode xsi:type="xsd:string">{19}</Huis_Postcode>
                    <Huis_Woonplaats xsi:type="xsd:string">{20}</Huis_Woonplaats>
                    <Huis_Woonland xsi:type="xsd:string">{21}</Huis_Woonland>
                    <Post_Straat xsi:type="xsd:string">{22}</Post_Straat>
                    <Post_Huisnummer xsi:type="xsd:string">{23}</Post_Huisnummer>
                    <Post_Huisnummer_toevoeging xsi:type="xsd:string">{24}</Post_Huisnummer_toevoeging>
                    <Post_Postcode xsi:type="xsd:string">{25}</Post_Postcode>
                    <Post_Woonplaats xsi:type="xsd:string">{26}</Post_Woonplaats>
                    <Post_Woonland xsi:type="xsd:string">{27}</Post_Woonland>
                    <DatumInDienst xsi:type="xsd:dateTime">{28}</DatumInDienst>
                    <DatumUitDienst xsi:type="xsd:dateTime">{29}</DatumUitDienst>
                    <Telefoon_Prive xsi:type="xsd:string">{30}</Telefoon_Prive>
                    <Telefoon_Prive_Mobiel xsi:type="xsd:string">{31}</Telefoon_Prive_Mobiel>
                    <Telefoon_Werk xsi:type="xsd:string">{32}</Telefoon_Werk>
                    <Email_Prive xsi:type="xsd:string">{33}</Email_Prive>
                    <Email_Werk xsi:type="xsd:string">{34}</Email_Werk>
                    <Functie xsi:type="xsd:string">{35}</Functie>
                </q1:UpdateMedewerker>
            </soap:Body>
            </soap:Envelope>' -f $SessionToken, $PersoneelsNummer, $Roepnaam, $Geboortenaam, $Geslacht, $Voorletters, $Voornamen, $Tussenvoegsel, $Achternaam, $Tussenvoegsel_meisjesnaam, $Meisjesnaam, $GeboorteDatum, $DatumOverlijden, $Geboorteplaats, $Geboorteland, $Nationaliteit, $Huis_Straat, $Huis_Huisnummer, $Huis_Huisnummer_toevoeging, $Huis_Postcode, $Huis_Woonplaats, $Huis_Woonland, $Post_Straat, $Post_Huisnummer, $Post_Huisnummer_toevoeging, $Post_Postcode, $Post_Woonplaats, $Post_Woonland, $DatumInDienst, $DatumUitDienst, $Telefoon_Prive, $Telefoon_Prive_Mobiel, $Telefoon_Werk, $Email_Prive, $Email_Werk, $Functie)

        $splatParams = @{
            Uri         = "$($actionContext.Configuration.BaseUrl)/soap/personeel?service=Personeel"
            Method      = 'POST'
            Body        = $xml
            ContentType = 'text/xml; charset=utf-8'
            Headers     = @{
                "SOAPAction" = 'urn:MediusServer_Soap-Personeel#UpdateMedewerker'
            }
        }
        Invoke-RestMethod @splatParams
    } catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
}
#endregion

try {
    # Verify if [aRef] has a value
    if ([string]::IsNullOrEmpty($($actionContext.References.Account))) {
        throw 'The account reference could not be found'
    }

    $sessionToken = Resolve-MagisterEmployeeToken

    # Add a message and the result of each of the validations showing what will happen during enforcement
    if ($actionContext.DryRun -eq $true) {
        Write-Verbose -Verbose "[DryRun] Delete Magister-Employee account: [$($actionContext.References.Account)] for person: [$($personContext.Person.DisplayName)] will be executed during enforcement"
    }

    # Process
    if (-not($actionContext.DryRun -eq $true)) {
        Write-Verbose "Disabling Magister-Employee account with accountReference: [$($actionContext.References.Account)]"

        # Make sure to test with special characters and if needed; add utf8 encoding.
        $splatParams = @{
            SessionToken               = $sessionToken
            PersoneelsNummer           = $actionContext.Data.PersoneelsNummer
            Roepnaam                   = $actionContext.Data.Roepnaam
            Geboortenaam               = $actionContext.Data.Geboortenaam
            Geslacht                   = $actionContext.Data.Geslacht
            Voorletters                = $actionContext.Data.Voorletters
            Voornamen                  = $actionContext.Data.Voornamen
            Tussenvoegsel              = $actionContext.Data.Tussenvoegsel
            Achternaam                 = $actionContext.Data.Achternaam
            Tussenvoegsel_meisjesnaam  = $actionContext.Data.Tussenvoegsel_meisjesnaam
            Meisjesnaam                = $actionContext.Data.Meisjesnaam
            GeboorteDatum              = if ($null -ne $actionContext.Data.GeboorteDatum) { (Get-Date $actionContext.Data.GeboorteDatum) } else { $null }
            DatumOverlijden            = if ($null -ne $actionContext.Data.DatumOverlijden) {(Get-Date $actionContext.Data.DatumOverlijden) } else { $null }
            Geboorteplaats             = $actionContext.Data.Geboorteplaats
            Geboorteland               = $actionContext.Data.Geboorteland
            Nationaliteit              = $actionContext.Data.Nationaliteit
            Huis_Straat                = $actionContext.Data.Huis_Straat
            Huis_Huisnummer            = $actionContext.Data.Huis_Huisnummer
            Huis_Huisnummer_toevoeging = $actionContext.Data.Huis_Huisnummer_toevoeging
            Huis_Postcode              = $actionContext.Data.Huis_Postcode
            Huis_Woonplaats            = $actionContext.Data.Huis_Woonplaats
            Huis_Woonland              = $actionContext.Data.Huis_Woonland
            Post_Straat                = $actionContext.Data.Post_Straat
            Post_Huisnummer            = $actionContext.Data.Post_Huisnummer
            Post_Huisnummer_toevoeging = $actionContext.Data.Post_Huisnummer_toevoeging
            Post_Postcode              = $actionContext.Data.Post_Postcode
            Post_Woonplaats            = $actionContext.Data.Post_Woonplaats
            Post_Woonland              = $actionContext.Data.Post_Woonland
            DatumInDienst              = if ($null -ne $actionContext.Data.DatumInDienst) {(Get-Date $actionContext.Data.DatumInDienst) } else { $null }
            DatumUitDienst             = (Get-Date)
            Telefoon_Prive             = $actionContext.Data.Telefoon_Prive
            Telefoon_Prive_Mobiel      = $actionContext.Data.Telefoon_Prive_Mobiel
            Telefoon_Werk              = $actionContext.Data.Telefoon_Werk
            Email_Prive                = $actionContext.Data.Email_Prive
            Email_Werk                 = $actionContext.Data.Email_Werk
        }
        $null = Set-MagisterEmployee @splatParams

        $outputContext.Success = $true
        $outputContext.AuditLogs.Add([PSCustomObject]@{
                Action  = 'DeleteAccount'
                Message = "Delete account was successful"
                IsError = $false
            })
    }
} catch {
    $outputContext.success = $false
    $ex = $PSItem
    $auditMessage = "Could not Delete Magister-Employee account. Error: $($ex.Exception.Message)"
    Write-Verbose "Error at Line '$($ex.InvocationInfo.ScriptLineNumber)': $($ex.InvocationInfo.Line). Error: $($ex.Exception.Message)"
    $outputContext.AuditLogs.Add([PSCustomObject]@{
            Action  = 'DeleteAccount'
            Message = $auditMessage
            IsError = $true
        })
}
