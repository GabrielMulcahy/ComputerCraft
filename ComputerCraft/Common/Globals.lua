local serverId = 41
local librarianId = 57
local secProtocol = "secure"
local beeProtocol = "buzz"
local bankProtocol = "vault"

function getServerId()
    return serverId
end

function getSecProtocol()
    return secProtocol
end

function getBeeProtocol()
    return beeProtocol
end

function getLibrarianId()
    return librarianId
end

function getBankProtocol()
    return bankProtocol
end

return {getServerId     = getServerId,
        getSecProtocol  = getSecProtocol,
        getBeeProtocol  = getBeeProtocol,
        getLibrarianId  = getLibrarianId,
        getBankProtocol = getBankProtocol}