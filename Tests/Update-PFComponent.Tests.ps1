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
    $KnownParameters = 'Computername', 'TCPPort', 'ApiVersion', 'Credential', 'Id', 'PhoneTagId',
    'ServiceTagId', 'CommonTagId', 'VLANId', 'Remove'

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

    # maybe later results from call
    Mock 'Invoke-PFRestMethod' {
      [pscustomobject]@{
        Items = @{
        }
      }
    }

    $AMCParams = @{
      CommandName = 'Invoke-PFRestMethod'
      Times       = 1
      Exactly     = $true
    }

    Context "General Execution" {

      It 'Update-PFComponent -Id 1 -VLANId 1 Should not throw' {
        { Update-PFComponent -Id 1 -VLANId 1 } | Should -Not -Throw
      }

      It 'Update-PFComponent -Id 1 -VLANId 1 Error -ErrorAction Stop Should throw' {
        { Update-PFComponent -Id 1 -VLANId 1 Error -ErrorAction Stop } | Should -Throw
      }

    }

    Context "Parameterset PhoneTag" {

      $Result = Update-PFComponent -Id 1 -PhoneTagId 1

      It 'Assert Invoke-PFRestMethod is called exactly 1 time' {
        Assert-MockCalled @AMCParams
      }

      It 'Result should have type pscustomobject' {
        $Result | Should -HaveType ([pscustomobject])
      }

      It 'Result should have 1 element' {
        @($Result).Count | Should BeExactly 1
      }

      It 'Result.Method should be exactly Put' {
        $Result.Method | Should BeExactly 'Put'
      }

      It 'Result.Method should have type [String]' {
        $Result.Method | Should -HaveType [String]
      }

      It 'Result.Id should be exactly 1' {
        $Result.Id | Should BeExactly 1
      }

      It 'Result.Id should have type [Int]' {
        $Result.Id | Should -HaveType [Int]
      }

      It 'Result.Type should be exactly PhoneTag' {
        $Result.Type | Should BeExactly 'PhoneTag'
      }

      It 'Result.Type should have type [String]' {
        $Result.Type | Should -HaveType [String]
      }

      It 'Result.TypeId should be exactly 1' {
        $Result.TypeId | Should BeExactly 1
      }

      It 'Result.TypeId should have type [Int]' {
        $Result.TypeId | Should -HaveType [Int]
      }

    }

    Context "Parameterset PhoneTag Remove" {

      $Result = Update-PFComponent -Id 1 -PhoneTagId 1 -Remove

      It 'Assert Invoke-PFRestMethod is called exactly 1 time' {
        Assert-MockCalled @AMCParams
      }

      It 'Result should have type pscustomobject' {
        $Result | Should -HaveType ([pscustomobject])
      }

      It 'Result should have 1 element' {
        @($Result).Count | Should BeExactly 1
      }

      It 'Result.Method should be exactly Delete' {
        $Result.Method | Should BeExactly 'Delete'
      }

      It 'Result.Method should have type [String]' {
        $Result.Method | Should -HaveType [String]
      }

      It 'Result.Id should be exactly 1' {
        $Result.Id | Should BeExactly 1
      }

      It 'Result.Id should have type [Int]' {
        $Result.Id | Should -HaveType [Int]
      }

      It 'Result.Type should be exactly PhoneTag' {
        $Result.Type | Should BeExactly 'PhoneTag'
      }

      It 'Result.Type should have type [String]' {
        $Result.Type | Should -HaveType [String]
      }

      It 'Result.TypeId should be exactly 1' {
        $Result.TypeId | Should BeExactly 1
      }

      It 'Result.TypeId should have type [Int]' {
        $Result.TypeId | Should -HaveType [Int]
      }

    }

    Context "Parameterset ServiceTag" {

      $Result = Update-PFComponent -Id 1 -ServiceTagId 1

      It 'Assert Invoke-PFRestMethod is called exactly 1 time' {
        Assert-MockCalled @AMCParams
      }

      It 'Result.Type should be exactly ServiceTag' {
        $Result.Type | Should BeExactly 'ServiceTag'
      }

    }

    Context "Parameterset CommonTag" {

      $Result = Update-PFComponent -Id 1 -CommonTagId 1

      It 'Assert Invoke-PFRestMethod is called exactly 1 time' {
        Assert-MockCalled @AMCParams
      }

      It 'Result.Type should be exactly CommonTag' {
        $Result.Type | Should BeExactly 'CommonTag'
      }

    }

    Context "Parameterset VLAN" {

      $Result = Update-PFComponent -Id 1 -VLANId 1

      It 'Assert Invoke-PFRestMethod is called exactly 1 time' {
        Assert-MockCalled @AMCParams
      }

      It 'Result.Type should be exactly VLAN' {
        $Result.Type | Should BeExactly 'VLAN'
      }

    }

    Context "Error Handling" {
      Mock 'Invoke-PFRestMethod' {
        throw 'Error'
      }

      It 'should throw Error' {
        {
          Update-PFComponent -Id 1 -PhoneTag 1 -Error
        } | Should throw 'Error'
      }

      It 'Result should be null or empty' {
        $Result | Should BeNullOrEmpty
      }
    }

  }

}
