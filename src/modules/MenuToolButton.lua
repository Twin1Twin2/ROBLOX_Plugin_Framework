


local MenuToolButton    = {
    ClassName   = "MenuToolButton";
}


function MenuToolButton:new(menu, name)
    local base  = MenuButton:new(menu, name);

    base.__index    = self
    setmetatable(self, base)

    local this  = {
        FullName    = "";

        Selected    = false;

        OnToolSelect        = nil;
        OnToolDeselect      = nil;
        OnSelectionChanged  = nil;
    }


    self.__index    = self
    setmetatable(this, self)

    local toolPath  = menu:GetFullName() .. "." .. name

    this.FullName   = toolPath

    this.OnToolSelect       = Signal:new();
    this.OnToolDeselect     = Signal:new();
    this.OnSelectionChanged = Signal:new();


    this.OnMouseButton1Click:Connect(function()
        pluginManager:SelectTool(toolPath)
    end)


    return this
end


return MenuToolButton