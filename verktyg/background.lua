Background = {}
Background.__index = Background

setmetatable(Background, {
  __call = function (cls, ...)
    return cls.ny(...)
  end,
})

function Background.ny(x, y, xfart, yfart, skala, kostym, ...)
    local self = setmetatable({}, Background)
    self.x = x
    self.y = y
    self.xfart = xfart
    self.yfart = yfart
    self.skala = skala
    self.image = love.graphics.newImage(kostym)
    self.image:setWrap("repeat", "repeat")
    self.bredd = self.image:getWidth() * self.skala
    self.hojd = self.image:getHeight() * self.skala
    self.quad = love.graphics.newQuad(
        0,
        0,
        self.bredd * 2,
        self.hojd,
        self.bredd,
        self.hojd
    )
    return self
end

function Background:rita()
    love.graphics.draw(self.image, self.quad, self.x, self.y)
end
