return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
    },
    keys = {
      -- {
      --   "<leader>tl",
      --   function()
      --     require("neotest").run.run_last()
      --   end,
      --   desc = "Run Last Test",
      -- },
      {
        "<leader>tL",
        function()
          require("neotest").run.run_last({ strategy = "dap", suite = false })
        end,
        desc = "Debug Last Test",
      },
      -- {
      --   "<leader>tw",
      --   function()
      --     require("neotest").run.run({ jestCommand = "npx jest --watch", suite = true })
      --   end,
      --   desc = "Run Watch",
      -- },
    },
    opts = {
      adapters = {
        "neotest-vitest",
        ["neotest-jest"] = {
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.js",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
      },
    },
    -- opts = function(_, opts)
    --   table.insert(
    --     opts.adapters,
    --     require("neotest-jest")({
    --       jestCommand = "npx jest --",
    --       -- jestConfigFile = "custom.jest.config.ts",
    --       -- env = { CI = true },
    --       cwd = function()
    --         return vim.fn.getcwd()
    --       end,
    --     })
    --   )
    --   table.insert(opts.adapters, require("neotest-vitest"))
    -- end,
  },
}
