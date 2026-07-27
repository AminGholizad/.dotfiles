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
      ft = { "c", "cpp", "objc", "objcpp", "cuda" },
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {
        cmake_build_directory = "build", 
        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
      },
      config = function(_, opts)
        require("cmake-tools").setup(opts)

        local map = vim.keymap.set

        map("n", "<leader>cb", "<cmd>CMakeBuild<cr>", { desc = "CMake Build current target" })
        map("n", "<leader>cr", "<cmd>CMakeRun<cr>", { desc = "CMake Run current target" })
        map("n", "<leader>cg", "<cmd>CMakeGenerate<cr>", { desc = "CMake Generate build system" })
        map("n", "<leader>cc", "<cmd>CMakeClean<cr>", { desc = "CMake Clean build directory" })
        map("n", "<leader>ct", "<cmd>CMakeSelectBuildTarget<cr>", { desc = "CMake Select Build Target" })
        map("n", "<leader>cx", "<cmd>CMakeSelectLaunchTarget<cr>", { desc = "CMake Select Launch/Run Target" })
        map("n", "<leader>cm", "<cmd>CMakeSelectBuildType<cr>", { desc = "CMake Select Build Type (Debug/Release)" })
        map("n", "<leader>co", "<cmd>CMakeOpenExecuter<cr>", { desc = "CMake Open console/output panel" })
        map("n", "<leader>cq", "<cmd>CMakeCloseExecuter<cr>", { desc = "CMake Close console/output panel" })
        
        map("n", "<leader>fca", "<cmd>Telescope cmake_tools<cr>", { desc = "Telescope cmake project files" })
        map("n", "<leader>fcs", "<cmd>Telescope cmake_tools sources<cr>", { desc = "Telescope cmake project source files" })
        map("n", "<leader>fcs", "<cmd>Telescope cmake_tools cmake_files<cr>", { desc = "Telescope cmake project model files" })
        map("n", "<leader>fct", "<cmd>CMakeShowTargetFiles<cr>", { desc = "Telescope cmake target files" })
      end,
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
      cmd = "GrugFar",
      config = function()
        require('grug-far').setup({})
      end,
    },
    {
      "tpope/vim-fugitive",
      cmd = "Git"
    },
    {
      "hedyhli/outline.nvim",
      cmd = { "Outline", "OutlineOpen" },
      opts = {
        outline_window = {
          position = "right",
          width = 30,
        },
        symbols = {
          icon_source = "lsp", 
        },
      },
    },
    {
      "sindrets/diffview.nvim",
      cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
      config = true,
    },
    {
      "fatih/vim-go",
      ft = {"go", "gomod"},
      build = ":GoUpdateBinaries",
      config = function()
        vim.g.go_fmt_autosave = 1
      end,
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
