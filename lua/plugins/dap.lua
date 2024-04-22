return {
  "jay-babu/mason-nvim-dap.nvim",
  opts = {
    handlers = {
      php = function(config)
        config.adapters = {
          type = "executable",
          command = "node",
          args = { os.getenv "HOME" .. "/Documents/Packages/vscode-php-debug/out/phpDebug.js" },
        }

        config.configurations = {
          {
            type = "php",
            request = "launch",
            name = "Listen for Xdebug",
            port = 9003,
            pathMappings = {
              ["/var/www"] = "${workspaceFolder}",
            },
          },
          {
            type = "php",
            request = "launch",
            name = "Run current script",
            port = 9003,
            cwd = "${fileDirname}",
            program = "${file}",
            runtimeExecutable = "php",
            pathMappings = {
              ["/var/www"] = "${workspaceFolder}",
            },
          },
          {
            type = "php",
            request = "launch",
            name = "Listen for Xdebug in local development",
            port = 9003,
          },
        }
        require("mason-nvim-dap").default_setup(config)
      end,

      coreclr = function(config)
        config.adapters = {
          type = "executable",
          command = "/usr/local/netcoredbg",
          args = { "--interpreter=vscode" },
        }

        config.configurations = {
          {
            type = "coreclr",
            name = "launch - netcoredbg",
            request = "launch",
            program = function() return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file") end,
          },
        }
        require("mason-nvim-dap").default_setup(config)
      end,
    },
  },
}
