require "base"
require "config/keymaps"
require "helper"

vim.loader.enable()
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins",
{
	ui = {
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
	checker = {
		enabled = true, -- プラグインのアップデートを自動的にチェック
	},
	diff = {
		cmd = "delta",
	},
	rtp = {
		disabled_plugins = {
			"gzip",
			"matchit",
			"matchparen",
			"netrwPlugin",
			"tarPlugin",
			"tohtml",
			"tutor",
			"zipPlugin",
		},
	},
})

-- 不可視文字の表示
vim.opt.list = true
vim.opt.listchars = {
    tab = ">>",
    trail = "-",
    nbsp = "+",
}

-- 常にインサートモードでTerminalを開く
vim.api.nvim_create_autocmd({ "TermOpen" }, { 
  group = vim.api.nvim_create_augroup("AutoCommands", {}),
  pattern = { "term://*" },
  command = "startinsert",
})


-- nvim-tree

-- nvim-treeを起動時に開く
-- automated settings
local function open_nvim_tree()
	require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- showing the tree of my current buffer from where i open up nvim-tree
vim.g.nvim_tree_respect_buf_cwd = 1


require("nvim-tree").setup
{
	sort_by = 'extension',
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	view = {
		width = '20%',
		side = 'left',
		signcolumn = 'no',
	},

	renderer = {
		highlight_git = true,
		highlight_opened_files = 'name',
		icons = {
			glyphs = {
				git = {
					unstaged = '!', renamed = '»',
					untracked = '?', deleted = '✘',
					staged = '✓', unmerged = '', ignored = '◌',
				},
			},
		},
	},

	git = {
		enable = true,
		ignore = false,
	},

	actions = {
		expand_all = {
			max_folder_discovery = 100,
			exclude = { '.git', 'target', 'build' },
		},
	},

	on_attach = 'default'
}

-- 起動時に右側にフォーカス
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local api = require("nvim-tree.api")
    api.tree.open()
    api.tree.find_file()
    vim.cmd("wincmd l")
  end,
})

-- nvim-treeが開いている場合もNeoVimを終了
-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     -- ウインドウが1つかつ、現在のバッファが通常のファイルの場合
--     if #vim.api.nvim_list_wins() == 1 then
-- 			local buf_ft = vim.bo.filetype
-- 			if buf_ft == "NvimTree" and buf_ft ~= "" then
-- 				vim.cmd("quit")
-- 			end
-- 		end
--   end,
-- })
