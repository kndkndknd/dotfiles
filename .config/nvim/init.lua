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

-- automated settings
local function open_nvim_tree()
    require("nvim-tree.api").tree.open()
end

-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

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
