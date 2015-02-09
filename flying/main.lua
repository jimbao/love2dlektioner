package.path = "../verktyg/?.lua;" .. package.path
require "bas"
require "sprite"

spelarkostymer = {
    "resources/player/frame-1.png",
    "resources/player/frame-2.png",
    "resources/player/frame-3.png",
    "resources/player/frame-4.png",
}

spelaranimationer = {
    ["skjut"] = {"resources/skjut/frame-1.png", "resources/skjut/frame-2.png", "resources/skjut/frame-3.png"}
}

skottkostymer = {
    "resources/skott/skott.png"
}

sprites = {}

function love.load()
    bakgrund = love.graphics.newImage( "resources/background.png" )
    bas.starta(bas.hanteraSignaler)
    bas.starta(bas.uppdateraGrafik)
    bas.starta(bas.repeteraAlla)
    spelare = Sprite(75, 250, 0, 0, 0.14, spelarkostymer, spelaranimationer)
    table.insert(sprites, spelare)
    bas.repetera(animera, 0.15, true, spelare)
    bas.startaGrafik(spelare, uppdateraSpelare)
end

function love.update()
    bas.tick()
end

function love.draw()
    love.graphics.draw(bakgrund, 0, 0, 0, 0.39)
    for _, sprite in pairs(sprites) do
        sprite:rita()
    end
    -- love.graphics.print(string.format("Poäng %s", points), 5, 5)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == "up" then
        bas.skickaSignal(upp, spelare)
    end
    if key == "down" then
        bas.skickaSignal(ner, spelare)
    end
    if key == " " then
        bas.skickaSignal(skjut, spelare)
    end
end

function uppdateraSpelare(spelare)
    -- Should simplify this
    if (spelare.x + spelare.bredd < 800 and spelare.xfart > 0) and (spelare.x > 0 and spelare.xfart > 0) then
        spelare.x = spelare.x + spelare.xfart
    end
    if (spelare.y + spelare.hojd < 600 or spelare.yfart < 0) and (spelare.y > 0 or spelare.yfart > 0) then
        spelare.y = spelare.y + spelare.yfart
    end
end

function animera(sprite)
    sprite:bytKostym()
end

function uppdateraSkott(skott)
    skott.x = skott.x + skott.xfart
    if skott.x > 1000 then
        -- Minneshantering
        sprites[skott] = nil
        bas.raderaGrafik(skott)
    end
end

function skjut(sprite)
    sprite:spelaAnimation("skjut")
    skott = Sprite(sprite.x + sprite.bredd, sprite.y + sprite.hojd / 2, 10, 0, 0.14, skottkostymer)
    table.insert(sprites, skott)
    bas.startaGrafik(skott, uppdateraSkott)
end

function upp(sprite)
    sprite.yfart = -2
end

function ner(sprite)
    sprite.yfart = 2
end
