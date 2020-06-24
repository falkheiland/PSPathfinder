---
external help file: PSPathfinder-help.xml
Module Name: PSPathfinder
online version: https://github.com/falkheiland/PSPathfinder/blob/main/Docs/Reference/Get-PFServiceTag.md
schema: 2.0.0
---

# Get-PFServiceTag

## SYNOPSIS
Gets information on service tags.

## SYNTAX

### Get (Default)
```
Get-PFServiceTag [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>] [[-Sort] <String>]
 [<CommonParameters>]
```

### Id
```
Get-PFServiceTag [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Id] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Gets information on service tags.

## EXAMPLES

### Example 1
```powershell
Get-PFServiceTag -Computername $CN -Credential $Cred
```

Gets information on service tags.

### Example 2
```powershell
Get-PFServiceTag -Computername $CN -Credential $Cred -Id 10000
```

Gets information on the service tag with the Id 10000.

### Example 3
```powershell
10000, 20000 | Get-PFServiceTag -Computername $CN -Credential $Cred
```

Gets information on the service tags with the Id 10000 and 20000.

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
Parameter Sets: Get
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Id of the service tag

```yaml
Type: Int32
Parameter Sets: Id
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Page
Pagination Number of Pages for the API request

```yaml
Type: Int32
Parameter Sets: Get
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
Parameter Sets: Get
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
Parameter Sets: Get
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
