# Lektion 2

## Happy bird

I denna lektion så är målet att skapa ett spel där en drake/fågel flyger igenom portar.

## Skapa happy

Först behöver vi ladda sprites för vår drake som jag kallar happy

```
sprites = {}
spelarkostymer = {
    "resources/player/frame-1.png",
    "resources/player/frame-2.png",
    "resources/player/frame-3.png",
    "resources/player/frame-4.png",
}

function love.load()
    bas.starta(bas.hanteraSignaler)
    bas.starta(bas.uppdateraGrafik)
    bas.starta(bas.repeteraAlla)
    happy = Sprite(125, 250, 0, 0, 0.14, spelarkostymer) -- Skapar en sprite på x=125, y=250, 14% av orginalstorleken
    table.insert(sprites, happy)
end

function love.update()
    bas.tick() -- Berättar för basmodulen att tid har passerat
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
```

Nu borde spelet rita en drake på svart bakgrund

## Animera happy

För att animera happy så behöver vi lägga till en rad som byter kostym i love.load() och en funktion som byter kostym. 

Lägg till en funktion som byter kostym
```
function animera(sprite)
    sprite:bytKostym()
end
```
Lägg till i love.load()
```
bas.repetera(animera, 0.15, true, happy)
```

## Få happy att dyka

