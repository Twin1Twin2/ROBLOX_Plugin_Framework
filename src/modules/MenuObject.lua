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


function MenuObject:new()
    local this  = {

    }


    self.__index    = self
    setmetatable(this, self)

    
    return this
end


return MenuObject