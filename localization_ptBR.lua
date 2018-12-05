-- ********************************************************
-- **           Mizus RaidTracker - ptBR Local           **
-- **               <http://cosmocanyon.de>              **
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
_L.yells[886]["Lei Shi"] = "Eu... ah... oh! Eu o quê...? Eu fiz o quê...? Estava tudo tão... tão turvo..."
_L.yells[886]["Tsulong"] = "Eu agradeço, forasteiros. Eu fui libertado."


---------------------------------
--  Core frames local strings  --
---------------------------------
MRT_L["Core"] = {
		["DKP_Frame_Bank_Button"] = "Banco",
		["DKP_Frame_Cancel_Button"] = "Cancelar",
		["DKP_Frame_Cost"] = "Custo",
		["DKP_Frame_Delete_Button"] = "Excluir",
		["DKP_Frame_Disenchanted_Button"] = "Desencantado",
		["DKP_Frame_EnterCostFor"] = "Insira o custo para",
		["DKP_Frame_LootetBy"] = "saqueado por |cFFFFFFFF%s|r.",
		["DKP_Frame_Note"] = "Nota",
		["DKP_Frame_OK_Button"] = "Ok",
		["DKP_Frame_Title"] = "Insira o custo",
		["Export_AttendanceNote"] = [=[Em "Raid-Log-Import-Settings", por favor, selecione a opção:
"Time in seconds, the loot belongs to the boss before."
para 180 segundos ou menos, afim de evitar problemas na frequência.]=],
		["Export_Attendees"] = "Participantes",
		["Export_Button"] = "Fechar",
		["Export_Explanation"] = [=[Pressione Ctrl + C para copiar os dados para a área de transferência.
Pressione Ctrl + V para importar dados no seu navegador.]=],
		["Export_Frame_Title"] = "Exportar dados",
		["Export_Heroic"] = "Heróico",
		["Export_Loot"] = "Saque",
		["Export_Normal"] = "Normal",
		["GuildAttendanceAddNotice"] = "%s adicionado %s na lista de participantes do chefe.",
		["GuildAttendanceAnnounceText"] = "Sussurre-me o nome do seu personagem principal para ser adicionado à lista DKP.",
		["GuildAttendanceAnnounceText2"] = "Sussurre-me com '%s' para ser adicionado à lista DKP.",
		["GuildAttendanceBossDownText"] = "%s derrotado!",
		["GuildAttendanceBossEntry"] = "Verificação de frequência",
		["GuildAttendanceFailNotice"] = "%s falhou em adicionar %s à lista de participantes.",
		["GuildAttendanceMsgBox"] = "%s derrotado. Realizar verificação de frequência agora?",
		["GuildAttendanceRemainingTimeText"] = "%d minutos restantes.",
		["GuildAttendanceReply"] = "%s adicionado à lista de DKP.",
		["GuildAttendanceReplyFail"] = "%s já está na lista DKP.",
		["GuildAttendanceTimeUpText"] = "Se você não me sussurrou, agora é tarde demais.",
		["LDB Left-click to toggle the raidlog browser"] = "Clique com o botão esquerdo para alternar o navegador de \"raidlog\"",
		["LDB Right-click to open the options menu"] = "Clique com o botão direito para abrir o menu de opções",
		["MB_Cancel"] = "Cancelar",
		["MB_No"] = "Não",
		["MB_Ok"] = "Ok",
		["MB_Yes"] = "Sim",
		["TakeSnapshot_CurrentRaidError"] = "Erro: Raide ativa ainda em progresso. Nenhum \"snapshot\" feito.",
		["TakeSnapshot_Done"] = "\"Snapshot\" feito.",
		["TakeSnapshot_NotInRaidError"] = "Erro: Você não está em raid. Nenhum \"snapshot\" feito.",
		["Trash Mob"] = "\"Trash Mob\"",
}


