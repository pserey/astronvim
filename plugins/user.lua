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
}
