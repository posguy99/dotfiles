-- basic wezterm config
-- msw 081624

local wezterm = require 'wezterm'

local config = {}

    config.color_scheme = 'Dracula'

    config.font_size = 14.0

    -- https://github.com/wez/wezterm/discussions/2311
    config.initial_cols = 120
    config.initial_rows= 36

    -- https://wezfurlong.org/wezterm/config/lua/config/check_for_updates.html
    -- https://github.com/wez/wezterm/issues/6355#issuecomment-2453465060
    config.check_for_updates = false

    -- https://wezfurlong.org/wezterm/config/lua/config/hide_tab_bar_if_only_one_tab.html
    config.hide_tab_bar_if_only_one_tab = true

    -- this is related to the application running in the wezterm window, not the window
    -- itself.  think "what happens if you type "exit" at a shell prompt.
    -- https://wezfurlong.org/wezterm/config/lua/config/exit_behavior.html
    config.exit_behavior = 'CloseOnCleanExit'

    -- https://wezfurlong.org/wezterm/config/lua/config/window_close_confirmation.html
    config.window_close_confirmation = 'NeverPrompt'

    -- https://wezfurlong.org/wezterm/config/lua/config/skip_close_confirmation_for_processes_named.html
    config.skip_close_confirmation_for_processes_named = {
        'bash',
        'sh',
        'zsh',
        'fish',
        'ksh',
        'tmux',
        'nu',
        'cmd.exe',
        'pwsh.exe',
        'powershell.exe',
    }

return config
