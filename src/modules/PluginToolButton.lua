-- // DESCRIPTION // --
--
--
--
--


-- // MODULES // --

local Signal        = require(script.Parent.Signal)

local PluginButton  = require(script.Parent.PluginButton)


-- // MAIN CODE // --

local PluginToolButton  = {
    ClassName   = "PluginToolButton";
}


function PluginToolButton:GetFullName()
    return self.Toolbar.Name .. "\\" .. self.Name
end



function PluginToolButton:new(toolbarObject, buttonName, hoverText, buttonIcon)
    local base  = PluginButton:new(toolbarObject, buttonName, hoverText, buttonIcon)

    base.__index    = self
    setmetatable(self, base)

    local this  = {
        FullName            = "";

        OnToolSelect        = nil;
        OnToolDeselect      = nil;
        OnSelectionChanged  = nil;
    }


    self.__index    = self
    setmetatable(this, self)

    
    local pluginManager = toolbarObject.PluginManager
    local toolbar       = this.Toolbar
    local button        = this.Button
    local toolPath      = toolbar.Name .. "." .. buttonName

    this.FullName       = toolPath

    this.OnToolSelect       = Signal:new();
    this.OnToolDeselect     = Signal:new();
    this.OnSelectionChanged = Signal:new();

    button.Click:Connect(function()
        pluginManager:SelectTool(toolPath)
    end)

    this.OnToolSelect:Connect(function()
        button:SetActive(true)
    end)

    this.OnToolDeselect:Connect(function()
        button:SetActive(false)
    end)

    pluginManager:ToolAdd(toolPath, this)

    return this
end


return PluginToolButton