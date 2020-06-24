function Get-PFComponent
{

  [CmdletBinding(DefaultParameterSetName = 'Get')]
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

    [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'Id')]
    [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'PhoneTags', Mandatory)]
    [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'ServiceTags', Mandatory)]
    [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'CommonTags', Mandatory)]
    [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'VLANs', Mandatory)]
    [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'Children', Mandatory)]
    [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'Modules', Mandatory)]
    [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'Ports', Mandatory)]
    [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'Slots', Mandatory)]
    [Int]
    $Id,

    [Parameter(ParameterSetName = 'Get')]
    [Parameter(ParameterSetName = 'PhoneTags')]
    [Parameter(ParameterSetName = 'ServiceTags')]
    [Parameter(ParameterSetName = 'CommonTags')]
    [Parameter(ParameterSetName = 'VLANs')]
    [Parameter(ParameterSetName = 'Children')]
    [Parameter(ParameterSetName = 'Modules')]
    [Parameter(ParameterSetName = 'Ports')]
    [Parameter(ParameterSetName = 'Slots')]
    [Int]
    $Page,

    [Parameter(ParameterSetName = 'Get')]
    [Parameter(ParameterSetName = 'PhoneTags')]
    [Parameter(ParameterSetName = 'ServiceTags')]
    [Parameter(ParameterSetName = 'CommonTags')]
    [Parameter(ParameterSetName = 'VLANs')]
    [Parameter(ParameterSetName = 'Children')]
    [Parameter(ParameterSetName = 'Modules')]
    [Parameter(ParameterSetName = 'Ports')]
    [Parameter(ParameterSetName = 'Slots')]
    [int]
    $PageSize,

    [Parameter(ParameterSetName = 'Get')]
    [Parameter(ParameterSetName = 'PhoneTags')]
    [Parameter(ParameterSetName = 'ServiceTags')]
    [Parameter(ParameterSetName = 'CommonTags')]
    [Parameter(ParameterSetName = 'VLANs')]
    [Parameter(ParameterSetName = 'Children')]
    [Parameter(ParameterSetName = 'Modules')]
    [Parameter(ParameterSetName = 'Ports')]
    [Parameter(ParameterSetName = 'Slots')]
    [String]
    $Filter,

    [Parameter(ParameterSetName = 'Get')]
    [Parameter(ParameterSetName = 'PhoneTags')]
    [Parameter(ParameterSetName = 'ServiceTags')]
    [Parameter(ParameterSetName = 'CommonTags')]
    [Parameter(ParameterSetName = 'VLANs')]
    [Parameter(ParameterSetName = 'Children')]
    [Parameter(ParameterSetName = 'Modules')]
    [Parameter(ParameterSetName = 'Ports')]
    [Parameter(ParameterSetName = 'Slots')]
    [String]
    $Sort,

    [Parameter(ParameterSetName = 'PhoneTags', Mandatory)]
    [Switch]
    $PhoneTags,

    [Parameter(ParameterSetName = 'ServiceTags', Mandatory)]
    [Switch]
    $ServiceTags,

    [Parameter(ParameterSetName = 'CommonTags', Mandatory)]
    [Switch]
    $CommonTags,

    [Parameter(ParameterSetName = 'VLANs', Mandatory)]
    [Switch]
    $VLANs,

    [Parameter(ParameterSetName = 'Children', Mandatory)]
    [Switch]
    $Children,

    [Parameter(ParameterSetName = 'Modules', Mandatory)]
    [Switch]
    $Modules,

    [Parameter(ParameterSetName = 'Ports', Mandatory)]
    [Switch]
    $Ports,

    [Parameter(ParameterSetName = 'Slots', Mandatory)]
    [Switch]
    $Slots
  )

  Begin
  {
    $UriArray = @($ComputerName, $TCPPort, $ApiVersion)
    $BaseURL = ('https://{0}:{1}/api/v{2}/infrastructure/component' -f $UriArray)
    switch ($PsCmdlet.ParameterSetName)
    {
      { 'Get' -or 'PhoneTags' -or 'ServiceTags' -or 'CommonTags' -or 'VLANs' -or 'Children' -or 'Modules' -or 'Ports' -or 'Slots' }
      {
        $FunctionStringParams = [ordered]@{
          Page     = $Page
          PageSize = $PageSize
          Filter   = $Filter
          Sort     = $Sort
        }
        $FunctionString = Get-PFFunctionString @FunctionStringParams
      }
    }
  }
  Process
  {
    $Params = @{
      Credential = $Credential
      Method     = 'Get'
    }

    switch ($PsCmdlet.ParameterSetName)
    {
      'Get'
      {
        $params.Add('Uri', ('{0}/get{1}' -f $BaseURL, $FunctionString))
        $APIObjectColl = (Invoke-PFRestMethod @Params).Items
      }
      'Id'
      {
        $params.Add('Uri', ('{0}/{1}' -f $BaseURL, $Id))
        $APIObjectColl = Invoke-PFRestMethod @Params
      }
      'PhoneTags'
      {
        $params.Add('Uri', ('{0}/{1}/phones{2}' -f $BaseURL, $Id, $FunctionString))
        $APIObjectColl = (Invoke-PFRestMethod @Params).Items
      }
      'ServiceTags'
      {
        $params.Add('Uri', ('{0}/{1}/services{2}' -f $BaseURL, $Id, $FunctionString))
        $APIObjectColl = (Invoke-PFRestMethod @Params).Items
      }
      'CommonTags'
      {
        $params.Add('Uri', ('{0}/{1}/tags{2}' -f $BaseURL, $Id, $FunctionString))
        $APIObjectColl = (Invoke-PFRestMethod @Params).Items
      }
      'VLANs'
      {
        $params.Add('Uri', ('{0}/{1}/vlans{2}' -f $BaseURL, $Id, $FunctionString))
        $APIObjectColl = (Invoke-PFRestMethod @Params).Items
      }
      'Children'
      {
        $params.Add('Uri', ('{0}/{1}/children{2}' -f $BaseURL, $Id, $FunctionString))
        $APIObjectColl = (Invoke-PFRestMethod @Params).Items
      }
      'Modules'
      {
        $params.Add('Uri', ('{0}/{1}/modules{2}' -f $BaseURL, $Id, $FunctionString))
        $APIObjectColl = (Invoke-PFRestMethod @Params).Items
      }
      'Ports'
      {
        $params.Add('Uri', ('{0}/{1}/ports{2}' -f $BaseURL, $Id, $FunctionString))
        $APIObjectColl = (Invoke-PFRestMethod @Params).Items
      }
      'Slots'
      {
        $params.Add('Uri', ('{0}/{1}/slots{2}' -f $BaseURL, $Id, $FunctionString))
        $APIObjectColl = (Invoke-PFRestMethod @Params).Items
      }
    }

    $Result = $APIObjectColl
    $Result

  }
  End
  {
  }
}