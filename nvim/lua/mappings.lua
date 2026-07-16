require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Tmux window left" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Tmux window right" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Tmux window down" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Tmux window up" })

map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "DAP Add breakpoint at line" })
map("n", "<leader>dr", function() require("dap").continue() end, { desc = "DAP Start or continue the debugger" })
map("n", "<leader>do", function() require("dap").step_over() end, { desc = "DAP step over" })
map("n", "<leader>di", function() require("dap").step_into() end ,{ desc = "DAP Step into" })

map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "LSP: Code Action (Quick Fix)" })

-- Git Signs / Hunk Navigation & Actions
map("n", "]c", function()
  if vim.wo.diff then return "]c" end
  vim.schedule(function() require("gitsigns").next_hunk() end)
  return "<Ignore>"
end, { expr = true, desc = "Gitsigns Next Git hunk" })

map("n", "[c", function()
  if vim.wo.diff then return "[c" end
  vim.schedule(function() require("gitsigns").prev_hunk() end)
  return "<Ignore>"
end, { expr = true, desc = "Gitsigns Previous Git hunk" })

-- Actions (Using the <leader>g prefix for Git)
map("n", "<leader>gs", function() require("gitsigns").stage_hunk() end, { desc = "Gitsigns Stage current hunk" })
map("n", "<leader>gr", function() require("gitsigns").reset_hunk() end, { desc = "Gitsigns Reset/Revert current hunk" })
map("v", "<leader>gs", function() require("gitsigns").stage_hunk {vim.fn.line("."), vim.fn.line("v")} end, { desc = "Gitsigns Stage selected lines" })
map("v", "<leader>gr", function() require("gitsigns").reset_hunk {vim.fn.line("."), vim.fn.line("v")} end, { desc = "Gitsigns Reset selected lines" })
map("n", "<leader>gS", function() require("gitsigns").stage_buffer() end, { desc = "Gitsigns Stage entire file" })
map("n", "<leader>gR", function() require("gitsigns").reset_buffer() end, { desc = "Gitsigns Reset entire file" })
map("n", "<leader>gp", function() require("gitsigns").preview_hunk() end, { desc = "Gitsigns Preview hunk diff inline" })
map("n", "<leader>gb", function() require("gitsigns").blame_line{full=true} end, { desc = "Gitsigns View full Git blame for line" })
map("n", "<leader>gdd", function() require("gitsigns").diffthis() end, { desc = "Gitsigns Open side-by-side Git diff split" })

-- Diffview bindings
map("n", "<leader>gdo", "<cmd>DiffviewOpen<cr>", { desc = "Git Diffview Open" })
map("n", "<leader>gdc", "<cmd>DiffviewClose<cr>", { desc = "Git Diffview Close" })
map("n", "<leader>gdh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Git File History" })


map("n","<leader>o", "<cmd>Outline<CR>", { desc = "toggle Code Outline Sidebar" })

map("n", "<leader>sr", function()
  require("grug-far").open({ transient = true })
end, { desc = "GrugFar Search and Replace (Global)" })
map("n", "<leader>sw", function()
  require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "GrugFar Search word under cursore (Global)" })
map("n", "<leader>sf", function()
  require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
end, { desc = "GrugFar Search and Replace (Current File)" })
map("v", "<leader>sr", function()
  require("grug-far").withMode('visual')
end, { desc = "GrugFar Search and Replace selection" })
