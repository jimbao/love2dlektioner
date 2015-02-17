package.path = "../verktyg/?.lua;..\\verktyg\\?.lua;" .. package.path
require "bas"
require "sprite"

sprites = {}
hinder = {}
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
nummerkostymer = {
    "resources/numbers/0.png",
    "resources/numbers/1.png",
    "resources/numbers/2.png",
    "resources/numbers/3.png",
    "resources/numbers/4.png",
    "resources/numbers/5.png",
    "resources/numbers/6.png",
    "resources/numbers/7.png",
    "resources/numbers/8.png",
    "resources/numbers/9.png",
}

function love.load()
    bas.starta(bas.hanteraSignaler)
    bas.starta(bas.uppdateraGrafik)
    bas.starta(bas.repeteraAlla)
    bakgrund = love.graphics.newImage( "resources/background.png" )
    getready = love.graphics.newImage( "resources/Get-Ready.png" )
    happy = Sprite(125, 250, 0, 0, 0.14, spelarkostymer)
    golvtorn = Sprite(850, 100, -5, 0, 0.14, tornkostymer)
    taktorn = Sprite(940, -100, -5, 0, -0.14, tornkostymer)
    ental = Sprite(60, 10, 0, 0, 0.30, nummerkostymer)
    tiotal = Sprite(40, 10, 0, 0, 0.30, nummerkostymer)
    hundratal = Sprite(20, 10, 0, 0, 0.30, nummerkostymer)
    table.insert(sprites, happy)
    table.insert(sprites, ental)
    table.insert(sprites, tiotal)
    table.insert(sprites, hundratal)
    bas.repetera(animera, 0.15, true, happy)
    bas.repetera(skapaTorn, 1.5, true)
    bas.startaGrafik(happy, uppdateraSpelare)
    spelstatus = "paus"
    score = 0
end

function love.update()
    if spelstatus == "startad" then
        bas.tick()
        for _, torn in pairs(hinder) do
            if happy:krock(torn) then
                reset()
            end
        end
    end
end

function love.draw()
    love.graphics.draw(bakgrund, 0, 0, 0, 1.2)
    for _, torn in pairs(hinder) do
        torn:rita()
    end
    for _, sprite in pairs(sprites) do
        sprite:rita()
    end
    if spelstatus == "paus" then
        love.graphics.draw(getready, 200, 150, 0, 0.2)
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == " " then
        if spelstatus ~= "startad" then
            start()
        end
        bas.skickaSignal(fly, happy)
    end
end

function animera(sprite)
    sprite:bytKostym()
end

function start()
    spelstatus = "startad"
end

function success(sprite)
    if sprite.x < happy.x then
        score = score + 1
        uppdateraScore()
    else
        bas.repetera(success, 0.23, false, sprite)
    end
end

function uppdateraScore()
    ental.kostym = score % 10 + 1
    tiotal.kostym = math.floor(score / 10) % 10 + 1
    hundratal.kostym = math.floor(score / 100) % 10 + 1
end

function reset()
    sprites = {}
    hinder = {}
    table.insert(sprites, happy)
    table.insert(sprites, ental)
    table.insert(sprites, tiotal)
    table.insert(sprites, hundratal)
    happy.y = 250
    happy.vinkel = 0
    spelstatus = "paus"
    score = 0
    uppdateraScore()
end

function gameover()

end

function skapaTorn()
    slump = math.random(100, 500)
    golvtornkopia = golvtorn:kopiera()
    taktornkopia = taktorn:kopiera()
    golvtornkopia.y = slump + 100
    taktornkopia.y = slump - 100
    taktornkopia.kostym = slump % table.getn(taktornkopia.kostymer) + 1
    golvtornkopia.kostym = taktornkopia.kostym
    table.insert(hinder, golvtornkopia)
    table.insert(hinder, taktornkopia)
    bas.startaGrafik(golvtornkopia, uppdateraTorn)
    bas.startaGrafik(taktornkopia, uppdateraTorn)
    bas.repetera(success, 0.2, false, golvtornkopia)
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


