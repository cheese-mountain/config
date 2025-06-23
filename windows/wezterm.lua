local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.default_prog = { "powershell.exe", "-NoLogo" }
config.initial_cols = 80
config.enable_tab_bar = false
config.window_decorations = "NONE"
config.window_close_confirmation = "NeverPrompt"

-- Windows style copy/select with mouse
config.disable_default_mouse_bindings = false
config.allow_win32_input_mode = true
config.term = "xterm-256color"
config.colors = {
	selection_bg = "#000000",
	-- selection_bg = "#11111b",
    	background = "#181825"
}

-- Theming
config.font = wezterm.font("CaskaydiaCove Nerd Font")
config.font_size = 14.0
config.color_scheme = "rose-pine"
config.window_background_opacity = 1
-- config.win32_system_backdrop = "Mica"
config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 10,
}

-- Keybindings
config.keys = {
	-- New tab with Ctrl+T
	{ key = "t", mods = "CTRL", action = wezterm.action.SpawnTab("CurrentPaneDomain") },

	-- Close tab with Ctrl+W
	{ key = "w", mods = "CTRL", action = wezterm.action.CloseCurrentTab({ confirm = false }) },

	{
		key = "k",
		mods = "CTRL",
		action = wezterm.action.Hide,
	},

    -- Maximize window
    {
            key = 'Z',
        mods = 'CTRL',
        action = wezterm.action.TogglePaneZoomState,
    },

	-- Switch between tabs with Ctrl+J/K
	{ key = "l", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) }, -- Next tab
	{ key = "h", mods = "CTRL", action = wezterm.action.ActivateTabRelative(-1) }, -- Previous tab

	-- Tab picker/dropdown with Ctrl+P
	{ key = "p", mods = "CTRL", action = wezterm.action.ShowTabNavigator },

	-- Jump to specific tabs with Ctrl+Number
	{ key = "1", mods = "CTRL", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "CTRL", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "CTRL", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "CTRL", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "CTRL", action = wezterm.action.ActivateTab(4) },
	{ key = "6", mods = "CTRL", action = wezterm.action.ActivateTab(5) },
	{ key = "7", mods = "CTRL", action = wezterm.action.ActivateTab(6) },
	{ key = "8", mods = "CTRL", action = wezterm.action.ActivateTab(7) },
	{ key = "9", mods = "CTRL", action = wezterm.action.ActivateTab(8) },
}

-- Enable multiplexing (used to spawn new tab from vscode)
config.unix_domains = {
	{
		name = "unix",
	},
}
config.default_gui_startup_args = { "connect", "unix" }

-- Shared function to set window size with max width limit
local function set_window_size(gui_window)
    if not gui_window then return end

    wezterm.time.call_after(0.1, function()
        local screens = wezterm.gui.screens()
        if screens and screens.active then
            local screen = screens.active
            local width = math.min(screen.width, 2000) -- Max width of 2000 pixels
            local height = screen.height
            gui_window:set_position(0, 0)
            gui_window:set_inner_size(width, height)
        end
    end)
end

-- Auto maximize
wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
    if window then
        local gui_window = window:gui_window()
        set_window_size(gui_window)
    end
end)

-- Handle new GUI attachments to existing mux
wezterm.on("gui-attached", function(domain)
    -- This fires when a new GUI attaches to an existing mux server
    local workspace = wezterm.mux.get_active_workspace()
    if workspace then
        for _, window in ipairs(wezterm.mux.all_windows()) do
            local gui_window = window:gui_window()
            if gui_window then
                set_window_size(gui_window)
                break -- Only resize the first window
            end
        end
    end
end)

return config
