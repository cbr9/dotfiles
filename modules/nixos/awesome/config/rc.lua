-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
-- local keyboard_layout_indicator = require("keyboard-layout-indicator")

local scratchpads = require("scratchpads")
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification {
    urgency = "critical",
    title   = "Oops, an error happened" .. (startup and " during startup!" or "!"),
    message = message
  }
end)

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- This is used later as the default terminal and editor to run.
local terminal = "kitty"

-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local super = "Mod4"
local alt = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.magnifier,
}
-- }}}

-- {{{ Wibar
-- Create a textclock widget
local text_clock = wibox.widget.textclock()


beautiful.font = "DejaVu Sans Mono"
beautiful.notification_icon_size = 50
beautiful.notification_height = 75
beautiful.border_color_active = "#fabd2f"
beautiful.border_width = 3
beautiful.useless_gap = 5
beautiful.gap_single_client = true
beautiful.wallpaper = "@wallpaper@"

beautiful.tasklist_shape_border_width = 0
beautiful.tasklist_shape = gears.shape.rectangle
beautiful.tasklist_bg_focus = beautiful.border_color_active
beautiful.tasklist_fg_focus = "#000000"
beautiful.tasklist_disable_icon = true
beautiful.tasklist_align = "center"

beautiful.taglist_bg_focus = beautiful.tasklist_bg_focus
beautiful.taglist_fg_focus = "#000000"
beautiful.taglist_shape = gears.shape.rectangle


-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({ super }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ super }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end)
)

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        { raise = true }
      )
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end)
)

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, false)
  end
end

local brightness = {}

function brightness.up()
  awful.spawn("brightnessctl set +5%")
end

function brightness.down()
  awful.spawn("brightnessctl set 5%-")
end

local volume = {}

function volume.mute()
  awful.spawn("pamixer -t")
end

function volume.raise()
  awful.spawn("pamixer --increase 5 --set-limit 100")
end

function volume.lower()
  awful.spawn("pamixer -d 5")
end

-- These are example rubato tables. You can use one for just y, just x, or both.
-- The duration and easing is up to you. Please check out the rubato docs to learn more.


-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
local tag_names = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  --   -- Wallpaper
  set_wallpaper(s)

  --   -- Each screen has its own tag table.
  awful.tag(tag_names, s, awful.layout.layouts[1])

  --   -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create a taglist widget
  s.tag_list = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }

  --   -- Create a tasklist widget
  s.task_list = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
  }

  local right_widgets = {}
  if s == screen.primary then
    right_widgets = {
      layout = wibox.layout.fixed.horizontal,
      awful.widget.keyboardlayout(),
      wibox.widget.systray(),
      text_clock, -- keyboard_layout,
    }
  else
    right_widgets = {
      layout = wibox.layout.fixed.horizontal,
      awful.widget.keyboardlayout(),
      text_clock,
    }
  end

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.tag_list,
      s.mypromptbox,
    },
    s.task_list, -- Middle widget
    right_widgets
  }
end)
-- }}}

local focus_bydirection = function(direction)
  awful.client.focus.global_bydirection(direction)
  if client.focus then
    -- focus on the client
    client.focus:raise()
  end

  -- BUG: focus across screens is wonky when there are no clients on the destination screen
  -- https://github.com/awesomeWM/awesome/issues/3638
  -- Workaround: manually unfocus client after moving focus to an empty screen
  local is_empty_destination = #awful.screen.focused().clients < 1

  if is_empty_destination then
    -- manually unfocus the current focused client
    client.focus = nil
  end
end

local function minimize(c)
  -- The client currently has the input focus, so it cannot be
  -- minimized, since minimized clients can't have the focus.
  c.minimized = true
end

local function unminimize()
  local c = awful.client.restore()
  -- Focus restored client
  if c then
    c:emit_signal(
      "request::activate", "key.unminimize", { raise = true }
    )
  end
end

local function toggle_fullscreen(c)
  c.fullscreen = not c.fullscreen
  c:raise()
end

local function maximize(c)
  c.maximized = not c.maximized
  c:raise()
end

local function screenshot()
  local date = awful.spawn('date "+%x %T:%N"')
  awful.spawn.with_shell(string.format('maim "/home/cabero/Nextcloud/Pictures/Screenshots/%s.jpg"', date))
end

local function __follow_mouse_wrapped(c)
  c:activate { context = "mouse_enter", raise = true }
end


local is_following_mouse = true

if is_following_mouse then
  client.connect_signal("mouse::enter", __follow_mouse_wrapped)
  client.focus = mouse.object_under_pointer()
end


