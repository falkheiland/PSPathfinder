function Remove-PFPhoneTag
{

  [cmdletbinding(SupportsShouldProcess, ConfirmImpact = 'High')]
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
    $Id
  )

  Begin
  {
    $UriArray = @($ComputerName, $TCPPort, $ApiVersion)
    $BaseURL = ('https://{0}:{1}/api/v{2}/tags/phone' -f $UriArray)
  }
  Process
  {
    $Params = @{
      Credential = $Credential
      Method     = 'Delete'
      Uri        = (' {0}/{1}' -f $BaseURL, $Id)
    }

    if ($PSCmdlet.ShouldProcess((' {0} Id: {1}' -f $Params.Method, $Id)))
    {
      $APIObjectColl = Invoke-PFRestMethod @Params
    }

    $Result = foreach ($APIObject in $APIObjectColl)
    {
      $Properties = [ordered]@{
        'Method' = $Params.Method
        'Id'     = $Id
      }
      New-Object psobject -Property $Properties
    }

    $Result

  }
  End
  {
  }
}