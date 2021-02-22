local utils = require('config.utils')

local M = {}

function M.setup()
    local builtins = require('telescope.builtin')
    local themes = require('telescope.themes')

    local options = {
        shorten_path = false,
        layout_strategy = 'horizontal',
        layout_config = {preview_width = 0.65},
        hidden = true
    }
    function _G.__telescope_files()
        -- Launch file search using Telescope
        -- if vim.fn.isdirectory(".git") then
        --     -- if in a git project, use :Telescope git_files
        --     builtins.git_files(options)
        -- else
        -- otherwise, use :Telescope find_files
        builtins.find_files(options)
        -- end
    end
    function _G.__telescope_buffers()
        builtins.buffers({
            sort_lastused = true,
            ignore_current_buffer = true,
            sorter = require('telescope.sorters').get_substr_matcher(),
            shorten_path = true,
            layout_strategy = 'horizontal',
            layout_config = {preview_width = 0.65},
            show_all_buffers = true,
            color_devicons = true
        })
    end
    function _G.__telescope_grep()
        builtins.live_grep({
            shorten_path = false,
            layout_strategy = 'horizontal',
            layout_config = {preview_width = 0.4}
        })
    end
    function _G.__telescope_commits()
        builtins.git_commits({
            layout_strategy = 'horizontal',
            layout_config = {preview_width = 0.55}
        })
    end
    function _G.__telescope_colorscheme()
        builtins.colorscheme(themes.get_dropdown())
    end

    -- require('telescope').load_extension('yoink')
    -- utils.map('n', '<Leader>fy', "<cmd>lua require('telescope').extensions.yoink.yoink()<CR>")

    utils.map('n', '<Leader>fb', '<cmd>lua __telescope_buffers()<CR>')
    utils.map('n', '<C-p>', '<cmd>lua __telescope_files()<CR>')
    utils.map('n', '<Leader>ff', '<cmd>lua __telescope_files()<CR>')
    utils.map('n', '<Leader>fg', '<cmd>lua __telescope_grep()<CR>')
    utils.map(
      'n', 
      '<Leader>fh', 
      "<cmd>lua require('telescope.builtin').help_tags(options)<CR>"
    )
    utils.map('n', '<Leader>fc', '<cmd>lua __telescope_commits()<CR>')
    utils.map('n', '<Leader>ft', "<cmd>lua __telescope_colorscheme()<CR>")
    utils.map('n', '<C-f>', "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
    utils.map('n', '<Leader>fr', "<cmd>lua require('telescope.builtin').registers()<CR>")
end

function M.config()
    local actions = require('telescope.actions')
    local sorters = require('telescope.sorters')
    local previewers = require('telescope.previewers')

    require'telescope'.setup {
        defaults = {
            mappings = {
              i = {
                ["<ESC>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
              }
            },
            file_ignore_patterns = {"%.jpg", "%.jpeg", "%.png", "%.svg", "%.otf", "%.ttf"},
        }
    }
end

return M

