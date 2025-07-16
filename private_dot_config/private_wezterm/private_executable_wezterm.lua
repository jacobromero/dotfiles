local Config = require('config')

-- config.font_size = 14.0;
--
-- -- TODO: Keys for deleting words, opening links
-- -- add to github
-- config.keys = {
--   -- Turn off the default CMD-m Hide action, allowing CMD-m to
--   -- be potentially recognized and handled by the tab
-- }

-- config.unix_domains = {
--   {
--     name = 'jacob',
--   },
-- }

-- This causes `wezterm` to act as though it was started as
-- `wezterm connect unix` by default, connecting to the unix
-- domain on startup.
-- If you prefer to connect manually, leave out this line.
-- config.default_gui_startup_args = { 'connect', 'jacob' }
--
return Config:init()
    :append(require('config.appearance'))
    :append(require('config.fonts'))
    :append(require('config.bindings')).options
   -- :append(require('config.launch')).options

