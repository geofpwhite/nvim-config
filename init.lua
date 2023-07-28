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
            return "/opt/homebrew/bin/python3"
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
        CodewindowUnderline = { sp = bg }
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
    virtual_text = true,
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
    vim.keymap.set("n", "<leader>\\", ":split | Telescope buffers<cr>")
    vim.keymap.set("n", "<leader>|", ":vsplit| Telescope buffers<cr>")
    vim.keymap.set("n", "gR", ":lua vim.lsp.buf.references()<cr>")
    vim.keymap.set("n", "<leader>j", ":ToggleTerm direction=horizontal<cr>")
    vim.keymap.set("n", "<Tab>", "<C-w>w")
    vim.keymap.set("n", "<S-Tab>", "<C-w>W")
    vim.g.ui_notifications_enabled = true
    vim.cmd "hi CodewindowBorder guifg=#1e222a guibg=#1e222a<cr>"
    vim.cmd ":nmap s ysiw"
    vim.cmd ":nmap <S-Space> za"
    vim.cmd ":vmap s S"
    vim.cmd ":highlight @variable guifg=lightblue"
    vim.cmd ":highlight @attribute guifg=#56b6c2"
    vim.cmd ":highlight @function guifg=#dcccab"
    vim.cmd ":highlight @function guifg=#dcccab"
    vim.cmd ":highlight @function.builtin guifg=#61afef"
    vim.cmd ":highlight @property guifg=lightblue"
    vim.cmd ":highlight @field guifg=lightblue"
    vim.cmd ":highlight CursorLine guibg=Black"
    vim.cmd ":highlight CursorLineNC guibg=#1e222a"
    vim.cmd ":highlight NeoTreeCursorLine guibg=Black"
    vim.cmd ":highlight AerialLine guibg=Black"
    vim.cmd ":highlight Identifier guifg=pink"
    vim.cmd ":highlight Normal guibg=#1e1e1e"
    vim.cmd ":highlight NeoTreeNormal guibg=#1e1e1e"
    vim.cmd ":highlight NormalNC guibg=#191919"
    vim.cmd ":highlight NeoTreeNormalNC guibg=#191919"
    vim.cmd ":highlight DiagnosticInfo guifg=grey"
    vim.cmd ":highlight DiagnosticInfo guifg=orange"
    vim.cmd ":highlight @method guifg=#dcdcaa"
    vim.cmd ":highlight @parameter guifg=lightblue"
    vim.cmd ":highlight @constructor guifg=#e06c75"
    vim.cmd ":highlight TelescopePromptBorder guifg=#1e1e1e"
    vim.cmd ":highlight TelescopeResultsBorder guifg=#1e1e1e"
    vim.cmd ":highlight TelescopePreviewBorder guifg=#1e1e1e"
    vim.cmd ":highlight CodewindowUnderline guifg=#1e1e1e gui=none"
    vim.cmd ":highlight CursorLineNr guifg=lightpink gui=none"
    vim.cmd ":imap <silent><script><expr> <S-Enter> copilot#Accept(\"<CR>\")"
    vim.cmd ":let g:python3_host_prog='/opt/homebrew/Cellar/python@3.11/3.11.2_1/bin/python3'"
    vim.cmd ":set autochdir"
    vim.cmd ":nmap <S-space> za"
    vim.cmd ":let g:copilot_enabled=0"
    vim.cmd ":hi DapUIVariable guifg=white"

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
    -- cmp.setup {
    --   mapping = {
    --     ["<Tab>"] = cmp.mapping(function(fallback)
    --       if cmp.visible() then
    --         cmp.select_next_item()
    --       elseif luasnip.expand_or_jumpable() then
    --         luasnip.expand_or_jump()
    --       elseif cmp.has_words_before() then
    --         cmp.complete()
    --       else
    --         vim.cmd("copilot#Accept()")
    --       end
    --     end, { "i", "s" }),
    --     ['<C-s>'] = cmp.mapping.complete({
    --       config = {
    --         sources = {
    --           { name = 'vsnip' }
    --         }
    --       }
    --     })
    --   }
    -- }
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}
