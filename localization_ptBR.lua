-- ********************************************************
-- **           Mizus RaidTracker - ptBR Local           **
-- **             <http://cosmocanyon.de>                **
-- ********************************************************
--
-- This localization is written by:
--  boux2
--
-- Note: 
--  MRT requires a correct localization of bossyells for working
--

-- Check for addon table
if (not MizusRaidTracker) then return; end
local _L = MizusRaidTracker._L

----------------------
--  Are you local?  --
----------------------
if GetLocale() ~= "ptBR" then return end


-----------------
--  Bossyells  --
-----------------
-- Yells/Ulduar
	_L.yells[529]["Algalon"] = "Já vi mundos banhados pelas chamas dos Criadores, seus habitantes desaparecendo sem sequer um gemido. Sistemas planetários inteiros nascem e são destruídos no tempo que leva para seus corações mortais para baterem uma vez. No entanto, durante todo o tempo, meu coração desprovido de emoção ... de empatia. Eu. Sinto. Nada. Um milhão de vidas desperdiçadas. Todos eles tinham dentro de si a sua tenacidade? Todos eles amavam a vida como você?"
	_L.yells[529]["Freya"] = "Seu domínio sobre mim se dissipa. Eu posso ver claramente mais uma vez. Obrigado heróis."
	_L.yells[529]["Hodir"] = "Eu... Eu estou livre do seu alcance... finalmente."
	_L.yells[529]["Mimiron"] = "Parece que cometi um ligeiro erro de cálculo. Eu permiti que minha mente fosse corrompida pelo demônio na prisão, anulando minha diretiva primária. Todos os sistemas parecem estar funcionais agora. Livre."
	_L.yells[529]["Thorim"] = "Baixem as armas! Eu me rendo!"

-- Yells/Trials_of_the_Crusader
	_L.yells[543]["Faction Champions"] = "Uma vitória superficial e trágica. Somos mais fracos como um todo pelas perdas sofridas hoje. Quem, a não ser o Lich King, poderia se beneficiar dessa tolice? Grandes guerreiros perderam suas vidas. E para quê? A verdadeira ameaça está à frente - o Lich Rei nos aguarda na morte."

-- Yells/Icecrown_Citadel
	_L.yells[604]["Dreamwalker"] = [=[
EU ESTOU RENOVADO! Ysera conceda-me o favor de colocar essas criaturas sujas para descansar!]=]
	_L.yells[604]["Icecrown Gunship Battle Alliance"] = "Não digam que eu não avisei, canalhas! Avante, irmãos e irmãs!"
	_L.yells[604]["Icecrown Gunship Battle Horde"] = "A Aliança vacila. Avante ao Lich Rei!"

-- Yells/Ruby_Sanctum
	_L.yells[609]["Halion"] = "Aprecie esta vitória, mortais, pois será a última. Este mundo vai queimar com o retorno do mestre!"

-- Yells/Throne_of_the_Four_Winds
	_L.yells[773]["Conclave Of Wind"] = "O Conclave do Vento se dissipou. Sua conduta e determinação honrosas lhe valeram o direito de enfrentar-me em batalha, mortais. Aguardo seu ataque na minha plataforma! Venham!"

-- Yells/Firelands
	_L.yells[800]["Ragnaros"] = "Cedo demais! ... Vocês vieram cedo demais ..."

-- Yells/Terrace_of_Endless_Spring
	_L.yells[886]["Lei Shi"] = "Eu... ah... oh! Eu fiz ...? Eu estava...? Estava... tão... turvo..."
	_L.yells[886]["Tsulong"] = "Eu agradeço, estranhos. Eu fui libertado."

-- Yells/Siege_of_Orgrimmar
	_L.yells[953]["Immerseus"] = "Ah, você conseguiu! As águas são puras mais uma vez."
	_L.yells[953]["Spoils of Pandaria"] = "Sistema reiniciando. Não desligue a energia, ou a coisa toda provavelmente explodirá."

