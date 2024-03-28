$token = $env:INPUT_TOKEN
$repo = $env:INPUT_REPO
$keyword = $env:INPUT_KEYWORD
$owner = $env:INPUT_OWNER

$tagsUrl = "https://api.github.com/repos/$owner/$repo/git/refs/tags"
$headers = @{
    "Authorization" = "token $token"
    "User-Agent" = "PowerShell-GitHub-Tag-Deletion"
}

Write-Host "$tagsUrl"

$response = Invoke-RestMethod -Uri $tagsUrl -Headers $headers -Method Get

 

foreach ($tag in $response) {
    $tagName = $tag.url

 

    
    if ($tagName -like "*$keyword*") {
        
        $deleteUrl = "https://api.github.com/repos/$owner/$repo/git/$tagName"
        Invoke-RestMethod -Uri $tagname -Headers $headers -Method Delete
        Write-Host "Deleted tag: $tagName"
    }
}
