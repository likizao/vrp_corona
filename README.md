# vrp_corona
#### Sistema simples de Corona Vírus.
Não tem muito oque falar, é um sistema simples e feito rapidamente numa madrugada aleatória de quarentena.
1. A mascará `101` protege a pessoa de se contaminar com o vírus.
2. A pessoa contaminada, fica vomitando e tossindo.
3. Comando `/curar` pro paramédico curar a pessoa. Não tive nenhuma idéia legal de animação pra colocar, então, ele tá totalmente sem sentido, mas creio que esteja funcional.
4. Tá feito pra vRPex, mas pode ser facilmente convertido.
5. Comando `/setcorona [id]` pra setar o paciente zero, quem executar o comando precisa ter a permissão `admin.permissao`. 
# Dicas de Instalação:
A resource é literalmente, baixar e startar, porém, caso queiram:

* Eu sugiro, adicionar o item `mascaracorona`, como a grande maioria não usa mais o menu da vRP, não tenho a mínima idéia do sistema de inventário que vocês usam, então, criem o item `mascaracorona` e igual aos outros itens, ao usar, execute algo semelhante a isso:
```
local user_id = vRP.getUserId(player)
if user_id then
  vida = vRPclient.getHealth(player)
  if vida > 101 then
    if vRP.tryGetInventoryItem(user_id, "mascaracorona", 1) then
      vRPclient._playAnim(player, true, {{"misscommon@van_put_on_masks", "put_on_mask_ps"}}, false)
      TriggerClientEvent("setMask", player)
    else
      TriggerClientEvent("Notify", player, "negado", "Mascara não encontrada na mochila.")
    end
  else
    TriggerClientEvent("Notify", player, "aviso", "Você não pode utilizar nocauteado.")
  end
end
```
O item `mascaracorona` impedirá as pessoas de serem contaminadas. 

* Caso queiram adicionar em alguma outra resource uma forma de curar a doença, há um evento server-side chamado `vrp_corona:Curar`.

#### https://discord.gg/QcD67Pt
