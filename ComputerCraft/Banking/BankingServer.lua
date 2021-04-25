local bcl  = require("../Common/BooshCommonLua")
local globals = require("../Common/Globals")
local bdbc = require("BankingDBConnector")

local params = {...}
local side   = params[1]

local protocol = globals.getBankProtocol()

rednet.open(side)

while true do
    local id, message = rednet.receive(protocol)
    print("Request " .. message .. " received from PC" .. id)

    local params = bcl.getParams(message)
    local action = params["action"]
    local response

    if action == "balance" then
        local floppyId = params["floppyId"]
        response = bdbc.getBalance(floppId)

    elseif action == "send" then
        local floppyId = params["floppyId"]
        local recipientId = 
        response = fdbc.checkUserAtDoor(floppyId)

    end

    rednet.send(id, response, protocol)
end


rednet.close(side)