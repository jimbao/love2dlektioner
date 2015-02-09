package.path = "../verktyg/?.lua;" .. package.path
require "bas"
require "sprite"

sprites = {}
kostymer = {
    "resources/blue.png",
    "resources/green.png",
    "resources/brun.png"
}

function love.load()
    bas.starta(bas.hanteraSignaler)
    bas.starta(bas.uppdateraGrafik)
    bas.starta(bas.repeteraAlla)
    rad1 = Sprite(100, 230, 0, 0, 0.2, kostymer)
    rad2 = Sprite(300, 230, 0, 0, 0.2, kostymer)
    rad3 = Sprite(500, 230, 0, 0, 0.2, kostymer)
    table.insert(sprites, rad1)
    table.insert(sprites, rad2)
    table.insert(sprites, rad3)
    bas.repetera(animera, 0.5, true, rad1)
    bas.repetera(animera, 1, true, rad2)
    bas.repetera(animera, 1.3, true, rad3)
end

function love.update()
    bas.tick()
end

function love.draw()
    for _, sprite in pairs(sprites) do
        sprite:rita()
    end
    -- love.graphics.print(string.format("Poäng %s", points), 5, 5)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function animera(sprite)
    sprite:bytKostym()
end
