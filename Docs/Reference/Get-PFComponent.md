---
external help file: PSPathfinder-help.xml
Module Name: PSPathfinder
online version:
schema: 2.0.0
---

# Get-PFComponent

## SYNOPSIS
Gets information on components.

## SYNTAX

### Get (Default)
```
Get-PFComponent [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>] [[-Sort] <String>]
 [<CommonParameters>]
```

### Slots
```
Get-PFComponent [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Id] <Int32>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>]
 [[-Sort] <String>] [-Slots] [<CommonParameters>]
```

### Ports
```
Get-PFComponent [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Id] <Int32>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>]
 [[-Sort] <String>] [-Ports] [<CommonParameters>]
```

### Modules
```
Get-PFComponent [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Id] <Int32>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>]
 [[-Sort] <String>] [-Modules] [<CommonParameters>]
```

### Children
```
Get-PFComponent [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Id] <Int32>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>]
 [[-Sort] <String>] [-Children] [<CommonParameters>]
```

### VLANs
```
Get-PFComponent [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Id] <Int32>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>]
 [[-Sort] <String>] [-VLANs] [<CommonParameters>]
```

### CommonTags
```
Get-PFComponent [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Id] <Int32>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>]
 [[-Sort] <String>] [-CommonTags] [<CommonParameters>]
```

### ServiceTags
```
Get-PFComponent [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Id] <Int32>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>]
 [[-Sort] <String>] [-ServiceTags] [<CommonParameters>]
```

### PhoneTags
```
Get-PFComponent [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Id] <Int32>] [[-Page] <Int32>] [[-PageSize] <Int32>] [[-Filter] <String>]
 [[-Sort] <String>] [-PhoneTags] [<CommonParameters>]
```

### Id
```
Get-PFComponent [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [[-Id] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Gets information on components.

## EXAMPLES

### Example 1
```powershell
Get-PFComponent -Computername $CN -Credential $Cred -Filter 'Name @=* Dev'
```

Gets information on components with the name containing "Dev".

### Example 2
```powershell
Get-PFComponent -Computername $CN -Credential $Cred -Id 100000
```

Gets information on the component with the ID 10000.

### Example 3
```powershell
Get-PFComponent -Computername $CN -Credential $Cred -Id 100000 -VLANs
```

Gets information on the VLANs of the component with the Id 10000.

### Example 4
```powershell
Get-PFComponent -Computername $CN -Credential $Cred -Filter 'Name @=* Dev' |
  Get-PFComponent -VLANs | Select-Object -Unique
```

Gets information on VLANs for components with the name containing "Dev".

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

### -Children
Switch to get children information

```yaml
Type: SwitchParameter
Parameter Sets: Children
Aliases:

Required: True
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CommonTags
Switch to get (common) tag information

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
Parameter Sets: Get, Slots, Ports, Modules, Children, VLANs, CommonTags, ServiceTags, PhoneTags
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Id of the component

```yaml
Type: Int32
Parameter Sets: Slots, Ports, Modules, Children, VLANs, CommonTags, ServiceTags, PhoneTags, Id
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Modules
Switch to get module information

```yaml
Type: SwitchParameter
Parameter Sets: Modules
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
Parameter Sets: Get, Slots, Ports, Modules, Children, VLANs, CommonTags, ServiceTags, PhoneTags
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
Parameter Sets: Get, Slots, Ports, Modules, Children, VLANs, CommonTags, ServiceTags, PhoneTags
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PhoneTags
Switch to get phone tag information

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

### -Ports
Switch to get port information

```yaml
Type: SwitchParameter
Parameter Sets: Ports
Aliases:

Required: True
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServiceTags
Switch to get service tag information

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

### -Slots
Switch to get slot information

```yaml
Type: SwitchParameter
Parameter Sets: Slots
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
Parameter Sets: Get, Slots, Ports, Modules, Children, VLANs, CommonTags, ServiceTags, PhoneTags
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
Switch to get VLAN information

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
