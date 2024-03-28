# Delete tags
This will delete tags with any particular keyword
Note: You have to genrate a PAT which has delete access in it. The default github token doesnot have delete access. 

# Example
```yaml
name: Delete Tag

on:
  workflow_dispatch:

jobs:
  delete:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Execute Delete Release/Tag action
        uses: ShivamHS/delete-tag@v2
        with:
          token: ${{ secrets.REPO_TOKEN }} #generate new PAT and give delete access to it
          repo:  your-repo-name
          owner: repo-owner
          keyword: any-keyword-to-look-while-deleting
          deletetype: "tag/release/tr" #tag: will delete tags only; release: will delete releases only; tr: will delete both releases and tags
