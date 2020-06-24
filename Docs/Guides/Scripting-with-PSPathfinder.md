# Scripting with PSPathfinder

## Table of contents

- [Installation](#installation)
- [Setup](#setup)
- [Configuration](#configuration)
- [Authentication](#authentication)
- [Creating a script](#creating-a-script)

## Installation

There are several ways to install PSPathfinder:

### Powershell Gallery

```powershell
C:\> Install-Module -Name PSPathfinder -Repository PSGallery
```

### Github Repository

#### Clone

Use your favorite Git client (e.g. git, Github Desktop etc.) to clone the PSPathfinder repository via HTTPS `https://github.com/falkheiland/PSPathfinder.git`

#### Release

Download and extract the latest [release](https://github.com/falkheiland/PSPathfinder/releases).

## Setup

### Import the module

Powershell needs to import the PSPathfinder module. This is done automatically if it resides within one of the Powershell Module Paths:

```powershell
C:\> [Environment]::GetEnvironmentVariable('PSModulePath') -split ';'
```

If you installed it by using the [PSGallery](#powershell-gallery) it will be located in one of the above paths. If it is not, you have to import the Module:

```powershell
C:\> Import-Module -FullyQualifiedName C:\Path\to\PSPathfinder.psd1
```

## Configuration

If you want to script with PSPathfinder, you will use parameters like `Computername` multiple times. To avoid unnecessary repetitions you can set Default Parameter Values (example):

```powershell
C:\> $PSDefaultParameterValues = @{
      '*-PF*:Computername' = 'pathfinderserver' # Name or IP address of the Pathfinder server
}
```

## Authentication

The Pathfinder API can be used with basic authentication (username and password). The `Credential` parameter is a mandatory parameter in all functions and uses a credential object. You can provide it interactively via:

```powershell
$Credential = Get-Credential
```

For the use in an unattended or repeated script you want to automatically add your credentials.

Within Windows you can store your credential in a secure way by using:

```powershell
C:\> Get-Credential | Export-Clixml -Path ('C:\Path\To\Your.cred')
```

**Warning:** This method does not create an encrypted file within Linux / MacOS.

Finally we import and add the saved credential to the Default Parameter Values as well:

```powershell
C:\> $PSDefaultParameterValues = @{
      '*-PF*:Computername' = 'pathfinderserver' # Name or IP address of the Pathfinder server
      '*-PF*:Credential'   = Import-Clixml -Path 'C:\Path\To\Your.cred'
     }
```

## Creating a script

Let's say we want to tag all our servers with the naming scheme "SRV-DC*" with a (common) tag "Domaincontroller".

We start by finding our servers by name:

```powershell
C:\> $ComponentColl = Get-PFComponent -Filter 'Name _= SRV-DC'
C:\> $ComponentColl

Name                      : SRV-DC-L-01
SlotPosition              : 0,0
LeftOffsetMM              : 0,0
BayPosition               : 0
TVLeft                    : 0,0
TVTop                     : 0,0
TVWidth                   : 0,0
TVHeight                  : 0,0
TVColor                   : 0
LayerNumber               : 0
ReverseMounting           : False
....
```

Now we are looking for the ID of the Tag to apply:

```powershell
C:\> $TagId = (Get-PFCommonTag -Filter 'Name == Domaincontroller').Id
C:\> $TagId

10800
```

Now we update the components with the tag:

```powershell
$ComponentColl | Update-PFComponent -CommonTagId $DCTag

Method     Id Type      TypeId
------     -- ----      ------
Put    126000 CommonTag 108000
Put    126002 CommonTag 108000
Put    176017 CommonTag 108000
```

- The complete script:

```powershell
$PSDefaultParameterValues = @{
  '*-PF*:Computername' = 'pathfinderserver' # Name or IP address of the Pathfinder server
  '*-PF*:Credential'   = Import-Clixml -Path 'C:\Path\To\Your.cred'
}

$DCTag = (Get-PFCommonTag -Filter 'Name == Domaincontroller').Id
Get-PFComponent -Filter 'Name _= SRV-DC' | Update-PFComponent -CommonTagId $DCTag
```
