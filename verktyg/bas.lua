bas = {}

local tickande = {}
local signaler = {}
local grafik = {}

-- Kör alla signaler som har kommit in sen senast
function bas.hanteraSignaler()
    repeat
        for signal, meddelande in pairs(signaler) do
            -- print(signaler[meddelande])
            signal(unpack(meddelande))
        end
        signaler = {}
        coroutine.yield()
    until false
end

-- Starta en coroutine
function bas.starta(objekt)
    -- params: function
    objekt = coroutine.create(objekt)
    table.insert(tickande, objekt)
end

-- Kör alla coroutines en gång
function bas.tick()
    for _, objekt in pairs(tickande) do
        coroutine.resume(objekt)
    end
end

-- Skicka en signal
function bas.skickaSignal(signal, ...)
    -- params: function, ...
    signaler[signal] = {...}
end

-- Uppdatera grafik
function bas.uppdateraGrafik()
    repeat
        for _, bild in pairs(grafik) do
            bild:uppdatera()
        end
        coroutine.yield()
    until false
end

function bas.startaGrafik(sprite)
    -- params: sprite med funktionen uppdatera
    table.insert(grafik, sprite)
end
