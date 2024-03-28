$token = $env:INPUT_TOKEN
$repo = $env:INPUT_REPO
$keyword = $env:INPUT_KEYWORD


 Write-Host "repo: $repo"
 Write-Host "keyword: $keyword"


$tagsUrl = "https://api.github.com/repos/$repo/git/refs/tags"
$headers = @{
    "Authorization" = "token $token"
    "User-Agent" = "PowerShell-GitHub-Tag-Deletion"
}

 

$response = Invoke-RestMethod -Uri $tagsUrl -Headers $headers -Method Get

Write-Host "tagurl: $tagsurl"
 

foreach ($tag in $response) {
    $tagName = $tag.url

 

    
    if ($tagName -like "*$keyword*") {
        
        Invoke-RestMethod -Uri $tagname -Headers $headers -Method Delete
        Write-Host "Deleted tag: $tagName"
    }
}
