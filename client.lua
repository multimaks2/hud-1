DGS = exports.dgs
local x,y = guiGetScreenSize()
local NotifeData = {}
ProgressBarShaders = {}
NotifeData.x, NotifeData.y = x,y
NotifeData.resW, NotifeData.resH = guiGetScreenSize()
NotifeData.x2, NotifeData.y2 =  guiGetScreenSize()
Font = dxCreateFont("file/Gilroy-Medium.ttf", 25)
Font_fps = dxCreateFont("file/fps.ttf", 15)
intervalWanted = 70

-------------Глушит-Звуки-----------------
setAmbientSoundEnabled( "general", false )
setAmbientSoundEnabled( "gunfire", false )
setPlayerHudComponentVisible("ammo", false)
setPlayerHudComponentVisible("health", false)
setPlayerHudComponentVisible("armour", false)
setPlayerHudComponentVisible("breath", false)
setPlayerHudComponentVisible("clock", false)
setPlayerHudComponentVisible("money", false)
setPlayerHudComponentVisible("weapon", false)
setPlayerHudComponentVisible("vehicle_name", false)
setPlayerHudComponentVisible("area_name", false)
setPlayerHudComponentVisible("radio", false)
setPlayerHudComponentVisible("wanted", false)
setPlayerHudComponentVisible("radar", false)
------------------------------------------

-- function ProgressBar()
--     DGS = exports.dgs
--     pbRound = DGS:dgsCreateProgressBar(x-170,-35,200,200,false)
--     DGS:dgsSetProperty(pbRound,"bgColor",tocolor(255,255,255, 255))
--     DGS:dgsSetProperty(pbRound,"indicatorColor",tocolor(225, 0, 0,255))

--     DGS:dgsProgressBarSetProgress(pbRound, 15)
--     DGS:dgsProgressBarSetStyle(pbRound,"ring-round",{
--         isReverse = false,
--         rotation = 90,
--         antiAliased = 0.005,
--         radius = 0.54,
--         thickness = 5})
--     DGS:dgsProgressBarSetStyleProperty(pbRound,"thickness",50)
-- end

function Progress()
DGS = exports.dgs
local pbRoundOptional = DGS:dgsCreateProgressBar(x-455,-15,200,200,false)
    DGS:dgsSetProperty(pbRoundOptional,"bgColor",tocolor(255,255,255, 20))
    DGS:dgsSetProperty(pbRoundOptional,"indicatorColor",tocolor(225, 0, 0,215))
DGS:dgsProgressBarSetProgress(pbRoundOptional, 50)
DGS:dgsProgressBarSetStyle(pbRoundOptional,"ring-round",{
	isReverse = true,
	rotation = 270,
	antiAliased = 1.005,
	radius = 0.25,
    thickness = 0.027})
    DGS:dgsProgressBarSetProgress(pbRoundOptional, 55)
end



