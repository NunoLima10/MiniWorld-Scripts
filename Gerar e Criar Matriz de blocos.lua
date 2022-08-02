--Script by Play Craft uid=869061
tamanho=5
blockId=681
StartPosition={0,7,0}

-------------------------------------
function ImprimirBlocos(matriz,Position,blockId)
    local x=Position[1]-1
    local y=Position[2]
    local z=Position[3]-1
    local matrizImprimir=matriz
    
    
for i=1, tamanho do
for j=1, tamanho do
--Chat:sendSystemMsg(("Elemento em linha="..i.." e coluna="..j.." é "..matrizImprimir[i][j]),0)
    if((matrizImprimir[i][j])==1)then
       Block:placeBlock(blockId, x+i,y,z+j,0)
       -- Chat:sendSystemMsg("Geração Iniciada em".." x= "..x.." y="..y.." z= "..z,0)
    end
end

end
    
end
-------------------------------------
function GerarMatriz()
    local matriz= {
    {0,0,0,0,0},
    {0,0,0,0,0},
    {0,0,0,0,0},
    {0,0,0,0,0},
    {0,0,0,0,0}
    
}
local numGerado=0
for i=1, tamanho do
for j=1, tamanho do
    
    
  local  numGerado=math.random(0,1)
    matriz[i][j]= numGerado
    
  
     if((i==1 or i==2 or i==3 or i==4 or i==5) and j==1) or j==tamanho then
    matriz[i][j]=1
    end
   
end

end 
return matriz
    
end
-------------------------------------

function main ()
  
    
    Chat:sendSystemMsg("Geração Iniciada em".." x= "..StartPosition[1].." y="..StartPosition[2].." z= "..StartPosition[3],0)


end
ScriptSupportEvent:registerEvent([=[Game.Start]=], main)


function Geracao()
    
  local matrizGerada=GerarMatriz()
   ImprimirBlocos(matrizGerada,StartPosition,blockId)
   StartPosition[1]=StartPosition[1]+tamanho   
    
end
ScriptSupportEvent:registerEvent([=[Game.RunTime]=],Geracao)

