return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('neo-tree').setup {
        event_handlers = {
          {
            event = 'file_opened',
            handler = function(file_path)
              require('neo-tree.command').execute { action = 'close' }
            end,
          },
        },
      }
    end,
  },
}
