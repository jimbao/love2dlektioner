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

Ett sätt att få happy att dyka är att flytta i en riktning. När en sprite skapas är vinkeln noll. Så en negativ vinkel kommer att få happy att titta uppåt och en positiv vinkel får happy att titta nedåt. Om y är en funktion av vinkeln så kommer happy flytta sig uppåt med en negativ vinkel och tvärt om.

Lägg till 

Denna kod får det att se ut som att happy dyker.
```
function uppdateraHappy(happy)
    -- Öka y fart med vinkeln gånger 15
    happy.yfart = happy.vinkel * 15
    if happy.vinkel < 1.0 then -- Bestäm en max vinkel
        happy.vinkel = happy.vinkel + 0.05
    end
    -- Stoppa happy från att ramla ur bild (valfritt)
    if (happy.y + happy.hojd < 600 or happy.yfart < 0) and (happy.y > 0 or happy.yfart > 0) then
        happy.y = happy.y + happy.yfart
    end
end
```
Lägg till denna rad i love.load() för att köra uppdateraHappy varje gång love.update() kör
```
bas.startaGrafik(happy, uppdateraHappy)
```

## Få happy att flyga

Eftersom happy nu faller beroende av vinkeln så kan vi koppla en knapp till att återställa vinkeln. Då kommer happy att röra sig uppåt om vinkeln sätts till att vara negativ

Skapa funktionen flyg
```
function flyg(sprite)
    sprite.vinkel = -0.55
end
```
Lägg sedan till tre rader i love.keypressed(key)
```
if key == " " then
    bas.skickaSignal(flyg, happy)
end
```
Nu borde happy flyga varje gång man trycker på mellanslag

## Skapa torn
