local bcl  = require("../Common/BooshCommonLua")

local beeDB = "beeDB"


function getBeesAsTable()
    return bcl.getTableFile(beeDB)
end

function setBeesAsTable(tb)
    bcl.setTableFile(beeDB, tb)
end


function addBee(beeName, beeX, beeZ)
    local tb     = getBeesAsTable()
    local coords = {beeX, beeZ}
    tb[beeName]  = coords
    setBeesAsTable(tb)
end

function removeBee(beeName)
    local tb    = getBeesAsTable()
    tb[beeName] = nil
    setBeesAsTable(tb)
end

function getBeeCoords(beeName)
    local tb  = getBeesAsTable()
    local bee = tb[beeName]
    local x   = bee[1]
    local z   = bee[2]
    return x, z
end

return {addBee = addBee, removeBee = removeBee, getBeeCoords = getBeeCoords}

