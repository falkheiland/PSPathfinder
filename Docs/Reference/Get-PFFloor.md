---
external help file: PSPathfinder-help.xml
Module Name: PSPathfinder
online version: https://github.com/falkheiland/PSPathfinder/blob/main/Docs/Reference/Get-PFFloor.md
schema: 2.0.0
---

# Get-PFFloor

## SYNOPSIS
Gets information on floors.

## SYNTAX

### Get (Default)
```
Get-PFFloor [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>] [[-Sort] <String>]
 [<CommonParameters>]
```

### Rooms
```
Get-PFFloor [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [-Id] <Int32> [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>]
 [[-Sort] <String>] [-Rooms] [<CommonParameters>]
```

### Id
```
Get-PFFloor [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [-Id] <Int32> [<CommonParameters>]
```

## DESCRIPTION
Gets information on floors.

## EXAMPLES

### Example 1
```powershell
Get-PFFloor -Computername $CN -Credential $Cred -Filter 'Name == 1OG'
```

Gets information on floors with the name "1OG".

### Example 2
```powershell
Get-PFFloor -Computername $CN -Credential $Cred -Id 10000
```

Gets information on the floor with the Id 10000.

### Example 3
```powershell
Get-PFFloor -Computername $CN -Credential $Cred -Id 10000 -Rooms -Filter 'Number _= 110'
```

Gets information on the rooms with numbers beginning with "110" of the floor with the Id 10000.

### Example 4
```powershell
Get-PFFloor -Computername $CN -Credential $Cred -Filter 'Name == 1OG' |
  Get-PFFloor -Rooms | Select-Object -Property Number
```

Gets numbers of rooms of floors with names "1OG".

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
Parameter Sets: Get, Rooms
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Id of the floor

```yaml
Type: Int32
Parameter Sets: Rooms, Id
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
Parameter Sets: Get, Rooms
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
Parameter Sets: Get, Rooms
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Rooms
Switch to get room information

```yaml
Type: SwitchParameter
Parameter Sets: Rooms
Aliases:

Required: True
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sort
Sorting for the API request

```yaml
Type: String
Parameter Sets: Get, Rooms
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
