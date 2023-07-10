--target coordinates
--x_t = 1
--y_t = 1

-- target coordinates to target table (only holds the current target coordinates)
-- in {x coord, y coord} format
--[[
tgt = {x_t, y_t}
io.write('Target Coordinates (x,y): ')
for i,v in pairs(tgt) do
    io.write(v, ' ')
end
print('\n')
--]]
-- global target table - holds all current target coordinates
tgts = {}
--table.insert(tgts,tgt)
for i = 1,6 do
    table.insert(tgts,{i,i})
    if #tgts > 8 then
        tgts = table.move(tgts,2,#tgts,1,{})
    end
end

---[[
for index, data in ipairs(tgts) do
    io.write('Target ', index,':')
    
    ---[[
    for key, value in pairs(data) do 
        io.write(' ', value)
    end
    --]]
    print('\n')
end
--]]






