function Get-PFFunctionString
{
  <#
  .EXAMPLE
  $Params = [ordered]@{
    Query = 'some+message'
    Limit = '10'
    Expand = $true
    Page   = 1
    Per_page = 3
  }
  Get-PFFunctionString @Params

  .EXAMPLE
  $Params = [ordered]@{
    Page     = $null
    PageSize = 1
    Filter = $null
    Sort   = $null
  }
  Get-PFFunctionString @Params

  Get-PFFunctionString -Query "Heiland"


  /search?query=some+message&limit=10&expand=true'
  /search?query=state:new%20OR%20state:open&limit=10&expand=true'
  /search?query=smith&limit=10&expand=true'
  ?expand=true&page=1&per_page=5 HTTP/1.1


  #>

  [CmdletBinding()]
  param (
    [Int]
    $Page,

    [int]
    $PageSize,

    [String]
    $Filter,

    [String]
    $Sort,

    [Int]
    $FloorId,

    [Int]
    $BuildingId,

    [Int]
    $LocationId,

    [Int]
    $CableId,

    [Int]
    $ComponentId,

    [Int]
    $PortId,

    [Int]
    $TaggroupId
  )

  begin
  {
  }
  process
  {
    foreach ($item in $PSBoundParameters.GetEnumerator())
    {
      if ($item.Value)
      {
        switch ($item)
        {
          { $_.Value -is [int] }
          {
            $Value = ($item.Value).toString()
            continue
          }
          default
          {
            $Value = $item.Value
          }
        }
        $FunctionString += ('&{0}={1}' -f $($item.Key).ToLower(), $Value)
      }
    }
    $FunctionString -replace ('^&', '?')
  }
  end
  {
  }
}