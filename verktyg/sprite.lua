Sprite = {}
Sprite.__index = Sprite

setmetatable(Sprite, {
  __call = function (cls, ...)
    return cls.ny(...)
  end,
})

function Sprite.ny(x, y, xfart, yfart, skala, kostymer, animationer, ...)
    local self = setmetatable({}, Sprite)
    self.x = x
    self.y = y
    self.xfart = xfart
    self.yfart = yfart
    self.skala = skala
    self.kostym = 1
    self.kostymer = {}
    self.animationer = {}
    for nummer, filnamn in pairs(kostymer) do
        bild = love.graphics.newImage( filnamn )
        self.kostymer[nummer] = bild
    end
    if animationer then
        for namn, tabell in pairs(animationer) do
            bilder = {}
            for nummer, filnamn in pairs(tabell) do
                bild = love.graphics.newImage( filnamn )
                bilder[nummer] = bild
            end
            self.animationer[namn] = bilder
        end
    end
    self.animation = self.kostymer
    self.bredd = self.kostymer[1]:getWidth() * self.skala
    self.hojd = self.kostymer[1]:getHeight() * self.skala
    self.stop = false
    return self
end

function Sprite:rita()
    love.graphics.draw( self.animation[self.kostym], self.x, self.y, 0, self.skala)
end

function Sprite:bytKostym()
    self.kostym = self.kostym % table.getn(self.animation) + 1
    if self.kostym == table.getn(self.animation) and not self.stop then
        self.animation = self.kostymer
    elseif self.stop then
        self.kostym = table.getn(self.animation)
    end
end

function Sprite:spelaAnimation(namn)
    self.kostym = 1
    self.animation = self.animationer[namn]
end

function Sprite:stopAnimation(namn)
    self.stop = true
    self.animation = self.animationer[namn]
end
