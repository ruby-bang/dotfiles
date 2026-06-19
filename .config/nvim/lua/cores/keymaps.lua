local map = vim.keymap.set

-- Clear search highlight
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostics
map('n', '[d', vim.diagnostic.goto_prev, {
  desc = 'Go to previous diagnostic message',
})

map('n', ']d', vim.diagnostic.goto_next, {
  desc = 'Go to next diagnostic message',
})

map('n', '<leader>e', vim.diagnostic.open_float, {
  desc = 'Show diagnostic messages',
})

map('n', '<leader>q', vim.diagnostic.setloclist, {
  desc = 'Open diagnostic quickfix list',
})

-- File Explorer
map('n', '<leader>p', '<cmd>Ex<CR>', {
  desc = 'Open file explorer',
})

map('n', '\\', '<cmd>Oil<CR>', {
  desc = 'Open parent directory',
})

-- Buffer Navigation
map('n', 'L', '<cmd>bnext<CR>', {
  desc = 'Next buffer',
})

map('n', 'H', '<cmd>bprevious<CR>', {
  desc = 'Previous buffer',
})

map('n', '<C-Right>', '<cmd>bnext<CR>', {
  desc = 'Next buffer',
})

map('n', '<C-Left>', '<cmd>bprevious<CR>', {
  desc = 'Previous buffer',
})

map('n', '<leader>bd', '<cmd>bd<CR>', {
  desc = 'Close current buffer',
})

-- Window Navigation
map('n', '<C-h>', '<C-w>h', {
  desc = 'Move to left window',
})

map('n', '<C-j>', '<C-w>j', {
  desc = 'Move to lower window',
})

map('n', '<C-k>', '<C-w>k', {
  desc = 'Move to upper window',
})

map('n', '<C-l>', '<C-w>l', {
  desc = 'Move to right window',
})

-- Join lines and keep cursor position
map('n', 'J', 'mzJ`z', {
  desc = 'Join lines',
})

-- Move selected lines
map('v', 'J', ":m '>+1<CR>gv=gv", {
  desc = 'Move selection down',
})

map('v', 'K', ":m '<-2<CR>gv=gv", {
  desc = 'Move selection up',
})

-- Location List Navigation
map('n', '<leader>j', '<cmd>lprev<CR>zz', {
  desc = 'Previous location list item',
})

map('n', '<leader>k', '<cmd>lnext<CR>zz', {
  desc = 'Next location list item',
})

-- Half-page movement with centered cursor
map('n', '<C-u>', '<C-u>zz', {
  desc = 'Half page up',
})

map('n', '<C-d>', '<C-d>zz', {
  desc = 'Half page down',
})

-- Terminal
map('t', '<Esc><Esc>', '<C-\\><C-n>', {
  desc = 'Exit terminal mode',
})

-- Select all
map('n', '<C-a>', 'ggVG', {
  desc = 'Select all',
})

-- Faster cursor movement
map('n', '<S-Down>', '2jzz', {
  desc = 'Move down 2 lines',
})

map('n', '<S-Up>', '2kzz', {
  desc = 'Move up 2 lines',
})

-- Compile
map('n', '<M-S-1>', '<cmd>Compile<CR>', {
  silent = false,
  desc = 'Compile project',
})

-- Tagbar
map('n', '<leader>;', '<cmd>TagbarToggle<CR><C-w>l', {
  desc = 'Toggle Tagbar',
})

-- Buffer Manager
map('n', '<leader>b', function()
  require('buffer_manager.ui').toggle_quick_menu()
end, {
  desc = 'Open buffer list',
})
