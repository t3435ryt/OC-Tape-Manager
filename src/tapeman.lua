
local arguments_as_a_table = {...}

component = require("component")

local tape1 = component.proxy("ed6f617e-fc8e-405b-877e-eafbe97fa116")
local tape2 = component.proxy("a49e98dc-dcb2-49fd-84d3-5927573b4191")
local transposer = component.proxy("6208f201-e283-4c8e-8ad5-df470c327d8e")

local function getStoredTapes()
    return transposer.getAllStacks(1).getAll()
end

for index, value in ipairs(getStoredTapes()) do
    print("Table name:"+tostring(value))
    for index1, value1 in ipairs(value) do
        print("Value:"+tostring(value1))
    end
end