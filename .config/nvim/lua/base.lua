-- encoding
vim.o.encofing = 'utf-8'
vim.scriptencoding = 'utf-8'

-- visual
vim.o.ambiwidth = 'double'
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true

vim.o.visualbell = true
vim.o.number = true
vim.o.showmatch = true
vim.o.matchtime = 1

-- search
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':nohl<CR>', { noremap = true, silent = true})

-- complete
vim.o.completeopt = 'menuone,noinsert'
-- 補完表示時のEnterでは改行しない
vim.api.nvim_set_keymap('i', '<CR>', 'pumvisible() ? "<C-y>" : "<CR>"', { expr = true })
-- 矢印キーにCtrl+n, Ctrl+pを割り当てる
vim.api.nvim_set_keymap('i', '<C-n>', 'pumvisible() ? "<Down>" : "<C-n>"', { expr = true })
vim.api.nvim_set_keymap('i', '<C-p>', 'pumvisible() ? "<Up>" : "<C-p>"', { expr = true })

-- manipulation
vim.g.mapleader = ' '
vim.opt.clipboard:append{'unnamedplus'}
vim.o.ttimeout = true
vim.o.ttimeoutlen = 50

vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath('cache') .. '/undo'

vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })
vim.api.nvim_set_keymap('n', '<Down>', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', '<Up>', 'gk', { noremap = true })
vim.api.nvim_set_keymap('n', 'gj', 'j', { noremap = true })
vim.api.nvim_set_keymap('n', 'gk', 'k', { noremap = true })

-- github copilot https://zenn.dev/hirokisan/articles/8f2c9ca238d8b1
polish = function()
  vim.g.copilot_no_tab_map = true
  vim.api.nvim_set_keymap('i', '<C-g>', 'copilot#Accept("<CR>")', {silent = true, expr = true, script = true, replace_keycodes = false })
  vim.api.nvim_set_keymap('i', '<C-j>', '<Plug>(copilot-next)')
  vim.api.nvim_set_keymap('i', '<C-k>', '<Plug>(copilot-previous)')
  vim.api.nvim_set_keymap('i', '<C-o>', '<Plug>(copilot-dismiss)')
  vim.api.nvim_set_keymap('i', '<C-s>', '<Plug>(copilot-suggest)')
end
