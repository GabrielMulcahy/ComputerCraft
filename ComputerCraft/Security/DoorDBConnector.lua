local bcl  = require("../Common/BooshCommonLua")

local doorOwnerPath = "DoorOwners"

function getPersonalDoorLvlPath(ownerId) 
    return "/doorsLvls/" .. ownerId
end

function getPersonalUserAccessPath(ownerId) 
    return "/usersLvls/" .. ownerId
end

function getDoorOwnerTable()
    return bcl.getTableFile(doorOwnerPath)
end

function setDoorOwnerTable(tb)
    bcl.setTableFile(doorOwnerPath, tb)
end

function getDoorOwner(doorId)
    local tb = getDoorOwnerTable()
    return tb[doorId]
end

function setDoorOwner(ownerId, doorId)
    local tb = getDoorOwnerTable()
    tb[doorId] = ownerId
    setDoorOwnerTable(tb)
    return true
end



function getDoorLvlTable(ownerId)
    local path = getPersonalDoorLvlPath(ownerId)
    return bcl.getTableFile(path)
end  

function setDoorLvlTable(ownerId, tb)
    local path = getPersonalDoorLvlPath(ownerId)
    bcl.setTableFile(path, tb)
    return true
end


function getUserLvlTable(ownerId)
    local path = getPersonalUserAccessPath(ownerId)
    return bcl.getTableFile(path)
end  

function setUserLvlTable(ownerId, tb)
    local path = getPersonalUserAccessPath(ownerId)
    bcl.setTableFile(path, tb)
    return true
end


function setDoorAccessLevel(doorId, level)
    local ownerId = getDoorOwner(doorId)
    local tb   = getDoorLvlTable(ownerId)
    tb[doorId] = level
    setDoorLvlTable(tb)
    return true
end

function getDoorAccessLevel(doorId)
    local ownerId = getDoorOwner(doorId)
    local tb      = getDoorLvlTable(ownerId)
    local level   = tb[doorId]
    return level
end


function setUserAccessLevel(ownerId, userId, level)
    local tb      = getUserLvlTable(ownerId)
    tb[userId]    = level
    setUserLvlTable(ownerId, tb)
    return true
end

function getUserAccessLevel(ownerId, userId)
    local tb      = getUserLvlTable(ownerId)
    local level   = tb[userId]
    return level
end


function checkUserAtDoor(userId, doorId)
    local ownerId = getDoorOwner(doorId)
    if userId == ownerId then
        return true
    end
    return getUserAccessLevel(ownerId, userId) >= getDoorAccessLevel(ownerId, doorId)
end



return {setDoorAccessLevel = setDoorAccessLevel,
        getDoorAccessLevel = getDoorAccessLevel,
        setUserAccessLevel = setUserAccessLevel,
        getUserAccessLevel = getUserAccessLevel,
        checkUserAtDoor    = checkUserAtDoor,
        getDoorOwner       = getDoorOwner,
        setDoorOwner       = setDoorOwner
    }