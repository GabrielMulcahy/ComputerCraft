local bdbc = require("BeeDBConnector")
local bcl  = require("../Common/BooshCommonLua")
local globals = require("../Common/Globals")

local params = {...}
local side   = params[1]

local protocol = globals.getBeeProtocol()

rednet.open(side)

while true do
    local id, message = rednet.receive(protocol)
    print("Request " .. message .. " received from PC" .. id)
    
    local params = bcl.getParams(message)
    local action = params["action"]
    local bee    = params["bee"]
    local response

    if action == "get" then
        beeX, beeZ = bdbc.getBeeCoords(bee)
        local resParams = {}
        resParams["beeX"] = beeX
        resParams["beeZ"] = beeZ
        bcl.netSend(id, resParams, protocol)
    elseif action == "add" then
        beeX = params["beeX"]
        beeZ = params["beeZ"]
        bdbc.addBee(bee, beeX, beeZ)
        response = "Added " .. bee .. " bee from the database at X=" .. beeX .. " Z=" .. beeZ
    elseif action == "remove" then
        bdbc.removeBee(bee)
        response = "Removed " .. bee .. " bee from the database."
    end

    rednet.send(id, response, protocol)
    
end

rednet.close(side)