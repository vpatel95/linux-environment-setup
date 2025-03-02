# nvim

## Setup

### Pre-reqs
Set following environment variables in your RC files

1. `SDK_DIR` --> point to your sdk repo
2. `NPSUITE_DIR` --> point to your npsuite repo

### Installation
There are two ways to setup the Neovim config
1. Create soft link to all the lua config files
2. Create a copy of all the lua config files

#### Soft link
`bash setup.sh nvim-ln`

#### Copy
`bash setup.sh nvim-cp`

Additionally if you run into home directory space issue, set following
enviroment variables

```
export XDG_DATA_HOME=$WS/.local/share
export XDG_STATE_HOME=$WS/.local/state
export XDG_CACHE_HOME=$WS/.local/cache
```

### NPL Language Server

NP Suite team publishes NPL Language server for VS Code. We can leverage the
same to setup the LS with neovim-lspconfig. The repo already has
neovim-lspconfig setup in lua files. We just need to download and extract the
language server.

#### Download

1. Download the vsix extension bundle from : https://engci-maven-master.cisco.com/artifactory/list/leaba-others/ide-releases/npl-extension-2.9.0.vsix
2. Extract the vsix just like any other compressed bundle.

#### Update the NPL LS config

1. Update the `~/.config/nvim/lua/lsp/custom/npl.lua` file and point to directory where extention is extracted.


#### Docs

1. [Keymap shortcuts](docs/keymaps.md)
2. [Tasks](docs/tasks.md)
