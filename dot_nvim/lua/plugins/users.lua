-- ---- Users Plugins ----

-- Please uncomment belows and rename this file to 'users.lua' to enable it.

local lua_keys = require("builtin.utils.plugin").lua_keys
local lua_init = require("builtin.utils.plugin").lua_init
local lua_config = require("builtin.utils.plugin").lua_config
local vim_init = require("builtin.utils.plugin").vim_init
local vim_config = require("builtin.utils.plugin").vim_config

local VeryLazy = "VeryLazy"
local BufReadPre = "BufReadPre"
local BufNewFile = "BufNewFile"
local CmdlineEnter = "CmdlineEnter"
local VimEnter = "VimEnter"
local InsertEnter = "InsertEnter"
local UIEnter = "UIEnter"

return {
  -- Lazygit
  {
    "kdheepak/lazygit.nvim",
    init = lua_init("kdheepak/lazygit.nvim"),
    keys = lua_keys("kdheepak/lazygit.nvim"),
  },
  -- Yank
  {
    "gbprod/yanky.nvim",
    config = lua_config("gbprod/yanky.nvim"),
    keys = lua_keys("gbprod/yanky.nvim"),
  },

  -- Cursor motion
  {
    "smoka7/hop.nvim",
    event = { VeryLazy, BufReadPre, BufNewFile },
    version = "*",
    config = lua_config("smoka7/hop.nvim"),
    keys = lua_keys("smoka7/hop.nvim"),
  },
  {
    "ggandor/leap.nvim",
    event = { VeryLazy, BufReadPre, BufNewFile },
    dependencies = { "tpope/vim-repeat" },
    config = lua_config("ggandor/leap.nvim"),
  },
  {
    "ggandor/flit.nvim",
    event = { VeryLazy, BufReadPre, BufNewFile },
    dependencies = { "ggandor/leap.nvim", "tpope/vim-repeat" },
    config = lua_config("ggandor/flit.nvim"),
  },
  {
    "folke/flash.nvim",
    event = { VeryLazy, BufReadPre, BufNewFile },
    config = lua_config("folke/flash.nvim"),
    keys = lua_keys("folke/flash.nvim"),
  },
  -- Java
  -- {
  --   "nvim-java/nvim-java",
  --   dependencies = {
  --     "nvim-java/lua-async-await",
  --     "nvim-java/nvim-java-core",
  --     "nvim-java/nvim-java-test",
  --     "nvim-java/nvim-java-dap",
  --     "MunifTanjim/nui.nvim",
  --     "neovim/nvim-lspconfig",
  --     "mfussenegger/nvim-dap",
  --     "williamboman/mason.nvim",
  --   },
  --   event = { VeryLazy, InsertEnter, CmdlineEnter },
  --   config = lua_config("nvim-java/nvim-java"),
  -- },
  -- -- Copilot
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   event = { VeryLazy, InsertEnter, CmdlineEnter },
  --   config = lua_config("zbirenbaum/copilot-cmp"),
  -- },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   event = { VeryLazy, InsertEnter, CmdlineEnter },
  --   config = lua_config("zbirenbaum/copilot.lua"),
  -- },
  -- -- Codeium
  -- {
  --   "Exafunction/codeium.nvim",
  --   event = { VeryLazy, BufReadPre, BufNewFile, CmdlineEnter },
  --   config = lua_config("Exafunction/codeium.nvim"),
  -- },
  -- UI improved
  {
    "folke/noice.nvim",
    event = { VimEnter },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = lua_config("folke/noice.nvim"),
  },
  {
    "rcarriga/nvim-notify",
    config = lua_config("rcarriga/nvim-notify"),
    lazy = true,
  },
  -- Oil file manager
  {
    "stevearc/oil.nvim",
    config = lua_config("stevearc/oil.nvim"),
    keys = lua_keys("stevearc/oil.nvim"),
  },
  -- Auto save
  {
    "Pocco81/auto-save.nvim",
    cmd = { "ASToggle" },
    event = { VeryLazy, BufReadPre, BufNewFile },
    config = lua_config("Pocco81/auto-save.nvim"),
    keys = lua_keys("Pocco81/auto-save.nvim"),
  },
  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = { VeryLazy, CmdlineEnter },
    config = lua_config("akinsho/toggleterm.nvim"),
    keys = lua_keys("akinsho/toggleterm.nvim"),
  },
  -- Generate documents
  {
    "danymat/neogen",
    cmd = { "Neogen" },
    dependencies = { "L3MON4D3/LuaSnip" },
    config = lua_config("danymat/neogen"),
    keys = lua_keys("danymat/neogen"),
  },
  -- Undo tree
  {
    "mbbill/undotree",
    event = { VeryLazy, CmdlineEnter },
    init = lua_init("mbbill/undotree"),
    keys = lua_keys("mbbill/undotree"),
  },
  -- Better markdown previewer for github
  {
    "wallpants/github-preview.nvim",
    cmd = { "GithubPreviewToggle" },
    keys = lua_keys("wallpants/github-preview.nvim"),
    config = lua_config("wallpants/github-preview.nvim"),
  },
  -- Vim/Neovim api version helper
  {
    "tweekmonster/helpful.vim",
    cmd = { "HelpfulVersion" },
  },
  -- Todo comments
  {
    "folke/todo-comments.nvim",
    event = { VeryLazy, BufReadPre, BufNewFile },
    config = lua_config("folke/todo-comments.nvim"),
  },
  -- Url viewer
  {
    "axieax/urlview.nvim",
    cmd = { "UrlView" },
    config = lua_config("axieax/urlview.nvim"),
    keys = lua_keys("axieax/urlview.nvim"),
  },
  -- Tags generator
  {
    "linrongbin16/gentags.nvim",
    event = { VeryLazy },
    config = lua_config("linrongbin16/gentags.nvim"),
  },
  -- Diagnostic
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh" },
    config = lua_config("folke/trouble.nvim"),
    keys = lua_keys("folke/trouble.nvim"),
  },
  -- Json schema
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
  },
  -- Search and replace
  {
    "nvim-pack/nvim-spectre",
    cmd = { "Spectre" },
    config = lua_config("nvim-pack/nvim-spectre"),
  },
  -- Project/local configuration
  {
    "folke/neoconf.nvim",
    config = lua_config("folke/neoconf.nvim"),
  },
  -- Lsp configuration
  {
    "folke/neodev.nvim",
    dependencies = { "folke/neoconf.nvim" }, -- neoconf must be setup before neodev
    config = lua_config("folke/neodev.nvim"),
  },
  -- Lsp server GC
  {
    "Zeioth/garbage-day.nvim",
    event = { VeryLazy },
    dependencies = { "neovim/nvim-lspconfig" },
    config = lua_config("Zeioth/garbage-day.nvim"),
  },
  -- Mark word
  {
    "inkarkat/vim-ingo-library",
    lazy = true,
  },
  {
    "inkarkat/vim-mark",
    event = { CmdlineEnter },
    dependencies = { "inkarkat/vim-ingo-library" },
    init = lua_init("inkarkat/vim-mark"),
    keys = lua_keys("inkarkat/vim-mark"),
  },
}

