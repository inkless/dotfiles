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
          -- jestConfigFile = function(file)
          --   if string.find(file, "/packages/") or string.find(file, "/apps/") then
          --     return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
          --   end
          --
          --   return vim.fn.getcwd() .. "/jest.config.ts"
          -- end,
          env = { CI = true },
          -- cwd = function()
          --   return vim.fn.getcwd()
          -- end,
          cwd = function(file)
            -- for monorepo, we need to use the package root
            if string.find(file, "/packages/") or string.find(file, "/apps/") then
              return LazyVim.root()
            end
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
