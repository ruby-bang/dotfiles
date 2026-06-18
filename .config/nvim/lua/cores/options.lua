vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

vim.opt.showmode = false

vim.opt.clipboard = 'unnamedplus'

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.guicursor = ''
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true

vim.opt.updatetime = 250

vim.cmd [[
    highlight Visual ctermfg=none ctermbg=darkyellow guifg=none guibg=#FFA500
]]

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

vim.opt.hlsearch = true

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.opt.guicursor = 'n-v-c:block-CursorNormal,i:block-CursorInsert'

vim.api.nvim_set_hl(0, 'CursorInsert', { fg = '#fabd2f', bg = '#fabd2f' })

vim.api.nvim_set_hl(0, 'CursorNormal', { fg = '#2ecc71', bg = '#2ecc71' })