-----------------------------------
--  Option panels local strings  --
-----------------------------------
MRT_L["Options"] = {
		["AP_GroupRestriction"] = "Acompanhar apenas os primeiros 2/4/5/6 grupos",
		["AP_GuildAttendance"] = "Ativar verificação de freqüência da guilda",
		["AP_GuildAttendanceCustomTextTitle"] = "Texto de freqüência da guilda personalizado:",
		["AP_GuildAttendanceDuration"] = "Duração para realizar freqüência",
		["AP_GuildAttendanceNoAuto"] = "Pedir confirmação",
		["AP_GuildAttendanceTrigger"] = "Gatilho",
		["AP_GuildAttendanceUseCustomText"] = "Usar texto de freqüência da guilda personalizado",
		["AP_GuildAttendanceUseTrigger"] = "Usar o gatilho em vez do nome do personagem",
		["AP_Minutes"] = "minutos",
		["AP_Title"] = "Freqüência",
		["AP_TitleText"] = "MRT - Opções de comparecimento",
		["AP_TrackOfflinePlayers"] = "Acompanhar jogadores desconectados",
		["EP_AllXMLExportsTitle"] = "Todos os formatos de exportação XML",
		["EP_BBCode"] = "Texto BBCode formatado",
		["EP_BBCode_wowhead"] = "Texto BBCode formatado com links do wowhead",
		["EP_ChooseExport_Title"] = "Formato de exportação",
		["EP_CTRT_AddPoorItem"] = [=[Ativar a correção de detecção de encontro de chefe para o 
EQdkp (-Plus) CT_RaidTrackerImport 1.16.x]=],
		["EP_CTRT_compatible"] = "EQdkp / MLdkp 1.1 (Compatível com CT RaidTracker)",
		["EP_CTRT_IgnorePerBossAttendance"] = "Ignorar frequência por chefe",
		["EP_CTRT_RLIAttendanceFix"] = [=[Ativar correção de frequência para o
EQdkp-Plus Raid-Log-Import 0.5.6.x]=],
		["EP_CTRTTitleText"] = [=[
Configurações de exportação compatíveis com CTRT]=],
		["EP_Currency"] = "Moeda",
		["EP_DKPBoard"] = "Quadro DKP",
		["EP_EnglishExport"] = "Exportar nomes de zonas e nomes de chefes em inglês",
		["EP_EQDKP_Plus_XML"] = "EQdkp-Plus XML",
		["EP_EQDKPTitleText"] = "Configurações XML do EQdkp-Plus",
		["EP_HTML"] = "CSS baseado em HTML com links do wowhead",
		["EP_MLDKP_15"] = "MLdkp 1.5",
		["EP_Plain_Text"] = "Texto simples",
		["EP_SetDateTimeFormat"] = "Definir formato de data e hora",
		["EP_TextExportTitleText"] = "Configurações de exportação de texto",
		["EP_Title"] = "Exportar",
		["EP_TitleText"] = "MRT - opções de exportação",
		["ITP_AutoFocus_Always"] = "Sempre",
		["ITP_AutoFocus_Never"] = "Nunca",
		["ITP_AutoFocus_NoCombat"] = "Quando não estiver em combate",
		["ITP_AutoFocus_Title"] = "Foco automático na janela de custo do saque",
		["ITP_IgnoreEnchantingMats"] = "Ignorar materiais de encantamento",
		["ITP_IgnoreGems"] = "Ignorar gemas",
		["ITP_Title"] = "Rastreamento de item",
		["ITP_TitleText"] = "MRT - Opções de rastreamento de itens",
		["ITP_UseEPGP_GP_Values"] = "Use os valores de GP do EPGP",
		["MP_AutoPrunning"] = "Excluir automaticamente raids mais antigas que",
		["MP_Days"] = "dias",
		["MP_Debug"] = "Ativar mensagens de depuração",
		["MP_Description"] = "Rastreia raides, saques e frequência",
		["MP_Enabled"] = "Ativar rastreamento automático",
		["MP_MinimapIcon"] = "Mostrar ícone do mini-mapa",
		["MP_ResetGuiPos"] = "Redefinir a posição da GUI",
		["MP_SlashCmd"] = "Comando de barra",
		["TP_AskForDKPValue"] = "Pedir custo do item",
		["TP_AskForDKPValuePersonal"] = "... se o modo de saque for \"pessoal\"",
		["TP_CreateNewRaidOnNewZone"] = "Criar nova raide em nova zona",
		["TP_Log10MenRaids"] = "Rastrear raides de 10 jogadores",
		["TP_LogAVRaids"] = "Rastrear raides de PVP (VoA, BH)",
		--[[Translation missing --]]
		["TP_LogBCRaids"] = "Track Burning Crusade raids",
		["TP_LogCataclysmRaids"] = "Rastrear raides do Cataclisma",
		--[[Translation missing --]]
		["TP_LogClassicRaids"] = "Track classic raids",
		["TP_LogLFRRaids"] = "Rastrear raides do LDR",
		["TP_LogLootModePersonal"] = "Rastrear modo de saque \"Pessoal\"",
		["TP_LogMoPRaids"] = "Rastrear raides de Pandaria",
		["TP_LogWarlordsRaids"] = "Rastrear raides de Warlords of Draenor",
		["TP_LogWotLKRaids"] = "Rastrear raides de WotLK",
		["TP_MinItemQualityToGetCost_Desc"] = "Qualidade mínima do item para pedir custo",
		["TP_MinItemQualityToLog_Desc"] = "Qualidade mínima do item para registrar (log)",
		["TP_OnlyTrackItemsAbove"] = "Rastrear apenas itens de item level igual ou acima",
		["TP_OnlyTrackItemsBelow"] = "Item level igual ou inferior",
		["TP_Title"] = "Rastreamento de raide",
		["TP_TitleText"] = "MRT - Opções de rastreamento de raide",
		["TP_UseServerTime"] = "Usar o horário do servidor",
		["TT_AP_GA_CustomText"] = [=[Variáveis disponíveis:
<<BOSS>> - Nome do evento do chefe
<<TIME>> - Tempo restante da verificação de frequência da guilda
<<TRIGGER>> - O comando "gatilho" personalizado]=],
		["TT_EP_AddPoorItem"] = [=[Esta opção altera um pouco a exportação de saque para corrigir a detecção 
de encontros de chefes do CT_RaidTrackerImport. 
Use isso, se você tiver eventos de chefe na sua raide sem saques associados a ele. 
(por exemplo, verificações de frequência)]=],
		["TT_EP_DateTimeTT"] = [=[ %d - dia do mês [01-31] 
 %m - mês [01-12] 
 %y - ano com dois dígitos [00-99] 
 %Y - ano completo [2018] 

 %H - hora, no formato de 24hs [00-23] 
 %I - hora, no formato de 12hs [01-12] 
 %M - minuto [00-59] 
 %S - segundo [00-59] 
 %p - ou 'am' ou 'pm']=],
		["TT_EP_RLIAttendanceFix"] = [=[Esta opção altera um pouco a exportação de "timestamps" para passar
o limite de participação de 50% do "Raid-Log-Importer".
Utilize esta opção apenas se o seu sistema de DKP for baseado em participação por chefe.]=],
		["TT_MP_SlashCmd"] = [=[Comando sem barra.
É recomendado que você "relogue" depois de alterar este valor.]=],
}


