# PSPathfinder

[![GitHub last commit][github-commit-badge]][github-PSPathfinder]
[![GitHub release (latest by date)][github-release-badge]][github-PSPathfinder]
[![PowerShell Gallery Version][psgallery-v-badge]][powershell-gallery]
[![PS Gallery][psgallery-dl-badge]][powershell-gallery]
[![GitHub stars][github-start-badge]][github-PSPathfinder]

## Table of contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Getting Started](#getting-started)
- [Documentation](#documentation)
- [Maintainer](#maintainer)
- [License](#license)

## Overview

**PSPathfinder** is a powershell module that makes use of the REST API of Pathfinder by [**Tripunkt**](https://www.tripunkt.de).

## Prerequisites

|OS|min. PS Version (Edition)|
|-|-|
|Windows|5.1 (Desktop)\*|
|Windows|7 (Core)\*|
|Linux|7 (Core)\*|
|MacOS|7 (Core)|

\* tested

## Quickstart

### Installation

If you have the [PowerShellGet](https://github.com/powershell/powershellget) module installed you can enter the following command:

```powershell
C:\> Install-Module -Name PSPathfinder
```

Alternatively you can download a ZIP file of the latest version from our [Releases](https://github.com/falkheiland/PSPathfinder/releases) page.

### Basic usage

Import Module:

```powershell
C:\> Import-Module -Name PSPathfinder
```

Call a Function - e.g. get name, description and id of all components with the name beginning with "SRV":

```powershell
C:\> Get-PFComponent -Computername Pathfinder -Credential (Get-Credential) -Filter "Name _= SRV" 
| Select-Object -Property Name, Description, Id

Name                 Description                    Id
----                 -----------                    --
SRV-AV-L-01          AntiVirus Server 01            177000
SRV-AV-L-02          AntiVirus Server 02            109000
SRV-DC-L-01          DomainController 01            114000
```

## Documentation

- [Scripting with PSPathfinder](/Docs/Guides/Scripting-with-PSPathfinder.md)
  - [Installation](/Docs/Guides/Scripting-with-PSPathfinder.md#installation)
  - [Setup](/Docs/Guides/Scripting-with-PSPathfinder.md#setup)
  - [Configuration](/Docs/Guides/Scripting-with-PSPathfinder.md#configuration)
  - [Authentication](/Docs/Guides/Scripting-with-PSPathfinder.md#authentication)
  - [Creating a script](/Docs/Guides/Scripting-with-PSPathfinder.md#creating-a-script)
- Functions
  - [Get-PFBuilding](/Docs/Reference/Get-PFBuilding.md)
  - [Get-PFCommonTag](/Docs/Reference/Get-PFCommonTag.md)
  - [Get-PFComponent](/Docs/Reference/Get-PFComponent.md)
  - [Get-PFFLoor](/Docs/Reference/Get-PFFloor.md)
  - [Get-PFLocation](/Docs/Reference/Get-PFLocation.md)
  - [Get-PFPhoneTag](/Docs/Reference/Get-PFPhoneTag.md)
  - [Get-PFPort](/Docs/Reference/Get-PFPort.md)
  - [Get-PFRoom](/Docs/Reference/Get-PFRoom.md)
  - [Get-PFRootGroup](/Docs/Reference/Get-PFRootGroup.md)
  - [Get-PFServiceTag](/Docs/Reference/Get-PFServiceTag.md)
  - [Get-PFTagGroup](/Docs/Reference/Get-PFTagGroup.md)
  - [Get-PFVlan](/Docs/Reference/Get-PFVlan.md)
  - [Update-PFComponent](/Docs/Reference/Update-PFComponent.md)

- [Changelog](CHANGELOG.md)

## Maintainer

- Falk Heiland
[![https://github.com/falkheiland][github-fh-badge]][github-fh]
[![http://twitter.com/falkheiland][twitter-fh-badge]][twitter-fh]

## License

This project is [licensed under the MIT License](LICENSE).

[![MIT licensed][mit-badge]][mit-license]

[psgallery-dl-badge]: https://img.shields.io/powershellgallery/dt/PSPathfinder.svg?logo=powershell
[powershell-gallery]: https://www.powershellgallery.com/packages/PSPathfinder/
[mit-badge]: https://img.shields.io/github/license/falkheiland/PSPathfinder?logo=github
[mit-license]: LICENSE
[github-commit-badge]: https://img.shields.io/github/last-commit/falkheiland/PSPathfinder?logo=github
[github-PSPathfinder]: https://github.com/falkheiland/PSPathfinder
[github-release-badge]: https://img.shields.io/github/release/falkheiland/PSPathfinder/all.svg?logo=github
[psgallery-v-badge]: https://img.shields.io/powershellgallery/v/PSPathfinder?include_prereleases&logo=powershell
[github-start-badge]: https://img.shields.io/github/stars/falkheiland/PSPathfinder?logo=github
[github-fh-badge]: https://img.shields.io/badge/Github-falkheiland-green?logo=github
[github-fh]: https://github.com/falkheiland
[twitter-fh-badge]: https://img.shields.io/badge/Twitter-falkheiland-blue?logo=twitter
[twitter-fh]: https://twitter.com/falkheiland
