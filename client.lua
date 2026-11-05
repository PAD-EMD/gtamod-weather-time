print("^2[WEATHER AND TIME]^0 Script chargé !")

------------------------------
-- Réglages
------------------------------

local OPEN_KEY = 'F12'   -- touche pour ouvrir le menu (change-la si elle est déjà prise)

-- Liste unique des météos : sert au menu ET à la commande /weather
local weatherList = {
    { name = 'clear',      type = 'CLEAR',      description = 'Météo claire' },
    { name = 'rain',       type = 'RAIN',       description = 'Météo pluvieuse' },
    { name = 'snow',       type = 'XMAS',       description = 'Météo enneigée' },
    { name = 'thunder',    type = 'THUNDER',    description = 'Météo orageuse' },
    { name = 'fog',        type = 'FOGGY',      description = 'Météo brumeuse' },
    { name = 'smog',       type = 'SMOG',       description = 'Météo smog' },
    { name = 'overcast',   type = 'OVERCAST',   description = 'Météo couverte' },
    { name = 'clouds',     type = 'CLOUDS',     description = 'Météo nuageuse' },
    { name = 'extrasunny', type = 'EXTRASUNNY', description = 'Météo extra-sunny' },
    { name = 'neutral',    type = 'NEUTRAL',    description = 'Météo neutre' }
}

-- Tables dérivées de la liste (on ne les écrit pas deux fois)
local weatherTypes = {}   -- nom tapé -> type du jeu (pour /weather)
local sliderValues = {}   -- valeurs du slider MenuV
local neutralIndex = 1    -- position de "neutral" dans le slider
for index, weather in ipairs(weatherList) do
    weatherTypes[weather.name] = weather.type
    sliderValues[#sliderValues + 1] = {
        label = weather.name,
        value = weather.type,
        description = weather.description
    }
    if weather.type == 'NEUTRAL' then neutralIndex = index end
end

------------------------------
-- Fonctions utilitaires
------------------------------

-- Notification au-dessus de la minimap (visible en jeu, contrairement à print)
local function notify(message)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(false, true)
end

local function applyWeather(weatherType)
    ClearOverrideWeather()
    ClearWeatherTypePersist()
    SetWeatherTypeNow(weatherType)
    SetWeatherTypeNowPersist(weatherType)
    SetWeatherTypePersist(weatherType)
    print("^2[WEATHER]^0 Météo appliquée : " .. weatherType)
end

local currentHour = GetClockHours()
local currentMinute = GetClockMinutes()

local function applyTime(hour, minute)
    NetworkOverrideClockTime(hour, minute, 0)
    print(string.format("^2[TIME]^0 Heure définie sur %02d:%02d", hour, minute))
end

------------------------------
-- MenuV
------------------------------

local menu = MenuV:CreateMenu(
    'Weather and Time',    -- titre affiché en haut du menu
    'Modify as you wish',  -- sous-titre
    'topleft',             -- position à l'écran
    0, 120, 255,           -- couleur du menu (rouge, vert, bleu)
    'size-125',            -- taille du menu
    'default',             -- texture
    'menuv',               -- dictionnaire de textures (le fichier menuv.ytd de MenuV)
    'weather_and_time',    -- namespace : un nom unique pour ton mod
    'native'               -- thème : 'native' ou 'default'
)

-- Choix de la météo
-- Pour un slider, "value" est la POSITION de départ dans la liste (1, 2, 3...), pas un texte.
local weatherSlider = menu:AddSlider({
    icon = '☀️',
    label = 'Météo',
    value = neutralIndex,
    values = sliderValues,
    saveOnUpdate = true      -- le menu retient le choix quand on le rouvre
})

-- Choix de l'heure
local hoursRange = menu:AddRange({
    icon = '⏰',
    label = 'Heure',
    min = 0,
    max = 23,
    value = currentHour,
    saveOnUpdate = true
})

-- Événements : sans eux, le menu s'affiche mais ne fait rien.
-- 'change' est appelé à chaque déplacement gauche / droite.
-- Pour un slider, newValue est la POSITION (1, 2, 3...) : on retrouve la météo dans la liste.
weatherSlider:On('change', function(item, newValue, oldValue)
    local weather = weatherList[newValue]
    if weather then
        applyWeather(weather.type)
        notify('Météo : ' .. weather.name)
    end
end)

hoursRange:On('change', function(item, newValue, oldValue)
    currentHour = newValue
    applyTime(currentHour, currentMinute)
end)

-- Ouverture du menu avec une touche (gérée par MenuV)
menu:OpenWith('KEYBOARD', OPEN_KEY)

-- Commande de secours (console F8) : weather_and_time
RegisterCommand('weather_and_time', function()
    menu:Open()
end, false)

------------------------------
-- Commandes /weather et /time
------------------------------

RegisterCommand("weather", function(source, args)
    local weather = args[1]

    if not weather then
        print("^3[WEATHER]^0 Utilisation : /weather clear")
        print("^3[WEATHER]^0 Types : clear, rain, snow, thunder, fog, smog, overcast, clouds, extrasunny, neutral")
        return
    end

    local weatherType = weatherTypes[string.lower(weather)]

    if not weatherType then
        print("^1[WEATHER]^0 Météo inconnue : " .. weather)
        return
    end

    applyWeather(weatherType)
end, false)

RegisterCommand("time", function(source, args)
    -- Aucun argument : afficher l'heure actuelle
    if not args[1] then
        print(string.format("^2[TIME]^0 Heure actuelle : %02d:%02d", GetClockHours(), GetClockMinutes()))
        return
    end

    local hour = tonumber(args[1])
    local minute = 0
    if args[2] then
        minute = tonumber(args[2])   -- nil si ce n'est pas un nombre
    end

    if not hour or not minute then
        print("^1[TIME]^0 Utilisation : time <heure> <minute>")
        print("^3Exemple :^0 time 12 30")
        return
    end

    -- Le jeu veut des entiers
    hour = math.floor(hour)
    minute = math.floor(minute)

    if hour < 0 or hour > 23 then
        print("^1[TIME]^0 L'heure doit être comprise entre 0 et 23.")
        return
    end

    if minute < 0 or minute > 59 then
        print("^1[TIME]^0 Les minutes doivent être comprises entre 0 et 59.")
        return
    end

    currentHour, currentMinute = hour, minute
    applyTime(hour, minute)
end, false)