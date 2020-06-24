function Update-PFComponent
{

  [cmdletbinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
  param (
    [Parameter(Mandatory)]
    [string]
    $Computername,

    [ValidateRange(0, 65535)]
    [Int]
    $TCPPort = 8087,

    [ValidateSet('1.0')]
    [string]
    $ApiVersion = '1.0',

    [ValidateNotNull()]
    [System.Management.Automation.PSCredential]
    [System.Management.Automation.Credential()]
    $Credential = (Get-Credential -Message 'Enter your credentials'),

    [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline)]
    [Int]
    $Id,

    [Parameter(ParameterSetName = 'PhoneTag', Mandatory)]
    [Int]
    $PhoneTagId,

    [Parameter(ParameterSetName = 'ServiceTag', Mandatory)]
    [Int]
    $ServiceTagId,

    [Parameter(ParameterSetName = 'CommonTag', Mandatory)]
    [Int]
    $CommonTagId,

    [Parameter(ParameterSetName = 'VLAN', Mandatory)]
    [Int]
    $VLANId,

    [Switch]
    $Remove
  )

  Begin
  {
    $UriArray = @($ComputerName, $TCPPort, $ApiVersion)
    $BaseURL = ('https://{0}:{1}/api/v{2}/infrastructure/component' -f $UriArray)
  }
  Process
  {
    $Params = @{ }
    $Params.Add('Credential', $Credential)
    Switch ($Remove)
    {
      $false
      {
        $Method = 'Put'
      }
      $true
      {
        $Method = 'Delete'
      }
    }
    $Params.Add('Method', $Method)

    Switch ($PsCmdlet.ParameterSetName)
    {
      'PhoneTag'
      {
        $EndpointUri = 'phones'
        $TypeId = $PhoneTagId
      }
      'ServiceTag'
      {
        $EndpointUri = 'services'
        $TypeId = $ServiceTagId
      }
      'CommonTag'
      {
        $EndpointUri = 'tags'
        $TypeId = $CommonTagId
      }
      'VLAN'
      {
        $EndpointUri = 'vlans'
        $TypeId = $VLANId
      }
    }

    $Params.Add('Uri', ('{0}/{1}/{2}/{3}' -f $BaseURL, $Id, $EndpointUri, $TypeId))

    if ($PSCmdlet.ShouldProcess(('{0} Id: {1} Type: {2} TypeId: {3}' -f $Method, $Id, $PsCmdlet.ParameterSetName, $TypeId)))
    {
      $APIObjectColl = Invoke-PFRestMethod @Params
    }

    $Result = foreach ($APIObject in $APIObjectColl)
    {
      $Properties = [ordered]@{
        'Method' = $Method
        'Id'     = $Id
        'Type'   = $PsCmdlet.ParameterSetName
        'TypeId' = $TypeId
      }
      New-Object psobject -Property $Properties
    }

    $Result
  }
  End
  {
  }
}