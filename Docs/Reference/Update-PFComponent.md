---
external help file: PSPathfinder-help.xml
Module Name: PSPathfinder
online version:
schema: 2.0.0
---

# Update-PFComponent

## SYNOPSIS
Updates information on components.

## SYNTAX

### PhoneTag
```
Update-PFComponent [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [-Id] <Int32> [-PhoneTagId] <Int32> [-Remove] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### ServiceTag
```
Update-PFComponent [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [-Id] <Int32> [-ServiceTagId] <Int32> [-Remove] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### CommonTag
```
Update-PFComponent [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [-Id] <Int32> [-CommonTagId] <Int32> [-Remove] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### VLAN
```
Update-PFComponent [-Computername] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [-Id] <Int32> [-VLANId] <Int32> [-Remove] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates information on components.

## EXAMPLES

### Example 1
```powershell
Update-PFComponent -Computername $CN -Credential $Cred -Id 10000 -CommonTagId 20000
```

Sets (common) tag with Id 20000 on the component with the ID 10000.

### Example 1
```powershell
Update-PFComponent -Computername $CN -Credential $Cred -Id 10000 -VLAN 30000 -Remove -Confirm
```

Removes VLAN with Id 30000 from the component with the ID 10000 and asks for confirmation (interactively).

### Example 3
```powershell
$PSDefaultParameterValues = @{
  '*-PF*:Credential'   = $Cred
  '*-PF*:Computername' = $CN
}
Get-PFComponent -Filter 'Name @=* Dev' | Update-PFComponent -VLAN 30000
```

Gets all components with Names containing "Dev" and sets VLAN with ID 30000.

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

### -CommonTagId
Id of the (common) tag

```yaml
Type: Int32
Parameter Sets: CommonTag
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

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
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

### -Id
Id of the component

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Benannt
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -PhoneTagId
Id of the phone tag

```yaml
Type: Int32
Parameter Sets: PhoneTag
Aliases:

Required: True
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Remove
Switch to remove information (instead of setting information without that switch (default))

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServiceTagId
Id of the service tag

```yaml
Type: Int32
Parameter Sets: ServiceTag
Aliases:

Required: True
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

### -VLANId
Id of the VLAN

```yaml
Type: Int32
Parameter Sets: VLAN
Aliases:

Required: True
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int32

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
