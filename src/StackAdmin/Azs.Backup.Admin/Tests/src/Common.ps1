# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------


$global:SkippedTests = @(
)

$global:Location = "local"
$global:Provider = "Microsoft.Backup.Admin"
$global:ResourceGroupName = "System.local"
$global:username = "azurestack\AzureStackAdmin"
[SecureString]$global:password = ConvertTo-SecureString -String "password" -AsPlainText -Force
$global:path = "\\su1fileserver\SU1_Infrastructure_2\BackupStore"
[SecureString]$global:encryptionKey = ConvertTo-SecureString -String "MIIDPzCCAiegAwIBAgIQLeqM7fek06pOGOJ+fU/bfDANBgkqhkiG9w0BAQsFADAhMR8wHQYDVQQDDBZ3d3cuaGFoYS5ub3Rzb211Y2guY29tMB4XDTE4MDgyODA2MzcyMVoXDTE5MDgyODA2NTcyMVowITEfMB0GA1UEAwwWd3d3LmhhaGEubm90c29tdWNoLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANqODsU5P1j257arMxu3KEFmmW5swahCOgmoyd3EBsnWwTfdOD6OiAep/ubLpjsmWRlzroTBPTnLbZVC6OxNsvdGQx30EeOfGF9JBd7xbhXYeT668GwPuTlVBeDYOSO4qbnHsLJSvoxHkaMEiq6TqrIgnmr/WRG1Kd4iZ+goSth3A+Eck1KpaQ1r1KxSWazNChPU6gQ6+/Slhxydse7mMsbSCJkzPeZ5YppmUBbbk3GOQj/2+aLMYCyPe2kosMZFr37owRP6bL7hKXyyUBUyQWQTau/fMQ369WJO9wWdYb+z5vQbgZV81qeXcJWu6H+VkL1qNrMfPuh6ET5wM5ZDU80CAwEAAaNzMHEwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDATAhBgNVHREEGjAYghZ3d3cuaGFoYS5ub3Rzb211Y2guY29tMB0GA1UdDgQWBBRh/K5ZaNGyX406dYi0U5rrKaguQjANBgkqhkiG9w0BAQsFAAOCAQEAR4EbToyzUSZHz/Q4aajSyrIukcqJr7IiWs+uDVuqEAUqb6BD5wbkNMvZlSmahLPGm2bXnuboB6W4xEctph1bMVx/up7G3p8aKM4kC/34wBOJCIlJqp9MCUW9zDDR5+BOiS2N1gDgqdBKDFcPjUC9bd7UM6xLL6T1EL5tka1UF36YuHlntfWUGsfWdaM0iC6eG4H2WVx7jhuRGYkiaLJ1v7BVqgXSUV4kiUPTC6T6UuGp7Exkoy6v4+4e1Aj6yCHib70lvSGM+i06j+AFt+tMmEprOgOglC/ZjyKuN3qm7Dt21IDf9BHf5eOtPXTQ4foN55qHJ7qhzGQOje5P5jUrfg==" -AsPlainText -Force
$global:isBackupSchedulerEnabled = $false
$global:backupFrequencyInHours = 10
$global:backupRetentionPeriodInDays = 6

$global:Client = $null

if (-not $global:RunRaw) {
    $scriptBlock = {
        if ($null -eq $global:Client) {
            $global:Client = Get-MockClient -ClassName 'BackupAdminClient' -TestName $global:TestName -Verbose
        }
        return $global:Client
    }
    Mock New-ServiceClient $scriptBlock -ModuleName $global:ModuleName
}

if (Test-Path "$PSScriptRoot\Override.ps1") {
    . $PSScriptRoot\Override.ps1
}
