--- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--- If you have any issues, please report them here: https://github.com/nameouschangey/STORMWORKS_VSCodeExtension/issues - by Nameous Changey


--[====[ HOTKEYS ]====]
-- Press F6 to simulate this file
-- Press F7 to build the project, copy the output from /_build/out/ into the game to use
-- Remember to set your Author name etc. in the settings: CTRL+COMMA


--[====[ EDITABLE SIMULATOR CONFIG - *automatically removed from the F7 build output ]====]
---@section __LB_SIMULATOR_ONLY__
do
    ---@type Simulator -- Set properties and screen sizes here - will run once when the script is loaded
    simulator = simulator
    simulator:setScreen(1, "2x2")
    simulator:setProperty("ExampleNumberProperty", 123)


    -- Runs every tick just before onTick; allows you to simulate the inputs changing
    ---@param simulator Simulator Use simulator:<function>() to set inputs etc.
    ---@param ticks     number Number of ticks since simulator started
    function onLBSimulatorTick(simulator, ticks)
        simulator:setInputBool(1, simulator:getIsClicked(1))
        simulator:setInputNumber(1,90)
        simulator:setInputNumber(2,-0.5)
        simulator:setInputNumber(3,10)
        
        simulator:setInputBool(2, simulator:getIsClicked(2))
        simulator:setInputNumber(5,90)
        simulator:setInputNumber(6,-0.25)
        simulator:setInputNumber(7,10)
        
        simulator:setInputBool(3, simulator:getIsClicked(3))
        simulator:setInputNumber(9,90)
        simulator:setInputNumber(10,0)
        simulator:setInputNumber(11,10)

        simulator:setInputBool(4, simulator:getIsClicked(4))
        simulator:setInputNumber(13,90)
        simulator:setInputNumber(14,0.25)
        simulator:setInputNumber(15,10)

        simulator:setInputBool(5, simulator:getIsClicked(5))
        simulator:setInputNumber(17,90)
        simulator:setInputNumber(18,0.5)
        simulator:setInputNumber(19,10)

        simulator:setInputNumber(4,0) --represents the orientation of the radar in turns 
        simulator:setInputNumber(8,0) --represents vehicle x coordinate
        simulator:setInputNumber(12,0) --represents vehicle y coordinate
        simulator:setInputNumber(16,0) --represents vehicle z coordinate
        simulator:setInputNumber(20,0) --represents radians from map east
        simulator:setInputNumber(24,0) --represents radians from pointing horizontial, using a forward-facing tilt sensor
        simulator:setInputNumber(28,0) --represents radians from zero roll, using a right-facing tilt sensor

        
        
        
        --[[

        -- touchscreen defaults
        local screenConnection = simulator:getTouchScreen(1)
        simulator:setInputBool(1, screenConnection.isTouched)
        simulator:setInputNumber(1, screenConnection.width)
        simulator:setInputNumber(2, screenConnection.height)
        simulator:setInputNumber(3, screenConnection.touchX)
        simulator:setInputNumber(4, screenConnection.touchY)

        -- NEW! button/slider options from the UI
        simulator:setInputBool(31, simulator:getIsClicked(1))       -- if button 1 is clicked, provide an ON pulse for input.getBool(31)
        simulator:setInputNumber(31, simulator:getSlider(1))        -- set input 31 to the value of slider 1

        simulator:setInputBool(32, simulator:getIsToggled(2))       -- make button 2 a toggle, for input.getBool(32)
        simulator:setInputNumber(32, simulator:getSlider(2) * 50)   -- set input 32 to the value from slider 2 * 50
        
        --]]
        


    end;
end
---@endsection


--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!

