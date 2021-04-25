local params = {...}
local side = params[1]

local hours

while true do
    print("Run excavator for how many hours?")
    hours = io.read()
    if hours == "quit"
        print("Exiting...")
        break
    end
    redstone.setOutput(side, true)
    os.sleep(hours * 60 * 60)
    redstone.setOutput(side, false)
end