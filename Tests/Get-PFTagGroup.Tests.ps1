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
          Name        = 'Taggroup01'
          Guid        = 'BB9E1375-7231-4401-A22E-B33129F5655C'
          RootGroupId = 1
          TagIds      = 1, 2
          TagGroupIds = 3, 4
          Id          = 43076
          Created     = '2015-06-26T10:53:40.637'
          Modified    = '2015-06-29T10:49:16.487'
          CreatedBy   = 'Pathfinder'
          ModifiedBy  = 'Pathfinder'
        }
      }
    }

    Mock 'Get-PFFunctionString' { }

    Mock 'Get-PFPropertyCast' {
      [pscustomobject]@{
        Name        = [String]'Taggroup01'
        Guid        = [GUID]'BB9E1375-7231-4401-A22E-B33129F5655C'
        RootGroupId = [Int]1
        TagIds      = [Array](1, 2)
        TagGroupIds = [Array](3, 4)
        Id          = [Int]43076
        Created     = [DateTime]'2015-06-26T10:53:40.637'
        Modified    = [DateTime]'2015-06-29T10:49:16.487'
        CreatedBy   = [String]'Pathfinder'
        ModifiedBy  = [String]'Pathfinder'
      }
    }

    Context "General Execution" {

      It 'Get-PFTagGroup Should not throw' {
        { Get-PFTagGroup } | Should -Not -Throw
      }

      It 'Get-PFTagGroup Error -ErrorAction Stop Should throw' {
        { Get-PFTagGroup Error -ErrorAction Stop } | Should -Throw
      }

    }

    Context "Parameterset Default" {

      $Result = Get-PFTagGroup

      It 'Assert Get-PFFunctionString is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Get-PFFunctionString'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Assert Get-PFPropertyCast is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Get-PFPropertyCast'
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

      It 'Result should have 10 NoteProperties' {
        ($Result | Get-Member -MemberType NoteProperty).Count | Should BeExactly 10
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

      It 'Result.Guid should be BB9E1375-7231-4401-A22E-B33129F5655C' {
        #$Result.Guid.ToString() | Should BeExactly 'BB9E1375-7231-4401-A22E-B33129F5655C'
        $Result.Guid.ToString() | Should Be 'BB9E1375-7231-4401-A22E-B33129F5655C'
      }

      It 'Result.Guid should have type [GUID]' {
        $Result.Guid | Should -HaveType [GUID]
      }

      It 'Result.TagIds should be exactly "1, 2"' {
        $Result.TagIds | Should BeExactly @(1, 2)
      }

      <#
      It 'Result.TagIds should have type [Array]' {
        $Result.TagIds | Should -HaveType [Array]
      }
      #>

      <#
      It 'Result.Created should be exactly 2018-02-24T13:48:00.1000000' {
        $Result.Created | Should BeExactly '2018-02-24T13:48:00.1000000'
      }
      #>

      It 'Result.Created should have type [DateTime]' {
        $Result.Created | Should -HaveType [DateTime]
      }

    }

    Context "Parameterset Default Page" {

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


      It 'Assert Get-PFPropertyCast is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Get-PFPropertyCast'
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

      Get-PFTagGroup -Id 15

      It 'Assert Get-PFFunctionString is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Get-PFFunctionString'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }


      It 'Assert Get-PFPropertyCast is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Get-PFPropertyCast'
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
