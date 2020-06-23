---
external help file: PSPathfinder-help.xml
Module Name: PSPathfinder
online version:
schema: 2.0.0
---

# Get-PFBuilding

## SYNOPSIS
Gets information on a building.

## SYNTAX

### Get (Default)
```
Get-PFBuilding [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>] [[-Sort] <String>]
 [<CommonParameters>]
```

### Floors
```
Get-PFBuilding [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Id] <Int32>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>]
 [[-Sort] <String>] [-Floors] [<CommonParameters>]
```

### Id
```
Get-PFBuilding [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Id] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Gets information on a building.

## EXAMPLES

### Example 1
```powershell
Get-PFBuilding -Computername $CN -Credential $Cred -Filter 'Name _= Building'
```

Gets information on buildings with the name beginning with "Building".

### Example 2
```powershell
Get-PFBuilding -Computername $CN -Credential $Cred -Id 10000
```

Gets information on the building with the ID 10000.

### Example 3
```powershell
Get-PFBuilding -Computername $CN -Credential $Cred -Id 10000 -Floors |
  Select-Object -Property Name
```

Gets names of the floors in the building with the ID 10000.


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
Parameter Sets: Get, Floors
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Floors
Switch to get floor information

```yaml
Type: SwitchParameter
Parameter Sets: Floors
Aliases:

Required: True
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Id of the building

```yaml
Type: Int32
Parameter Sets: Floors, Id
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Page
Pagination Number of Pages for the API request

```yaml
Type: Int32
Parameter Sets: Get, Floors
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
Parameter Sets: Get, Floors
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
Parameter Sets: Get, Floors
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