-- Yells/Hellfire_Citadel
	_L.yells[1026]["Hellfire Assault"] = "Se você quer que algo fique bem feito, então faça você mesmo..."



---------------------------------
--  Core frames local strings  --
---------------------------------
-- MRT_L/Core
	MRT_L.Core["DKP_Frame_Bank_Button"] = "Banco"
	MRT_L.Core["DKP_Frame_Cancel_Button"] = "Cancelar"
	MRT_L.Core["DKP_Frame_Cost"] = "Custo"
	MRT_L.Core["DKP_Frame_Delete_Button"] = "Excluir"
	MRT_L.Core["DKP_Frame_Disenchanted_Button"] = "Desencantado"
	MRT_L.Core["DKP_Frame_EnterCostFor"] = "Insira o custo para"
	MRT_L.Core["DKP_Frame_LootetBy"] = "saqueado por |cFFFFFFFF%s|r."
	MRT_L.Core["DKP_Frame_Note"] = "Nota"
	MRT_L.Core["DKP_Frame_OK_Button"] = "Ok"
	MRT_L.Core["DKP_Frame_Title"] = "Insira o custo"
	MRT_L.Core["Export_AttendanceNote"] = [=[Em "Raid-Log-Import-Settings", por favor, selecione a opção:
"Time in seconds, the loot belongs to the boss before."
para 180 segundos ou menos, afim de evitar problemas na frequência.]=]
	MRT_L.Core["Export_Attendees"] = "Participantes"
	MRT_L.Core["Export_Button"] = "Fechar"
	MRT_L.Core["Export_Explanation"] = [=[Pressione Ctrl + C para copiar os dados para a área de transferência.
Pressione Ctrl + V para importar dados no seu navegador.]=]
	MRT_L.Core["Export_Frame_Title"] = "Exportar dados"
	MRT_L.Core["Export_Heroic"] = "Heróico"
	MRT_L.Core["Export_Loot"] = "Saque"
	MRT_L.Core["Export_Normal"] = "Normal"
	MRT_L.Core["GuildAttendanceAddNotice"] = "%s adicionado %s na lista de participantes do chefe."
	MRT_L.Core["GuildAttendanceAnnounceText"] = "Sussurre-me o nome do seu personagem principal para ser adicionado à lista DKP."
	MRT_L.Core["GuildAttendanceAnnounceText2"] = "Sussurre-me com '%s' para ser adicionado à lista DKP."
	MRT_L.Core["GuildAttendanceBossDownText"] = "%s derrotado!"
	MRT_L.Core["GuildAttendanceBossEntry"] = "Verificação de frequência"
	MRT_L.Core["GuildAttendanceFailNotice"] = "%s falhou em adicionar %s à lista de participantes."
	MRT_L.Core["GuildAttendanceMsgBox"] = "%s derrotado. Realizar verificação de frequência agora?"
	MRT_L.Core["GuildAttendanceRemainingTimeText"] = "%d minutos restantes."
	MRT_L.Core["GuildAttendanceReply"] = "%s adicionado à lista de DKP."
	MRT_L.Core["GuildAttendanceReplyFail"] = "%s já está na lista DKP."
	MRT_L.Core["GuildAttendanceTimeUpText"] = "Se você não me sussurrou, agora é tarde demais."
	MRT_L.Core["LDB Left-click to toggle the raidlog browser"] = "Clique com o botão esquerdo para alternar o navegador de \"raidlog\""
	MRT_L.Core["LDB Right-click to open the options menu"] = "Clique com o botão direito para abrir o menu de opções"
	MRT_L.Core["MB_Cancel"] = "Cancelar"
	MRT_L.Core["MB_No"] = "Não"
	MRT_L.Core["MB_Ok"] = "Ok"
	MRT_L.Core["MB_Yes"] = "Sim"
	MRT_L.Core["TakeSnapshot_CurrentRaidError"] = "Erro: Raide ativa ainda em progresso. Nenhum \"snapshot\" feito."
	MRT_L.Core["TakeSnapshot_Done"] = "\"Snapshot\" feito."
	MRT_L.Core["TakeSnapshot_NotInRaidError"] = "Erro: Você não está em raid. Nenhum \"snapshot\" feito."
	MRT_L.Core["Trash Mob"] = "\"Trash Mob\""



