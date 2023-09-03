-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  v = {
    ["="] = { "c<C-r>=<C-r>\"<Esc>jk" }
  },
  i = {
    ["<C-Enter>"] = { "<Esc>o" },
  },
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    [";"] = { ":" },
    ["H"] = { ":bp<cr>" },
    ["L"] = { ":bn<cr>" },
    ["f"] = { "<cmd>HopWordMW<cr>" },
    ["gr"] = { function() vim.lsp.buf.references() end },
    ["<leader>lps"]= {"<cmd>lua _bpytop_toggle()<cr>"},
    ["<leader>\\"] = { "<cmd>split | Telescope buffers <cr>" },
    -- ["<leader><S-\\>"] = { "<cmd>vsplit | Telescope buffers <cr>" },
    ["<leader>o"] = { "<cmd>AerialToggle<cr>", desc = "symbol outline" },
    ["<leader>O"] = { "<cmd>AerialNavToggle<cr>", desc = "symbol goto" },

    ["<leader>|"] = { "<cmd>vsplit | Telescope buffers <cr>" },
    -- ["<leader><S-|>"] = { "<cmd>vsplit | Telescope buffers <cr>" },
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },

    ["<leader>bd"] = { "<cmd>WintabsClose<cr>" },
    ["<leader>E"] = { "<cmd>Neotree current float<cr>" },
    ["<leader>Q"] = { ":qa!<cr>" },
    ["<leader>gP"] = {
      ":tabe ~/documents/ufc_flutter_django/ufc_flutter_django/FighterSearch/src/app/app.component.ts<cr>:tabe ~/documents/ufc_flutter_django/ufc_flutter_django/djangoUFCbackend<cr>", desc =
    "open ufc project" },
    ["<leader>e"] = { "<cmd>Neotree current left toggle filesystem<cr>" },
    ["<leader>bD"] = {

      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {
    ["<Esc>"] = { "<C-\\><C-n>" },
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
