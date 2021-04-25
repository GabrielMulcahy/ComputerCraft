local cobalt = dofile( "cobalt" )
cobalt.ui = dofile( "cobalt-ui/init.lua" )

local bcl     = require("../Common/BooshCommonLua")
local globals = require("../Common/Globals")

local params = {...}

local modemSide = "back"

rednet.open(modemSide)

local backPanel = cobalt.ui.new({ w = "100%", h = "100%", backColour = colours.grey })

--local getPanel = backPanel:add("panel", {w = "40%", marginleft="5%", h = "90%", margintop = "5%", backColour = colours.blue})

local title = backPanel:add( "text", { text="the buzzcorp bee bank ", wrap="center", y = 2, backColour = colours.orange} )

local titleGet = backPanel:add( "text", { text="get bees ", marginleft = "10%", y = 3, backColour = colours.orange} )
local titleGet = backPanel:add( "text", { text="update bees ", marginleft = "75%", y = 3, backColour = colours.orange} )

--LEFT PANEL--

local getResult = backPanel:add( "text", { text="[result]", w = "40%", marginleft="5%", y = 16 } )

local getBeeInput = backPanel:add( "input", {
	w = "40%",
	marginleft="5%",
	y = 5,
	backPassiveColour = colours.lightGrey,
	forePassiveColour = colours.grey,
	backActiveColour = colours.lightGrey,
	placeholder = " bee variety",
	placeholderColour = colours.grey,
})

local getRoleInput = backPanel:add( "input", {
	w = "40%",
	marginleft="5%",
	y = 7,
	backPassiveColour = colours.lightGrey,
	forePassiveColour = colours.grey,
	backActiveColour = colours.lightGrey,
	placeholder = " drone/princess",
	placeholderColour = colours.grey,
})

local getNumberInput = backPanel:add( "input", {
	w = "40%",
	marginleft="5%",
	y = 9,
	backPassiveColour = colours.lightGrey,
	forePassiveColour = colours.grey,
	backActiveColour = colours.lightGrey,
	placeholder = " amount",
	placeholderColour = colours.grey,
})

local checkBeeButton = backPanel:add("button", {w = "18%", marginleft="5%", text="Check", y = 11})
checkBeeButton.onclick = function()
    local params = {}
    params["action"] = "get"
    params["bee"]    = getBeeInput.text

    bcl.netSend(globals.getServerId(), params, globals.getBeeProtocol())

    local beeX, beeZ = receiveBeeCoords()

    getResult.text = "X:" .. beeX .. " Z:" .. beeZ
end

local getBeeButton = backPanel:add("button", {w = "18%", marginleft="27%", text="Get", y = 11})
getBeeButton.onclick = function()
    local params = {}
    params["action"] = "get"
    params["bee"]    = getBeeInput.text

	local role = getRoleInput.text
	local n    = getNumberInput.text

    bcl.netSend(globals.getServerId(), params, globals.getBeeProtocol())

	local beeX, beeZ = receiveBeeCoords()
	
	local turtParams = {}
	turtParams["beeX"] = beeX
	turtParams["role"] = role
	turtParams["beeZ"] = beeZ
	turtParams["n"]    = n

	bcl.netSend(globals.getLibrarianId(), turtParams, globals.getBeeProtocol())

	getResult.text = "Librarian is finding your bee..." 
	local libId, libMsg = rednet.receive(globals.getBeeProtocol())
	getResult.text = libMsg 
end



function receiveBeeCoords()
    local id, message  = rednet.receive(globals.getBeeProtocol())
    local answerParams = bcl.getParams(message)
    local beeX         = answerParams["beeX"]
    local beeZ         = answerParams["beeZ"]
    return beeX, beeZ
end

--RIGHT PANEL--

local setResult = backPanel:add( "text", { text="[response]", w = "40%", marginleft="55%", y = 14 } )

local setBeeInput = backPanel:add( "input", {
	w = "40%",
	marginleft="55%",
	y = 5,
	backPassiveColour = colours.lightGrey,
	forePassiveColour = colours.grey,
	backActiveColour = colours.lightGrey,
	placeholder = " bee variety",
	placeholderColour = colours.grey,
})

local setXInput = backPanel:add( "input", {
	w = "18%",
	marginleft="55%",
	y = 7,
	backPassiveColour = colours.lightGrey,
	forePassiveColour = colours.grey,
	backActiveColour = colours.lightGrey,
	placeholder = " x",
	placeholderColour = colours.grey,
})

local setZInput = backPanel:add( "input", {
	w = "18%",
	marginleft="77%",
	y = 7,
	backPassiveColour = colours.lightGrey,
	forePassiveColour = colours.grey,
	backActiveColour = colours.lightGrey,
	placeholder = " z",
	placeholderColour = colours.grey,
})

local setBeeButton = backPanel:add("button", {w = "18%", marginleft="55%", text="Update", y = 9})
setBeeButton.onclick = function()
    local params = {}
    params["action"] = "add"
    params["bee"]    = setBeeInput.text
    params["beeX"]   = setXInput.text
    params["beeZ"]   = setZInput.text

    bcl.netSend(globals.getServerId(), params, globals.getBeeProtocol())

    local id, message = rednet.receive(globals.getBeeProtocol())
    setResult.text = message

end

local removeBeeButton = backPanel:add("button", {w = "18%", marginleft="77%", text="Remove", y = 9})
removeBeeButton.onclick = function()
    local params = {}
    params["action"] = "remove"
    params["bee"]    = setBeeInput.text

    bcl.netSend(globals.getServerId(), params, globals.getBeeProtocol())

    local id, message = rednet.receive(globals.getBeeProtocol())
    setResult.text = message

end



function cobalt.draw()
    cobalt.ui.draw()
end
  
function cobalt.update( dt )
    cobalt.ui.update( dt )
end

function cobalt.mousepressed( x, y, button )
    cobalt.ui.mousepressed( x, y, button )
end

function cobalt.mousereleased( x, y, button )
    cobalt.ui.mousereleased( x, y, button )
end

function cobalt.keypressed( keycode, key )
    cobalt.ui.keypressed( keycode, key )
end

function cobalt.keyreleased( keycode, key )
    cobalt.ui.keyreleased( keycode, key )
end

function cobalt.textinput( t )
    cobalt.ui.textinput( t )
end

function getBalance()
end

cobalt.initLoop()

