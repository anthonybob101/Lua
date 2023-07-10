N = 3
M = 3

roll = math.pi/3
pitch = 0
bearing = 0

-- create the matrix
mt = {}          
for i=1,N do
    -- create a new row
    mt[i] = {}
    for j=1,M do
        mt[i][j] = 0
    end
end

--roll rotation matrix
mt_r = {}
for i=1,3 do
    mt_r[i] = {}
    for j=1,3 do
        mt_r[i][j] = 0
    end
end
mt_r[1] = {1, 0, 0}
mt_r[2] = {0, math.cos(roll), -math.sin(roll)}
mt_r[3] = {0, math.sin(roll), math.cos(roll)}

for i=1,3 do
    for j=1,3 do
        mt_r[i][j] = tonumber(string.format("%0.5f",mt_r[i][j]))
    end
end

---[[
for index, data in ipairs(mt_r) do
    for k,v in pairs(data) do
        io.write(v,' ')
    end
    io.write('\n')
end
print('\n')
--]]

--pitch rotation matrix
mt_p = {}
for i=1,3 do
    mt_p[i] = {}
    for j=1,3 do
        mt_p[i][j] = 0
    end
end
mt_p[1] = {math.cos(pitch), 0, math.sin(pitch)}
mt_p[2] = {0, 1, 0}
mt_p[3] = {-math.sin(pitch), 0, math.cos(pitch)}

for i=1,3 do
    for j=1,3 do
        mt_p[i][j] = tonumber(string.format("%0.5f",mt_p[i][j]))
    end
end

---[[
for index, data in ipairs(mt_p) do
    for k,v in pairs(data) do
        io.write(v,' ')
    end
    io.write('\n')
end
print('\n')
--]]

--bearing rotation matrix
mt_b = {}
for i=1,3 do
    mt_b[i] = {}
    for j=1,3 do
        mt_b[i][j] = 0
    end
end

mt_b[1] = {math.cos(bearing), -math.sin(bearing), 0}
mt_b[2] = {math.sin(bearing), math.cos(bearing), 0}
mt_b[3] = {0, 0, 1}

for i=1,3 do
    for j=1,3 do
        mt_b[i][j] = tonumber(string.format("%0.5f",mt_b[i][j]))
    end
end


--[[
for index, data in ipairs(mt_b) do
    for k,v in pairs(data) do
        io.write(v,' ')
    end
    io.write('\n')
end
print('\n')
--]]

mt_pos = {}
for i=1,3 do
    mt_pos[i] = {}
    for j=1,1 do
        mt_pos[i][j] = 0
    end
end
--[[
for index, data in ipairs(mt_pos) do
    for k,v in pairs(data) do
        io.write(v,' ')
    end
    io.write('\n')
end
print('\n')
--]]

--[mt_r] * [mt_p]
A = mt_r
B = mt_p
C = {}          
for i=1,3 do
    -- create a new row
    C[i] = {}
    for j=1,3 do
        C[i][j] = 0
    end
end

for i = 1,3 do 
    for j = 1,3 do 
        for k = 1,3 do
            C[i][j] = C[i][j] + A[i][k] * B[k][j]
        end
    end
end
mt_rp = C
---[[
for index, data in ipairs(mt_rp) do
    for k,v in pairs(data) do
        io.write(v,' ')
    end
    io.write('\n')
end
print('\n')
--]]

--([mt_r] * [mt_p]) * [mt_b]
A = mt_rp
B = mt_b
C = {}          
for i=1,3 do
    -- create a new row
    C[i] = {}
    for j=1,3 do
        C[i][j] = 0
    end
end

for i = 1,3 do 
    for j = 1,3 do 
        for k = 1,3 do
            C[i][j] = C[i][j] + A[i][k] * B[k][j]
        end
    end
end
mt_rpb = C
--[[
for index, data in ipairs(mt_rpb) do
    for k,v in pairs(data) do
        io.write(v,' ')
    end
    io.write('\n')
end
print('\n')
--]]

--([mt_r] * [mt_p]) * [mt_b] * [mt_pos]
A = mt_rpb
B = mt_pos
C = {}          
for i=1,3 do
    -- create a new row
    C[i] = {}
    for j=1,3 do
        C[i][j] = 0
    end
end

for i = 1,3 do 
    for j = 1,1 do 
        for k = 1,3 do
            C[i][j] = C[i][j] + A[i][k] * B[k][j]
        end
    end
end
mt_posf = C
--[[
for index, data in ipairs(mt_posf) do
    for k,v in pairs(data) do
        io.write(v,' ')
    end
    io.write('\n')
end
print('\n')
--]]



