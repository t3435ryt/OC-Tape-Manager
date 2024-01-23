
local arguments_as_a_table = {...}

component = require("component")
event = require("event")

local tape = component.proxy("c34adf35-ce27-416e-aecc-f9605a58211f")
local transposer = component.proxy("6208f201-e283-4c8e-8ad5-df470c327d8e")
local keyboard = component.getPrimary("keyboard")

--Transposer sides
--  Crate: 1
-- Tape: 2

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

local function key_pressed(keyboardAddress, char, code, playerName)
    print(char)
end

event.listen("key_down", key_pressed)

while true do
    while transposer.getAllStacks(1)[activeSlot]["name"] ~= "computronics:tape" do
        print("Checking slot "..tostring(activeSlot))
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

-- for index, value in pairs(transposer.getAllStacks(1).getAll()) do
--     print("Slot:"..tostring(index))
--     for key, value1 in pairs(value) do
--         print(tostring(key).." : "..tostring(value1))
--     end
--     if index > 9 then
--         break
--     end
-- end