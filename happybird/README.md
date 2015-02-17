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

För att spelet ska vara intressant så behöver vi hinder som happy måste passera. Börja med att skapa en tabell med grafik för hindren. 

Först måste vi skapa två stycken torn som vi kommer att klona i love.load()
```
golvtorn = Sprite(850, 100, -5, 0, 0.14, tornkostymer)
taktorn = Sprite(940, -100, -5, 0, -0.14, tornkostymer)
bas.repetera(skapaTorn, 1.5, true) -- Skapa torn med 1.5 sekunders mellanrum
```

För att klona tornen och få dom att röra sig

```
hinder = {} --En tom tabell för alla hinder som finns på banan
-- Alla hinder är torn och kan ha olika färger
tornkostymer = {
    "resources/towers/Green-tower.png",
    "resources/towers/Icy-tower.png",
    "resources/towers/Pink-tower.png",
    "resources/towers/Yellow-tower.png",
}

-- Kopierar golvtorn och taktorn från love.load och får dom att uppdatera sig hela tiden
function skapaTorn()
    golvtornkopia = golvtorn:kopiera()
    taktornkopia = taktorn:kopiera()
    golvtornkopia.y = 300
    taktornkopia.y = 100
    table.insert(hinder, golvtornkopia)
    table.insert(hinder, taktornkopia)
    bas.startaGrafik(golvtornkopia, uppdateraTorn)
    bas.startaGrafik(taktornkopia, uppdateraTorn)
end

function uppdateraTorn(torn)
    torn.x = torn.x + torn.xfart --torn.xfart är -5
end
```
För att rita tornen så behöver vi ändra på love.draw(). Lägg till dessa fyra rader för att rita alla torn
```
-- För varje torn i tabellen hinder så anropa funktionen rita
for _, torn in pairs(hinder) do
    torn:rita()
end
```

Om man kör spelet nu så kommer det likadana torn på samma plats hela tiden

## Slumpa färg och plats på tornen

För att få tornen att vara olika höga varje gång som de klonas så kan vi använda ett slumptal. Ändra på funktionen skapa torn så att den ser ut som nedan.
```
function skapaTorn()
    slump = math.random(100, 500) -- Slumpa ett tal mellan 100 och 500
    golvtornkopia = golvtorn:kopiera()
    taktornkopia = taktorn:kopiera()
    golvtornkopia.y = slump + 100 -- Lägg till 100 för att tornet ska hamna lägre ner
    taktornkopia.y = slump - 100 -- Ta bort 100 för att tornet ska hamna högre upp
    -- Ändra slumptalet så att det är mellan 0 och 3 och lägg till 1, tornen har 4 olika kostymer
    taktornkopia.kostym = slump % table.getn(taktornkopia.kostymer) + 1
    -- Ge golvtornet samma kostym som taktornet
    golvtornkopia.kostym = taktornkopia.kostym
    table.insert(hinder, golvtornkopia) --Lägg till tornen bland hinder
    table.insert(hinder, taktornkopia)
    bas.startaGrafik(golvtornkopia, uppdateraTorn) -- Få tornen att uppdatera sig
    bas.startaGrafik(taktornkopia, uppdateraTorn)
end
```

Nu bör tornen inte vara likadana hela tiden. Men happy kan inte krocka med dom

## Få happy att krocka med tornen

Först skapar vi en funktion som vi kallar reset. Syftet är att återställa spelet till startpunkten.

```
function reset()
    sprites = {}
    hinder = {}
    table.insert(sprites, happy)
    happy.y = 250
    happy.vinkel = 0
end
```

För att upptäcka när happy krockar med torn så kan man lägga till kod i love.update()

```
for _, torn in pairs(hinder) do
    if happy:krock(torn) then
        reset()
    end
end
```
Med denna kod så kommer spelet återställas till startpunkten varje gång happy krockar med ett torn. 

## Lägg till en bakgrund

## Räkna poäng

## Rita poäng

## Game over
