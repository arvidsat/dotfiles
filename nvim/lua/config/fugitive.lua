local map = require('config.utils').map

map('n', '<Leader>gg', ':G<cr>')
map('n', '<leader>gf', ':diffget //2')
map('n', '<leader>gj', ':diffget //3')
map('n', '<leader>gu', ':G push<cr>')
map('n', '<leader>gd', ':G pull<cr>')
map('n', '<leader>go', ':Git -c push.default=current push')
