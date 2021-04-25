local bcl  = require("../Common/BooshCommonLua")

local floppyDB = "floppyDB"

function getFloppyTable()
    return bcl.getTableFile(floppyDB)
end

function setFloppyTable(tb)
    bcl.setTableFile(floppyDB, tb)
end

function addUserFloppy(floppyId, userId)
    local tb = getFloppyTable()
    tb[floppyId] = userId
    setFloppyTable(tb)
end

function getUserId(floppyId)
    local tb     = getFloppyTable()
    local userId = tb[floppyId]
    return userId
end

function getFloppyId(userId)
    local tb     = getFloppyTable()
    for k, v in pairs(tb) do 
        if v == userId then
        return k
        end
    end
    return "unknown"
end

return {addUserFloppy = addUserFloppy, getUserId = getUserId}