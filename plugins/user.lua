return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "karb94/neoscroll.nvim",
    lazy = false,
    config = function()
      require("neoscroll").setup {
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = false, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
        performance_mode = true, -- Disable "Performance Mode" on all buffers.
      }
    end,
  },
  {
    "MunifTanjim/nougat.nvim",
  },
  { "jremmen/vim-ripgrep", lazy = false },
  { "tpope/vim-unimpaired", lazy = false },
  { "tpope/vim-surround", lazy = false },
  { "tpope/vim-repeat", lazy = false },
  {
    lazy = false,
    "chentoast/marks.nvim",
    config = function()
      require("marks").setup {
        default_mappings = true,
        -- which builtin marks to show. default {}
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = true,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = "⚑",
          annotate = false,
        },
        mappings = {},
      }
    end,
  },
  { lazy = false, "phaazon/hop.nvim", config = function() require("hop").setup() end },
  -- { "zefei/vim-wintabs", lazy = false },
  { lazy = false, "tiagovla/scope.nvim", config = function() require("scope").setup() end },
  {
    "gorbit99/codewindow.nvim",
    lazy = false,
    config = function()
      require("codewindow").setup {
        exclude_filetypes = { "aerial", "neo-tree", "none" },
      }
      require("codewindow").apply_default_keybinds()
    end,
  },
  { lazy = false, "kevinhwang91/nvim-bqf", config = function() require("bqf").setup() end },
  { "navarasu/onedark.nvim", lazy = false },
  { "martinsione/darkplus.nvim", lazy = false },
  { "petertriho/nvim-scrollbar", lazy = false },
  { "Mofiqul/vscode.nvim", lazy = false },
  { "askfiy/visual_studio_code", lazy = false },
  { "maxmx03/fluoromachine.nvim", lazy = false },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function() require("go").setup() end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  { "romainl/vim-qf", lazy = false },
}
