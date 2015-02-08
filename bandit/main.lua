package.path = "../verktyg/?.lua;" .. package.path
require "bas"

sprites = {}
points = 0

function love.load()
    bas.starta(bas.hanteraSignaler)
    bas.starta(bas.uppdateraGrafik)
    bas.starta(bas.repeteraAlla)
    bas.repetera(testSchema, 3, true, "Param")
    bas.repetera(testFaster, 2, false, 2)
    -- bas.startaGrafik()
end

function love.update()
    bas.tick()
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

function testSchema(...)
    print(...)
end

function testFaster(delay)
    print(delay)
    delay = delay * 0.9
    bas.repetera(testFaster, delay, false, delay)
end