-----------------------------------
--  Option panels local strings  --
-----------------------------------
-- MRT_L/Options
	MRT_L.Options["AP_GroupRestriction"] = "Acompanhar apenas os primeiros 2/4/5/6 grupos"
	MRT_L.Options["AP_GuildAttendance"] = "Ativar verificação de freqüência da guilda"
	MRT_L.Options["AP_GuildAttendanceCustomTextTitle"] = "Texto de freqüência da guilda personalizado:"
	MRT_L.Options["AP_GuildAttendanceDuration"] = "Duração para realizar freqüência"
	MRT_L.Options["AP_GuildAttendanceNoAuto"] = "Pedir confirmação"
	MRT_L.Options["AP_GuildAttendanceTrigger"] = "Gatilho"
	MRT_L.Options["AP_GuildAttendanceUseCustomText"] = "Usar texto de freqüência da guilda personalizado"
	MRT_L.Options["AP_GuildAttendanceUseTrigger"] = "Usar o gatilho em vez do nome do personagem"
	MRT_L.Options["AP_Minutes"] = "minutos"
	MRT_L.Options["AP_Title"] = "Freqüência"
	MRT_L.Options["AP_TitleText"] = "MRT - Opções de comparecimento"
	MRT_L.Options["AP_TrackOfflinePlayers"] = "Acompanhar jogadores desconectados"
	MRT_L.Options["EP_AllXMLExportsTitle"] = "Todos os formatos de exportação XML"
	MRT_L.Options["EP_BBCode"] = "Texto BBCode formatado"
	MRT_L.Options["EP_BBCode_wowhead"] = "Texto BBCode formatado com links do wowhead"
	MRT_L.Options["EP_ChooseExport_Title"] = "Formato de exportação"
	MRT_L.Options["EP_CTRT_AddPoorItem"] = [=[Ativar a correção de detecção de encontro de chefe para o 
EQdkp (-Plus) CT_RaidTrackerImport 1.16.x]=]
	MRT_L.Options["EP_CTRT_compatible"] = "EQdkp / MLdkp 1.1 (Compatível com CT RaidTracker)"
	MRT_L.Options["EP_CTRT_IgnorePerBossAttendance"] = "Ignorar frequência por chefe"
	MRT_L.Options["EP_CTRT_RLIAttendanceFix"] = [=[Ativar correção de frequência para o
EQdkp-Plus Raid-Log-Import 0.5.6.x]=]
	MRT_L.Options["EP_CTRTTitleText"] = [=[
Configurações de exportação compatíveis com CTRT]=]
	MRT_L.Options["EP_Currency"] = "Moeda"
	MRT_L.Options["EP_DKPBoard"] = "Quadro DKP"
	MRT_L.Options["EP_EnglishExport"] = "Exportar nomes de zonas e nomes de chefes em inglês"
	MRT_L.Options["EP_EQDKP_Plus_XML"] = "EQdkp-Plus XML"
	MRT_L.Options["EP_EQDKPTitleText"] = "Configurações XML do EQdkp-Plus"
	MRT_L.Options["EP_HTML"] = "CSS baseado em HTML com links do wowhead"
	--[[Translation missing --]]
	MRT_L.Options["EP_JSON"] = "JSON"
	MRT_L.Options["EP_MLDKP_15"] = "MLdkp 1.5"
	--[[Translation missing --]]
	MRT_L.Options["EP_Onslaught_LootList"] = "Onslaught Loot List"
	MRT_L.Options["EP_Plain_Text"] = "Texto simples"
	MRT_L.Options["EP_SetDateTimeFormat"] = "Definir formato de data e hora"
	MRT_L.Options["EP_TextExportTitleText"] = "Configurações de exportação de texto"
	MRT_L.Options["EP_Title"] = "Exportar"
	MRT_L.Options["EP_TitleText"] = "MRT - opções de exportação"
	MRT_L.Options["ITP_AutoFocus_Always"] = "Sempre"
	MRT_L.Options["ITP_AutoFocus_Never"] = "Nunca"
	MRT_L.Options["ITP_AutoFocus_NoCombat"] = "Quando não estiver em combate"
	MRT_L.Options["ITP_AutoFocus_Title"] = "Foco automático na janela de custo do saque"
	MRT_L.Options["ITP_IgnoreEnchantingMats"] = "Ignorar materiais de encantamento"
	MRT_L.Options["ITP_IgnoreGems"] = "Ignorar gemas"
	MRT_L.Options["ITP_Title"] = "Rastreamento de item"
	MRT_L.Options["ITP_TitleText"] = "MRT - Opções de rastreamento de itens"
	MRT_L.Options["ITP_UseEPGP_GP_Values"] = "Use os valores de GP do EPGP"
	MRT_L.Options["MP_AutoPrunning"] = "Excluir automaticamente raids mais antigas que"
	MRT_L.Options["MP_Days"] = "dias"
	MRT_L.Options["MP_Debug"] = "Ativar mensagens de depuração"
	MRT_L.Options["MP_Description"] = "Rastreia raides, saques e frequência"
	MRT_L.Options["MP_Enabled"] = "Ativar rastreamento automático"
	MRT_L.Options["MP_MinimapIcon"] = "Mostrar ícone do mini-mapa"
	MRT_L.Options["MP_ResetGuiPos"] = "Redefinir a posição da GUI"
	MRT_L.Options["MP_SlashCmd"] = "Comando de barra"
	MRT_L.Options["TP_AskForDKPValue"] = "Pedir custo do item"
	MRT_L.Options["TP_AskForDKPValuePersonal"] = "... se o modo de saque for \"pessoal\""
	MRT_L.Options["TP_CreateNewRaidOnNewZone"] = "Criar nova raide em nova zona"
	MRT_L.Options["TP_Log10MenRaids"] = "Rastrear raides de 10 jogadores"
	MRT_L.Options["TP_LogAVRaids"] = "Rastrear raides de PVP (VoA, BH)"
	--[[Translation missing --]]
	MRT_L.Options["TP_LogBCRaids"] = "Track Burning Crusade raids"
	MRT_L.Options["TP_LogCataclysmRaids"] = "Rastrear raides do Cataclisma"
	--[[Translation missing --]]
	MRT_L.Options["TP_LogClassicRaids"] = "Track classic raids"
	MRT_L.Options["TP_LogLFRRaids"] = "Rastrear raides do LDR"
	MRT_L.Options["TP_LogLootModePersonal"] = "Rastrear modo de saque \"Pessoal\""
	MRT_L.Options["TP_LogMoPRaids"] = "Rastrear raides de Pandaria"
	MRT_L.Options["TP_LogWarlordsRaids"] = "Rastrear raides de Warlords of Draenor"
	--[[Translation missing --]]
	MRT_L.Options["TP_LogWhileGroup"] = "Track raids while being in a group"
	--[[Translation missing --]]
	MRT_L.Options["TP_LogWhileSolo"] = "Track raids while being solo"
	MRT_L.Options["TP_LogWotLKRaids"] = "Rastrear raides de WotLK"
	MRT_L.Options["TP_MinItemQualityToGetCost_Desc"] = "Qualidade mínima do item para pedir custo"
	MRT_L.Options["TP_MinItemQualityToLog_Desc"] = "Qualidade mínima do item para registrar (log)"
	MRT_L.Options["TP_OnlyTrackItemsAbove"] = "Rastrear apenas itens de item level igual ou acima"
	MRT_L.Options["TP_OnlyTrackItemsBelow"] = "Item level igual ou inferior"
	MRT_L.Options["TP_Title"] = "Rastreamento de raide"
	MRT_L.Options["TP_TitleText"] = "MRT - Opções de rastreamento de raide"
	MRT_L.Options["TP_UseServerTime"] = "Usar o horário do servidor"
	MRT_L.Options["TT_AP_GA_CustomText"] = [=[Variáveis disponíveis:
<<BOSS>> - Nome do evento do chefe
<<TIME>> - Tempo restante da verificação de frequência da guilda
<<TRIGGER>> - O comando "gatilho" personalizado]=]
	MRT_L.Options["TT_EP_AddPoorItem"] = [=[Esta opção altera um pouco a exportação de saque para corrigir a detecção 
de encontros de chefes do CT_RaidTrackerImport. 
Use isso, se você tiver eventos de chefe na sua raide sem saques associados a ele. 
(por exemplo, verificações de frequência)]=]
	MRT_L.Options["TT_EP_DateTimeTT"] = [=[ %d - dia do mês [01-31] 
 %m - mês [01-12] 
 %y - ano com dois dígitos [00-99] 
 %Y - ano completo [2018] 

 %H - hora, no formato de 24hs [00-23] 
 %I - hora, no formato de 12hs [01-12] 
 %M - minuto [00-59] 
 %S - segundo [00-59] 
 %p - ou 'am' ou 'pm']=]
	MRT_L.Options["TT_EP_RLIAttendanceFix"] = [=[Esta opção altera um pouco a exportação de "timestamps" para passar
o limite de participação de 50% do "Raid-Log-Importer".
Utilize esta opção apenas se o seu sistema de DKP for baseado em participação por chefe.]=]
	MRT_L.Options["TT_MP_SlashCmd"] = [=[Comando sem barra.
É recomendado que você "relogue" depois de alterar este valor.]=]



