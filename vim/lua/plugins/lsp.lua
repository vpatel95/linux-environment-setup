return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          mason = true,
        },
        clangd = {
          mason = true,
          name = "clangd",
          cmd = {
            "clangd",
            "--background-index",
            "-j=4",
            "--clang-tidy",
            "--header-insertion=never",
            "--completion-style=detailed",
            "--function-arg-placeholders",
          },
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          filetypes = { "c", "cc", "cpp", "h", "hh", "hpp", "proto" },
          root_dir = require("lspconfig.util").root_pattern("compile_commands.json"),
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
        basedpyright = {
          mason = true,
          name = "basedpyright",
          root_dir = require("lspconfig.util").root_pattern(
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "requirements.txt",
            "Pipfile",
            "pyrightconfig.json",
            ".git"
          ),
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "off",
                diagnosticMode = "openFilesOnly",
                autoImportCompletions = true,
              },
            },
          },
        },
        gopls = {
          enabled = false,
          mason = true,
          name = "gopls",
          cmd = { "gopls" },
          root_dir = require("lspconfig.util").root_pattern("go.mod", "go.sum", "go.work", ".git"),
          settings = {
            gopls = {
              experimentalPostfixCompletions = true,
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
            },
          },
          init_options = {
            usePlaceholders = true,
          },
        },
      },
    },
  },
}
