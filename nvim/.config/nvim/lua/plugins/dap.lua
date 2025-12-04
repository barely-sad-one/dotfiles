return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      -- "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local ui = require("dapui")

      require('dapui').setup()
      -- require("nvim-dap-virtual-text").setup()

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }

      local default_config = {
        c = {
          {
            name = "Launch",
            type = "gdb",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            args = {},
            cwd = "${workspaceFolder}",
            stopAtBeginningOfMainSubprogram = false,
          },
        },
      }

      dap.configurations.c = default_config.c
      dap.configurations.cpp = default_config.c
      dap.configurations.rust = default_config.c

      require('utils').load_custom_project_config("dap.lua")

      local opts = { noremap = true, silent = false }

      -- Keybindings
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts)
      vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, opts)

      vim.keymap.set("n", "<leader>dgb", dap.run_to_cursor, opts)
      vim.keymap.set("n", "<F8>", dap.run_to_cursor, opts)

      vim.keymap.set("n", "<leader>dt", function() require("dapui").eval(nil, { enter = true }) end, opts)

      vim.keymap.set("n", "<leader>dc", dap.continue, opts)        -- Continue
      vim.keymap.set("n", "<F5>", dap.continue, opts)        -- Continue

      vim.keymap.set("n", "<leader>di", dap.step_into, opts)       -- Step Into
      vim.keymap.set("n", "<F11>", dap.step_into, opts)       -- Step Into

      vim.keymap.set("n", "<leader>do", dap.step_over, opts)       -- Step Over
      vim.keymap.set("n", "<F10>", dap.step_over, opts)       -- Step Over

      vim.keymap.set("n", "<leader>dO", dap.step_out, opts)        -- Step Out
      vim.keymap.set("n", "<F12>", dap.step_out, opts)        -- Step Out

      vim.keymap.set("n", "<leader>dB", dap.step_back, opts)       -- Step Back
      vim.keymap.set("n", "<F6>", dap.step_back, opts)       -- Step Back

      vim.keymap.set("n", "<leader>dr", dap.restart, opts)         -- Restart
      vim.keymap.set("n", "<leader>dT", function()
        dap.terminate()  
        ui.close()      
      end, opts)

      dap.listeners.before.attach.dapui_config = function() ui.open() end
      dap.listeners.before.launch.dapui_config = function() ui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
      dap.listeners.before.event_exited.dapui_config = function() ui.close() end
    end,
  },
}

