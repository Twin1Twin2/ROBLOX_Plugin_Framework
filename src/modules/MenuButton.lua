-- // DESCRIPTION // --
--
--
--
--


-- // MODULES // --

local Signal    = require(script.Parent.Signal)

local MenuObjeect   = require(script.Parent.MenuObject)


-- // MAIN CODE // --

local MenuButton    = {
    ClassName   = "MenuButton";
}


function MenuButton:new(menu, name)
    local pluginManager = menu.PluginManager

    local base  = MenuObject:new(pluginManager, name)

    base.__index    = base
    setmetatable(self, base)

    local this  = {
        Icon    = nil;
        Color   = Color3.new(0, 0, 0);

        OnMouseButton1Click = nil;  --Signal
        OnMouseButton2Click = nil;  --Signal

        OnCtrlClick         = nil;  --Signal
        OnAltClick          = nil;  --Signal
        OnCtrlAltClick      = nil;  --Signal
    }


    self.__index    = self
    setmetatable(this, self)


    this.OnMouseButton1Click    = Signal:new()
    this.OnMouseButton2Click    = Signal:new()

    this.OnCtrlClick    = Signal:new()
    this.OnAltClick     = Signal:new()
    this.OnCtrlAltClick = Signal:new()

    
    return this
end


return MenuButton