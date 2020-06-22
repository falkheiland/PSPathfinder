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
          Postalcode = '01234'
          Diagram    = '<mock_root></mock_root>'
          Street     = 'Hauptstraße 1'
          Createdby  = 'Max Mustermann'
          Id         = 15
          Viewmode   = 2
          Modifiedby = 'Max Mustermann'
          Created    = '2018-02-24T13:48:00.1'
          Name       = 'Berlin'
          Modified   = '2018-05-24T17:03:22.1'
          Country    = 'Deutschland'
        }
      }
    }

    Mock 'Get-PFFunctionString' { }

    Mock 'Get-PFPropertyCast' {
      [pscustomobject]@{
        Postalcode = [String]'01234'
        Diagram    = [Xml]'<mock_root></mock_root>'
        Street     = [String]'Hauptstraße 1'
        Createdby  = [String]'Max Mustermann'
        Id         = [Int]15
        Viewmode   = [int]2
        Modifiedby = [String]'Max Mustermann'
        Created    = [DateTime]'2018-02-24T13:48:00.1'
        Name       = [String]'Berlin'
        Modified   = [DateTime]'2018-05-24T17:03:22.1'
        Country    = [String]'Deutschland'
      }
    }

    Context "General Execution" {

      It 'Get-PFLocation Should not throw' {
        { Get-PFLocation } | Should -Not -Throw
      }

      It 'Get-PFLocation Error -ErrorAction Stop Should throw' {
        { Get-PFLocation Error -ErrorAction Stop } | Should -Throw
      }

    }

    Context "Parameterset Default" {

      $Result = Get-PFLocation

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

      It 'Result should have 11 NoteProperties' {
        ($Result | Get-Member -MemberType NoteProperty).Count | Should BeExactly 11
      }

      It 'Result.Id should be exactly 15' {
        $Result.Id | Should BeExactly 15
      }

      It 'Result.Id should have type [Int]' {
        $Result.Id | Should -HaveType [Int]
      }

      It 'Result.Diagram should be exactly System.Xml.XmlDocument' {
        $Result.Diagram | Should BeExactly 'System.Xml.XmlDocument'
      }

      It 'Result.Diagram should have type [Xml]' {
        $Result.Diagram | Should -HaveType [Xml]
      }

      It 'Result.Name should be exactly Berlin' {
        $Result.Name | Should BeExactly 'Berlin'
      }

      It 'Result.Name should have type [String]' {
        $Result.Name | Should -HaveType [String]
      }

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

      Get-PFLocation -Page 1

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

      Get-PFLocation -Id 15

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
          Get-PFLocation
        } | Should throw 'Error'
      }

      It 'Result should be null or empty' {
        $Result | Should BeNullOrEmpty
      }
    }
  }

}
