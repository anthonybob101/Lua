local values = {1,45,1,44,123,2354,321,745,1231}

-- Printing values table
io.write('Values: ')
for i,v in pairs(values) do
    io.write(v, ' ')
end
print('\n')

--Old way to get a subset of a list
local subset = {}
for i = 3,7 do --for loop going from index 3 to 7
    table.insert(subset, values[i])
end

-- Printing subset table
io.write('For Loop   - Subset: ')
for i,v in pairs(subset) do
    io.write(v, ' ')
end
print('\n')


--Alternative method, using table.move
local subset = table.move(values,3,7,1,{})

-- Printing subset table
io.write('table.move - Subset: ')
for i,v in pairs(subset) do
    io.write(v, ' ')
end
print('\n')



local a = {1,2,3,4,5,6,7}
for i,v in pairs(a) do
    io.write(i, ' ', v, '\t')
end
print('\n')

local b = table.move(a,2,#a,1,{})
for i,v in pairs(b) do
    io.write(i, ' ', v, '\t')
end
print('\n')
