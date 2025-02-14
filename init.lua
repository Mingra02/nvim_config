-- Keybinds

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('v', '<M-Up>', ":m '<-2<CR>gv=gv", { desc = 'Move Line up', noremap = true, silent = true })
vim.keymap.set('v', '<M-Down>', ":m '>+1<CR>gv=gv", { desc = 'Move line down', noremap = true, silent = true })
vim.keymap.set('n', '<M-Up>', ':m .-2<CR>==', { desc = 'Move line up', noremap = true, silent = true })
vim.keymap.set('n', '<M-Down>', ':m .+1<CR>==', { desc = 'Move line down', noremap = true, silent = true })
vim.keymap.set('n', '<S-Up>', 'v<Up>', { desc = 'Select line up', noremap = true, silent = true })
vim.keymap.set('n', '<S-Down>', 'v<Down>', { desc = 'Select line down', noremap = true, silent = true })
vim.keymap.set('v', '<S-Up>', '<Up>', { desc = 'Select line up', noremap = true, silent = true })
vim.keymap.set('v', '<S-Down>', '<Down>', { desc = 'Select line down', noremap = true, silent = true })

vim.keymap.set('n', '<C-j>', ':cnext<CR>', { desc = 'Next quickfix item', noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', ':cprev<CR>', { desc = 'Previous quickfix item', noremap = true, silent = true })

vim.keymap.set('v', '{', '<gv', { desc = 'Move selected text left', noremap = true, silent = true })
vim.keymap.set('v', '}', '>gv', { desc = 'Move selected text right', noremap = true, silent = true })

vim.keymap.set('n', '<leader>wq', '<cmd>noautocmd wq <CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-s>', '<cmd>noautocmd w <CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-S>', '<cmd>w <CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down half page', noremap = true, silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up half page', noremap = true, silent = true })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Move to next search result', noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Move to previous search result', noremap = true, silent = true })

vim.keymap.set('n', '<leader><Tab>', ':bnext<CR>', { desc = 'Next buffer', noremap = true, silent = true })
vim.keymap.set('n', '<leader><S-Tab>', ':bprevious<CR>', { desc = 'Previous buffer', noremap = true, silent = true })
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = 'Close buffer', noremap = true, silent = true })
vim.keymap.set('n', '<leader>ba', ':bufdo bd<CR>', { desc = 'Close all buffers', noremap = true, silent = true })
vim.keymap.set('n', '<leader>bn', ':enew<CR>', { desc = 'New buffer', noremap = true, silent = true })

vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab', noremap = true, silent = true })
vim.keymap.set('n', '<leader>tq', ':tabclose<CR>', { desc = 'Close tab', noremap = true, silent = true })
vim.keymap.set('n', '<leader>tn', ':tabnext<CR>', { desc = 'Next tab', noremap = true, silent = true })
vim.keymap.set('n', '<leader>tp', ':tabprevious<CR>', { desc = 'Previous tab', noremap = true, silent = true })
vim.opt.showtabline = 2

--vim.keymap.set('v', 'p', '"_dP', { desc = 'Paste without yanking', noremap = true, silent = true })
--vim.keymap.set('n', 'p', '"_dP', { desc = 'Paste without yanking', noremap = true, silent = true })
vim.keymap.set('n', '<leader>lw', ':set wrap!<CR>', { desc = 'Toggle line wrap', noremap = true, silent = true })

vim.keymap.set('n', '<C-q>', 'bd<CR>', { desc = 'Close Buffer', noremap = true, silent = true })

-- set <C-/> to comment/uncomment
vim.keymap.set('n', '<C-/>', ':CommentToggle<CR>', { desc = 'Comment/Uncomment', noremap = true, silent = true })

vim.g.have_nerd_font = true
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle undo tree', noremap = true, silent = true })

-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'
vim.opt.showmode = false

vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Disable Bell noises
vim.o.belloff = 'all'
vim.o.visualbell = false

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
vim.opt.conceallevel = 1
require('lazy').setup({
  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.theme',
  require 'kickstart.plugins.telescope',
  require 'kickstart.plugins.treesitter',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.lualine',
  require 'kickstart.plugins.alpha',
  require 'kickstart.plugins.misc',
  require 'kickstart.plugins.which-key',
  require 'kickstart.plugins.autocomplete',
  require 'kickstart.plugins.autoformat',
  require 'kickstart.plugins.lsp',
  require 'kickstart.plugins.bufferline',
  require 'kickstart.plugins.repl',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
