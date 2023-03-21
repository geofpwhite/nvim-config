-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  -- i = {
  --   ["kj"] = { "<Esc>" },
  -- },
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    [";"] = { ":" },
    ["H"] = { ":bp<cr>" },
    ["L"] = { ":bn<cr>" },
    ["f"] = { "<cmd>HopWordMW<cr>" },
    ["gr"] = { "<cmd>lua vim.lsp.buf.references()<cr>" },
    ["<leader>\\"] = { "<cmd>split | Telescope buffers <cr>" },
    ["<leader><S-\\>"] = { "<cmd>vsplit | Telescope buffers <cr>" },
    ["<leader>o"] = { "<cmd>AerialToggle<cr>", desc = "symbol outline" },
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bd"] = { "<cmd>WintabsClose<cr>" },
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
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
