local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "nvim-neotest/neotest",
      version = "v5.7.0",
      dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        { "fredrikaverpil/neotest-golang", version = "v1.7.1" }, -- Installation
      },
      config = function()
        require("neotest").setup({
          adapters = {
            require("neotest-golang"), -- Registration
          },
        })
      end,
    },
    {
      "willothy/flatten.nvim",
      -- version = 'v0.5.1',
      opts = {},
      lazy = false,
    },
    {

      "nvim-treesitter/nvim-treesitter",
      version = "*",
      event = "VeryLazy",
      dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      build = ":TSUpdate",
      config = function()
        vim.defer_fn(function()
          require("nvim-treesitter.configs").setup({
            ensure_installed = { "go" },
            auto_install = true,
            sync_install = false,
            ignore_install = {},
            modules = {},
            highlight = { enable = true },
            indent = { enable = true },
          })
        end, 0)
      end,
    },
  },
  dev = {
    ---@type string | fun(plugin: LazyPlugin): string directory where you store your local plugin projects
    path = "/workspaces",
    ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = { "willothy" }, -- For example {"folke"}
    fallback = true, -- Fallback to git when local plugin doesn't exist
  },
  checker = { enabled = true },
})
