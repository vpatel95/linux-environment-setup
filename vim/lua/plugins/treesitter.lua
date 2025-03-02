local get_treesitter_dir = function()
  local dir = "/ws/vedpatel-sjc/rhel8/treesitter"
  if vim.fn.isdirectory(dir) ~= 0 then
    vim.opt.runtimepath:prepend(dir)
    return dir
  end
  vim.notify("Treesitter parser dir '" .. dir .. "'' not found")
  return nil
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      parser_install_dir = get_treesitter_dir(),
      matchup = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "diff",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "vim",
        "yaml",
        "make",
      },
    },
  },
}
