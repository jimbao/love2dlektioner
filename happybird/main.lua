package.path = "../verktyg/?.lua;" .. package.path
require "bas"
require "sprite"

sprites = {}
spelarkostymer = {
    "resources/player/frame-1.png",
    "resources/player/frame-2.png",
    "resources/player/frame-3.png",
    "resources/player/frame-4.png",
}
tornkostymer = {
    "resources/towers/Green-tower.png",
    "resources/towers/Icy-tower.png",
    "resources/towers/Pink-tower.png",
    "resources/towers/Yellow-tower.png",
}

function love.load()
    bas.starta(bas.hanteraSignaler)
    bas.starta(bas.uppdateraGrafik)
    bas.starta(bas.repeteraAlla)
    bakgrund = love.graphics.newImage( "resources/background.png" )
    happy = Sprite(75, 250, 0, 0, 0.14, spelarkostymer)
    golvtorn = Sprite(850, 100, -5, 0, 0.14, tornkostymer)
    taktorn = Sprite(940, -100, -5, 0, -0.14, tornkostymer)
    table.insert(sprites, happy)
    bas.repetera(animera, 0.15, true, happy)
    bas.repetera(skapaTorn, 1.5, true)
    bas.startaGrafik(happy, uppdateraSpelare)
end

function love.update()
    bas.tick()
end

function love.draw()
    love.graphics.draw(bakgrund, 0, 0, 0, 1.2)
    for _, sprite in pairs(sprites) do
        sprite:rita()
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == " " then
        bas.skickaSignal(fly, happy)
    end
end

function animera(sprite)
    sprite:bytKostym()
end

function skapaTorn()
    slump = math.random(100, 500)
    golvtornkopia = golvtorn:kopiera()
    taktornkopia = taktorn:kopiera()
    golvtornkopia.y = slump + 100
    taktornkopia.y = slump - 100
    taktornkopia.kostym = slump % table.getn(taktornkopia.kostymer) + 1
    golvtornkopia.kostym = taktornkopia.kostym
    table.insert(sprites, golvtornkopia)
    table.insert(sprites, taktornkopia)
    bas.startaGrafik(golvtornkopia, uppdateraTorn)
    bas.startaGrafik(taktornkopia, uppdateraTorn)
end

function fly(sprite)
    sprite.vinkel = -0.55
end

function uppdateraTorn(torn)
    torn.x = torn.x + torn.xfart
end

function uppdateraSpelare(happy)
    -- Should simplify this
    happy.yfart = happy.vinkel * 15
    if happy.vinkel < 0.8 then
        happy.vinkel = happy.vinkel + 0.05
    end
    if (happy.y + happy.hojd < 600 or happy.yfart < 0) and (happy.y > 0 or happy.yfart > 0) then
        happy.y = happy.y + happy.yfart
    end
end


