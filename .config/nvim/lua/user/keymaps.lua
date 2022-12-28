local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --

-- Make current file executable
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", opts)

-- Toggle wrap
keymap("n", "<leader>tw", ":set wrap!<CR>", opts)

-- Keep cursor position when joining lines
keymap("n", "J", "mzJ`z", opts)

-- Keep cursop position when jumping by search results
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Better scrolling
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Make splits easily
keymap("n", "<leader>sv", ":vsplit<Cr>", opts)
keymap("n", "<leader>sh", ":split<Cr>", opts)

-- Better splits navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Close Buffers
keymap("n", "<C-q>", ":q<CR>", opts)

-- Leader-v goes to visual block mode because I like C-v for paste
keymap("n", "<leader>v", "<C-v>", opts)

-- Toggle default file expolorer
-- keymap("n", "<leader>e", ":Lex 30<CR>", opts)

-- Increment/decrement
keymap("n", "+", "<C-a>", opts)
keymap("n", "-", "<C-x>", opts)

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Visual --

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
keymap("v", "y", "myy`y", opts)
keymap("v", "Y", "myY`y", opts)

-- Paste replace visual selection without copying it
keymap("v", "p", '"_dP', opts)

-- Misc --

-- Select all as usual
keymap("n", "<C-a>", "gg<S-v>G", opts)
keymap("v", "<C-a>", "<Esc>gg<S-v>G", opts)

-- Clipboard
keymap("v", "<C-c>", '"+y', opts)

-- Saving
-- Just save all files
keymap("v", "<C-s>", "<Esc>:wa<CR>gv", opts)
keymap("i", "<C-s>", "<Esc>:wa<CR>a", opts)
keymap("n", "<C-s>", ":wa<CR>", opts)

-- Telescope
vim.keymap.set('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
vim.keymap.set('n', '<leader>fF', [[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]]) -- luacheck: no max line length
vim.keymap.set('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
vim.keymap.set('n', '<leader>fg', [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>]])
vim.keymap.set('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Nvimtree
keymap("n", "<leader>e", ":NvimTreeFindFileToggle<cr>", opts)
keymap("n", "<A-e>", ":NvimTreeFocus<cr>", opts)
