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
    self.vinkel = 0
    self.kostym = 1
    self.kostymer = {}
    self.animationer = {}
    if kostymer then
        for nummer, filnamn in pairs(kostymer) do
            bild = love.graphics.newImage( filnamn )
            self.kostymer[nummer] = bild
        end
        self.bredd = self.kostymer[1]:getWidth() * self.skala
        self.hojd = self.kostymer[1]:getHeight() * self.skala
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
    self.stop = false
    return self
end

function Sprite:rita()
    love.graphics.draw( self.animation[self.kostym], self.x, self.y, self.vinkel, self.skala)
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

function Sprite:kopiera()
    local kopia = Sprite.ny()
    for n,v in pairs(self) do kopia[n] = v end
    return kopia
end

function Sprite:krock(other)
    if other == self then
        return false
    end
    if other.skala < 0 then
        -- Inverted
        x2 = other.x + other.bredd
        y2 = other.y + other.hojd
        h2 = other.hojd * -1
        w2 = other.bredd * -1
    else
        x2, y2, h2, w2 = other.x, other.y, other.hojd, other.bredd
    end
    x1, y1, h1, w1 = self.x, self.y, self.hojd, self.bredd
    return x1 < x2+w2 and
        x2 < x1+w1 and
        y1 < y2+h2 and
        y2 < y1+h1
end


