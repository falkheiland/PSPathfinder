---
external help file: PSPathfinder-help.xml
Module Name: PSPathfinder
online version: https://github.com/falkheiland/PSPathfinder/Docs/Reference/Get-PFLocation.md
schema: 2.0.0
---

# Get-PFLocation

## SYNOPSIS
Gets information on locations.

## SYNTAX

### Get (Default)
```
Get-PFLocation [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>] [[-Sort] <String>]
 [<CommonParameters>]
```

### Buildings
```
Get-PFLocation [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [-Id] <Int32> [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>]
 [[-Sort] <String>] [-Buildings] [<CommonParameters>]
```

### Id
```
Get-PFLocation [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [-Id] <Int32> [<CommonParameters>]
```

## DESCRIPTION
Gets information on locations.

## EXAMPLES

### Example 1
```powershell
Get-PFLocation -Computername $CN -Credential $Cred -Filter 'Name _= Lei'
```

Gets information on locations with a name beginning with "Lei".

### Example 2
```powershell
Get-PFLocation -Computername $CN -Credential $Cred -Id 10000
```

Gets information on the location with the Id 10000.

### Example 3
```powershell
Get-PFLocation -Computername $CN -Credential $Cred -Id 10000 -Buildings -Filter 'Name _= Mensa'
```

Gets information on buildings with names beginning with "Mensa" of the location with the Id 10000.

### Example 4
```powershell
Get-PFLocation -Computername $CN -Credential $Cred -Filter 'Name _= Lei' |
  Get-PFLocation -Buildings | Select-Object -Property Name
```

Gets names of buildings for locations with names beginning with "Lei".

## PARAMETERS

### -ApiVersion
API Version to use

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: 1.0

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Buildings
Switch to get building information

```yaml
Type: SwitchParameter
Parameter Sets: Buildings
Aliases:

Required: True
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Computername
Computername of the Pathfinder Server

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Credential for the API request

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter
Filter for the API request

```yaml
Type: String
Parameter Sets: Get, Buildings
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Id of the location

```yaml
Type: Int32
Parameter Sets: Buildings, Id
Aliases:

Required: True
Position: Benannt
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Page
Pagination Number of Pages for the API request

```yaml
Type: Int32
Parameter Sets: Get, Buildings
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PageSize
Pagination Size of Page for the API request

```yaml
Type: Int32
Parameter Sets: Get, Buildings
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sort
Sorting for the API request

```yaml
Type: String
Parameter Sets: Get, Buildings
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TCPPort
TCP Port for the API request

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Keine

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
