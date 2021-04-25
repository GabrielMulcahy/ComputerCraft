local globals = require("../Common/Globals")
local bcl     = require("../Common/BooshCommonLua")

local params = {...}


print("STARTING FLOPPY CLIENT...")

local serverId    = globals.getServerId()
local secProtocol = globals.getSecProtocol()

local diskSide, modemSide = bcl.findDiskModem()

local request

rednet.open(modemSide)

while true do
    registerFloppy()
end

function registerFloppy()
    print("Please enter your floppy disk:")
    os.pullEvent("disk")
    local floppyId = disk.getID(diskSide)
    print("Disk ID: " .. floppyId)

    print("Please enter this disk's owner's name:")
    local userId = io.read()

    local success = rednet.send(32, "registerfloppy " .. floppyId .. " " .. userId, secProtocol)

    if success then
        print("Floppy registered!")
    else
        print("Something went wrong!") 
    end
end