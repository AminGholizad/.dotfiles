require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!


local o = vim.o
local g = vim.g

-- Default options from NvChad are here...

-- Windows PowerShell Setup
if vim.fn.has("win32") == 1 then
  local powershell_options = {
    shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
    shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s",
    shellquote = "",
    shellxquote = "",
  }

  for option, value in pairs(powershell_options) do
    vim.opt[option] = value
  end
end
