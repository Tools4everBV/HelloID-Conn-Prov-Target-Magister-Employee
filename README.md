
# HelloID-Conn-Prov-Target-MagisterEmployee

> [!IMPORTANT]
> This repository contains the connector and configuration code only. The implementer is responsible to acquire the connection details such as username, password, certificate, etc. You might even need to sign a contract or agreement with the supplier before implementing this connector. Please contact the client's application manager to coordinate the connector requirements.

> [!WARNING]
> Note that this connector is __a work in progress__ and therefore __not ready to use__ in your production environment.

> [!TIP]
> Please contact your local Tools4ever sales representative for further information and details about the implementation of this connector.


<p align="center">
  <img src="https://www.magister.nl/wp-content/themes/magister/assets/images/logo-fc.svg">
</p>

## Table of contents

- [HelloID-Conn-Prov-Target-MagisterEmployee](#helloid-conn-prov-target-magisteremployee)
  - [Table of contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Getting started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Provisioning PowerShell V2 connector](#provisioning-powershell-v2-connector)
      - [Field mapping](#field-mapping)
        - [Complex mapping](#complex-mapping)
          - [FamilyName](#familyname)
          - [Mail](#mail)
    - [Connection settings](#connection-settings)
    - [Prerequisites](#prerequisites-1)
    - [Remarks](#remarks)
      - [GET calls not available](#get-calls-not-available)
      - [`UpdateMedewerker` must contain _all_ available properties.](#updatemedewerker-must-contain-all-available-properties)
      - [No API response for `UpdateMedewerker`](#no-api-response-for-updatemedewerker)
      - [Error handling](#error-handling)
  - [Getting help](#getting-help)
  - [HelloID docs](#helloid-docs)

## Introduction

_HelloID-Conn-Prov-Target-MagisterEmployee_ is a _target_ connector. _MagisterEmployee_ provides a set of SOAP API's that allow you to programmatically interact with its data. The HelloID connector uses the API endpoints listed in the table below.

| Endpoint   | Description                                                                                       |
| ---------- | ------------------------------------------------------------------------------------------------- |
| /Algemeen  | SOAP API for authentication on the Magister API's.                                                |
| /Personeel | SOAP API for creating and updating _employees_. In the Netherlands referred to as: _medewerkers_. |

The following lifecycle actions are available:

| Action             | Description                           |
| ------------------ | ------------------------------------- |
| create.ps1         | PowerShell _create_ lifecycle action  |
| delete.ps1        | PowerShell _delete_ lifecycle action  |
| update.ps1         | PowerShell _update_ lifecycle action  |
| configuration.json | Default _configuration.json_          |

## Getting started

### Prerequisites

- [ ] Your outgoing IP address must be whitelisted by _Iddink_.

### Provisioning PowerShell V2 connector

##### Complex mapping

> [!IMPORTANT]
> Make sure to toggle `Use account data from other systems` on the `Account` tab and select `Active Directory`.

###### FamilyName

```javascript
function updatePersonSurnameToConvention(personObject) {
    let surname;

    switch (personObject.Name.Convention) {
        case 'B':
            surname = `${personObject.Name.FamilyName}`;
            if (personObject.Name.FamilyNamePrefix) {
                surname += `, ${personObject.Name.FamilyNamePrefix}`;
            }
            break;
        case 'BP':
            surname = `${personObject.Name.FamilyName} - ${personObject.Name.FamilyNamePartnerPrefix} ${personObject.Name.FamilyNamePartner}`;
            if (personObject.Name.FamilyNamePrefix) {
                surname += `, ${personObject.Name.FamilyNamePrefix}`;
            }
            break;
        case 'P':
            surname = `${personObject.Name.FamilyNamePartner}`;
            if (personObject.Name.FamilyNamePartnerPrefix) {
                surname += `, ${personObject.Name.FamilyNamePartnerPrefix}`;
            }
            break;
        case 'PB':
            surname = `${personObject.Name.FamilyNamePartner} - ${personObject.Name.FamilyNamePrefix} ${personObject.Name.FamilyName}`;
            if (personObject.Name.FamilyNamePartnerPrefix) {
                surname += `, ${personObject.Name.FamilyNamePartnerPrefix}`;
            }
            break;
        default:
            surname = `${personObject.Name.FamilyName}`;
            if (personObject.Name.FamilyNamePrefix) {
                surname += `, ${personObject.Name.FamilyNamePrefix}`;
            }
            break;
    }

    return surname;
}

updatePersonSurnameToConvention(Person);
```

###### Mail

```javascript
function getActiveDirectoryEmailAddress(personObject){
  return personObject.Accounts.MicrosoftActiveDirectory.mail
}
getActiveDirectoryEmailAddress(Person);
```

### Connection settings

The following settings are required to connect to the API.

| Setting  | Description                        | Mandatory |
| -------- | ---------------------------------- | --------- |
| UserName | The UserName to connect to the API | Yes       |
| Password | The Password to connect to the API | Yes       |
| BaseUrl  | The URL to the API                 | Yes       |

### Prerequisites

### Remarks

#### GET calls not available

Magister does not provide _GET_ calls in order to retrieve employees. The immediate side-effects are:

- Account correlation not possible.
- The _update_ lifecycle action always overwrites data within _Magister_. It is therefore not possible to make changes to an _employee_ within _Magister_.

> [!TIP]
> It is possible to create a custom _decibel_ query to retrieve employee data. These queries however are custom made and therefore, not part of this connector.

#### `UpdateMedewerker` must contain _all_ available properties.

The `UpdateMedewerker` SOAP action must always contain all available properties. Properties not specified will be set to an __empty__ value within Magister.

> [!CAUTION]
> Because both the _enable_ and _disable_ lifecycle actions use the same SOAP action `updateMedewerker`, execution of either will result in the update of _all_ properties.

#### No API response for `UpdateMedewerker`

Apart from a _200OK_, no response is being returned by the API. Since there are no _GET_ calls, it's also not possible to verify if the account is created or updated.

#### Error handling

_Magister_ provides little to no error messages. This also means that; error handling within the connector is very limited.

## Getting help

> [!TIP]
>  _For more information on how to configure a HelloID PowerShell connector, please refer to our [documentation](https://docs.helloid.com/en/provisioning/target-systems/powershell-v2-target-systems.html) pages_.

> [!TIP]
>  _If you need help, feel free to ask questions on our [forum](https://forum.helloid.com)_.

## HelloID docs

The official HelloID documentation can be found at: https://docs.helloid.com/
