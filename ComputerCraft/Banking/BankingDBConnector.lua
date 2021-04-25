local bcl  = require("../Common/BooshCommonLua")

local balanceTb= "BalanceTb"

function getBalanceTb()
    return bcl.getTableFile(balanceTb)
end

function setBalanceTable(tb)
    bcl.setTableFile(balanceTb, tb)
end

function makeDeposit(floppyId, combs)
    local tb = getBalanceTb()
    tb[floppyId] = tb[floppyId] + combs
    setFloppyTable(tb)
    return true
end

function makeWithdrawal(floppyId, combs)
    if getBalance(floppyId) < combs then
        return false
    end
    return makeDeposit(floppyId, combs*-1)
end

function getBalance(floppyId)
    local  tb      = getBalanceTb()
    local  balance = tb[floppyId]
    return balance
end

function sendMoney(senderId, recepientId, combs)
    if makeWithdrawal(senderId, combs) then 

    end
    
end

return {sendMoney = sendMoney, getBalance = getBalance}