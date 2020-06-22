# Big Data

## Homebrew

Currently overriding the local homebrew-core files to preserve the versions and make minor changes

`/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core`

After pinning the formula it is safe to run

`brew update && brew upgrade`

If there are changes to the remote brew update will stash the changes.

`stash pop`

## Appendix

### check if a port is in use

lsof -i :2181

### show pinned formulas

brew list --pinned
