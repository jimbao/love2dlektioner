package.path = "../verktyg/?.lua;" .. package.path
require "bas"
require "sprite"

local spelmapp = love.filesystem.getWorkingDirectory ()

local sprites = {}
local kostymer = {
    "resources/a1.png",
    "resources/a2.png",
    "resources/a3.png",
    "resources/a4.png",
    "resources/a5.png",
    "resources/a6.png",
    "resources/a7.png",
    "resources/a8.png"
}

-- Ladda spelet
function love.load()
    bas.starta(bas.uppdateraGrafik)
    bas.starta(bas.repeteraAlla)
    mynt = Sprite(200, 200, 0.2, kostymer)
    table.insert(sprites, mynt)
    bas.startaGrafik(mynt)
    bas.repetera(animera, 0.15, true)
end

-- Denna funktion repeteras för alltid
function love.update()
    bas.tick()
    -- love.timer.sleep(1/30)
end

-- Denna funktion repeteras för alltid
function love.draw()
    for _, sprite in pairs(sprites) do
        sprite:rita()
    end
end

-- Denna funktion läser tangentbordet
function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function animera()
    mynt:bytKostym()
end

function Sprite:uppdatera()
    if self.x + self.bredd > 800 or self.x < 0 then
        self.xfart = self.xfart * -1 -- Gånger minus ändrar från negativt till positivt
    end
    if self.y + self.hojd > 600 or self.y < 0 then
        self.yfart = self.yfart * -1 -- Gånger minus ändrar från positivt till negativt
    end
    self.x = self.x + self.xfart
    self.y = self.y + self.yfart
end

