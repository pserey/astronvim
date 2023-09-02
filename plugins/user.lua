return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    event = 'User AstroFile'
  },
  {
    'ellisonleao/gruvbox.nvim'
  },
  {
    'lambdalisue/suda.vim'
  },
  {
    'tpope/vim-commentary'
  },
  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require 'plugins.configs.nvim-autopairs'(plugin, opts)
      local Rule = require 'nvim-autopairs.rule'
      local cond = require 'nvim-autopairs.conds'
      local npairs = require 'nvim-autopairs'

      npairs.add_rules {
        Rule("$", "$",{"tex", "latex", "md", "markdown"})
          -- don't add a pair if the next character is %
          :with_pair(cond.not_after_regex("%%"))
          -- don't add a pair if  the previous character is xxx
          :with_pair(cond.not_before_regex("xxx", 3))
          -- don't move right when repeat character
          :with_move(cond.none())
          -- don't delete if the next character is xx
          :with_del(cond.not_after_regex("xx"))
          -- disable adding a newline when you press <cr>
          :with_cr(cond.none()),
        Rule('*', '*', {'md', 'markdown'}),
        Rule("f'", "'", {'python', 'py'}),
        Rule("r'", "'", {'python', 'py'}),
        Rule("b'", "'", {'python', 'py'}),
        }
    end
  },
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      -- include the default astronvim config that calls the setup call
      require "plugins.configs.luasnip"(plugin, opts)
      -- load snippets paths
      require("luasnip.loaders.from_vscode").lazy_load {
        -- this can be used if your configuration lives in ~/.config/nvim
        -- if your configuration lives in ~/.config/astronvim, the full path
        -- must be specified in the next line
        paths = { "./lua/user/snippets" }
      }
    end,
  },
  {
    'mfussenegger/nvim-dap',
    config = function(plugin, opts)
      local dap = require 'dap'
      dap.adapters.python = function(cb, config)
          if config.request == 'attach' then
            ---@diagnostic disable-next-line: undefined-field
            local port = (config.connect or config).port
            ---@diagnostic disable-next-line: undefined-field
            local host = (config.connect or config).host or '127.0.0.1'
            cb({
              type = 'server',
              port = assert(port, '`connect.port` is required for a python `attach` configuration'),
              host = host,
              options = {
                source_filetype = 'python',
              },
            })
        else
          cb({
            type = 'executable',
            command = '/home/pedro/.virtualenvs/debugpy/bin/python',
            args = { '-m', 'debugpy.adapter' },
            options = {
              source_filetype = 'python',
            },
          })
        end
      end
      dap.configurations.python = {
        {
          -- The first three options are required by nvim-dap
          type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
          request = 'launch';
          name = "Launch file";

          -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

          program = "${file}"; -- This configuration will launch the current file if used.
          justMyCode = false;
          pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
              return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
              return cwd .. '/.venv/bin/python'
            else
              return '/usr/bin/python'
            end
          end;
          console = 'integratedTerminal';
        },
      }
    end
  },
  {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    opts = {
      auto_load = true,
      close_ond_bdelete = true,
      syntax = true,
      theme = 'dark',
      update_on_change = true,
      app = {
        'brave-nightly',
        '--new-window'
      },
      filetype = { 'markdown' },
      throttle_at = 200000,
      throttle_time = 'auto',
    }
  }
}
