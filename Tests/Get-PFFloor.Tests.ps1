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
    $KnownParameters = 'Computername', 'TCPPort', 'ApiVersion', 'Credential', 'Id', 'Page', 'PageSize', 'Filter', 'Sort', 'BuildingId'

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
          Diagram    = '<mock_root></mock_root>'
          Createdby  = 'Max Mustermann'
          Id         = 151515
          BuildingId = 1515
          Modifiedby = 'Max Mustermann'
          Created    = '2018-02-24T13:48:00.1'
          Name       = 'Building01'
          Modified   = '2018-05-24T17:03:22.1'
        }
      }
    }

    Mock 'Get-PFFunctionString' { }

    Mock 'Get-PFPropertyCast' {
      [pscustomobject]@{
        Diagram    = [Xml]'<mock_root></mock_root>'
        Createdby  = [String]'Max Mustermann'
        Id         = [Int]151515
        BuildingId = [Int]1515
        Modifiedby = [String]'Max Mustermann'
        Created    = [DateTime]'2018-02-24T13:48:00.1'
        Name       = [String]'Building01'
        Modified   = [DateTime]'2018-05-24T17:03:22.1'
      }
    }

    Context "General Execution" {

      It 'Get-PFFloor Should not throw' {
        { Get-PFFloor } | Should -Not -Throw
      }

      It 'Get-PFFloor Error -ErrorAction Stop Should throw' {
        { Get-PFFloor Error -ErrorAction Stop } | Should -Throw
      }

    }

    Context "Parameterset Default" {

      $Result = Get-PFFloor

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

      It 'Result should have 8 NoteProperties' {
        ($Result | Get-Member -MemberType NoteProperty).Count | Should BeExactly 8
      }

      It 'Result.Id should be exactly 151515' {
        $Result.Id | Should BeExactly 151515
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

      It 'Result.Name should be exactly Building01' {
        $Result.Name | Should BeExactly 'Building01'
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

      Get-PFFloor -Page 1

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

      Get-PFFloor -Id 15

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

    Context "Parameterset GetByBuildingId" {

      Get-PFFloor -BuildingId 1515

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
          Get-PFFloor
        } | Should throw 'Error'
      }

      It 'Result should be null or empty' {
        $Result | Should BeNullOrEmpty
      }
    }
  }

}
