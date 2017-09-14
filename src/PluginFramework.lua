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
            self.TurnedOn = true
            self.Plugin:Activate(true)
            self.TurnedOn = false

            self.IsOn = true
        end
    else
        self.Plugin:Activate(false)
    end
end


function PluginFramework:new(pluginName)
    local this = {
        Name    = "";

        Plugin  = nil;
        Toolbar = nil;
        Mouse   = nil;

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
    }


    self.__index    = self
    setmetatable(this, self)

    local plugin    = plugin
    local mouse     = plugin:GetMouse()


    mouse.Button2Down:Connect(function()
        this.MouseButton2IsDown = true
    end)

    mouse.Button2Up:Connect(function()
        this.MouseButton2IsDown = false
    end)

    local leftCtrl  = false
    local rightCtrl = false
    local leftAlt   = false
    local rightAlt  = false

    local function UpdateCtrl()
        if (leftCtrl == true or rightCtrl == true) then
            this.CtrlIsDown = true
        else
            this.CtrlIsDown = false
        end
    end

    local function UpdateAlt()
        if (leftAlt == true or rightAlt == true) then
            this.AltIsDown = true
        else
            this.AltIsDown = false
        end
    end

    UserInputService.InputBegan:Connect(function(inputObject, gameProcessedEvent)
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

    UserInputService.InputEnded:Connect(function(inputObject, gameProcessedEvent)
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


    UserInputService.WindowFocusedReleased:Connect(function()
        this.CtrlIsDown         = false
        this.AltIsDown          = false
        this.MouseButton2IsDown = false
    end)


    plugin.Deactivation:Connect(function()
        if (this.IsOn == true and this.TurnedOn == false) then
            this:ClearInputEvents()

            this.CtrlIsDown         = false
            this.AltIsDown          = false
            this.MouseButton2IsDown = false

            this:DeselectTool(this.SelectedTool)
            this.PreviousTool       = this.SelectedTool
            this.SelectedTool       = nil
            
            this.IsOn = false
        end
    end)


    this.Plugin     = plugin
    this.Mouse      = mouse

    
    return this
end


return PluginFramework