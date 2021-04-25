local bcl  = require("../Common/BooshCommonLua")
local fdbc = require("FloppyDBConnector")
local ddbc = require("DoorDBConnector")

local params = {...}
local side   = params[1]

local protocol = "secure"

rednet.open(side)

while true do
    local id, message = rednet.receive(protocol)
    print("Request " .. message .. " received from PC" .. id)

    local params = bcl.getParams(message)
    local action = params["action"]
    local response

    if action == "register" then
        local floppyId = params["floppyId"]
        local userId   = params["userId"]

        fdbc.addUserFloppy(floppyId, userId)
        response = true

    elseif action == "identify" then
        local floppyId = params["floppyId"]
        response = fdbc.checkUserAtDoor(floppyId)

    elseif action == "checkdoor" then
        local floppyId = params["floppyId"]
        local doorId   = params["doorId"]
        response = ddbc.checkUserAtDoor(floppyId, doorId)

    elseif action == "getdoorlvl" then
        local doorId = params["doorId"]
        response = ddbc.getDoorAccessLevel(doorId)

    elseif action == "setdoorlvl" then
        local doorId   = params["doorId"]
        local level    = params["level"]
        response = ddbc.setDoorAccessLevel(floppyId, doorId)

    elseif action == "getdoorowner" then
        local doorId   = params["doorId"]
        response = ddbc.getDoorOwner(doorId)

    elseif action == "setdoorowner" then
        local ownerId  = params["ownerId"]
        local doorId   = params["doorId"]
        response = ddbc.setDoorOwner(floppyId, doorId)

    elseif action == "getaccesslvl" then
        local ownerId  = params["ownerId"]
        local userId   = params["userId"]
        response = ddbc.getUserAccessLevel(ownerId, userId)

    elseif action == "setaccesslvl" then
        local ownerId  = params["ownerId"]
        local userId   = params["userId"]
        local level    = params["level"]
        response = ddbc.setUserAccessLevel(ownerId, userId, level)
    end

    rednet.send(id, response, protocol)
end


rednet.close(side)