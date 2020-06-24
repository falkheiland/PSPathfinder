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
    'ServiceTags', 'CommonTags', 'VLANs', 'Children', 'Modules', 'Ports', 'Slots'

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
          Name                    = 'Component01'
          Description             = 'Decription'
          SlotPosition            = 1.0
          BayPosition             = 1
          BurdenCentre            = ''
          InventoryNumber         = '0123456'
          RoomId                  = 793
          ComponentDefinitionId   = 1019
          ComponentDefinitionName = 'HP ProCurve 2530-24G-PoE+ (J9854A)'
          ParentComponentId       = 103000
          ParentComponentName     = 'Component01Parent'
          DistributorId           = 0
          Id                      = 1515
          Created                 = '2020-05-06T12:35:18.373'
          Modified                = '2020-06-22T13:53:26.873'
          CreatedBy               = 'Pathfinder'
          ModifiedBy              = 'Pathfinder'
        }
      }
    }

    Mock 'Get-PFFunctionString' { }

    Context "General Execution" {

      It 'Get-PFComponent Should not throw' {
        { Get-PFComponent } | Should -Not -Throw
      }

      It 'Get-PFComponent Error -ErrorAction Stop Should throw' {
        { Get-PFComponent Error -ErrorAction Stop } | Should -Throw
      }

    }

    Context "Parameterset Get" {

      $Result = Get-PFComponent

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

      It 'Result.Id should be exactly 1515' {
        $Result.Id | Should BeExactly 1515
      }

      It 'Result.Id should have type [Int]' {
        $Result.Id | Should -HaveType [Int]
      }

      It 'Result.Name should be exactly Component01' {
        $Result.Name | Should BeExactly 'Component01'
      }

      It 'Result.Name should have type [String]' {
        $Result.Name | Should -HaveType [String]
      }

      <# PSCore
      It 'Result.Created should be exactly 2018-02-24T13:48:00.1' {
        $Result.Created | Should BeExactly '2018-02-24T13:48:00.1'
      }

      It 'Result.Created should have type [DateTime]' {
        $Result.Created | Should -HaveType [DateTime]
      }
      #>

    }

    Context "Parameterset Get Page" {

      Mock 'Get-PFFunctionString' { '?page=1' }

      Get-PFComponent -Page 1

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
          Id = 1515
        }
      }

      $Result = Get-PFComponent -Id 1515

      It 'Assert Invoke-PFRestMethod is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Invoke-PFRestMethod'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Result.Id should be exactly 1515' {
        $Result.Id | Should BeExactly 1515
      }

    }

    Context "Parameterset Id Pipeline" {

      Mock 'Invoke-PFRestMethod' {
        [pscustomobject]@(
          @{
            Id = 1515
          }
          [pscustomobject]@{
            Id = 1516
          }
        )
      }

      $Result = 1515, 1516 | Get-PFComponent

      It 'Assert Invoke-PFRestMethod is called exactly 2 time' {
        $AMCParams = @{
          CommandName = 'Invoke-PFRestMethod'
          Times       = 2
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Result[0].Id should be exactly 1515' {
        $Result[0].Id | Should BeExactly 1515
      }

    }

    Context "Parameterset PhoneTags" {

      Mock 'Invoke-PFRestMethod' {
        [pscustomobject]@{
          Items = @{
            Id = 1515
          }
        }
      }

      $Result = Get-PFComponent -Id 1515 -PhoneTags

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

      It 'Result.Id should be exactly 1515' {
        $Result.Id | Should BeExactly 1515
      }

    }

    Context "Parameterset PhoneTags Pipeline" {

      Mock 'Invoke-PFRestMethod' {
        [pscustomobject]@(
          @{
            Items = @{
              Id = 1515
            }
          }
          @{
            Items = @{
              Id = 1516
            }
          }
        )
      }

      $Result = 1515, 1516 | Get-PFComponent -PhoneTags

      It 'Assert Get-PFFunctionString is called exactly 1 time' {
        $AMCParams = @{
          CommandName = 'Get-PFFunctionString'
          Times       = 1
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Assert Invoke-PFRestMethod is called exactly 2 time' {
        $AMCParams = @{
          CommandName = 'Invoke-PFRestMethod'
          Times       = 2
          Exactly     = $true
        }
        Assert-MockCalled @AMCParams
      }

      It 'Result[0].Id should be exactly 1515' {
        $Result[0].Id | Should BeExactly 1515
      }

    }

    Context "Parameterset ServiceTags" {

      Mock 'Invoke-PFRestMethod' {
        [pscustomobject]@{
          Items = @{
            Id = 1515
          }
        }
      }

      $Result = Get-PFComponent -Id 1515 -ServiceTags

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

      It 'Result.Id should be exactly 1515' {
        $Result.Id | Should BeExactly 1515
      }

    }

    Context "Parameterset CommonTags" {

      Mock 'Invoke-PFRestMethod' {
        [pscustomobject]@{
          Items = @{
            Id = 1515
          }
        }
      }

      $Result = Get-PFComponent -Id 1515 -CommonTags

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

      It 'Result.Id should be exactly 1515' {
        $Result.Id | Should BeExactly 1515
      }

    }

    Context "Parameterset VLANs" {

      Mock 'Invoke-PFRestMethod' {
        [pscustomobject]@{
          Items = @{
            Id = 1515
          }
        }
      }

      $Result = Get-PFComponent -Id 1515 -VLANs

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

      It 'Result.Id should be exactly 1515' {
        $Result.Id | Should BeExactly 1515
      }

    }

    Context "Parameterset Children" {

      Mock 'Invoke-PFRestMethod' {
        [pscustomobject]@{
          Items = @{
            Id = 1515
          }
        }
      }

      $Result = Get-PFComponent -Id 1515 -Children

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

      It 'Result.Id should be exactly 1515' {
        $Result.Id | Should BeExactly 1515
      }

    }

    Context "Parameterset Modules" {

      Mock 'Invoke-PFRestMethod' {
        [pscustomobject]@{
          Items = @{
            Id = 1515
          }
        }
      }

      $Result = Get-PFComponent -Id 1515 -Modules

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

      It 'Result.Id should be exactly 1515' {
        $Result.Id | Should BeExactly 1515
      }

    }

    Context "Parameterset Ports" {

      Mock 'Invoke-PFRestMethod' {
        [pscustomobject]@{
          Items = @{
            Id = 1515
          }
        }
      }

      $Result = Get-PFComponent -Id 1515 -Ports

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

      It 'Result.Id should be exactly 1515' {
        $Result.Id | Should BeExactly 1515
      }

    }

    Context "Parameterset Slots" {

      Mock 'Invoke-PFRestMethod' {
        [pscustomobject]@{
          Items = @{
            Id = 1515
          }
        }
      }

      $Result = Get-PFComponent -Id 1515 -Slots

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

      It 'Result.Id should be exactly 1515' {
        $Result.Id | Should BeExactly 1515
      }

    }

    Context "Error Handling" {
      Mock 'Invoke-PFRestMethod' {
        throw 'Error'
      }

      It 'should throw Error' {
        {
          Get-PFComponent
        } | Should throw 'Error'
      }

      It 'Result should be null or empty' {
        $Result | Should BeNullOrEmpty
      }
    }
  }

}
