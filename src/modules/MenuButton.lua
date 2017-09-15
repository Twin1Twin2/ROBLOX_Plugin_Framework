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

}


function MenuButton:new(pluginManager, name)
    local base  = MenuObject:new(pluginManager, name)

    base.__index    = base
    setmetatable(self, base)

    local this  = {

    }


    self.__index    = self
    setmetatable(this, self)

    return this
end


return MenuButton