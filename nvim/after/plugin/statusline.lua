require('lualine').setup {
    options = {
        -- theme = 'dracula-nvim',
        -- theme = 'tokyonight',
        theme = 'catppuccin',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        -- lualine_x = {'encoding', {'fileformat', icons_enabled=false}, 'filetype'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'windows'},
        lualine_z = {'location'}
    },
}
