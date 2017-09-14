-- // DESCRIPTION // --
--
--
--
--


-- // MODULES // --

local Signal    = require(script.Parent.Signal)


-- // MAIN CODE // --

local PluginToolbar = {
    ClassName   = "PluginToolbar";
}


function PluginToolbar:Button()

end


function PluginToolbar:new(pluginManager, toolbarName)
    if (type(toolbarName) ~= "string") then
        error("Argument [2]", 2)
    end

    local this  = {
        Name            = "";

        PluginManager   = nil;

        Plugin          = nil;
        Toolbar         = nil;

        PluginButtons           = {};
        PluginButtonsList       = {};

        PluginToolButtons       = {};
        PluginToolButtonsList   = {};
    }


    self.__index    = self
    setmetatable(this, self)


    local plugin    = pluginManager.Plugin
    local toolbar   = plugin:CreateToolbar(toolbarName)

    this.Name       = toolbarName

    this.PluginManager  = pluginManager
    
    this.Plugin     = plugin
    this.Toolbar    = toolbar

    return this
end


return PluginToolbar