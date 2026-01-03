local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git","clone","--filter=blob:none",
		"https://github.com/folke/lazy.nvim",
		"--branch=stable", lazypath
	})
end
vim.opt.rtp:prepend(lazypath)
vim.o.completeopt = "menu,menuone,noselect,popup"
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.ruler = true
opt.wildmenu = true

opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.scrolloff = 5
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.history = 1000
opt.colorcolumn = "88"

opt.splitbelow = true
opt.splitright = true
opt.signcolumn = "yes"
opt.wildmode = "longest:full,full"
opt.updatetime = 250
opt.timeoutlen = 400
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true
opt.incsearch = true
opt.hlsearch = true

local function map(mode, lhs, rhs, opts)
	opts = opts or {}
	if vim.keymap and vim.keymap.set then
		vim.keymap.set(mode, lhs, rhs, opts)
	else
		local o = { noremap = true, silent = true }
		if opts.expr ~= nil then o.expr = opts.expr end
		local rhs_str = type(rhs) == "string" and rhs or ""
		vim.api.nvim_set_keymap(mode, lhs, rhs_str, o)
	end
end

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	update_in_insert = false,
	severity_sort = true,
})

require("autocmds")

require("config.keymaps")
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
})
