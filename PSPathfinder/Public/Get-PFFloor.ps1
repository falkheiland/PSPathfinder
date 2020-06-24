function Get-PFFloor
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
    [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'Rooms', Mandatory)]
    [Int]
    $Id,

    [Parameter(ParameterSetName = 'Get')]
    [Parameter(ParameterSetName = 'Rooms')]
    [Int]
    $Page,

    [Parameter(ParameterSetName = 'Get')]
    [Parameter(ParameterSetName = 'Rooms')]
    [int]
    $PageSize,

    [Parameter(ParameterSetName = 'Get')]
    [Parameter(ParameterSetName = 'Rooms')]
    [String]
    $Filter,

    [Parameter(ParameterSetName = 'Get')]
    [Parameter(ParameterSetName = 'Rooms')]
    [String]
    $Sort,

    [Parameter(ParameterSetName = 'Rooms', Mandatory)]
    [Switch]
    $Rooms
  )

  Begin
  {
    $UriArray = @($ComputerName, $TCPPort, $ApiVersion)
    $BaseURL = ('https://{0}:{1}/api/v{2}/infrastructure/floor' -f $UriArray)
    switch ($PsCmdlet.ParameterSetName)
    {
      { 'Get' -or 'Rooms' }
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
      'Rooms'
      {
        $params.Add('Uri', ('{0}/{1}/rooms{2}' -f $BaseURL, $Id, $FunctionString))
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