function convertNumber(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
        if (k==0) then
            break
        end
    end
    return formatted
end



function DxDrawHudConcept()
    local time = getRealTime()
    local dia = ("%02d"):format(time.monthday)
    local mes = ("%02d"):format(time.month+1)
    local ano = ("%02d"):format(time.year + 1900)

    local hours = time.hour
    local minutes = time.minute
    local seconds = time.second
    if minutes <= 9 then
        minutes = "0"..minutes
    end
    if (seconds < 10) then
        seconds = "0"..seconds
    end

    local x = x
    local y = 0

    local oxigenio = math.floor (getPedOxygenLevel( getLocalPlayer() ))
    local wantedLvl = getPlayerWantedLevel ( )
    local health = getElementHealth(localPlayer)
    local armor = getPedArmor(localPlayer)
    local money = getPlayerMoney()
    local level = getElementData(localPlayer,"lvl") or 1
    local xp = getElementData(localPlayer,"exp") or 0

    dxDrawRectangleCr(x-435,y+10,425,155,5,tocolor(0,0,0,75),false,false,false,true)

    dxDrawRectangleCr( x-255,70, 220, 10, 5, tocolor( 25, 25, 25, 154 ),false,false,false,true)
    dxDrawRectangleCr( x-255,70, armor*2.2, 10, 5, tocolor(50, 195, 255,154 ),false,false,false,true)

    dxDrawRectangleCr( x-255,110, 220, 10, 5, tocolor( 25, 25, 25, 154 ),false,false,false,true)
    dxDrawRectangleCr( x-255,110, health*2.2, 10, 6, tocolor( 255, 0, 0, 175 ),false,false,false,true)


    dxDrawRectangleCr( x-255,90, 220, 10, 5, tocolor( 25, 25, 25, 154 ),false,false,false,true)

    if ( oxigenio < 1000 or isElementInWater( getLocalPlayer() )) then
        dxDrawRectangleCr(x-255,90,oxigenio/10*2.2,10,5, tocolor(255, 255, 255,200),false,false,false,true)
    end
    ------------------------------------------------------------------------------------
    dxDrawText(hours..":"..minutes,x,y,x-150,80,tocolor(255,255,255,200),0.85,Font,"right","center",false,false,false,true)
    dxDrawText(""..convertNumber(money).." ₽ |", x-0, 5,x-55.5,280, tocolor(255,255,255,255),0.7,Font, "right", "center",false,false,false,true)





    dxDrawImage ( x-415, 175, 26, 24, 'images/wanted_a.png', angle, 0, -120 ,tocolor(25,25,25,154) )
    dxDrawImage ( x-415+intervalWanted, 175, 26, 24, 'images/wanted_a.png', angle, 0, -120 ,tocolor(25,25,25,154) )
    dxDrawImage ( x-415+intervalWanted*2, 175, 26, 24, 'images/wanted_a.png', angle, 0, -120 ,tocolor(25,25,25,154) )
    dxDrawImage ( x-415+intervalWanted*3, 175, 26, 24, 'images/wanted_a.png', angle, 0, -120 ,tocolor(25,25,25,154) )
    dxDrawImage ( x-415+intervalWanted*4, 175, 26, 24, 'images/wanted_a.png', angle, 0, -120 ,tocolor(25,25,25,154) )
    dxDrawImage ( x-415+intervalWanted*5, 175, 26, 24, 'images/wanted_a.png', angle, 0, -120 ,tocolor(25,25,25,154) )

    if wantedLvl < 1 then
        local wanted1 = 1
    else
        dxDrawImage ( x-415, 175, 26, 24, 'images/wanted.png', angle, 0, -120 ,tocolor(255,237,0,255))
    end
    if wantedLvl < 2 then
        local wanted2 = 2
    else
        dxDrawImage ( x-415+intervalWanted, 175, 26, 24, 'images/wanted.png', angle, 0, -120 ,tocolor(255,237,0,255))
    end
    if wantedLvl < 3 then
        local wanted3 = 3
    else
        dxDrawImage ( x-415+intervalWanted*2, 175, 26, 24, 'images/wanted.png', angle, 0, -120 ,tocolor(255,237,0,255))
    end
    if wantedLvl < 4 then
        local wanted4 = 4
    else
        dxDrawImage ( x-415+intervalWanted*3, 175, 26, 24, 'images/wanted.png', angle, 0, -120 ,tocolor(255,237,0,255))
    end
    if wantedLvl < 5 then
        local wanted5 = 5
    else
        dxDrawImage ( x-415+intervalWanted*4, 175, 26, 24, 'images/wanted.png', angle, 0, -120 ,tocolor(255,237,0,255))
    end
    if wantedLvl < 6 then
        local wanted6 = 6
    else
        dxDrawImage ( x-415+intervalWanted*5, 175, 26, 24, 'images/wanted.png', angle, 0, -120 ,tocolor(255,237,0,255))
    end

end






function round(num)
    if ( num >= 0 ) then return math.floor( num + .5 )
    else return math.ceil( num - .5 ) end
end

function dxDrawCorner( x, y, r, color, corner, postGUI )
    local corner = corner or 1
    local start = corner % 2 == 0 and 0 or -r
    local stop = corner % 2 == 0 and r or 0
    local m = corner > 2 and -1 or 1
    local h = ( corner == 1 or corner == 3 ) and -1 or 1
    for yoff = start, stop do
        local xoff = math.sqrt( r * r - yoff * yoff ) * m
        dxDrawRectangle( x - xoff, y + yoff, xoff, h, color, postGUI )
    end
end

function dxDrawRectangleCr( posX, posY, width, height, radius, color, postGUI )
    local posX, posY, width, height = round( posX ), round( posY ), round( width ), round( height )
    local radius = radius and math.min( radius, math.min( width, height ) / 2 )  or 12

    dxDrawRectangle( posX, posY + radius, width, height - radius * 2, color, postGUI )
    dxDrawRectangle( posX + radius, posY, width - 2 * radius, radius, color, postGUI )
    dxDrawRectangle( posX + radius, posY + height - radius, width - 2 * radius, radius, color, postGUI )

    dxDrawCorner( posX + radius, posY + radius, radius, color, 1, postGUI )
    dxDrawCorner( posX + radius, posY + height - radius, radius, color, 2, postGUI )
    dxDrawCorner( posX + width - radius, posY + radius, radius, color, 3, postGUI )
    dxDrawCorner( posX + width - radius, posY + height - radius, radius, color, 4, postGUI )
end




---------------------------------------------------------------
---------------------------------------------------------------
addEvent('startEventom',true)
function startEventom()
    addEventHandler("onClientPreRender", root, DxDrawHudConcept)
end
addEventHandler('startEventom',root,startEventom)

addEvent('stopEventom',true)
function stopEventom()
	        if isElement(pbRound) then
            destroyElement ( pbRound )
        end
    removeEventHandler("onClientPreRender", root, DxDrawHudConcept)
end
addEventHandler('stopEventom',root,stopEventom)

---------------------------------------------------------------
---------------------------------------------------------------

addEventHandler("onClientResourceStart",getRootElement(), DxDrawHudConcept)
local root = getRootElement()
local player = getLocalPlayer()
local counter = 0
local starttick
local currenttick
addEventHandler("onClientPreRender",root,
    function()
        if not starttick then
            starttick = getTickCount()
        end
        counter = counter + 1
        currenttick = getTickCount()
        if currenttick - starttick >= 1000 then
            setElementData(player,"FPS",counter)
            counter = 0
            starttick = false
        end
    end
)

function fppss()
    local FPS = getElementData(getLocalPlayer(),"FPS") or 0
    dxDrawText(FPS-1,0,0,25,25,tocolor(0,0,0,200),1.05,"default","center","center",false,false,false,true)
    dxDrawText(FPS-1,0,0,25,25,tocolor(255,255,255,150),1,"default","center","center",false,false,false,true)
end

isVisible = not isVisible
function fpss()
    if isVisible then
        addEventHandler("onClientPreRender", root, fppss)
    else
        removeEventHandler("onClientPreRender", root, fppss)
    end
    isVisible = not isVisible
end
addCommandHandler("showfps", fpss)








------------------------------------------------------------------
function toggleHud()
    if isVisible then
        addEventHandler("onClientPreRender", root, DxDrawHudConcept)
    else
        removeEventHandler("onClientPreRender", root, DxDrawHudConcept)
    end
    isVisible = not isVisible
end
addCommandHandler("showhud", toggleHud)


----Play render----
Progress()
startEventom()

-- ProgressBar()
-------------------





function fromcolor(int,useMath,relative)
    local a,r,g,b
    if useMath then
        b = int[3]%256
        g = int[2]%256
        r = int[1]%256
        a = int[4]%256
    end
    if relative then
        a,r,g,b = a/255,r/255,g/255,b/255
    end
    return r,g,b,a
end

