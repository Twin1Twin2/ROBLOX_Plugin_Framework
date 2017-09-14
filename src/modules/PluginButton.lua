-- // DESCRIPTION // --
--
--
--
--


-- // MODULES // --

local Signal    = require(script.Parent.Signal)


-- // MAIN CODE // --

local PluginButton  = {
    ClassName   = "PluginButton";
}


function PluginButton:new(toolbarObject, name, hoverText, buttonIcon)
    local this  = {
        Name            = nil;

        PluginManager   = nil;

        Plugin          = nil;
        Toolbar         = nil;
        Button          = nil;

        OnClick         = nil;
    }


    self.__index    = self
    setmetatable(this, self)

    local pluginManager = toolbarObject.PluginManager
    local toolbar       = toolbarObject.Toolbar
    local button        = toolbar:CreateButton(buttonName, hoverText, buttonIcon)

    button.Click:connect(function()
        this.OnClick:Fire()
    end)

    this.Name           = name

    this.PluginManager  = pluginManager
    this.Plugin         = pluginManager.Plugin

    this.Toolbar    = toolbar
    this.Button     = button
    
    this.OnClick    = Signal:new()

    return this
end


return PluginButton