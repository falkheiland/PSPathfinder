function Get-PFBuilding
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

    [Parameter(ParameterSetName = 'Id')]
    [Parameter(ParameterSetName = 'Floors', Mandatory)]
    [Int]
    $Id,

    [Parameter(ParameterSetName = 'Get')]
    [Parameter(ParameterSetName = 'Floors')]
    [Int]
    $Page,

    [Parameter(ParameterSetName = 'Get')]
    [Parameter(ParameterSetName = 'Floors')]
    [int]
    $PageSize,

    [Parameter(ParameterSetName = 'Get')]
    [Parameter(ParameterSetName = 'Floors')]
    [String]
    $Filter,

    [Parameter(ParameterSetName = 'Get')]
    [Parameter(ParameterSetName = 'Floors')]
    [String]
    $Sort,

    [Parameter(ParameterSetName = 'Floors', Mandatory)]
    [Switch]
    $Floors
  )

  Begin
  {
    $UriArray = @($ComputerName, $TCPPort, $ApiVersion)
    $BaseURL = ('https://{0}:{1}/api/v{2}/infrastructure/building' -f $UriArray)
    switch ($PsCmdlet.ParameterSetName)
    {
      { 'Get' -or 'Floors' }
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
      'Floors'
      {
        $params.Add('Uri', ('{0}/{1}/floors{2}' -f $BaseURL, $Id, $FunctionString))
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