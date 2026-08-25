-- SLYDMTA Login Panel - Client Script

local screenWidth, screenHeight = guiGetScreenSize()

-- Panel méretei és pozíciója (középre igazítva)
local panelWidth, panelHeight = 420, 480
local panelX = (screenWidth - panelWidth) / 2
local panelY = (screenHeight - panelHeight) / 2

local isPanelVisible = true

-- Képek betöltése
local bgImage = "hatter.png"
local logoImage = "logo.png"

-- UI Elemek (Input mezők és gombok létrehozása)
local editUser = guiCreateEdit(panelX + 40, panelY + 160, panelWidth - 80, 40, "", false)
local editPass = guiCreateEdit(panelX + 40, panelY + 220, panelWidth - 80, 40, "", false)
guiEditSetMasked(editPass, true) -- Jelszó csillagozása

-- Bejelentkezés gomb
local btnLogin = guiCreateButton(panelX + 40, panelY + 280, panelWidth - 80, 40, "Bejelentkezés", false)

-- Regisztráció gomb (A "VAGY" sáv alatt)
local btnRegister = guiCreateButton(panelX + 40, panelY + 390, panelWidth - 80, 40, "REGISZTRÁCIÓ", false)

-- Kezdetben rejtjük a natív elemeket, amíg a panel aktív
function setPanelVisible(state)
    isPanelVisible = state
    guiSetVisible(editUser, state)
    guiSetVisible(editPass, state)
    guiSetVisible(btnLogin, state)
    guiSetVisible(btnRegister, state)
    showCursor(state)
end

-- Render esemény a háttérhez, dobozhoz, logóhoz és a szövegekhez
function renderLoginPanel()
    if not isPanelVisible then return end

    -- 1. Háttérkép kirajzolása teljes képernyőre
    dxDrawImage(0, 0, screenWidth, screenHeight, bgImage, 0, 0, 0, tocolor(255, 255, 255, 255))

    -- 2. Fő panel háttér (sötét, áttetsző doboz)
    dxDrawRectangle(panelX, panelY, panelWidth, panelHeight, tocolor(15, 15, 15, 230), true)
    
    -- Panel keret
    dxDrawRectangle(panelX, panelY, panelWidth, 3, tocolor(220, 50, 30, 255), true) -- Pirosas felső díszcsík

    -- 3. Logó felül (a panel tetején, centézve)
    local logoSize = 70
    local logoX = panelX + (panelWidth - logoSize) / 2
    local logoY = panelY - 45
    dxDrawImage(logoX, logoY, logoSize, logoSize, logoImage, 0, 0, 0, tocolor(255, 255, 255, 255), true)

    -- 4. Címek és szövegek
    dxDrawText("Bejelentkezés", panelX, panelY + 40, panelX + panelWidth, panelY + 70, tocolor(255, 255, 255, 255), 1.2, "pricedown", "center", "center", false, false, true)
    dxDrawText("Add meg az adataid, melyekkel InGame regisztráltál.", panelX, panelY + 75, panelX + panelWidth, panelY + 95, tocolor(170, 170, 170, 255), 1.0, "default", "center", "center", false, false, true)

    -- Mezők feletti kis feliratok
    dxDrawText("Felhasználónév", panelX + 40, panelY + 138, 0, 0, tocolor(200, 200, 200, 255), 1.0, "default", "left", "bottom", false, false, true)
    dxDrawText("Jelszó", panelX + 40, panelY + 198, 0, 0, tocolor(200, 200, 200, 255), 1.0, "default", "left", "bottom", false, false, true)

    -- 5. "VAGY" elválasztó vonal középen
    local lineY = panelY + 355
    dxDrawLine(panelX + 40, lineY, panelX + panelWidth - 40, lineY, tocolor(50, 50, 50, 255), 1, true)
    dxDrawText("VAGY", panelX, lineY - 10, panelX + panelWidth, lineY + 10, tocolor(150, 150, 150, 255), 1.0, "default", "center", "center", false, false, true)
end
addEventHandler("onClientRender", root, renderLoginPanel)

-- Gombnyomások eseményei
addEventHandler("onClientGUIClick", root, function()
    if source == btnLogin then
        local user = guiGetText(editUser)
        local pass = guiGetText(editPass)
        
        if user == "" or pass == "" then
            outputChatBox("Hiba: Töltsd ki az összes mezőt!", 255, 50, 50)
            return
        end
        
        -- Itt küldheted tovább szerverre a bejelentkezési adatokat:
        -- triggerServerEvent("slydmta:loginAttempt", localPlayer, user, pass)
        outputChatBox("Bejelentkezés folyamatban...", 50, 255, 50)
        
    elseif source == btnRegister then
        outputChatBox("Regisztrációs ablak megnyitása...", 50, 150, 255)
        -- Ide jöhet a regisztrációs felület logika
    end
end)

-- Induláskor megjelenítjük a panelt
addEventHandler("onClientResourceStart", resourceRoot, function()
    setPanelVisible(true)
end)