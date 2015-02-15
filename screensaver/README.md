# Lektion 1

## En animerad skärmsläckare

I denna lektion så kommer vi skapa ett animerat mynt som studsar på skärmkanten. Öppna filen main.lua och följ instruktionerna som följer.

Först behöver vi två tabeller (listor i lua kallas tabeller), en för sprites och en för alla bilder som myntet kan ha. Vi kommer använda dessa tabeller senare. Det är alltså två variabler skapas med koden nedanför.

```
local sprites = {} -- Skapar en tom tabell
local kostymer = {
    "resources/a1.png",
    "resources/a2.png",
    "resources/a3.png",
    "resources/a4.png",
    "resources/a5.png",
    "resources/a6.png",
    "resources/a7.png",
    "resources/a8.png"
}
-- Skapar en tabell {[1]->"resources/a1.png" [2]->"resources/a2.png"
```

När ett spel laddas så kör Löve 2d funktionen load en gång

```
function love.load()

end
```

Under tiden ett spel kör så anropas functionen update hela tiden

```
function love.update()

end
```

Varje gång Löve 2d vill rita spelet så kommer draw att anropas. Det går inte att rita saker utanför draw funktionen

```
function love.draw()

end
```

Det är alltid smidigt att kunna stänga ett spel enkelt när man utvecklar. För att göra så att ESC avslutar spelet så lägg till denna kod längst ner i main.lua

```
-- Denna funktion läser tangentbordet
function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
```

Vi kommer börja med att lägga in några rader kod för att köra saker i bakgrunden. Detta kan göras med trådar eller med coroutines i lua. I dessa lektioner används coroutines. Ändra på load funktionen så att den ser ut såhär; Lägg även till funktionerna uppdatera och animera

```
-- Ladda spelet
function love.load()
    bas.starta(bas.uppdateraGrafik) -- Startar en coroutine för att köra funktioner kopplade till en sprite
    bas.starta(bas.repeteraAlla) -- Startar en coroutine för att repetera en funktion med ett visst intervall
    mynt = Sprite(200, 200, 4, 4, 0.2, kostymer) -- Skapar en sprite med alla kostymer
    table.insert(sprites, mynt) -- Stoppar myntet i tabellen av sprites som ska ritas på skärmen
    bas.startaGrafik(mynt, uppdatera) -- kopplar en funktion som heter uppdatera (som inte finns) till mynt spriten
    bas.repetera(animera, 0.15, true) -- Funktionen animera anropas för alltid med 0.15 sekunders mellanrum
end

function uppdatera()

end

function animera()

end
```

Nu har vi alltså laddat en sprite och lite hjälpmedel för att kunna animera och schemalägga funktioner. Nu ska vi bara se till så att den sprite vi har definerat ritas och att vi kör våra bakgrundsfunktioner varje gång spelet uppdateras

```
-- Denna funktion repeteras för alltid
function love.update()
    bas.tick()
end

-- Denna funktion repeteras för alltid
function love.draw()
    for _, sprite in pairs(sprites) do
        sprite:rita()
    end
end
```

Testa att starta spelet nu. Som du kommer att märka så är myntet inte animerat och det står stilla

## Uppdatera och animera

```
-- Anropar en funktion för att byta bild i tabellen med animationer i myntspriten
function animera()
    mynt:bytKostym()
end

-- Får myntet att studsa när myntet nuddar kanten av skärmen
function uppdatera(self)
    if self.x + self.bredd > 800 or self.x < 0 then
        self.xfart = self.xfart * -1 -- Gånger minus ändrar från negativt till positivt
    end
    if self.y + self.hojd > 600 or self.y < 0 then
        self.yfart = self.yfart * -1 -- Gånger minus ändrar från positivt till negativt
    end
    self.x = self.x + self.xfart
    self.y = self.y + self.yfart
end
```

