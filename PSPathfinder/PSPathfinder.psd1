#
# Modulmanifest für das Modul "PSPathfinder"
#
# Generiert von: Falk Heiland
#
# Generiert am: 03.03.2020
#

@{

    # Die diesem Manifest zugeordnete Skript- oder Binärmoduldatei.
    RootModule        = 'PSPathfinder.psm1'

    # Die Versionsnummer dieses Moduls
    ModuleVersion     = '0.0.1'

    # Unterstützte PSEditions
    # CompatiblePSEditions = @()

    # ID zur eindeutigen Kennzeichnung dieses Moduls
    GUID              = '2db572d6-614f-4bd6-bca0-79438284e35d'

    # Autor dieses Moduls
    Author            = 'Falk Heiland'

    # Unternehmen oder Hersteller dieses Moduls
    CompanyName       = 'n.a.'

    # Urheberrechtserklärung für dieses Modul
    Copyright         = '(c) 2020 Falk Heiland. Alle Rechte vorbehalten.'

    # Beschreibung der von diesem Modul bereitgestellten Funktionen
    Description       = 'Powershell Wrapper for Pathfinder Rest-API of the company tripunkt (www.tripunkt.de)'

    # Die für dieses Modul mindestens erforderliche Version des Windows PowerShell-Moduls
    PowerShellVersion = '5.1'

    # Der Name des für dieses Modul erforderlichen Windows PowerShell-Hosts
    # PowerShellHostName = ''

    # Die für dieses Modul mindestens erforderliche Version des Windows PowerShell-Hosts
    # PowerShellHostVersion = ''

    # Die für dieses Modul mindestens erforderliche Microsoft .NET Framework-Version. Diese erforderliche Komponente ist nur für die PowerShell Desktop-Edition gültig.
    # DotNetFrameworkVersion = ''

    # Die für dieses Modul mindestens erforderliche Version der CLR (Common Language Runtime). Diese erforderliche Komponente ist nur für die PowerShell Desktop-Edition gültig.
    # CLRVersion = ''

    # Die für dieses Modul erforderliche Prozessorarchitektur ("Keine", "X86", "Amd64").
    # ProcessorArchitecture = ''

    # Die Module, die vor dem Importieren dieses Moduls in die globale Umgebung geladen werden müssen
    # RequiredModules = @()

    # Die Assemblys, die vor dem Importieren dieses Moduls geladen werden müssen
    # RequiredAssemblies = @()

    # Die Skriptdateien (PS1-Dateien), die vor dem Importieren dieses Moduls in der Umgebung des Aufrufers ausgeführt werden.
    # ScriptsToProcess = @()

    # Die Typdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
    # TypesToProcess = @()

    # Die Formatdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
    # FormatsToProcess = @()

    # Die Module, die als geschachtelte Module des in "RootModule/ModuleToProcess" angegebenen Moduls importiert werden sollen.
    # NestedModules = @()

    # Aus diesem Modul zu exportierende Funktionen. Um optimale Leistung zu erzielen, verwenden Sie keine Platzhalter und löschen den Eintrag nicht. Verwenden Sie ein leeres Array, wenn keine zu exportierenden Funktionen vorhanden sind.
    FunctionsToExport = @(
        'Get-PFBuilding'
        'Get-PFCommonTag'
        'Get-PFComponent'
        'Get-PFFloor'
        'Get-PFLocation'
        'Get-PFPhoneTag'
        'Get-PFRoom'
        'Get-PFRootGroup'
        'Get-PFServiceTag'
        'Get-PFTagGroup'
        'Get-PFVlan'
    )

    # Aus diesem Modul zu exportierende Cmdlets. Um optimale Leistung zu erzielen, verwenden Sie keine Platzhalter und löschen den Eintrag nicht. Verwenden Sie ein leeres Array, wenn keine zu exportierenden Cmdlets vorhanden sind.
    CmdletsToExport   = @()

    # Die aus diesem Modul zu exportierenden Variablen
    VariablesToExport = @()

    # Aus diesem Modul zu exportierende Aliase. Um optimale Leistung zu erzielen, verwenden Sie keine Platzhalter und löschen den Eintrag nicht. Verwenden Sie ein leeres Array, wenn keine zu exportierenden Aliase vorhanden sind.
    AliasesToExport   = @()

    # Aus diesem Modul zu exportierende DSC-Ressourcen
    # DscResourcesToExport = @()

    # Liste aller Module in diesem Modulpaket
    # ModuleList = @()

    # Liste aller Dateien in diesem Modulpaket
    # FileList = @()

    # Die privaten Daten, die an das in "RootModule/ModuleToProcess" angegebene Modul übergeben werden sollen. Diese können auch eine PSData-Hashtabelle mit zusätzlichen von PowerShell verwendeten Modulmetadaten enthalten.
    PrivateData       = @{

        PSData = @{

            # 'Tags' wurde auf das Modul angewendet und unterstützt die Modulermittlung in Onlinekatalogen.
            Tags         = @('Pathfinder', 'tripunkt')

            # Eine URL zur Lizenz für dieses Modul.
            LicenseUri   = 'https://github.com/falkheiland/PSPathfinder/blob/master/LICENSE'

            # Eine URL zur Hauptwebsite für dieses Projekt.
            ProjectUri   = 'https://github.com/falkheiland/PSPathfinder'

            # Eine URL zu einem Symbol, das das Modul darstellt.
            # IconUri = ''

            # 'ReleaseNotes' des Moduls
            ReleaseNotes = @'
0.0.1 20200622
* Initial Release
'@

        } # Ende der PSData-Hashtabelle

    } # Ende der PrivateData-Hashtabelle

    # HelpInfo-URI dieses Moduls
    # HelpInfoURI = ''

    # Standardpräfix für Befehle, die aus diesem Modul exportiert werden. Das Standardpräfix kann mit "Import-Module -Prefix" überschrieben werden.
    # DefaultCommandPrefix = ''

}

