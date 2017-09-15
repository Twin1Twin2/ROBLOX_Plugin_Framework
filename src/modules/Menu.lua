-- // DESCRIPTION // --
--
--
--
--


-- // MODULES // --

local Signal        = require(script.Parent.Signal)

local MenuObject    = require(script.Parent.MenuObject)

local DropDownMenu  
local TextBoxObject 

local MenuButton    = require(script.Parent.MenuButton)
local ToolButton    = require(script.Parent.ToolButton)
local ToggleButton


-- // MAIN CODE // --

local Menu    = {
    ClassName   = "PluginMenu";
}


local function SetupMenuObject(pluginMenu, menuObject, name, global, index)
    local isIndex   = (index ~= nil and type(index) == "number")
    if (global == true) then
        if (isIndex == true) then
            table.insert(pluginMenu.GlobalMenuObjectList, index, name)
        else
            table.insert(pluginMenu.GlobalMenuObjectList, name)
        end

        pluginMenu.GlobalMenuObjects[name]  = menuObject
    else
        if (isIndex == true) then
            table.insert(pluginMenu.MenuObjectList, index, name)
        else
            table.insert(pluginMenu.MenuObjectList, name)
        end

        pluginMenu.MenuObjects[name]    = menuObject
    end
end


function Menu:CreateMenu(name, global, index)
    local menu  = Menu:new(self.PluginManager, name)
    
    SetupMenuObject(self, menu, name, global, index)

    table.insert(self.MenuList, name)
    self.Menus[name]    = menu

    menu.ParentMenu = self

    return menu
end


function Menu:CreateButton(name, global, index)
    local button    = MenuButton:new(self, name)

    SetupMenuObject(self, button, name, global, index)

    return button
end


function Menu:CreateToolButton(name, global, index)
    local toolButton    = MenuToolButton(self, name)

    SetupMenuObject(self, toolButton, name, global, index)

    self.PluginManager:ToolAdd(toolButton.FullName, toolButton)

    return toolButton
end


function Menu:CreateToggleButton(name, global, index)

end


function Menu:CreateCustomObject(name, global, index)
    local object    = MenuObject:new(self.PluginManager, name)

    SetupMenuObject(self, object, name, global, index)

    return object
end


function Menu:CreateTextBox(name, global, index)

end


function Menu:GetFullName()
    if (self.ParentMenu ~= nil) then
        return self.ParentMenu:GetFullName() .. "\\" .. self.Name
    end
    return self.Name
end


function Menu:new(pluginManager, menuName)
    local base  = MenuObject:new(pluginManager, menuName)

    base.__index    = base
    setmetatable(self, base)

    local this  = {
        MenuObjects     = {};
        MenuObjectsList = {};

        Menus           = {};
        MenuList        = {};

        GlobalMenuObjects       = {};
        GlobalMenuObjectList    = {};

        UseGlobalMenuObjects    = false;

        MenuStackingFrame       = false;
        HorizontalStack         = false;
        Alignment               = false;

        ObjectPadding           = 0;
        BorderPadding           = 0;
    }


    self.__index    = self
    setmetatable(this, self)

    
    return this
end


return Menu