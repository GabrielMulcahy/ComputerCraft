local cobalt = dofile( "cobalt" )
cobalt.ui = dofile( "cobalt-ui/init.lua" )

local bcl     = require("../Common/BooshCommonLua")
local globals = require("../Common/Globals")

local params = {...}

local diskSide = params[1]
local modemSide = params[2]

local ownerId = disk.getID(diskSide)

rednet.open(modemSide)

local backPanel = cobalt.ui.new({ w = "100%", h = "100%", backColour = colours.grey })

local title = backPanel:add( "text", { text="buzzcorp portal - welcome", wrap="center", y = 2, backColour = colours.orange} )

local titleGet = backPanel:add( "text", { text="banking ", marginleft = "7%", y = 3, backColour = colours.orange} )

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

