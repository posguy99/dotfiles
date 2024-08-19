-- basic wezterm config
-- msw 081624

local wezterm = require 'wezterm'

local config = {}

    config.color_scheme = 'Dracula'

    config.font_size = 14.0

    -- https://github.com/wez/wezterm/discussions/2311
    config.initial_cols = 120
    config.initial_rows= 36

    -- https://wezfurlong.org/wezterm/config/lua/config/hide_tab_bar_if_only_one_tab.html
    config.hide_tab_bar_if_only_one_tab = true
    config.exit_behavior = 'CloseOnCleanExit'

return config
