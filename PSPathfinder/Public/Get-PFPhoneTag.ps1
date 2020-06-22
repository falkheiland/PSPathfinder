function Get-PFPhoneTag
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
    [Int]
    $Id,

    [Parameter(ParameterSetName = 'Get')]

    [Int]
    $Page,

    [Parameter(ParameterSetName = 'Get')]

    [int]
    $PageSize,

    [Parameter(ParameterSetName = 'Get')]

    [String]
    $Filter,

    [Parameter(ParameterSetName = 'Get')]

    [String]
    $Sort

  )

  Begin
  {
    $UriArray = @($ComputerName, $TCPPort, $ApiVersion)
    $BaseURL = ('https://{0}:{1}/api/v{2}/tags/phone' -f $UriArray)
    $FunctionStringParams = [ordered]@{
      Page     = $Page
      PageSize = $PageSize
      Filter   = $Filter
      sort     = $Sort
    }
    $FunctionString = Get-PFFunctionString @FunctionStringParams
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
    }

    $Result = $APIObjectColl
    $Result

  }
  End
  {
  }
}