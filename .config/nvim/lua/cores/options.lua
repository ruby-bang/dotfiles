-- Leader
vim.g.mapleader = ' '

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.showmode = false

-- Mouse & Clipboard
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Undo
vim.opt.undofile = true

-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.breakindent = true

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Scrolling
vim.opt.scrolloff = 10

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.pumheight = 8
vim.opt.wrap = false

-- Whitespace chars
vim.opt.list = true
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
}

-- Preview substitutions
vim.opt.inccommand = 'split'

-- Cursor shape
vim.opt.guicursor = {
  'n-v-c:block-CursorNormal',
  'i:block-CursorInsert',
  'r-cr:block-CursorInsert',
}

-- vim.api.nvim_set_hl(0, 'Visual', {
--   fg = '#000000',
--   bg = '#FFA500',
-- })
--
-- vim.api.nvim_set_hl(0, 'IncSearch', {
--   fg = '#282828',
--   bg = '#fabd2f',
-- })
--
-- -- Cursor colors
-- vim.api.nvim_set_hl(0, 'CursorNormal', {
--   bg = '#e73722',
-- })
--
-- vim.api.nvim_set_hl(0, 'CursorInsert', {
--   fg = '#000000', bg = '#2ecc71',
-- })

-- Highlight yanked text
local yank_group = vim.api.nvim_create_augroup('highlight-yank', { clear = true })

-- vim.api.nvim_set_hl(0, 'Normal', {
--   bg = '#2ecc71',
-- })
--
-- vim.api.nvim_set_hl(0, 'Normal', { bg = '#ffffff' })
-- vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
-- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = yank_group,
  desc = 'Highlight yanked text',
  callback = function()
    vim.highlight.on_yank {
      timeout = 150,
    }
  end,
})

-- vim.api.nvim_set_hl(0, 'DiffAdd', {
--   fg = '#FFFFFF',
--   bg = '#156600',
-- })
-- vim.api.nvim_set_hl(0, 'NeogitDiffAddCursor', { bg = '#23452d' })
-- vim.api.nvim_set_hl(0, 'NeogitDiffAddHighlight', { bg = '#23452d' })
-- vim.api.nvim_set_hl(0, 'NeogitDiffAddInline', { bg = '#23452d' })
--
vim.api.nvim_set_hl(0, 'NeogitDiffDeleteCursor', { fg = '#FFA500' })
vim.api.nvim_set_hl(0, 'NeogitDiffDeleteHighlight', { fg = '#ffffff' })
vim.api.nvim_set_hl(0, 'NeogitDiffContextCursor', { bg = '#444444' })
