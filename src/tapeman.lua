local arguments_as_a_table = {...}

local component = require("component")

local running = true

local tape = component.proxy("c34adf35-ce27-416e-aecc-f9605a58211f")
local transposer = component.proxy("6208f201-e283-4c8e-8ad5-df470c327d8e")
local keyboard = component.getPrimary("keyboard")

local function getOpenSlot()
    for slot, itemData in ipairs(transposer.getAllStacks(1).getAll()) do
        if itemData["name"] == "minecraft:air" then
            return slot
        end
    end
    error("No open storage slots in tape storage container", 0)
end


if tape.isReady() then
    tape.seek(-math.huge)
    transposer.transferItem(2,1,1,1,getOpenSlot())
end

local activeSlot = 1

while running do
    while transposer.getAllStacks(1)[activeSlot]["name"] ~= "computronics:tape" do
        if activeSlot == 72 then
            activeSlot = 1
        else
            activeSlot = activeSlot + 1
        end
        os.sleep(0.01)
    end
    print("Pulling tape from slot "..tostring(activeSlot))
    transposer.transferItem(1,2,1,activeSlot,1)
    tape.seek(-math.huge)
    tape.play()
    print("Now playing: "..tostring(tape.getLabel()))
    while not tape.isEnd() do
        os.sleep(0.1)
    end
    tape.seek(-math.huge)
    transposer.transferItem(2,1,1,1,activeSlot)
    activeSlot = activeSlot + 1
    if activeSlot > transposer.getInventorySize(1) then
        print("Ran past last storage slot")
        activeSlot = 1
    end
end