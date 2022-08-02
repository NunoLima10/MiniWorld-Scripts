


mochila={  }
result,jogador=Player:getHostUin()
shift_on=false
bau={on=false,x=0,y=0,z=0}
itens_invalidos={11061,12001,12002,12003,12004,12005,12050,12056,12281,12283,12284,12288,12291
                ,12201,12202,12203,12204,12205,12206,12207,12208,12209,12210,12211,12212,12213,
                12214,12215,12221, 12222,12223,12224,12231,12232,12233,12234,12235,12241,12242,
                12243,12244,12245,12253,12275,12822,11580,11581,11592,11582,11583,11584}
            

--Funções
function shift_Status(e)
    local player=e.eventobjid
    
    if  not player==jogador then return end
    
    local key=e.vkey
    --Chat:sendChat(key,0)
    if key == 'SHIFT' then  
       if shift_on then shift_on=false  else shift_on=true  end
    end
end
ScriptSupportEvent:registerEvent([=[Player.InputKeyDown]=],shift_Status)
ScriptSupportEvent:registerEvent([=[Player.InputKeyUp]=],shift_Status)

function lista_itens(e)
   
   local player=e.eventobjid
    if not e.content=='lista itens' then return end
    Player:playMusic(player,10960,100,1,false)
    Chat:sendSystemMsg("#GLista de itens",player)
    local j=0
   
    for i=1,#mochila do
        
        local ret, item_name=Item:getItemName(mochila[i][1])
        
        Chat:sendSystemMsg("#W"..item_name.."="..mochila[i][2],0)
        j=j+1
    end  
    if j==0 then Chat:sendSystemMsg("#RMochila esta vazia",player) end
end
ScriptSupportEvent:registerEvent([=[Player.NewInputContent]=],lista_itens)

function encontrar_item(itemid)
     for i=1,#mochila do
         if mochila[i][1]==itemid then return i end
     end    
     return 0
end

function encontrar_itens_invalidos()
    local lista_invalidos={}
    
    for i=1,#mochila do
        local itemid = mochila[i][1]
        
        for j=1,#itens_invalidos do
            if itemid== itens_invalidos[j] then 
            lista_invalidos[#lista_invalidos+1]=itens_invalidos[j] end
        end    
    
    end
    
    return lista_invalidos
end

function add_Item(e)
    
    local item_id=e.itemid
    local item_num=e.itemnum
    local item_pos=encontrar_item(item_id)
    
    local x=e.x
    local y=e.y
    local z=e.z
    
    if x==bau.x and y==bau.y+1 and z==bau.z and bau.on==true then
    
      if item_pos ==0 then
          mochila[#mochila+1]={item_id,item_num} 
     else
         mochila[item_pos][2]= mochila[item_pos][2]+item_num 
        end
    end
end
ScriptSupportEvent:registerEvent([=[Backpack.ItemPutIn]=],add_Item)


function remover_item(e)
    
    local item_id=e.itemid
    local item_num=e.itemnum
    local item_pos=encontrar_item(item_id)
    
    local x=e.x
    local y=e.y
    local z=e.z
    
    if x==bau.x and y==bau.y+1 and z==bau.z and bau.on==true then
    
        if mochila[item_pos][2]-item_num ==0 then 
        table.remove(mochila,item_pos)
        else
          mochila[item_pos][2]= mochila[item_pos][2]-item_num 
     end 
    end
end 
ScriptSupportEvent:registerEvent([=[Backpack.ItemTakeOut]=],remover_item)

function bau_config(e)
    local player=e.eventobjid
    local x=e.x
    local y=e.y
    local z=e.z
     
    if shift_on and not bau.on then
        
        bau.on=true
        bau.x=x
        bau.y=y
        bau.z=z 
        
        
        Player:playMusic(player,10800,100,1,false)
        
        WorldContainer:addStorageBox(bau.x,bau.y+1,bau.z)
        local result = Player:openBoxByPos(player, bau.x, bau.y+1, bau.z)
    
        for i=1,#mochila do
            local  item_id=mochila[i][1]
            local item_num= mochila[i][2]
            local result,relNum=WorldContainer:addStorageItem(bau.x, bau.y+1, bau.z,item_id,item_num)
        end  
    
    elseif shift_on and bau.on then
        local lista_invalidos=encontrar_itens_invalidos()
        
        if #lista_invalidos==0 then
            WorldContainer:clearStorageBox(bau.x,bau.y+1,bau.z)
            WorldContainer:removeStorageBox(bau.x,bau.y+1,bau.z)
            bau.on=false
            Player:playMusic(player,10800,100,1,false)
        else
            Chat:sendSystemMsg("#WLista de itens #Rivalidos#W detetados", player) 
            for i=1 ,#lista_invalidos do
                local ret, item_name=Item:getItemName(lista_invalidos[i])
                 Chat:sendSystemMsg("#R"..item_name, player) 
                 Player:playMusic(player,10960,100,1,false)
            end
     
    end
   end
end
ScriptSupportEvent:registerEvent([=[Player.ClickBlock]=],bau_config)

function bau_destruido(e)
    local x=e.x
    local y=e.y
    local z=e.z
    
    if bau.x==x and bau.y+1==y and bau.z==z and bau.on then
        bau.on= false
        for i=1,#mochila do
            
        table.remove(mochila,i)
        end
    end
    
end

ScriptSupportEvent:registerEvent([=[Block.DestroyBy]=],bau_destruido)












