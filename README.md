# Delete tags
This will delete tags with any particular keyword

# Example
```yaml
name: Delete Tag

on:
  push:
    branches:
      - main  # Trigger the workflow on pushes to the main branch. Adjust if needed.

jobs:
  delete:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Execute Delete Release/Tag action
        uses: ShivamHS/delete-tag@v0.0.0
        with:
          owner: ${{ secrets.REPO_OWNER }}
          token: ${{ secrets.GITHUB_TOKEN }}
          repo: ${{ github.repository }}
          deleteType: "tr"  # Change this according to your needs
          keyword: "your-keyword"
