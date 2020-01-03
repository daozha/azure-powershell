$loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
if (-Not (Test-Path -Path $loadEnvPath)) {
    $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
}
. ($loadEnvPath)
$TestRecordingFile = Join-Path $PSScriptRoot 'Set-AzsBackupConfiguration.Recording.json'
$currentPath = $PSScriptRoot
while(-not $mockingPath) {
    $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
    $currentPath = Split-Path -Path $currentPath -Parent
}
. ($mockingPath | Select-Object -First 1).FullName

Describe 'Set-AzsBackupConfiguration' {
    . $PSScriptRoot\Common.ps1

    AfterEach {
        $global:Client = $null
    }

    It "TestUpdateBackupLocationExpanded" -Skip:$('TestUpdateBackupLocationExpanded' -in $global:SkippedTests) {
        $global:TestName = 'TestUpdateBackupLocationExpanded'

        try
        {
            [System.IO.File]::WriteAllBytes($global:encryptionCertPath, [System.Convert]::FromBase64String($global:encryptionCertBase64))
            $location = Set-AzsBackupConfiguration -IsBackupSchedulerEnabled:$global:isBackupSchedulerEnabled
            ValidateBackupLocation -BackupLocation $location

            $location                             | Should Not Be $Null
            $location.IsBackupSchedulerEnabled    | Should be $global:isBackupSchedulerEnabled
        }
        finally
        {
            if (Test-Path -Path $global:encryptionCertPath -PathType Leaf)
            {
                Remove-Item -Path $global:encryptionCertPath -Force -ErrorAction Continue
            }
        }
    }

    It "TestUpdateBackupLocation" -Skip:$('TestUpdateBackupLocation' -in $global:SkippedTests) {
        $global:TestName = 'TestUpdateBackupLocation'

        try
        {
            [System.IO.File]::WriteAllBytes($global:encryptionCertPath, [System.Convert]::FromBase64String($global:encryptionCertBase64))
            $location = Get-AzsBackupConfiguration
            $location.IsBackupSchedulerEnabled = $global:isBackupSchedulerEnabled
            $result = $location | Set-AzsBackupConfiguration
            ValidateBackupLocation -BackupLocation $result

            $result                             | Should Not Be $Null
            $result.IsBackupSchedulerEnabled    | Should be $global:isBackupSchedulerEnabled
        }
        finally
        {
            if (Test-Path -Path $global:encryptionCertPath -PathType Leaf)
            {
                Remove-Item -Path $global:encryptionCertPath -Force -ErrorAction Continue
            }
        }
    }
}
