---@class Colour
local Colour = {
    red = 0;
    green = 0;
    blue = 0;

    ---@type integer?
    alpha = 0
}
Colour.__index = Colour

---@param r integer
---@param g integer
---@param b integer
---@param a integer?
function Colour:create(r, g, b, a)
    return setmetatable({
        red = r;
        green = g;
        blue = b;
        alpha = a;
    }, self)
end

function Colour:__tostring()
    return string.format("Colour: %p ({ red = %d, green = %d, blue = %d })", self, self.red, self.green, self.blue)
end


debug.setmetatable(0, {
    __len = function(n)
        local r, g, b, a = bit.band(n, 0xFF0000) / 0x10000, bit.band(n, 0x00FF00) / 0x100, bit.band(n, 0x0000FF), bit.band(n, 0xFF000000) / 0x1000000
        return Colour:create(r, g, b, a)
    end,

})

local col = #0xA0AAFA
print(col)
