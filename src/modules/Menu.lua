-- // DESCRIPTION // --
--
--
--
--


-- // MODULES // --

local Signal    = require(script.Parent.Signal)


-- // MAIN CODE // --

local Menu    = {
    ClassName   = "PluginMenu";
}


function Menu:new()
    local this  = {

    }


    self.__index    = self
    setmetatable(this, self)

    
    return this
end


return Menu