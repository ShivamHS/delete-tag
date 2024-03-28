param (
    [string]$owner = $env:INPUT_OWNER,
    [string]$token = $env:INPUT_TOKEN,
    [string]$repo = $env:INPUT_REPO,
    [string]$deleteType = $env:INPUT_DELETETYPE,
    [string]$keyword =  $env:INPUT_KEYWORD
)

Write-Host "$deleteType"
$headers = @{
    "Authorization" = "token $token"
    "User-Agent" = "PowerShell-GitHub-Action"
}

if ($deleteType -eq "tag") {
    $url = "https://api.github.com/repos/$owner/$repo/git/refs/tags"
    DeleteTags
} elseif ($deleteType -eq "release") {
    $url = "https://api.github.com/repos/$owner/$repo/releases"
    DeleteReleases
} elseif ($deleteType -eq "tr") {
    $urlTags = "https://api.github.com/repos/$owner/$repo/git/refs/tags"
    DeleteTags
    $urlReleases = "https://api.github.com/repos/$owner/$repo/releases"
    DeleteReleases
} else {
    Write-Host "Invalid delete type. Please enter 'tag', 'release', or 'tr'."
    Exit
}

function DeleteTags {
    $response = Invoke-RestMethod -Uri $urlTags -Headers $headers -Method Get

    foreach ($tag in $response) {
        $tagName = $tag.ref

        if ($tagName -like "*$keyword*") {
            $deleteUrl = "https://api.github.com/repos/$owner/$repo/git/$tagName"
            Invoke-RestMethod -Uri $deleteUrl -Headers $headers -Method Delete
            Write-Host "Deleted tag: $tagName"
        }
    }
}

function DeleteReleases {
    $response = Invoke-RestMethod -Uri $urlReleases -Headers $headers -Method Get

    foreach ($release in $response) {
        $releaseVersion = $release.name

        if ($releaseVersion -like "*$keyword*") {
            $deleteUrl = $release.url
            Invoke-RestMethod -Uri $deleteUrl -Headers $headers -Method Delete
            Write-Host "Deleted release: $releaseVersion"
        }
    }
}
