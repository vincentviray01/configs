-- sets space as mapleader, must happen before plugins are loaded
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

vim.wo.relativenumber = true

vim.g.have_nerd_font = true

-- may be unnecssary
vim.opt.number = true

-- enable mouse mode
vim.opt.mouse = 'a'

-- may be unnecessary
vim.opt.showmode = false

-- yank from neovim into system clipboard. For Ubuntu, had to install xclip, not sure for MacOS
vim.api.nvim_set_option("clipboard", "unnamedplus")

-- enable break indent
vim.opt.breakindent = true

-- save undo history, this is for if you exit and reenter nvim of same file, then old changes are remembered
vim.opt.undofile = true

-- case-insensitive searching UNLESS \c or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- vim.opt.signcolumn = 'number'
--
-- decrease update time
vim.opt.updatetime = 250

-- decrease mapped sequence wait time
-- displays which-key popup sooner
vim.opt.timeoutlen = 300

-- configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- sets how neovim will display certain whitespace characters in the editor
-- see :help 'list'
-- see :help 'listchars'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail= '·', nbsp = '␣'}

-- preview substiutions live, as you type!
vim.opt.inccommand = 'split'

-- show which line your cursor is on
vim.opt.cursorline = true

vim.opt.iskeyword = vim.opt.iskeyword - '_'

-- allow multiple side columns for errors and git changes
-- vim.opt.signcolumn = "auto:9"
vim.opt.signcolumn = "yes:2"

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- the following two autocmds are used to highlight references of the word under your cursor when your cursor rests there for a little while.
-- see :help CursorHold for more information when this is executed
-- When you moveyour cursor the highlights will be cleared (the second autocommand)
-- local client = vim.lsp.get_client_by_id(event.data.client_id)
-- if client and client.server_capabilities.documentHighlightProvider then
--   vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
--     buffer = event.buf,
--     callback = vim.lsp.buf.document_highlight,
--   })
--
--   vim.api.nvim_create_autocomd({ 'CursorMoved', 'CursorMovedI'}, {
--     buffer = event.buf,
--     callback = vim.lsp.buf.clear_references,
--   })
-- end
