# Letion 1

## En animerad skärmsläckare

I denna letion så kommer vi skapa ett animerat mynt som studsar på skärmkanten

Först behöver vi två tabeller, en för sprites och en för alla bilder som myntet kan ha

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

