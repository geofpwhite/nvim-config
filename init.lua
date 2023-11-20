return {
  -- Configure AstroNvim updates
  --
  dap = {
    adapters = {
      python = {
        type = "executable",
        command = "env/debugpy/bin/python",
        args = { "-m", "debugpy.adapter" },
      },
    },
    configurations = {
      python = {
        {
          -- The first three options are required by nvim-dap
          type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
          request = "launch",
          name = "Launch file",
          -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

          program = "${file}", -- This configuration will launch the current file if used.
          pythonPath = function()
            -- -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            -- local cwd = vim.fn.getcwd()
            -- if vim.fn.executable(cwd .. "/env/bin/python3") == 1 then
            --   return cwd .. "/env/bin/python3"
            -- else
            --   return "/usr/bin/python3"
            -- end
            return "C:\\Users\\geof\\scoop\\apps\\python\\current\\python3.exe"
          end,
        },
      },
    },
  },
  highlights = {
    -- set highlights for all themes
    -- use a function override to let us use lua to retrieve colors from highlight group
    -- there is no default table so we don't need to put a parameter for this function
    init = function()
      local get_hlgroup = require("astronvim.utils").get_hlgroup
      -- get highlights from highlight groups
      --
      local normal = get_hlgroup "Normal"
      local fg, bg = normal.fg, normal.bg
      local bg_alt = bg
      local green = get_hlgroup("String").fg
      local red = get_hlgroup("Error").fg
      -- return a table of highlights for telescope based on colors gotten from highlight groups
      return {
        TelescopeBorder = { fg = bg_alt, bg = bg },
        TelescopeNormal = { bg = bg },
        TelescopePreviewBorder = { fg = bg, bg = bg },
        TelescopePreviewNormal = { bg = bg },
        TelescopePreviewTitle = { fg = bg, bg = green },
        TelescopePromptBorder = { fg = bg_alt, bg = bg_alt },
        TelescopePromptNormal = { fg = fg, bg = bg_alt },
        TelescopePromptPrefix = { fg = red, bg = bg_alt },
        TelescopePromptTitle = { fg = bg, bg = red },
        TelescopeResultsBorder = { fg = bg, bg = bg },
        TelescopeResultsNormal = { bg = bg },
        TelescopeResultsTitle = { fg = bg, bg = bg },
        CodewindowUnderline = { sp = bg },
        variable = { fg = "lightblue" },
        Attribute = { fg = "#56b6c2" },
        Function = { fg = "#dcccab" },
        property = { fg = "lightblue" },
        Field = { fg = "lightblue" },
        CursorLine = { bg = "Black" },
        CursorLineNC = { bg = "#1e222a" },
        NeoTreeCursorLine = { bg = "Black" },
        AerialLine = { bg = "Black" },
        Identifier = { fg = "pink" },
        Normal = { bg = "#1e1e1e", fg = "white" },
        NeoTreeNormal = { bg = "#1e1e1e" },
        NormalNC = { bg = "#191919" },
        NeoTreeNormalNC = { bg = "#191919" },
        DiagnosticInfo = { fg = "orange" },
        Method = { fg = "#dcdcaa" },
        Parameter = { fg = "lightblue" },
        Constructor = { fg = "#e06c75" },
        CursorLineNr = { fg = "lightpink gui=none" },
      }
    end,
  },
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
    remotes = {            -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  colorscheme = "astrodark",
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = false,
    underline = true,
  },
  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true,     -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {},
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    vim.keymap.set(
      "n",
      "<leader>\\",
      " :split | lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{ previewer = false })<cr> "
    )
    vim.keymap.set(
      "n",
      "<leader>|",
      ":vsplit| lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{ previewer = false })<cr> "
    )
    vim.keymap.set("n", "gR", ":lua vim.lsp.buf.references()<cr>")
    vim.keymap.set("n", "<leader>j", ":ToggleTerm direction=horizontal<cr>")
    vim.keymap.set("n", "<Tab>", "<C-w>w")
    vim.keymap.set("n", "<S-Tab>", "<C-w>W")
    vim.g.ui_notifications_enabled = false
    -- TelescopeNormal = { bg = bg },
    --        TelescopePreviewBorder = { fg = bg, bg = bg },
    --        TelescopePreviewNormal = { bg = bg },
    --        TelescopePreviewTitle = { fg = bg, bg = green },
    --        TelescopePromptBorder = { fg = bg_alt, bg = bg_alt },
    --        TelescopePromptNormal = { fg = fg, bg = bg_alt },
    --        TelescopePromptPrefix = { fg = red, bg = bg_alt },
    --        TelescopePromptTitle = { fg = bg, bg = red },
    --        TelescopeResultsBorder = { fg = bg, bg = bg },
    --        TelescopeResultsNormal = { bg = bg },

    vim.cmd ":nmap s ysiw"
    vim.cmd ":nmap <S-Space> za"
    vim.cmd ":vmap s S"
    vim.cmd ':imap <silent><script><expr> <S-Enter> copilot#Accept("<CR>")'
    vim.cmd ":let g:python3_host_prog='/opt/homebrew/Cellar/python@3.11/3.11.2_1/bin/python3.exe'"
    vim.cmd ":set autochdir"
    vim.cmd ":nmap <S-space> za"
    vim.cmd ":let g:copilot_enabled=0"
    vim.cmd ":hi DapUIVariable guifg=white"
    local Terminal = require("toggleterm.terminal").Terminal
    local bpytop = Terminal:new { cmd = "bpytop", hidden = true }
    function _bpytop_toggle() bpytop:toggle() end

    -- vim.cmd ":highlight Normal guibg=#191919"
    -- vim.cmd ":highlight NeoTreeNormal guibg=#1e1e1e"
    local status = require "astronvim.utils.status"
    require("heirline").setup {
      statuscolumn = {
        vim.fn.has "nvim-0.9" == 1 and {
          status.component.numbercolumn(),
          status.component.fill(),
          status.component.fill(),
          status.component.signcolumn(),
          status.component.foldcolumn(),
        } or nil,
      },
    }

    require("scrollbar").setup {
      excluded_filetypes = { "aerial", "neo-tree", "none" },
      excluded_buftypes = { "terminal" },
    }
    require("scrollbar.handlers.gitsigns").setup()
    local core = require "nougat.core"
    local Bar = require "nougat.bar"
    local bar_util = require "nougat.bar.util"
    local Item = require "nougat.item"
    local sep = require "nougat.separator"

    local nut = {
      buf = {
        diagnostic_count = require("nougat.nut.buf.diagnostic_count").create,
        filename = require("nougat.nut.buf.filename").create,
        filetype = require("nougat.nut.buf.filetype").create,
      },
      git = {
        branch = require("nougat.nut.git.branch").create,
        status = require "nougat.nut.git.status",
      },
      tab = {
        tablist = {
          tabs = require("nougat.nut.tab.tablist").create,
          close = require("nougat.nut.tab.tablist.close").create,
          icon = require("nougat.nut.tab.tablist.icon").create,
          label = require("nougat.nut.tab.tablist.label").create,
          modified = require("nougat.nut.tab.tablist.modified").create,
        },
      },
      mode = require("nougat.nut.mode").create,
      spacer = require("nougat.nut.spacer").create,
      truncation_point = require("nougat.nut.truncation_point").create,
    }

    local color = {
      bg = "#1d2021",
      bg0_h = "#1d2021",
      bg0 = "#282828",
      bg0_s = "#32302f",
      bg1 = "#3c3836",
      bg2 = "#504945",
      bg3 = "#665c54",
      bg4 = "#7c6f64",

      gray = "#928374",

      fg = "#ebdbb2",
      fg0 = "#fbf1c7",
      fg1 = "#ebdbb2",
      fg2 = "#d5c4a1",
      fg3 = "#bdae93",
      fg4 = "#a89984",

      lightgray = "#a89984",

      red = "#fb4934",
      green = "#b8bb26",
      yellow = "#fabd2f",
      blue = "#83a598",
      purple = "#d3869b",
      aqua = "#8ec07c",
      orange = "#f38019",

      accent = {
        red = "#cc241d",
        green = "#98971a",
        yellow = "#d79921",
        blue = "#458588",
        purple = "#b16286",
        aqua = "#689d6a",
        orange = "#d65d0e",
      },
    }

    local mode = nut.mode {
      sep_left = sep.left_half_circle_solid(true),
      sep_right = sep.right_half_circle_solid(true),
      config = {
        highlight = {
          normal = {
            bg = "fg",
            fg = color.bg,
          },
          visual = {
            bg = color.orange,
            fg = color.bg,
          },
          insert = {
            bg = color.blue,
            fg = color.bg,
          },
          replace = {
            bg = color.purple,
            fg = color.bg,
          },
          commandline = {
            bg = color.green,
            fg = color.bg,
          },
          terminal = {
            bg = color.accent.green,
            fg = color.bg,
          },
          inactive = {},
        },
      },
    }

    local filename = (function()
      local item = Item {
        prepare = function(_, ctx)
          local bufnr, data = ctx.bufnr, ctx.ctx
          data.readonly = vim.api.nvim_buf_get_option(bufnr, "readonly")
          data.modifiable = vim.api.nvim_buf_get_option(bufnr, "modifiable")
          data.modified = vim.api.nvim_buf_get_option(bufnr, "modified")
        end,
        sep_left = sep.left_half_circle_solid(true),
        content = {
          Item {
            hl = { bg = color.bg4, fg = color.fg },
            hidden = function(_, ctx) return not ctx.ctx.readonly end,
            suffix = " ",
            content = "RO",
          },
          Item {
            hl = { bg = color.bg4, fg = color.fg },
            hidden = function(_, ctx) return ctx.ctx.modifiable end,
            content = "",
            suffix = " ",
          },
          nut.buf.filename {
            hl = { bg = color.fg, fg = color.bg },
            prefix = function(_, ctx)
              local data = ctx.ctx
              if data.readonly or not data.modifiable then return " " end
              return ""
            end,
            suffix = function(_, ctx)
              local data = ctx.ctx
              if data.modified then return " " end
              return ""
            end,
          },
          Item {
            hl = { bg = color.bg4, fg = color.fg },
            hidden = function(_, ctx) return not ctx.ctx.modified end,
            prefix = " ",
            content = "+",
          },
        },
        sep_right = sep.right_half_circle_solid(true),
      }

      return item
    end)()

    local ruler = (function()
      local scroll_hl = {
        [true] = { bg = color.bg3 },
        [false] = { bg = color.bg4 },
      }

      local item = Item {
        content = {
          Item {
            hl = { bg = color.bg4 },
            sep_left = sep.left_half_circle_solid(true),
            content = core.group({
              core.code "l",
              ":",
              core.code "c",
            }, { align = "left", min_width = 8 }),
            suffix = " ",
          },
          Item {
            hl = function(_, ctx) return scroll_hl[ctx.is_focused] end,
            prefix = " ",
            content = core.code "P",
            sep_right = sep.right_half_circle_solid(true),
          },
        },
      }

      return item
    end)()

    -- renders space only when item is rendered
    ---@param item NougatItem
    local function paired_space(item)
      local hidden = item.hidden
      if type(hidden) == "boolean" then hidden = function(_, _) return item.hidden end end
      if type(hidden) == "function" then hidden = function(_, ctx) return item:hidden(ctx) end end

      return {
        content = sep.space().content,
        hidden = hidden,
      }
    end

    local stl = Bar "statusline"
    stl:add_item(mode)
    stl:add_item(sep.space())
    stl:add_item(nut.git.branch {
      hl = { bg = color.purple, fg = color.bg },
      sep_left = sep.left_half_circle_solid(true),
      prefix = " ",
      sep_right = sep.right_half_circle_solid(true),
    })
    stl:add_item(sep.space())
    local gitstatus = stl:add_item(nut.git.status.create {
      hl = { fg = color.bg },
      sep_left = sep.left_half_circle_solid(true),
      content = {
        nut.git.status.count("added", {
          hl = { bg = color.green },
          prefix = "+",
          suffix = function(_, ctx) return (ctx.gitstatus.changed > 0 or ctx.gitstatus.removed > 0) and " " or "" end,
        }),
        nut.git.status.count("changed", {
          hl = { bg = color.blue },
          prefix = function(_, ctx) return ctx.gitstatus.added > 0 and " ~" or "~" end,
          suffix = function(_, ctx) return ctx.gitstatus.removed > 0 and " " or "" end,
        }),
        nut.git.status.count("removed", {
          hl = { bg = color.red },
          prefix = function(_, ctx) return (ctx.gitstatus.added > 0 or ctx.gitstatus.changed > 0) and " -" or "-" end,
        }),
      },
      sep_right = sep.right_half_circle_solid(true),
    })
    stl:add_item(paired_space(gitstatus))
    stl:add_item(filename)
    stl:add_item(sep.space())
    stl:add_item(nut.spacer())
    stl:add_item(nut.truncation_point())
    stl:add_item(nut.buf.filetype {
      hl = { bg = color.blue, fg = color.bg },
      sep_left = sep.left_half_circle_solid(true),
      sep_right = sep.right_half_circle_solid(true),
    })
    stl:add_item(sep.space())
    local diagnostic_count = stl:add_item(nut.buf.diagnostic_count {
      hl = { bg = color.bg4 },
      sep_left = sep.left_half_circle_solid(true),
      sep_right = sep.right_half_circle_solid(true),
      config = {
        error = { prefix = " ", fg = color.red },
        warn = { prefix = " ", fg = color.yellow },
        info = { prefix = " ", fg = color.blue },
        hint = { prefix = " ", fg = color.green },
      },
    })
    stl:add_item(paired_space(diagnostic_count))
    stl:add_item(ruler)
    stl:add_item(sep.space())

    local stl_inactive = Bar "statusline"
    stl_inactive:add_item(mode)
    stl_inactive:add_item(sep.space())
    stl_inactive:add_item(filename)
    stl_inactive:add_item(sep.space())
    stl_inactive:add_item(nut.spacer())
    stl_inactive:add_item(ruler)
    stl_inactive:add_item(sep.space())

    bar_util.set_statusline(function(ctx) return ctx.is_focused and stl or stl_inactive end)

    local tal = Bar "tabline"

    tal:add_item(nut.tab.tablist.tabs {
      active_tab = {
        hl = { bg = color.bg0_h, fg = color.blue },
        prefix = " ",
        suffix = " ",
        content = {
          nut.tab.tablist.icon { suffix = " " },
          nut.tab.tablist.label {},
          nut.tab.tablist.modified { prefix = " ", config = { text = "●" } },
          nut.tab.tablist.close { prefix = " ", config = { text = "󰅖" } },
        },
        sep_left = sep.left_half_circle_solid { bg = "bg", fg = color.bg0_h },
        sep_right = sep.right_half_circle_solid { bg = "bg", fg = color.bg0_h },
      },
      inactive_tab = {
        hl = { bg = color.bg2, fg = color.fg2 },
        prefix = " ",
        suffix = " ",
        content = {
          nut.tab.tablist.icon { suffix = " " },
          nut.tab.tablist.label {},
          nut.tab.tablist.modified { prefix = " ", config = { text = "●" } },
          nut.tab.tablist.close { prefix = " ", config = { text = "󰅖" } },
        },
        sep_left = sep.left_half_circle_solid { bg = "bg", fg = color.bg2 },
        sep_right = sep.right_half_circle_solid { bg = "bg", fg = color.bg2 },
      },
    })

    bar_util.set_tabline(tal)
  end,
}
