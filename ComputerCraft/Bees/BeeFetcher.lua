local tc = require("../Common/TurtleCommon")
local bcl  = require("../Common/BooshCommonLua")
local globals = require("../Common/Globals")

local pY = 56
local dY = 55

local homeX = 706
local homeY = 58
local homeZ = 2777

local protocol = globals.getBeeProtocol()

rednet.open("right")

function findBankDestination(beeX, role, beeZ)

    local x
    local y
    local z

    x = beeX

    if role == "princess" then
        y = pY
    else
        y = dY
    end

    if backOrFront(beeZ) == "front" then
        z = beeZ - 1
    else
        z= beeZ + 1
    end
    
    return x, y, z
end

function backOrFront(beeZ)
    local r = beeZ % 4
    if r == 0 then
        return "front"
    else
        return "back"
    end
end

function takeBee(bof, n)

    if bof == "back" then
        tc.turnAround()
    end
    for i = 1,n,1 do
        turtle.suck(1)
    end
end

function dropBees(n)
    turtle.select(1)

    local droppedBees = 0

    while (droppedBees < n) do
        droppedBees = droppedBees + turtle.getItemCount()
        turtle.drop()
        if (turtle.getSelectedSlot() == 16) then
            print("Ran out of inventory slots to check.")
            break
        end
        turtle.select(turtle.getSelectedSlot() + 1)
    end
    turtle.select(1)
end

function retrieveBee(beeX, role, beeZ, n)
    local x, y, z = findBankDestination(beeX, role, beeZ)
    tc.goTo(tonumber(x), y, z)

    local bof = backOrFront(beeZ)
    takeBee(bof, n)

    tc.goTo(homeX, homeY, homeZ)
    dropBees(n)
    tc.turnAround()
end

while true do
    print("Waiting for request on " .. protocol .. " protocol...")
    local id, message = rednet.receive(protocol)
    print("Request " .. message .. " received from PC" .. id)
    local params = bcl.getParams(message)
    local beeX = tonumber(params["beeX"])
    local role = params["role"]
    local beeZ = tonumber(params["beeZ"])
    local n    = tonumber(params["n"])
    retrieveBee(beeX, role, beeZ, n)
    rednet.send(id, "Bee Retrieved", protocol)
end
