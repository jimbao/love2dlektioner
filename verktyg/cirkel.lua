Cirkel = {}
Cirkel.__index = Cirkel

setmetatable(Cirkel, {
    __call = function (cls, ...)
        return cls.ny(...)
    end,
})

function Cirkel.ny(x, y, ...)
    local self = setmetatable({}, Cirkel)
    self.x = x
    self.y = y
    self.radie = 50
    self.xfart = 4
    self.yfart = 4
    return self
end

function Cirkel:rita()
    love.graphics.setColor(255, 255, 255);
    love.graphics.circle("fill", self.x, self.y, self.radie, 100)
end

function Cirkel:uppdatera()

end
