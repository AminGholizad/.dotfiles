require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "window left" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "window right" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "window down" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "window up" })

local dap = require("dap")
map("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Add breakpoint at line" })
map("n", "<leader>dr", function() dap.continue() end, { desc = "Start or continue the debugger" })
map("n", "<leader>do", function() dap.step_over() end, { desc = "step over" })
map("n", "<leader>di", function() dap.step_into() end ,{ desc = "Step into" })


local gitsigns = require("gitsigns")
-- Git Signs / Hunk Navigation & Actions
map("n", "]c", function()
  if vim.wo.diff then return "]c" end
  vim.schedule(function() gitsigns.next_hunk() end)
  return "<Ignore>"
end, { expr = true, desc = "Next Git hunk" })

map("n", "[c", function()
  if vim.wo.diff then return "[c" end
  vim.schedule(function() gitsigns.prev_hunk() end)
  return "<Ignore>"
end, { expr = true, desc = "Previous Git hunk" })

-- Actions (Using the <leader>g prefix for Git)
map("n", "<leader>gs", function() gitsigns.stage_hunk() end, { desc = "Stage current hunk" })
map("n", "<leader>gr", function() gitsigns.reset_hunk() end, { desc = "Reset/Revert current hunk" })
map("v", "<leader>gs", function() gitsigns.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end, { desc = "Stage selected lines" })
map("v", "<leader>gr", function() gitsigns.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end, { desc = "Reset selected lines" })

map("n", "<leader>gS", function() gitsigns.stage_buffer() end, { desc = "Stage entire file" })
map("n", "<leader>gR", function() gitsigns.reset_buffer() end, { desc = "Reset entire file" })
map("n", "<leader>gp", function() gitsigns.preview_hunk() end, { desc = "Preview hunk diff inline" })
map("n", "<leader>gb", function() gitsigns.blame_line{full=true} end, { desc = "View full Git blame for line" })
map("n", "<leader>gd", function() gitsigns.diffthis() end, { desc = "Open side-by-side Git diff split" })
