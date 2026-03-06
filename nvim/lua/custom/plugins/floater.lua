--return {
--  {
--    'akinsho/toggleterm.nvim',
--    version = '*',
--    opts = {
--      open_mapping = [[<C-y>]],
--      start_in_insert = true,
--      size = 40,
--      hidden = true,
--      persist_mode = true,
--      direction = 'float',
--    },
--  },
--}

return {
  'hooksie1/floater.nvim',
  dev = true,
  opts = {
    key_mapping = [[<C-y>]],
    insert_on_open = true,
    escape = [[<esc>1]],
    jobs = {
      ['<leader>gr'] = 'go run .\r\n',
      ['<leader>gt'] = 'go test -v ./...\r\n',
      ['<leader>mt'] = 'make test\r\n',
      ['<leader>mb'] = 'make build\r\n',
    },
  },
}
