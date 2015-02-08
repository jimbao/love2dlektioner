package.path = "../verktyg/?.lua;" .. package.path
require "bas"
require "cirkel"

local sprites = {}

function love.load()
    bas.starta(bas.hanteraSignaler)
    bas.starta(bas.uppdateraGrafik)
    cirkel = Cirkel(100, 100)
    table.insert(sprites, cirkel)
    bas.startaGrafik(cirkel)
end

function love.update()
    bas.tick()
    love.timer.sleep(1/30)
end

function love.draw()
    for _, sprite in pairs(sprites) do
        sprite:rita()
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function Cirkel:uppdatera()
    if self.x + self.radie > 800 or self.x - self.radie < 0 then
        self.xfart = self.xfart * -1 -- Gånger minus ändrar från negativt till positivt
    end
    if self.y + self.radie > 600 or self.y - self.radie < 0 then
        self.yfart = self.yfart * -1 -- Gånger minus ändrar från positivt till negativt
    end
    self.x = self.x + self.xfart
    self.y = self.y + self.yfart
end

