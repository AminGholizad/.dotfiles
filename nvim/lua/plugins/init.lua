return {
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        opts = require "configs.conform",
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
    {
      "Civitasv/cmake-tools.nvim",
      -- lazy = false,
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {
        cmake_build_directory = "build", 
        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
      },
    },
    {
      "mfussenegger/nvim-dap",
      dependencies = {
        -- Installs debuggers automatically via Mason
        { "jay-babu/mason-nvim-dap.nvim", dependencies = "williamboman/mason.nvim" },
        -- The IDE-like layout
        { "rcarriga/nvim-dap-ui", dependencies = "nvim-neotest/nvim-nio" },
      },
      config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- Initialize the UI
        dapui.setup()

        -- Automatically open/close the VS layout windows
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
      
        -- Tell Mason-DAP to automatically hook up codelldb for C++
        require("mason-nvim-dap").setup({
          ensure_installed = { "codelldb" },
          automatic_configuration = true,
        })
      end,
    },
    {
      'MagicDuck/grug-far.nvim',
      lazy = true,
      cmd = "GrugFar",
      config = function()
        require('grug-far').setup({})
      end,
    },
    {
      "tpope/vim-fugitive",
      cmd = "Git"
    },
    -- test new blink
    -- { import = "nvchad.blink.lazyspec" },

    -- {
    -- 	"nvim-treesitter/nvim-treesitter",
    -- 	opts = {
    -- 		ensure_installed = {
    -- 			"vim", "lua", "vimdoc",
    --      "html", "css"
    -- 		},
    -- 	},
    -- },
}
