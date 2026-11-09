local map = vim.keymap.set

map("n", "t", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
map("n", "<leader>r", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer

map('n', '<leader>ff', function()
    require('telescope.builtin').find_files()
end, { desc = 'Telescope find files' })

map('n', '<leader>fg', function()
    require('telescope.builtin').live_grep()
end, { desc = 'Telescope live grep' })

map('n', '<leader>fb', function()
    require('telescope.builtin').buffers()
end, { desc = 'Telescope buffers' })

map('n', '<leader>fh', function()
    require('telescope.builtin').help_tags()
end, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<leader>fr', function()
    require('telescope.builtin').find_files({
        prompt_title = "Root Files",
        cwd = "/",       -- root directory
        hidden = true,   -- include hidden files
    })
end, { desc = "Telescope find files in /" })

-- window management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- clear search highlights
map("n", "nh", ":nohl<CR>", { desc = "Clear search highlights" })

map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

map('n', '<leader>h', '<C-w>h')
map('n', '<leader>j', '<C-w>j')
map('n', '<leader>k', '<C-w>k')
map('n', '<leader>l', '<C-w>l')
