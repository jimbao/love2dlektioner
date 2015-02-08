package.path = "../verktyg/?.lua;" .. package.path
require "bas"

sprites = {}
points = 0

function love.load()
    bas.starta(bas.hanteraSignaler)
    bas.starta(bas.uppdateraGrafik)
    -- bas.startaGrafik()
end

function love.update()
    bas.tick()
    love.timer.sleep(1/30)
end

function love.draw()
    for _, sprite in pairs(sprites) do
        sprite:rita()
    end
    love.graphics.print(string.format("Poäng %s", points), 5, 5)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