-- {{{ Key bindings
local global_keys = gears.table.join(
  scratchpads.global_keys,
  -- awful.key({ super, }, "s", hotkeys_popup.show_help),


  awful.key({ super, "Shift" }, "m", function()
    if not is_following_mouse then
      client.connect_signal("mouse::enter", __follow_mouse_wrapped)
      client.focus = mouse.object_under_pointer()
    else
      client.disconnect_signal("mouse::enter", __follow_mouse_wrapped)
    end
    is_following_mouse = not is_following_mouse
  end),

  awful.key({}, "XF86AudioMute", volume.mute),
  awful.key({}, "XF86AudioLowerVolume", volume.lower),
  awful.key({}, "XF86AudioRaiseVolume", volume.raise),
  awful.key({}, "XF86MonBrightnessDown", brightness.down),
  awful.key({}, "XF86MonBrightnessUp", brightness.up),
  awful.key({}, "Print", screenshot),

  -- Directionional client focus
  awful.key({ super }, "j", function() focus_bydirection("down") end),
  awful.key({ super }, "k", function() focus_bydirection("up") end),
  awful.key({ super }, "h", function() focus_bydirection("left") end),
  awful.key({ super }, "l", function() focus_bydirection("right") end),


  -- Layout manipulation
  awful.key({ super, "Shift" }, "j", function() awful.client.swap.byidx(1) end),
  awful.key({ super, "Shift" }, "k", function() awful.client.swap.byidx(-1) end),
  awful.key({ super, "Control" }, "j", function() awful.screen.focus_relative(1) end),
  awful.key({ super, "Control" }, "k", function() awful.screen.focus_relative(-1) end),
  awful.key({ super, }, "u", awful.client.urgent.jumpto),

  -- Standard program
  awful.key({ super, "Shift" }, "r", awesome.restart),
  awful.key({ super, "Shift" }, "q", awesome.quit),
  awful.key({ super, }, "Tab", function() awful.layout.inc(1) end),
  awful.key({ super, "Shift" }, "Tab", function() awful.layout.inc(-1) end),
  awful.key({ super, "Shift" }, "n", unminimize),

  awful.key({ super }, "Return", function() awful.spawn(terminal) end),
  awful.key({ super }, "d", function() awful.spawn("rofi -show-icons -show drun"); end),
  awful.key({ super }, "r", function() awful.spawn("rofi -show-icons -show run"); end),
  awful.key({ super }, "c", function() awful.spawn("rofi -show calc"); end),
  awful.key({ super }, "e", function() awful.spawn("rofi -show emoji"); end),
  awful.key({ super, alt }, "l", function() awful.spawn("betterlockscreen -l dim &"); end),
  awful.key({ super }, "b", function() awful.spawn("firefox"); end),
  awful.key({ super, "Shift"}, "h", function() awful.spawn("dm-hub -r"); end),
  awful.key({ super, "Shift"}, "p", function() awful.spawn("dm-logout -r"); end),
  awful.key({ super }, "space", function() awful.spawn("rofi_switch_keyboard_layout"); end),
  awful.key({ super }, "v", function() awful.spawn("clipmenu"); end),
  awful.key({ super }, "z", function() awful.spawn("zotero"); end)
)

local client_keys = gears.table.join(
  awful.key({ super, }, "f", toggle_fullscreen),
  awful.key({ super, }, "n", minimize),
  awful.key({ super }, "m", maximize),
  awful.key({ super, }, "q", function(c) c:kill() end),
  awful.key({ super, "Control" }, "space", awful.client.floating.toggle),
  awful.key({ super, }, "o", function(c) c:move_to_screen() end),
  awful.key({ super, "Shift" }, "t", function(c) c.ontop = not c.ontop end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  global_keys = gears.table.join(global_keys,
    -- View tag only.
    awful.key({ super }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
    awful.key({ super, "Control" }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
    awful.key({ super, "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
    awful.key({ super, "Control", "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

local client_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ super }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ super }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

-- Set keys
root.keys(global_keys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = client_keys,
      buttons = client_buttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  },

  -- Floating clients.
  {
    rule_any = {
      instance = {
        "DTA",   -- Firefox addon DownThemAll.
        "copyq", -- Includes session name in class.
        "pinentry",
      },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "MessageWin",  -- kalarm.
        "Sxiv",
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "veromix",
        "xtightvncviewer" },

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester", -- xev.
      },
      role = {
        "AlarmWindow",   -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
      }
    },
    properties = { floating = true }
  },

  -- Add titlebars to normal clients and dialogs
  {
    rule_any = { type = { "normal", "dialog" }
    },
    properties = { titlebars_enabled = false }
  },

  {
    rule = { class = "Firefox" },
    properties = { screen = 1, tag = tag_names[2] }
  },
}
-- }}}


-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

awful.spawn("/home/cabero/.config/autostart/autostart.sh")
