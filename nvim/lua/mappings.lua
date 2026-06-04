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

local dap = require("dap")
map("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "DAP Add breakpoint at line" })
map("n", "<leader>dr", function() dap.continue() end, { desc = "DAP Start or continue the debugger" })
map("n", "<leader>do", function() dap.step_over() end, { desc = "DAP step over" })
map("n", "<leader>di", function() dap.step_into() end ,{ desc = "DAP Step into" })


local gitsigns = require("gitsigns")
-- Git Signs / Hunk Navigation & Actions
map("n", "]c", function()
  if vim.wo.diff then return "]c" end
  vim.schedule(function() gitsigns.next_hunk() end)
  return "<Ignore>"
end, { expr = true, desc = "Gitsigns Next Git hunk" })

map("n", "[c", function()
  if vim.wo.diff then return "[c" end
  vim.schedule(function() gitsigns.prev_hunk() end)
  return "<Ignore>"
end, { expr = true, desc = "Gitsigns Previous Git hunk" })

-- Actions (Using the <leader>g prefix for Git)
map("n", "<leader>gs", function() gitsigns.stage_hunk() end, { desc = "Gitsigns Stage current hunk" })
map("n", "<leader>gr", function() gitsigns.reset_hunk() end, { desc = "Gitsigns Reset/Revert current hunk" })
map("v", "<leader>gs", function() gitsigns.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end, { desc = "Gitsigns Stage selected lines" })
map("v", "<leader>gr", function() gitsigns.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end, { desc = "Gitsigns Reset selected lines" })

map("n", "<leader>gS", function() gitsigns.stage_buffer() end, { desc = "Gitsigns Stage entire file" })
map("n", "<leader>gR", function() gitsigns.reset_buffer() end, { desc = "Gitsigns Reset entire file" })
map("n", "<leader>gp", function() gitsigns.preview_hunk() end, { desc = "Gitsigns Preview hunk diff inline" })
map("n", "<leader>gb", function() gitsigns.blame_line{full=true} end, { desc = "Gitsigns View full Git blame for line" })
map("n", "<leader>gd", function() gitsigns.diffthis() end, { desc = "Gitsigns Open side-by-side Git diff split" })
local grug = require("grug-far")
map("n", "<leader>sr", function()
  grug.open({ transient = true })
end, { desc = "GrugFar Search and Replace (Global)" })
map("n", "<leader>sw", function()
  grug.open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "GrugFar Search word under cursore (Global)" })
map("n", "<leader>sf", function()
  grug.open({ prefills = { paths = vim.fn.expand("%") } })
end, { desc = "GrugFar Search and Replace (Current File)" })
map("v", "<leader>sr", function()
  grug.withMode('visual')
end, { desc = "GrugFar Search and Replace selection" })
