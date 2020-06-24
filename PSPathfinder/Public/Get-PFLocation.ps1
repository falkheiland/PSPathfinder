function Get-PFLocation
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

    [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'Id', Mandatory)]
    [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'Buildings', Mandatory)]
    [Int]
    $Id,

    [Parameter(ParameterSetName = 'Get')]
    [Parameter(ParameterSetName = 'Buildings')]
    [Int]
    $Page,

    [Parameter(ParameterSetName = 'Get')]
    [Parameter(ParameterSetName = 'Buildings')]
    [int]
    $PageSize,

    [Parameter(ParameterSetName = 'Get')]
    [Parameter(ParameterSetName = 'Buildings')]
    [String]
    $Filter,

    [Parameter(ParameterSetName = 'Get')]
    [Parameter(ParameterSetName = 'Buildings')]
    [String]
    $Sort,

    [Parameter(ParameterSetName = 'Buildings', Mandatory)]
    [Switch]
    $Buildings
  )

  Begin
  {
    $UriArray = @($ComputerName, $TCPPort, $ApiVersion)
    $BaseURL = ('https://{0}:{1}/api/v{2}/infrastructure/location' -f $UriArray)
    switch ($PsCmdlet.ParameterSetName)
    {
      { 'Get' -or 'Buildings' }
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
      'Buildings'
      {
        $params.Add('Uri', ('{0}/{1}/buildings{2}' -f $BaseURL, $Id, $FunctionString))
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