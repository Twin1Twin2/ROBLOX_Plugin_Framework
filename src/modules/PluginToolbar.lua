-- // DESCRIPTION // --
--
--
--
--


-- // MODULES // --

local Signal    = require(script.Parent.Signal)

local PluginButton      = require(script.Parent.PluginButton)
local PluginToolButton  = require(script.Parent.PluginToolButton)


-- // MAIN CODE // --

local PluginToolbar = {
    ClassName   = "PluginToolbar";
}


function PluginToolbar:CreateButton(buttonName, buttonHovertext, buttonIcon)
    local button    = PluginButton:new(self, buttonName, buttonHovertext, buttonIcon)

    table.insert(self.PluginButtonList, buttonName)
    self.PluginButtons[buttonName]  = button

    return button
end


function PluginToolbar:CreateToolButton(buttonName, buttonHovertext, buttonIcon)
    local toolButton    = PluginToolButton:new(self, buttonName, buttonHovertext, buttonIcon)

    table.insert(self.PluginButtonList, buttonName)
    self.PluginButtons[buttonName]  = button

    self.PluginManager:ToolAdd(toolButton.FullName, toolButton)

    return toolButton
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
        PluginButtonList        = {};   --lists are used for iterating though their related dictionary
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