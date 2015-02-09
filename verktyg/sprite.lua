Sprite = {}
Sprite.__index = Sprite

setmetatable(Sprite, {
  __call = function (cls, ...)
    return cls.ny(...)
  end,
})

function Sprite.ny(x, y, skala, kostymer, ...)
    local self = setmetatable({}, Sprite)
    self.x = x
    self.y = y
    self.xfart = 4
    self.yfart = 4
    self.skala = skala
    self.kostym = 1
    self.kostymer = {}
    for nummer, filnamn in pairs(kostymer) do
        bild = love.graphics.newImage( filnamn )
        self.kostymer[nummer] = bild
    end
    self.bredd = self.kostymer[1]:getWidth() * self.skala
    self.hojd = self.kostymer[1]:getHeight() * self.skala
    return self
end

function Sprite:rita()
    love.graphics.draw( self.kostymer[self.kostym], self.x, self.y, 0, self.skala)
end

function Sprite:bytKostym()
    self.kostym = self.kostym % table.getn(self.kostymer) + 1
end
