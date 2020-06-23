$Script:ProjectRoot = Resolve-Path ('{0}\..' -f $PSScriptRoot)
$Script:ModuleRoot = Split-Path (Resolve-Path ('{0}\*\*.psm1' -f $Script:ProjectRoot))
$Script:ModuleName = Split-Path $Script:ModuleRoot -Leaf
$Script:ModuleManifest = Resolve-Path ('{0}/{1}.psd1' -f $Script:ModuleRoot, $Script:ModuleName)
$Script:FunctionName = $MyInvocation.MyCommand.Name.Replace(".Tests.ps1", "")
Import-Module ( '{0}/{1}.psm1' -f $Script:ModuleRoot, $Script:ModuleName) -Force

Describe "$Script:FunctionName Unit Tests" -Tag 'UnitTests' {

  Context "Basics" {

    It "Is valid Powershell (Has no script errors)" {
      $Content = Get-Content -Path ( '{0}\Public\{1}.ps1' -f $Script:ModuleRoot, $Script:FunctionName) -ErrorAction Stop
      $ErrorColl = $Null
      $Null = [System.Management.Automation.PSParser]::Tokenize($Content, [ref]$ErrorColl)
      $ErrorColl | Should -HaveCount 0
    }

    [object[]]$params = (Get-ChildItem function:\$Script:FunctionName).Parameters.Keys
    $KnownParameters = 'Computername', 'TCPPort', 'ApiVersion', 'Credential', 'Id', 'Page', 'PageSize', 'Filter', 'Sort', 'PhoneTags',
    'ServiceTags', 'CommonTags', 'VLANs', 'NetworkPath'

    It "Should contain our specific parameters" {
      (@(Compare-Object -ReferenceObject $KnownParameters -DifferenceObject $params -IncludeEqual |
          Where-Object SideIndicator -eq "==").Count) | Should Be $KnownParameters.Count
    }
  }

  InModuleScope $Script:ModuleName {

    $PSDefaultParameterValues = @{
      '*:Credential'   = New-MockObject -Type 'System.Management.Automation.PSCredential'
      '*:Computername' = 'pathfinder'
    }

    Mock 'Invoke-PFRestMethod' {
      [pscustomobject]@{
        Items = @{
          String = 'String'
          Id     = 1
          Date   = '2020-05-06T12:35:18.373'
          Object = @{ }
        }
      }
    }

    Mock 'Get-PFFunctionString' { }

    Context "General Execution" {

      It 'Get-PFPort -Id 1 Should not throw' {
        { Get-PFPort -Id 1 } | Should -Not -Throw
      }

      It 'Get-PFPort -Id 1 Error -ErrorAction Stop Should throw' {
        { Get-PFPort -Id 1 Error -ErrorAction Stop } | Should -Throw
      }

    }

    Context "Parameterset Id" {

      Mock 'Invoke-PFRestMethod' {
        [pscustomobject]@{
          Id = 1
        }
      }

      $Result = Get-PFPort -Id 1

      It 'Assert Invoke-PFRestMethod is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Invoke-PFRestMethod'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Result.Id should be exactly 1' {
        $Result.Id | Should BeExactly 1
      }

    }

    Context "Parameterset NetworkPath" {

      $Result = Get-PFPort -Id 1 -NetworkPath

      It 'Assert Invoke-PFRestMethod is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Invoke-PFRestMethod'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Result.Id should be exactly 1' {
        $Result.Id | Should BeExactly 1
      }

      It 'Result.Id should have type [Int]' {
        $Result.Id | Should -HaveType [Int]
      }

      It 'Result.Object should have type [pscustomobject]' {
        $Result.Object | Should -HaveType [pscustomobject]
      }

    }

    Context "Parameterset CommonTags" {

      $Result = Get-PFPort -Id 1 -CommonTags

      It 'Assert Get-PFFunctionString is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Get-PFFunctionString'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Assert Invoke-PFRestMethod is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Invoke-PFRestMethod'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Result should have type pscustomobject' {
        $Result | Should -HaveType ([pscustomobject])
      }

      It 'Result should have 1 element' {
        @($Result).Count | Should BeExactly 1
      }

      It 'Result.Id should be exactly 1' {
        $Result.Id | Should BeExactly 1
      }

      It 'Result.Id should have type [Int]' {
        $Result.Id | Should -HaveType [Int]
      }

      It 'Result.String should be exactly String' {
        $Result.String | Should BeExactly 'String'
      }

      It 'Result.String should have type [String]' {
        $Result.String | Should -HaveType [String]
      }

      <# PSCore
      It 'Result.Date should be exactly 05/06/2020 12:35:18' {
        $Result.Date | Should BeExactly '05/06/2020 12:35:18'
      }

      It 'Result.Date should have type [DateTime]' {
        $Result.Date | Should -HaveType [DateTime]
      }
      #>

    }

    Context "Parameterset CommonTags Page" {

      Mock 'Get-PFFunctionString' { '?page=1' }

      Get-PFPort  -Id 1 -CommonTags -Page 1

      It 'Assert Get-PFFunctionString is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Get-PFFunctionString'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Assert Invoke-PFRestMethod is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Invoke-PFRestMethod'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

    }

    Context "Parameterset PhoneTags" {

      $Result = Get-PFPort -Id 1 -PhoneTags

      It 'Assert Get-PFFunctionString is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Get-PFFunctionString'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Assert Invoke-PFRestMethod is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Invoke-PFRestMethod'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Result.Id should be exactly 1' {
        $Result.Id | Should BeExactly 1
      }

    }

    Context "Parameterset ServiceTags" {

      $Result = Get-PFPort -Id 1515 -ServiceTags

      It 'Assert Get-PFFunctionString is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Get-PFFunctionString'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Assert Invoke-PFRestMethod is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Invoke-PFRestMethod'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Result.Id should be exactly 1' {
        $Result.Id | Should BeExactly 1
      }

    }

    Context "Parameterset CommonTags" {

      $Result = Get-PFPort -Id 1 -CommonTags

      It 'Assert Get-PFFunctionString is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Get-PFFunctionString'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Assert Invoke-PFRestMethod is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Invoke-PFRestMethod'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Result.Id should be exactly 1' {
        $Result.Id | Should BeExactly 1
      }

    }

    Context "Parameterset VLANs" {

      $Result = Get-PFPort -Id 1 -VLANs

      It 'Assert Get-PFFunctionString is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Get-PFFunctionString'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Assert Invoke-PFRestMethod is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Invoke-PFRestMethod'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Result.Id should be exactly 1' {
        $Result.Id | Should BeExactly 1
      }

    }

    Context "Error Handling" {
      Mock 'Invoke-PFRestMethod' {
        throw 'Error'
      }

      It 'should throw Error' {
        {
          Get-PFPort -Id 1 -CommonTags
        } | Should throw 'Error'
      }

      It 'Result should be null or empty' {
        $Result | Should BeNullOrEmpty
      }
    }
  }

}
