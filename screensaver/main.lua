package.path = "../verktyg/?.lua;" .. package.path
require "bas"
require "sprite"

local sprites = {}

function love.load()
    bas.starta(bas.hanteraSignaler)
    bas.starta(bas.uppdateraGrafik)
    cirkel = Sprite(100, 100)
    table.insert(sprites, cirkel)
    bas.startaGrafik(cirkel)
    text = "Hej!"
end

function love.update()
    bas.tick()
    love.timer.sleep(1/30)
end

function love.draw()
    for _, sprite in pairs(sprites) do
        sprite:rita()
    end
    love.graphics.print(text, 550, 300)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == " " then 
        bas.skickaSignal(mellanslag, "Mellanslag!")
    end
    if key == "w" then
        text = "Hejsan"
    end
end

function mellanslag(event, ...)
    text = event
end