-------------------
--  GUI strings  --
-------------------
-- MRT_L/GUI
	MRT_L.GUI["Active raid found. End current one first."] = "Erro: Raide ativa encontrada. Por favor, finalize a raid ativa antes de começar uma nova."
	MRT_L.GUI["Add boss attendee"] = "Adicionar freqüência do chefe"
	MRT_L.GUI["Add bosskill"] = "Adicionar morte do chefe"
	MRT_L.GUI["Add loot data"] = "Adicionar dados do saque"
	MRT_L.GUI["Add raid attendee"] = "Adicionar freqüência de raide"
	MRT_L.GUI["Bossname"] = "Nome do chefe"
	MRT_L.GUI["Button_Add"] = "Adicionar"
	MRT_L.GUI["Button_Delete"] = "Excluir"
	MRT_L.GUI["Button_EndCurrentRaid"] = "Finalizar raid corrente"
	MRT_L.GUI["Button_Export"] = "Exportar"
	MRT_L.GUI["Button_ExportHeroic"] = "Exportar H"
	MRT_L.GUI["Button_ExportNormal"] = "Exportar N"
	MRT_L.GUI["Button_MakeGuildAttendanceCheck"] = "Faça verificação de comparecimento da guilda"
	MRT_L.GUI["Button_Modify"] = "Modificar"
	--[[Translation missing --]]
	MRT_L.GUI["Button_Rename"] = "Rename"
	MRT_L.GUI["Button_ResumeLastRaid"] = "Retomar última raide"
	MRT_L.GUI["Button_StartNewRaid"] = "Começar nova raide"
	MRT_L.GUI["Button_TakeSnapshot"] = "Tirar \"Snapshot\""
	MRT_L.GUI["Can not delete current raid"] = "Erro: Não é possível excluir a raide corrente."
	MRT_L.GUI["Cell_Hard"] = "Difícil"
	MRT_L.GUI["Cell_LFR"] = "LDR"
	MRT_L.GUI["Cell_Normal"] = "Normal"
	MRT_L.GUI["Col_Cost"] = "Custo"
	MRT_L.GUI["Col_Date"] = "Data"
	MRT_L.GUI["Col_Difficulty"] = "Modo"
	MRT_L.GUI["Col_Join"] = "Entrar"
	MRT_L.GUI["Col_Leave"] = "Sair"
	MRT_L.GUI["Col_Looter"] = "Saqueador"
	MRT_L.GUI["Col_Name"] = "Nome"
	MRT_L.GUI["Col_Num"] = "#"
	MRT_L.GUI["Col_Size"] = "Tamanho"
	MRT_L.GUI["Col_Time"] = "Hora"
	MRT_L.GUI["Col_Zone"] = "Zona"
	MRT_L.GUI["Confirm boss attendee entry deletion"] = "Você deseja excluir %s da lista de participantes do chefe?"
	MRT_L.GUI["Confirm boss entry deletion"] = "Deseja excluir a entrada %d - %s - da lista de morte do chefe?"
	MRT_L.GUI["Confirm loot entry deletion"] = "Deseja excluir o item %s da lista de saque?"
	MRT_L.GUI["Confirm raid attendee entry deletion"] = "Você deseja excluir %s da lista de participantes da raide?"
	MRT_L.GUI["Confirm raid entry deletion"] = "Você deseja excluir a raid de número %d?"
	MRT_L.GUI["Difficulty N or H"] = "Dificuldade ('N' ou 'H')"
	MRT_L.GUI["End tracking of current raid before exporting it"] = "Erro: Não é possível exportar a raide ativa."
	MRT_L.GUI["Entered join time is not before leave time"] = "Erro: O tempo inserido de entrada não é antes do tempo de saída."
	MRT_L.GUI["Entered time is not between start and end of raid"] = "Erro: O tempo inserido não está entre o início e o fim da raide."
	MRT_L.GUI["Header_Title"] = "MRT - Log de raide"
	MRT_L.GUI["Item cost invalid"] = "Erro: O custo do item não é um número."
	MRT_L.GUI["Itemlink"] = "\"Itemlink\" ou \"ItemID\" ou \"Itemname\""
	MRT_L.GUI["Looter"] = "Saqueador"
	MRT_L.GUI["Modify loot data"] = "Modificar dados do saque"
	MRT_L.GUI["No active raid in progress. Please enter time."] = "Erro: nenhuma raide ativa em andamento. Por favor insira o horário."
	MRT_L.GUI["No active raid."] = "Erro: nenhuma raide ativa."
	MRT_L.GUI["No boss attendee selected"] = "Erro: Nenhum participante do chefe foi selecionado."
	MRT_L.GUI["No boss name entered"] = "Erro: Nenhum nome de chefe inserido."
	MRT_L.GUI["No boss selected"] = "Erro: Nenhum chefe selecionado."
	MRT_L.GUI["No itemLink found"] = "Erro: o link do item não é válido."
	MRT_L.GUI["No loot selected"] = "Erro: Nenhum item selecionado."
	MRT_L.GUI["No name entered"] = "Erro: Nenhum nome inserido."
	MRT_L.GUI["No raid attendee selected"] = "Erro: Nenhum participante de raide selecionado."
	MRT_L.GUI["No raid selected"] = "Error: Nenhuma raide foi selecionada."
	MRT_L.GUI["No valid difficulty entered"] = "Erro: Nenhuma dificuldade válida inserida."
	MRT_L.GUI["No valid raid size"] = "Erro: Nenhum tamanho de raide válido foi inserido."
	MRT_L.GUI["No valid time entered"] = "Erro: Nenhum tempo válido inserido."
	MRT_L.GUI["Note"] = "Nota"
	MRT_L.GUI["Player not in raid."] = "Erro: Você não está em um grupo de raide."
	MRT_L.GUI["Raid size"] = "Tamanho da raide"
	--[[Translation missing --]]
	MRT_L.GUI["Rename boss"] = "Rename boss"
	MRT_L.GUI["Resuming last raid failed"] = "Erro: Não foi possível retomar a última raid"
	MRT_L.GUI["Resuming last raid successful"] = "A última raid foi retomada com sucesso."
	MRT_L.GUI["Tables_BossAttendeesTitle"] = "Participantes do chefe"
	MRT_L.GUI["Tables_BossLootTitle"] = "Saque do boss"
	MRT_L.GUI["Tables_RaidAttendeesTitle"] = "Participantes da raide"
	MRT_L.GUI["Tables_RaidBosskillsTitle"] = "Mortes dos chefes de raide"
	MRT_L.GUI["Tables_RaidLogTitle"] = "Lista de raide"
	MRT_L.GUI["Tables_RaidLootTitle"] = "Saque da raide"
	MRT_L.GUI["Time"] = "Tempo"
	MRT_L.GUI["TT_Attendee_Add_JoinEB"] = [=[Formato HH:MM

Se deixado em branco, o MRT utilizará
o horário de início da raide.]=]
	MRT_L.GUI["TT_Attendee_Add_LeaveEB"] = [=[Formato HH:MM

Se deixado em branco, o MRT utilizará
a hora final da raide ou a hora atual.]=]
	MRT_L.GUI["TT_BA_Add"] = "Adicionar um participante à lista de participantes do chefe."
	MRT_L.GUI["TT_BA_Delete"] = "Excluir o participante do chefe selecionado."
	MRT_L.GUI["TT_Boss_Add"] = "Adicionar encontro de chefe."
	MRT_L.GUI["TT_Boss_Add_TimeEB"] = [=[Formato HH:MM

Deixe em branco, se você quiser adicionar um chefe
como o mais recente da raid corrente.]=]
	MRT_L.GUI["TT_Boss_Delete"] = "Excluir encontro de chefe selecionado."
	MRT_L.GUI["TT_Boss_Export"] = "Exportar encontro do chefe selecionado."
	--[[Translation missing --]]
	MRT_L.GUI["TT_Boss_Rename"] = "Renames selected boss encounter."
	MRT_L.GUI["TT_Loot_Add"] = "Adicionar um item à lista de saque."
	MRT_L.GUI["TT_Loot_Delete"] = "Excluir item selecionado"
	MRT_L.GUI["TT_Loot_Modify"] = "Modificar dados do item selecionado."
	MRT_L.GUI["TT_RA_Add"] = "Adicione um participante à lista de frequência da raide."
	MRT_L.GUI["TT_RA_Delete"] = "Excluir participante da raide selecionado."
	MRT_L.GUI["TT_Raid_Delete"] = "Excluir raide selecionada."
	MRT_L.GUI["TT_Raid_Export"] = "Exportar raide selecionada."
	MRT_L.GUI["TT_Raid_ExportH"] = "Exportar todos os encontros do modo heróico da raide selecionada."
	MRT_L.GUI["TT_Raid_ExportN"] = "Exportar todos os encontros do modo normal da raide selecionada."
	MRT_L.GUI["TT_StartNewRaid_RaidSizeEB"] = "Se deixado em branco, o MRT usará 25 como o valor padrão."
	MRT_L.GUI["TT_StartNewRaid_ZoneNameEB"] = "Se deixado em branco, o MRT usará sua zona atual."
	MRT_L.GUI["TT_TakeSnapshot"] = [=[Faça uma "foto rápida" do grupo de raid corrente.
Não funciona se o rastreamento de raid estiver em progresso.
Nesse caso, adicione um evento de chefe.]=]
	MRT_L.GUI["Value"] = "Valor"
	MRT_L.GUI["Zone name"] = "Nome da zona"


