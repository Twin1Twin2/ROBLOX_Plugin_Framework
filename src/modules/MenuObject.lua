-- // DESCRIPTION // --
--
--
--
--


-- // MODULES // --

local Signal    = require(script.Parent.Signal)


-- // MAIN CODE // --

local MenuObject    = {
    ClassName   = "MenuObject";
}


function MenuObject:SetVisible(value)
    if (value ~= nil and type(value) ~= "boolean") then
        error("Argument [1]", 2)
    end

    if (value ~= nil) then
        if (self.Visible == value) then
            return
        end
        self.Visible    = value
    else
        self.Visible    = not self.Visible
    end
    
    self.OnVisibleChanged:Fire(self.Visible)
end


function MenuObject:SetEnabled(value)
    if (value ~= nil and type(value) ~= "boolean") then
        error("Argument [1]", 2)
    end

    if (value ~= nil) then
        if (self.Enabled == value) then
            return
        end
        self.Enabled    = value
    else
        self.Enabled    = not self.Enabled
    end

    self.OnEnabledChanged:Fire(self.Enabled)
end


function MenuObject:new(pluginManager, name)
    local this  = {
        Name    = "";

        PluginManager   = nil;

        Visible     = true;
        Enabled     = true;

        Text            = "";
        MouseOverText   = "";

        CustomStylist   = nil;

        Position        = nil;

        OnVisibleChanged    = nil;  --Signal
        OnEnabledChanged    = nil;  --Signal

        Stackable           = true;

        BaseFrameStylist    = nil;

        GUIObjects  = {};
    }


    self.__index    = self
    setmetatable(this, self)


    this.PluginManager  = pluginManager

    this.Name   = name


    this.OnVisibleChanged   = Signal:new()
    this.OnEnabledChanged   = Signal:new()

    
    return this
end


return MenuObject