-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

require("packer").startup(function()
  -- 起動時に読み込むプラグインを書いてください。
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
    'neoclide/coc.nvim',
    branch = "release"
  }
  use 'prettier/vim-prettier'
  use 'github/copilot.vim'

  -- https://github.com/iamcco/markdown-preview.nvim
  -- install without yarn or npm
  use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

  -- https://github.com/nvim-tree/nvim-tree.lua
  -- filer
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'

  -- colorscheme
  -- https://github.com/EdenEast/nightfox.nvim
  use "EdenEast/nightfox.nvim"

end)
