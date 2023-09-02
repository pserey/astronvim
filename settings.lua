return {
  local peek = require 'peek'
  vim.api.nvim_create_user_command('PeekOpen', peek.open(), {})
}
