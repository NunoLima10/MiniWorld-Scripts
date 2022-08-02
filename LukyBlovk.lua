--Script by Play Craft

itens_list= {230,241,236,239} --adiciona o id de itens que deseja
id_lukyblock=100  -- adiciona o id do bloco usado como lukyblock

--id encontrados em  IDLibrary
function lukyblock(e)
    
    local block_id=e.blockid
    local pos_x=e.x
    local pos_y=e.y
    local pos_z=e.z
    
    id_gerado=math.random(1,#itens_list)
    
    if block_id==id_lukyblock then  World:spawnItem(pos_x,pos_y,pos_z,itens_list[id_gerado],1)end 
end 
ScriptSupportEvent:registerEvent([=[Block.Dig.End]=],lukyblock)
