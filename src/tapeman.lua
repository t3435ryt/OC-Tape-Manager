
local arguments_as_a_table = {...}

component = require("component")

local tape = component.proxy("c34adf35-ce27-416e-aecc-f9605a58211f")
local transposer = component.proxy("6208f201-e283-4c8e-8ad5-df470c327d8e")

local function getStoredTapes()
    return 
end


--Transposer sides
--  Crate: 1
-- Tape 1: 3
-- Tape 2: 2

local function getActiveTape1()
    return transposer.getAllStacks(3).getAll()
end

local function getActiveTape2()
    return transposer.getAllStacks(2).getAll()
end

local function getOpenSlot()
    for slot, itemData in ipairs(transposer.getAllStacks(1).getAll()) do
        if itemData["name"] == "minecraft:air" then
            return tonumber(slot)
        end
    end
    error("No open storage slots in tape storage container", 0)
end

if tape.isReady() then
    tape.seek(-math.huge)
    transposer.transferItem(3,1,1,1,getOpenSlot())
end

local activeSlot = 1

while true do
    transposer.transferItem(1,3,1,activeSlot,1)
    tape.seek(-math.huge)
    tape.play()
    while not tape.isEnd() do
        os.sleep(0.1)
    end
    tape.seek(-math.huge)
    transposer.transferItem(3,1,1,1,activeSlot)
    activeSlot = activeSlot+1
    if activeSlot > transposer.getInventorySize(1) then
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