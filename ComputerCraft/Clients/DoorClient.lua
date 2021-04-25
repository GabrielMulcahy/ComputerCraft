local globals = require("../Common/Globals")
local bcl     = require("../Common/BooshCommonLua")

local params = {...}


print("STARTING DOOR CLIENT...")

local serverId    = globals.getServerId()
local secProtocol = globals.getSecProtocol()

local diskSide  = params[1]
local modemSide = params[2]
local doorSide  = params[3]

local doorId = os.getComputerID()

rednet.open(modemSide)

rednet.send(serverId, "action=getdoorowner " .. doorId, secProtocol)
local doorOwner = rednet.receive(secProtocol)

rednet.send(serverId, "action=getdoorlvl " .. "doorId=" .. doorId, secProtocol)
local doorLvl = rednet.receive(secProtocol)

if doorLvl == nil then
    print("Door not registered!\n
    Please insert identifying floppy disk:")
    os.pullEvent("disk")
    local floppyId = disk.getID(diskSide)
    if 
end

while true do 
    os.pullEvent("disk")
    local floppyId = disk.getID(diskSide)
end

function 