-- // DESCRIPTION // --
--
--
--
--


-- // MODULES // --

local Signal    = require(script.Parent.Signal)


-- // MAIN CODE // --

local ToolObject  = {
    ClassName   = "ToolObject";
}


function ToolObject:new()
    local this  = {
        Name        = "";
        FullName    = "";

        OnToolSelect        = nil;
        OnToolDeselect      = nil;
        OnSelectionChanged  = nil;
    }


    this.OnToolSelect       = Signal:new();
    this.OnToolDeselect     = Signal:new();
    this.OnSelectionChanged = Signal:new();


    return this
end


return ToolObject