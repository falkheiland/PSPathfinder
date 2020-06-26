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
    $KnownParameters = 'Computername', 'TCPPort', 'ApiVersion', 'Credential', 'Id', 'Page', 'PageSize', 'Filter', 'Sort'

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
          Name          = 'Taggroup01'
          Color         = -1
          RootGroupId   = 1
          RootGroupName = 'RootGroupName'
          TagGroupId    = 3
          TagGroupName  = 'TagGroupName'
          Id            = 43076
          Created       = '2015-06-26T10:53:40.637'
          Modified      = '2015-06-29T10:49:16.487'
          CreatedBy     = 'Pathfinder'
          ModifiedBy    = 'Pathfinder'
        }
      }
    }

    Mock 'Get-PFFunctionString' { }

    Context "General Execution" {

      It 'Get-PFTagGroup Should not throw' {
        { Get-PFTagGroup } | Should -Not -Throw
      }

      It 'Get-PFTagGroup -Error -ErrorAction Stop Should throw' {
        { Get-PFTagGroup -Error -ErrorAction Stop } | Should -Throw
      }

    }

    Context "Parameterset Get" {

      $Result = Get-PFTagGroup

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

      It 'Result.Id should be exactly 43076' {
        $Result.Id | Should BeExactly 43076
      }

      It 'Result.Id should have type [Int]' {
        $Result.Id | Should -HaveType [Int]
      }

      It 'Result.Name should be exactly Taggroup01' {
        $Result.Name | Should BeExactly 'Taggroup01'
      }

      It 'Result.Name should have type [String]' {
        $Result.Name | Should -HaveType [String]
      }

      <# PSCore
      It 'Result.Created should be exactly 2018-02-24T13:48:00.1000000' {
        $Result.Created | Should BeExactly '2018-02-24T13:48:00.1000000'
      }

      It 'Result.Created should have type [DateTime]' {
        $Result.Created | Should -HaveType [DateTime]
      }
      #>

    }

    Context "Parameterset Get Page" {

      Mock 'Get-PFFunctionString' { '?page=1' }

      Get-PFTagGroup -Page 1

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

    Context "Parameterset Id" {

      Mock 'Invoke-PFRestMethod' {
        [pscustomobject]@{
          Id = 43076
        }
      }

      $Result = Get-PFTagGroup -Id 43076

      It 'Assert Invoke-PFRestMethod is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Invoke-PFRestMethod'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Result.Id should be exactly 43076' {
        $Result.Id | Should BeExactly 43076
      }

    }

    Context "Parameterset Id Pipeline" {

      Mock 'Invoke-PFRestMethod' {
        [pscustomobject]@(
          @{
            Id = 43076
          },
          @{
            Id = 43077
          }
        )
      }

      $Result = 43076, 43077 | Get-PFTagGroup

      It 'Assert Invoke-PFRestMethod is called exactly 2 time' {
        $AMCParams = @{
          CommandName = 'Invoke-PFRestMethod'
          Times       = 2
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Result[0].Id should be exactly 43076' {
        $Result[0].Id | Should BeExactly 43076
      }

    }

    Context "Error Handling" {
      Mock 'Invoke-PFRestMethod' {
        throw 'Error'
      }

      It 'should throw Error' {
        {
          Get-PFTagGroup
        } | Should throw 'Error'
      }

      It 'Result should be null or empty' {
        $Result | Should BeNullOrEmpty
      }
    }
  }

}
