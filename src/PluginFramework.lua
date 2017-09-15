-- // DESCRIPTION // --
--
--
--
--


-- // SERVICES // --

local UserInputService  = game:GetService("UserInputService")


-- // MODULES // --

local Signal        = require(script.Signal)

local Menu          = require(script.Menu)
local Tool          = require(script.Tool)
local PluginToolbar = require(script.PluginToolbar)


-- // MAIN CODE // --

local PluginFramework = {
    ClassName   = "PluginFramework";
}


function PluginFramework:ClearInputEvents()

end


function PluginFramework:DeselectTool(tool)
    if (tool == nil) then
        return
    end

    self.Tools[tool].OnToolDeselect:Fire(tool)

    self.SelectedTool = nil
    self:ClearInputEvents()
end


function PluginFramework:SelectedTool(tool)
    self:SetPluginActive(true)

    if (tool == nil) then
        return
    end

    if (self.SelectedTool ~= nil) then
        local prev  = self.SelectedTool

        self.PreviousTool   = prev
        self:DeselectTool(prev)

        if (prev == tool) then
            self.PreviousTool   = nil
            return
        end
    end

    self.SelectedTool = tool

    self.Tools[tool].OnToolSelect:Fire()
end


function PluginFramework:SelectPrevious()
    if (self.SelectedTool ~= nil) then
        self:DeselectTool(self.SelectedTool)
    end
    
    self:SelectedTool(self.PreviousTool)
end


function PluginFramework:SetPluginActive(value)
    if (value == true) then
        if (self.IsOn == false) then
            self.TurnedOn = true        --prevent deactivation when activate is called
            self.Plugin:Activate(true)
            self.TurnedOn = false       --

            self.IsOn = true
        end
    else
        self.Plugin:Activate(false)     --wll trigger the plugin deactivation event
    end
end


function PluginFramework:EnableInput()
    local leftCtrl  = false
    local rightCtrl = false
    local leftAlt   = false
    local rightAlt  = false

    local function UpdateCtrl()
        if (leftCtrl == true or rightCtrl == true) then
            self.CtrlIsDown = true
        else
            self.CtrlIsDown = false
        end
    end

    local function UpdateAlt()
        if (leftAlt == true or rightAlt == true) then
            self.AltIsDown = true
        else
            self.AltIsDown = false
        end
    end
    
    self.Button2DownConnection  = self.Mouse.Button2Down:Connect(function()
        self.MouseButton2IsDown = true
    end)

    self.Button2UpConnection    = self.Mouse.Button2Up:Connect(function()
        self.MouseButton2IsDown = false
    end)

    self.InputBeganConnection   = UserInputService.InputBegan:Connect(function(inputObject, gameProcessedEvent)
        local keyCode = inputObject.KeyCode

        if (keyCode == Enum.KeyCode.LeftControl) then
            leftCtrl    = true
            UpdateCtrl()
        elseif (keyCode == Enum.KeyCode.RightControl) then
            rightCtrl   = true
            UpdateCtrl()
        elseif (keyCode == Enum.KeyCode.LeftAlt) then
            leftAlt     = true
            UpdateCtrl()
        elseif (keyCode == Enum.KeyCode.RightAlt) then
            rightAlt    = true
            UpdateCtrl()
        end

        --KeyDown:Fire(keyCode)
    end)

    self.InputEndedConnection   = UserInputService.InputEnded:Connect(function(inputObject, gameProcessedEvent)
        local keyCode = inputObject.KeyCode

        if (keyCode == Enum.KeyCode.LeftControl) then
            leftCtrl    = false
            UpdateCtrl()
        elseif (keyCode == Enum.KeyCode.RightControl) then
            rightCtrl   = false
            UpdateCtrl()
        elseif (keyCode == Enum.KeyCode.LeftAlt) then
            leftAlt     = false
            UpdateCtrl()
        elseif (keyCode == Enum.KeyCode.RightAlt) then
            rightAlt    = false
            UpdateCtrl()
        end

        --KeyDown:Fire(keyCode)
    end)

    self.WindowFocusedReleasedConnection    = UserInputService.WindowFocusedReleased:Connect(function()
        self.CtrlIsDown         = false
        self.AltIsDown          = false
        self.MouseButton2IsDown = false
    end)
end


function PluginFramework:DisableInput()
    self.CtrlIsDown         = false
    self.AltIsDown          = false
    self.MouseButton2IsDown = false

    if (self.Button2DownConnection ~= nil) then
        self.Button2DownConnection:Disconnect()
        self.Button2DownConnection  = nil
    end

    if (self.Button2UpConnection ~= nil) then
        self.Button2UpConnection:Disconnect()
        self.Button2UpConnection    = nil
    end

    if (self.InputBeganConnection ~= nil) then
        self.InputBeganConnection:Disconnect()
        self.InputBeganConnection   = nil
    end

    if (self.InputEndedConnection ~= nil) then
        self.InputEndedConnection:Disconnect()
        self.InputEndedConnection   = nil
    end

    if (self.WindowFocusedReleasedConnection ~= nil) then
        self.WindowFocusedReleasedConnection:Disconnect()
        self.WindowFocusedReleasedConnection    = nil
    end
end


function PluginFramework:ToolAdd(toolName, toolObject)
    table.insert(self.ToolList, toolName)
    self.Tools[toolName, toolObject]
end


function PluginFramework:CreateMenu(menuName, index)
    local menu  = Menu:new(self, menuName)

    index   = index or #self.MenuList + 1

    table.insert(self.MenuList, index, menuName)
    self.Menus[menuName]    = menu

    return menu
end


function PluginFramework:CreateToolbar(toolbarName)
    local toolbar   = PluginToolbar:new(self, toolbarName)

    table.insert(self.ToolbarList, toolbarName)
    self.Toolbars[toolbarName]  = toolbar

    return toolbar
end


function PluginFramework:new(pluginName)
    local this = {
        Name    = "";

        Plugin  = nil;
        Mouse   = nil;

        Toolbars    = {};
        ToolbarList = {};

        Menus       = {};
        MenuList    = {};

        Tools       = {};
        ToolList    = {};

        PreviousTool    = nil;  --string
        SelectedTool    = nil;  --string

        IsOn        = false;
        TurnedOn    = false;

        CtrlIsDown          = false;
        AltIsDown           = false;
        MouseButton2IsDown  = false;

        Button2DownConnection           = nil;
        Button2UpConnection             = nil;
        InputBeganConnection            = nil;
        InputEndedConnection            = nil;
        WindowFocusedReleasedConnection = nil;
    }


    self.__index    = self
    setmetatable(this, self)

    local plugin    = plugin
    local mouse     = plugin:GetMouse()


    this.Plugin     = plugin
    this.Mouse      = mouse


    this.Plugin.Deactivation:Connect(function()
        if (this.IsOn == true and this.TurnedOn == false) then
            this:ClearInputEvents()

            this:DisableInput()

            this:DeselectTool(this.SelectedTool)
            this.PreviousTool       = this.SelectedTool
            this.SelectedTool       = nil
            
            this.IsOn = false
        end
    end)
    
    return this
end


return PluginFramework