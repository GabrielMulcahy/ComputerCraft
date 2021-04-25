function split (inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function getParams(request)
        local params = {}

        for _, v in pairs(split(request, " ")) do
                local spl = split(v, "=")
                local param = spl[1]
                local value = spl[2]
                params[param] = value
        end

        return params
end

function netSend(serverId, params, protocol)
        local message = ""
        for k, v in pairs(params) do 
                message = message .. k .. "=" .. v .. " "
        end

        rednet.send(serverId, message, protocol)
end

function getTableFile(dbFile)
        local tb
    
        if fs.exists(dbFile) then
            local file = fs.open(dbFile, "r")
            local data = file.readAll()
            file.close()
            tb         = textutils.unserialise(data)
        else
            tb = {}
        end
    
        return tb
end

function setTableFile(dbFile, tb)
        local file = fs.open(dbFile, "w")
        local data = textutils.serialise(tb)
        file.write(data)
        file.close()
end

return {split         = split,
        getTableFile  = getTableFile,
        setTableFile  = setTableFile,
        getParams     = getParams,
        netSend       = netSend}
