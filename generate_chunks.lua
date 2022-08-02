
function get_block(x, y, z)

    local frequency = 0.1
    local amplitude = 10
    local x_offset = math.sin(frequency * x) * amplitude
    local z_offset = math.sin(frequency * z) * amplitude
    --local z_offset = math.sqrt(z) * amplitude
    --local x_offset = math.sqrt(x) * amplitude
    
    local sufacey = 20 + x_offset + z_offset
    
    if y<sufacey then
        return 104
    elseif y<17 then
        return 3
    else
        return -1
    end

    
end

function generate_chunks(x_offset, z_offset)
    for y = 10, 50 do
        for x = x_offset * 16, 16 + x_offset * 16 do
            for z = z_offset * 16, 16 + z_offset * 16 do
                local block = get_block(x,y,z)
                if block > 0 then
                    Block:placeBlock(block, x, y, z, 0)
                end
            end
        end
    end
end

function generate(event)
    if event.content == "/build" then
        for x_offset = 0, 5 do
            for z_offset = 0, 5 do
            generate_chunks(x_offset, z_offset)
            threadpool:wait(0.005)
            end
        end
    Chat:sendSystemMsg("Construido", 0)
    end    
    
end
ScriptSupportEvent:registerEvent([=[Player.NewInputContent]=], generate)
