
local arguments_as_a_table = {...}

component = require("component")

local tape1 = component.proxy("ed6f617e-fc8e-405b-877e-eafbe97fa116")
local tape2 = component.proxy("a49e98dc-dcb2-49fd-84d3-5927573b4191")
local transposer = component.proxy("6208f201-e283-4c8e-8ad5-df470c327d8e")

local function getStoredTapes()
    return transposer.getAllStacks(1).getAll()
end

local function getActiveTape1()
    return transposer.getAllStacks(3).getAll()
end

local function getActiveTape2()
    return transposer.getAllStacks(2).getAll()
end

print(tape1.isEnd)






-- for index, value in pairs(getStoredTapes()) do
--     print("Slot:"..tostring(index))
--     for key, value1 in pairs(value) do
--         print(tostring(key).." : "..tostring(value1))
--     end
--     if index > 9 then
--         break
--     end
-- end