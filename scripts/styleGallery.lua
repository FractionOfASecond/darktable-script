--[[
    This file is part of darktable,
    copyright (c) 2016 Tobias Jakobs

    darktable is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    darktable is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with darktable.  If not, see <http://www.gnu.org/licenses/>.
]]
--[[

USAGE
* require this script from your main lua file
  To do this add this line to the file .config/darktable/luarc: 
require "styleGallery"
* it creates this lighttable module: you can create a group with
  all your library's styles
]]

local dt = require "darktable"

-- add generate button
--     for each style duplicate selected image & apply it
local button_gen = dt.new_widget("button")
{
  -- button label
  label = "Apply styles",

  -- button callback
  clicked_callback = function (_)
    -- load styles
    local styles = dt.styles
    -- load selection
    local selection = dt.gui.selection()
    -- for each image
    for _,img in ipairs(selection) do
      -- for each style
      for _,style in ipairs(styles) do
        -- duplicate image
        local img2 = dt.database.duplicate(img)
        -- group image
        img2:group_with(img)
 	      -- apply style
        dt.styles.apply(style, img2)
      end
    end
  end
}

-- module register
dt.register_lib(
  "Styles gallery",    -- Module name
  "Styles gallery",    -- name
  true,                -- expandable
  false,               -- resetable
  {[dt.gui.views.lighttable] = {"DT_UI_CONTAINER_PANEL_RIGHT_CENTER", 100}},   -- containers
  dt.new_widget("box") -- widget
  {
    orientation = "vertical",
    button_gen
  },
  nil,-- view_enter
  nil -- view_leave
)

-- vim: shiftwidth=2 expandtab tabstop=2 cindent syntax=lua
-- kate: hl Lua;