ticks = 0
w = 64
h = 64
a = 0        --current radar anglular position
spd = 0.001  -- radar angular speed (turns per tick, multiply by 60 to get turns per second)
maxdistance = 100
tgts = {}
function onTick()
    ticks = ticks + 1
    
    -- a = input.getNumber(4)
    -- Booleans - turn true when a target is detected, up to 8 targets detected at a time.
    t1_bo = input.getBool(1)
    t2_bo = input.getBool(2)
    t3_bo = input.getBool(3)
    t4_bo = input.getBool(4)
    t5_bo = input.getBool(5)
    t6_bo = input.getBool(6)
    t7_bo = input.getBool(7)
    t8_bo = input.getBool(8) 

    -- Converting compass and tilt sensor inputs to radians
    -- Vehicle positional properties:
    --  veh_x - represents the vehicle's x coordinate, where X goes left and right (east/west), with increasing values towards the right (east).
    --  veh_y - represents the vehicle's y coordibnate, where Y goes up and down (north/south), with increasing values towards the top (north).
    --  veh_z - represents the vehicle's z coordinate or height relative to sea level, where Z increases above the sea level.
    --  veh_b - represents the vehicle bearing from east in radians
    --  veh_p - represents the vehicle pitch from pointing horizontial in radians
    --  veh_r - represents the vehicle roll from zero roll in radians
    veh_x = input.getNumber(8)
    veh_y = input.getNumber(12)
    veh_z = input.getNumber(16)

    veh_b_turns = input.getNumber(20)
    veh_b = math.fmod((veh_b_turns+1.25)*math.pi*2, math.pi*2)

    veh_p_turns = input.getNumber(24)
    veh_p = veh_p_turns * 2 * math.pi

    veh_r_turns = input.getNumber(28)
    veh_r = veh_r_turns * 2 * math.pi




    


    -- Numbers - give numeric information about the detected targets.
    --  t(x)_d - represents the distance to the (x) radar target.
    --  t(x)_b - represents the bearing to the (x) radar target. (in turns - multiply by 2pi for radians)
    --  t(x)_h - represents the elevation to the (x) radar target. (in turns - multiply by 2pi for radians)
    --[[
    t1_d = input.getNumber(1)
    t1_b = input.getNumber(2)
    t1_h = input.getNumber(3)
    
    t2_d = input.getNumber(5)
    t2_b = input.getNumber(6)
    t2_h = input.getNumber(7)

    t3_d = input.getNumber(9)
    t3_b = input.getNumber(10)
    t3_h = input.getNumber(11)

    t4_d = input.getNumber(13)
    t4_b = input.getNumber(14)
    t4_h = input.getNumber(15)

    t5_d = input.getNumber(17)
    t5_b = input.getNumber(18)
    t6_h = input.getNumber(20)

    t6_d = input.getNumber(22)
    t6_b = input.getNumber(23)
    t6_h = input.getNumber(24)

    t7_d = input.getNumber(25)
    t7_b = input.getNumber(26)
    t7_h = input.getNumber(27)

    t8_d = input.getNumber(29)
    t8_b = input.getNumber(30)
    t8_h = input.getNumber(31)
    --]]

    --store the booleans as a table to get pos data 
    t_bool = {t1_bo,t2_bo,t3_bo,t4_bo,t5_bo,t6_bo,t7_bo,t8_bo}
    t_pos = {0,0,0,0,0,0,0,0}
    for k, v in pairs(t_bool) do
        if t_bool[k] then
            t_d = input.getNumber(k*4-3)
            t_b = input.getNumber(k*4-2)
            t_h = input.getNumber(k*4-1)
            --storing individual positional data into table
            tgt_pos = {t_d, t_b, t_h}
            
            -- storing positional data as tuples in a table
            table.remove(t_pos, k)
            -- if a target is detected, then add raw target pos to table
            table.insert(t_pos, k, tgt_pos)
        end
    end

    -- Converting raw pos to x, y, z coordinates for every index (target) in t_pos
    for i, d in ipairs(t_pos) do 
        if t_bool[i] then
            length = d[1]
            bearing = d[2] * 2 * math.pi --converting from -0.5/0.5 turns to -pi/pi radians
            height = d[3] * 2 * math.pi  --converting from -0.5/0.5 turns to -pi/pi radians

            lengthPixel = (length/maxdistance) * 32

            x_t = w/2 + lengthPixel * math.cos(math.pi/2 + bearing)
            y_t = w/2 + lengthPixel * math.sin(math.pi/2 + bearing)
            --[[
            z_t = math.sin(height)
            y_t = math.sin(-bearing) * length
            x_t = math.sqrt(length^2 - y_t ^ 2 - z_t ^ 2)

            --Creating rotation matrices
                mt = {}          -- create the matrix
                for i=1,N do
                    mt[i] = {}     -- create a new row
                    for j=1,M do
                        mt[i][j] = 0
                    end
                end
            --]]

            table.remove(tgts, i)
            -- if a target is detected, then add converted target pos to table
            table.insert(tgts,i,{x_t,y_t})
        end
    end

    --old code---------------------------------------------------------------------------------

    distance = input.getNumber(1)
    distancePixel = (distance/maxdistance) * 32

    a = a + spd

    if a >= 0.5 then
        a = -0.5 -- + a
    end

    -- radarA = ((a + 0.5) * 360)  * (math.pi/180) -- converting from turns to radians
     radarA = a * 2 * math.pi + math.pi

    r = math.min(w, h)/2
    x1 = w / 2 + 32 * math.cos(math.pi/2 + radarA)  -- x coordinate of radar line
    y1 = h / 2 + 32 * math.sin(math.pi/2 + radarA)  -- y coordinate of radar line

    --if target then     

    if radarA == 0 then
        for i in pairs(tgts) do 
            tgts[i] = nil
            tgt = nil
        end
    end


    -- Output Control
    output.setNumber(1,radarA)
    output.setBool(1,t1_bo)
    output.setBool(2,t2_bo)
    output.setBool(3,t3_bo)
    output.setBool(4,t4_bo)
    output.setBool(5,t5_bo)
    output.setBool(6,t6_bo)
    output.setBool(7,t7_bo)
    output.setBool(8,t8_bo)
    --output.setNumber(3,)
end

function onDraw()
    w = screen.getWidth()
    h = screen.getHeight()
    screen.setColor(0,255,0)
    screen.drawCircle(w / 2, h / 2, 32)
    screen.drawLine(w / 2, h / 2, x1, y1)

    ---[[
    for i, d in ipairs(tgts) do
        print('Target', i,':')        
        x_d = d[1]
        y_d = d[2]
        print(x_d, ' ', y_d)

        screen.setColor(255,0,0)
        screen.drawCircleF(x_d,y_d,0.5)
    end
    --]]
end


