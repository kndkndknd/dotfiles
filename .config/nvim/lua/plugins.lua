-- https://github.com/nvim-tree/nvim-tree.lua
-- filer
-- keys property Example for neo-tree.nvim
-- cf https://zenn.dev/vim_jp/articles/20231113vim_ekiden
return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      })
    end,
    keys = {
      {mode = "n", "<C-n>", "<cmd>NvimTreeToggle<CR>", desc = "NvimTreeをトグルする"},
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = { "lua", "typescript" },
        sync_install = true,
    }, 
  },
  {
    --colorscheme
    'blueshirts/darcula',
    config = function()
      vim.cmd([[colorscheme darcula]])
    end
  },
  'editorconfig/editorconfig-vim'
}