-------------------
--  GUI strings  --
-------------------
MRT_L["GUI"] = {
		["Active raid found. End current one first."] = "Erro: Raide ativa encontrada. Por favor, finalize a raid ativa antes de começar uma nova.",
		["Add boss attendee"] = "Adicionar freqüência do chefe",
		["Add bosskill"] = "Adicionar morte do chefe",
		["Add loot data"] = "Adicionar dados do saque",
		["Add raid attendee"] = "Adicionar freqüência de raide",
		["Bossname"] = "Nome do chefe",
		["Button_Add"] = "Adicionar",
		["Button_Delete"] = "Excluir",
		["Button_EndCurrentRaid"] = "Finalizar raid corrente",
		["Button_Export"] = "Exportar",
		["Button_ExportHeroic"] = "Exportar H",
		["Button_ExportNormal"] = "Exportar N",
		["Button_MakeGuildAttendanceCheck"] = "Faça verificação de comparecimento da guilda",
		["Button_Modify"] = "Modificar",
		["Button_ResumeLastRaid"] = "Retomar última raide",
		["Button_StartNewRaid"] = "Começar nova raide",
		["Button_TakeSnapshot"] = "Tirar \"Snapshot\"",
		["Can not delete current raid"] = "Erro: Não é possível excluir a raide corrente.",
		["Cell_Hard"] = "Difícil",
		["Cell_LFR"] = "LDR",
		["Cell_Normal"] = "Normal",
		["Col_Cost"] = "Custo",
		["Col_Date"] = "Data",
		["Col_Difficulty"] = "Modo",
		["Col_Join"] = "Entrar",
		["Col_Leave"] = "Sair",
		["Col_Looter"] = "Saqueador",
		["Col_Name"] = "Nome",
		["Col_Num"] = "#",
		["Col_Size"] = "Tamanho",
		["Col_Time"] = "Hora",
		["Col_Zone"] = "Zona",
		["Confirm boss attendee entry deletion"] = "Você deseja excluir %s da lista de participantes do chefe?",
		["Confirm boss entry deletion"] = "Deseja excluir a entrada %d - %s - da lista de morte do chefe?",
		["Confirm loot entry deletion"] = "Deseja excluir o item %s da lista de saque?",
		["Confirm raid attendee entry deletion"] = "Você deseja excluir %s da lista de participantes da raide?",
		["Confirm raid entry deletion"] = "Você deseja excluir a raid de número %d?",
		["Difficulty N or H"] = "Dificuldade ('N' ou 'H')",
		["End tracking of current raid before exporting it"] = "Erro: Não é possível exportar a raide ativa.",
		["Entered join time is not before leave time"] = "Erro: O tempo inserido de entrada não é antes do tempo de saída.",
		["Entered time is not between start and end of raid"] = "Erro: O tempo inserido não está entre o início e o fim da raide.",
		["Header_Title"] = "MRT - Log de raide",
		["Item cost invalid"] = "Erro: O custo do item não é um número.",
		["Itemlink"] = "\"Itemlink\" ou \"ItemID\" ou \"Itemname\"",
		["Looter"] = "Saqueador",
		["Modify loot data"] = "Modificar dados do saque",
		["No active raid in progress. Please enter time."] = "Erro: nenhuma raide ativa em andamento. Por favor insira o horário.",
		["No active raid."] = "Erro: nenhuma raide ativa.",
		["No boss attendee selected"] = "Erro: Nenhum participante do chefe foi selecionado.",
		["No boss name entered"] = "Erro: Nenhum nome de chefe inserido.",
		["No boss selected"] = "Erro: Nenhum chefe selecionado.",
		["No itemLink found"] = "Erro: o link do item não é válido.",
		["No loot selected"] = "Erro: Nenhum item selecionado.",
		["No name entered"] = "Erro: Nenhum nome inserido.",
		["No raid attendee selected"] = "Erro: Nenhum participante de raide selecionado.",
		["No raid selected"] = "Error: Nenhuma raide foi selecionada.",
		["No valid difficulty entered"] = "Erro: Nenhuma dificuldade válida inserida.",
		["No valid raid size"] = "Erro: Nenhum tamanho de raide válido foi inserido.",
		["No valid time entered"] = "Erro: Nenhum tempo válido inserido.",
		["Note"] = "Nota",
		["Player not in raid."] = "Erro: Você não está em um grupo de raide.",
		["Raid size"] = "Tamanho da raide",
		["Resuming last raid failed"] = "Erro: Não foi possível retomar a última raid",
		["Resuming last raid successful"] = "A última raid foi retomada com sucesso.",
		["Tables_BossAttendeesTitle"] = "Participantes do chefe",
		["Tables_BossLootTitle"] = "Saque do boss",
		["Tables_RaidAttendeesTitle"] = "Participantes da raide",
		["Tables_RaidBosskillsTitle"] = "Mortes dos chefes de raide",
		["Tables_RaidLogTitle"] = "Lista de raide",
		["Tables_RaidLootTitle"] = "Saque da raide",
		["Time"] = "Tempo",
		["TT_Attendee_Add_JoinEB"] = [=[Formato HH:MM

Se deixado em branco, o MRT utilizará
o horário de início da raide.]=],
		["TT_Attendee_Add_LeaveEB"] = [=[Formato HH:MM

Se deixado em branco, o MRT utilizará
a hora final da raide ou a hora atual.]=],
		["TT_BA_Add"] = "Adicionar um participante à lista de participantes do chefe.",
		["TT_BA_Delete"] = "Excluir o participante do chefe selecionado.",
		["TT_Boss_Add"] = "Adicionar encontro de chefe.",
		["TT_Boss_Add_TimeEB"] = [=[Formato HH:MM

Deixe em branco, se você quiser adicionar um chefe
como o mais recente da raid corrente.]=],
		["TT_Boss_Delete"] = "Excluir encontro de chefe selecionado.",
		["TT_Boss_Export"] = "Exportar encontro do chefe selecionado.",
		["TT_Loot_Add"] = "Adicionar um item à lista de saque.",
		["TT_Loot_Delete"] = "Excluir item selecionado",
		["TT_Loot_Modify"] = "Modificar dados do item selecionado.",
		["TT_RA_Add"] = "Adicione um participante à lista de frequência da raide.",
		["TT_RA_Delete"] = "Excluir participante da raide selecionado.",
		["TT_Raid_Delete"] = "Excluir raide selecionada.",
		["TT_Raid_Export"] = "Exportar raide selecionada.",
		["TT_Raid_ExportH"] = "Exportar todos os encontros do modo heróico da raide selecionada.",
		["TT_Raid_ExportN"] = "Exportar todos os encontros do modo normal da raide selecionada.",
		["TT_StartNewRaid_RaidSizeEB"] = "Se deixado em branco, o MRT usará 25 como o valor padrão.",
		["TT_StartNewRaid_ZoneNameEB"] = "Se deixado em branco, o MRT usará sua zona atual.",
		["TT_TakeSnapshot"] = [=[Faça uma "foto rápida" do grupo de raid corrente.
Não funciona se o rastreamento de raid estiver em progresso.
Nesse caso, adicione um evento de chefe.]=],
		["Value"] = "Valor",
		["Zone name"] = "Nome da zona",
}
