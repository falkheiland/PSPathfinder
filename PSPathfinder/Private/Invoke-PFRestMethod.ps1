function Invoke-PFRestMethod
{
  <#
    .SYNOPSIS
    Invoke-RestMethod Wrapper for PF API

    .DESCRIPTION
    Invoke-RestMethod Wrapper for PF API

    .EXAMPLE
    Invoke-PFRestMethod -Credential $Credential -Uri $Uri -Method 'Get'

    .NOTES
     n.a.
    #>

  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [System.Management.Automation.PSCredential]
    [System.Management.Automation.Credential()]
    $Credential,

    [Parameter(Mandatory)]
    [string]
    $Uri,

    [string]
    $Body,

    [string]
    $OutFile,

    [Parameter(Mandatory)]
    [ValidateSet('Get', 'Post', 'Delete', 'Patch', 'Put')]
    [string]
    $Method
  )

  begin
  {
    switch (Get-Variable -Name PSEdition -ValueOnly)
    {
      'Desktop'
      {
        Invoke-PFTrustSelfSignedCertificate
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
      }
    }
    $CredString = ("{0}:{1}" -f $Credential.UserName, $Credential.GetNetworkCredential().Password)
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($CredString))
    $PSBoundParameters.Add('Headers', @{Authorization = ("Basic {0}" -f $base64AuthInfo) })
    $PSBoundParameters.Add('ContentType', 'application/json; charset=utf-8')
    $Null = $PSBoundParameters.Remove('Credential')
  }
  process
  {
    Switch (Get-Variable -Name PSEdition -ValueOnly)
    {
      'Desktop'
      {
        try
        {
          Invoke-RestMethod @PSBoundParameters -ErrorAction Stop
        }
        catch [System.Net.WebException]
        {
          switch ($($PSItem.Exception.Response.StatusCode.value__))
          {
            200
            {
              Write-Warning -Message ('Success. Uri: {0} Method: {1}' -f $Uri, $Method)
            }
            304
            {
              Write-Warning -Message ('Not Modified. Uri: {0} Method: {1}' -f $Uri, $Method)
            }
            401
            {
              Write-Warning -Message ('Unauthorized. Uri: {0} Method: {1}' -f $Uri, $Method)
            }
            404
            {
              Write-Warning -Message ('Not Acceptable. Uri: {0} Method: {1}' -f $Uri, $Method)
            }
            406
            {
              Write-Warning -Message ('Not Found. Uri: {0} Method: {1}' -f $Uri, $Method)
            }
            422
            {
              Write-Warning -Message ('Client Error. Uri: {0} Method: {1}' -f $Uri, $Method)
            }
            500
            {
              Write-Warning -Message ('Server Error. Uri: {0} Method: {1}' -f $Uri, $Method)
            }
            default
            {
              Write-Warning -Message ('Some error occured, see HTTP status code for further details. Uri: {0} Method: {1}' -f $Uri, $Method)
            }
          }
        }
      }
      'Core'
      {
        try
        {
          $null = $PSBoundParameters.Add('SkipCertificateCheck', $true)
          Invoke-RestMethod @PSBoundParameters -ErrorAction Stop
        }
        catch [Microsoft.PowerShell.Commands.HttpResponseException]
        {
          switch ($($PSItem.Exception.Response.StatusCode.value__))
          {
            200
            {
              Write-Warning -Message ('Success. Uri: {0} Method: {1}' -f $Uri, $Method)
            }
            304
            {
              Write-Warning -Message ('Not Modified. Uri: {0} Method: {1}' -f $Uri, $Method)
            }
            401
            {
              Write-Warning -Message ('Unauthorized. Uri: {0} Method: {1}' -f $Uri, $Method)
            }
            404
            {
              Write-Warning -Message ('Not Acceptable. Uri: {0} Method: {1}' -f $Uri, $Method)
            }
            406
            {
              Write-Warning -Message ('Not Found. Uri: {0} Method: {1}' -f $Uri, $Method)
            }
            422
            {
              Write-Warning -Message ('Client Error. Uri: {0} Method: {1}' -f $Uri, $Method)
            }
            500
            {
              Write-Warning -Message ('Server Error. Uri: {0} Method: {1}' -f $Uri, $Method)
            }
            default
            {
              Write-Warning -Message ('Some error occured, see HTTP status code for further details. Uri: {0} Method: {1}' -f $Uri, $Method)
            }
          }
        }
      }
    }
  }
  end
  {
  }
}