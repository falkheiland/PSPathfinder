---
external help file: PSPathfinder-help.xml
Module Name: PSPathfinder
online version:
schema: 2.0.0
---

# Get-PFPort

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

### Id (Default)
```
Get-PFPort [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [-Id] <Int32> [<CommonParameters>]
```

### VLANs
```
Get-PFPort [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Id] <Int32>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>]
 [[-Sort] <String>] [-VLANs] [<CommonParameters>]
```

### CommonTags
```
Get-PFPort [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Id] <Int32>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>]
 [[-Sort] <String>] [-CommonTags] [<CommonParameters>]
```

### ServiceTags
```
Get-PFPort [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Id] <Int32>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>]
 [[-Sort] <String>] [-ServiceTags] [<CommonParameters>]
```

### PhoneTags
```
Get-PFPort [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Id] <Int32>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>]
 [[-Sort] <String>] [-PhoneTags] [<CommonParameters>]
```

### NetworkPath
```
Get-PFPort [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Id] <Int32>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>]
 [[-Sort] <String>] [-NetworkPath] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

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

### -CommonTags
{{ Fill CommonTags Description }}

```yaml
Type: SwitchParameter
Parameter Sets: CommonTags
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
Parameter Sets: VLANs, CommonTags, ServiceTags, PhoneTags, NetworkPath
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
{{ Fill Id Description }}

```yaml
Type: Int32
Parameter Sets: Id
Aliases:

Required: True
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: Int32
Parameter Sets: VLANs, CommonTags, ServiceTags, PhoneTags, NetworkPath
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NetworkPath
{{ Fill NetworkPath Description }}

```yaml
Type: SwitchParameter
Parameter Sets: NetworkPath
Aliases:

Required: True
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Page
Pagination Number of Pages for the API request

```yaml
Type: Int32
Parameter Sets: VLANs, CommonTags, ServiceTags, PhoneTags, NetworkPath
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
Parameter Sets: VLANs, CommonTags, ServiceTags, PhoneTags, NetworkPath
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PhoneTags
{{ Fill PhoneTags Description }}

```yaml
Type: SwitchParameter
Parameter Sets: PhoneTags
Aliases:

Required: True
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServiceTags
{{ Fill ServiceTags Description }}

```yaml
Type: SwitchParameter
Parameter Sets: ServiceTags
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
Parameter Sets: VLANs, CommonTags, ServiceTags, PhoneTags, NetworkPath
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

### -VLANs
{{ Fill VLANs Description }}

```yaml
Type: SwitchParameter
Parameter Sets: VLANs
Aliases:

Required: True
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
