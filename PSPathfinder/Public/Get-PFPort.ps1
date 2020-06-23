function Get-PFPort
{

  [CmdletBinding(DefaultParameterSetName = 'Id')]
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

    [Parameter(ParameterSetName = 'Id', Mandatory)]
    [Parameter(ParameterSetName = 'NetworkPath')]
    [Parameter(ParameterSetName = 'PhoneTags')]
    [Parameter(ParameterSetName = 'ServiceTags')]
    [Parameter(ParameterSetName = 'CommonTags')]
    [Parameter(ParameterSetName = 'VLANs')]
    [Int]
    $Id,

    [Parameter(ParameterSetName = 'NetworkPath')]
    [Parameter(ParameterSetName = 'PhoneTags')]
    [Parameter(ParameterSetName = 'ServiceTags')]
    [Parameter(ParameterSetName = 'CommonTags')]
    [Parameter(ParameterSetName = 'VLANs')]
    [Int]
    $Page,

    [Parameter(ParameterSetName = 'NetworkPath')]
    [Parameter(ParameterSetName = 'PhoneTags')]
    [Parameter(ParameterSetName = 'ServiceTags')]
    [Parameter(ParameterSetName = 'CommonTags')]
    [Parameter(ParameterSetName = 'VLANs')]
    [int]
    $PageSize,

    [Parameter(ParameterSetName = 'NetworkPath')]
    [Parameter(ParameterSetName = 'PhoneTags')]
    [Parameter(ParameterSetName = 'ServiceTags')]
    [Parameter(ParameterSetName = 'CommonTags')]
    [Parameter(ParameterSetName = 'VLANs')]
    [String]
    $Filter,

    [Parameter(ParameterSetName = 'NetworkPath')]
    [Parameter(ParameterSetName = 'PhoneTags')]
    [Parameter(ParameterSetName = 'ServiceTags')]
    [Parameter(ParameterSetName = 'CommonTags')]
    [Parameter(ParameterSetName = 'VLANs')]
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

    [Parameter(ParameterSetName = 'NetworkPath', Mandatory)]
    [Switch]
    $NetworkPath
  )

  Begin
  {
    $UriArray = @($ComputerName, $TCPPort, $ApiVersion)
    $BaseURL = ('https://{0}:{1}/api/v{2}/infrastructure/port' -f $UriArray)
    switch ($PsCmdlet.ParameterSetName)
    {
      { 'Get' -or 'PhoneTags' -or 'ServiceTags' -or 'CommonTags' -or 'VLANs' -or 'NetworkPath' }
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
      'NetworkPath'
      {
        $params.Add('Uri', ('{0}/{1}/NetworkPath{2}' -f $BaseURL, $Id, $FunctionString))
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