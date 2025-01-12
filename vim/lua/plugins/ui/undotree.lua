return {
  {
      "mbbill/undotree",
      config = function()
          local undo_dir = vim.fn.stdpath("config") .. "/.undoes"
          if vim.fn.isdirectory(undo_dir) == 0 then
              vim.fn.mkdir(undo_dir, "p", 0755)
          end

          vim.o.undodir = undo_dir
          vim.o.undofile = true

          vim.g.undotree_WindowLayout = 4
          vim.g.undotree_ShortIndicators = 1
          vim.g.undotree_SetFocusWhenToggle = 1
      end
  },
}
