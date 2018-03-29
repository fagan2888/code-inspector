-------------------------------------------------------------------------------------------------------------
--
-- MangAdmin Version 1.0
--
-- Copyright (C) 2007 Free Software Foundation, Inc.
-- License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
-- This is free software: you are free to change and redistribute it.
-- There is NO WARRANTY, to the extent permitted by law.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--
-- Official Forums: http://www.manground.org/forum/
-- GoogleCode Website: http://code.google.com/p/mangadmin/
-- Subversion Repository: http://mangadmin.googlecode.com/svn/
--
-------------------------------------------------------------------------------------------------------------

function Return_ptPT() 
  return {
    ["slashcmds"] = { "/mangadmin", "/ma" },
    ["lang"] = "Portuguese (PT)",
    ["realm"] = "|cFF00FF00Realm:|r "..GetCVar("realmName"),
    ["char"] = "|cFF00FF00Char:|r "..UnitName("player"),
    ["guid"] = "|cFF00FF00Guid:|r ",
    ["tickets"] = "|cFF00FF00Tickets:|r ",
    ["gridnavigator"] = "Grid-Navigator",
    ["selectionerror1"] = "Apenas jogadores podem ser selecionados!",
    ["selectionerror2"] = "Apenas tu podes ser selecionado!",
    ["selectionerror3"] = "Apenas outro jogador pode ser selecionado!",
    ["selectionerror4"] = "Apenas um NPC pode ser selecionado!",
    ["searchResults"] = "|cFF00FF00Search-Results:|r ",
    ["tabmenu_Main"] = "Geral",
    ["tabmenu_Char"] = "Personagem",
    ["tabmenu_Tele"] = "Teleporte",
    ["tabmenu_Ticket"] = "Systema de Ticket",
    ["tabmenu_Misc"] = "Variados",
    ["tabmenu_Server"] = "Servidor",
    ["tabmenu_Log"] = "Histзrico",
    ["tt_Default"] = "Move o cursor sobre um elemento para mostrar a sua informaусo!",
    ["tt_MainButton"] = "Clique para alterar a janela mostrando a parte Geral do MangAdmin.",
    ["tt_CharButton"] = "Clique para alterar a janela com acушes especьficas de personagens.",
    ["tt_TeleButton"] = "Clique para alterar a janela com funушes de teleporte.",
    ["tt_TicketButton"] = "Clique para alterar a janela que te mostra e possibilita a gestсo de tickets.",
    ["tt_MiscButton"] = "Clique para alterar a janela que mostra vрrias acушes.",
    ["tt_ServerButton"] = "Clique para mostrar varias informaушes e acушes que ocorrem no servidor.",
    ["tt_LogButton"] = "Click to show the log of all actions done with MangAdmin.",
    ["tt_LanguageButton"] = "Clique para alterar o idioma e reniciar o MangAdmin.",
    ["tt_GMOnButton"] = "Clique para activar o teu modo de GM.",
    ["tt_GMOffButton"] = "Clique para desactivar o teu modo de GM.",
    ["tt_FlyOnButton"] = "Clique para activar o modo de Voar no jogador selecionado.",
    ["tt_FlyOffButton"] = "Clique para desactivar o modo de Voar no jogador selecionado.",
    ["tt_HoverOnButton"] = "Clique para activar o modo de Sobreposiусo.",
    ["tt_HoverOffButton"] = "Clique para desactivar o modo de Sobreposiусo",
    ["tt_WhispOnButton"] = "Clique para aceitar whispers de outros jogadores.",
    ["tt_WhispOffButton"] = "Clique para nсo aceitar whispers de outros jogadores.",
    ["tt_InvisOnButton"] = "Clique para ficar invisьvel.",
    ["tt_InvisOffButton"] = "Clique para ficar visьvel.",
    ["tt_TaxiOnButton"] = "Clique para mostrar todos as rotas de taxi no jogador selecionado. Esta opусo irр ficar desactivada assim que esse jogador terminar a sessсo.",
    ["tt_TaxiOffButton"] = "Clique para restaurar apenas as rotas de taxi conhecidas no jogador selecionado.",
    ["tt_BankButton"] = "Clique para mostrar o teu banco.",
    ["tt_ScreenButton"] = "Clique para criar um screenshot.",
    ["tt_SpeedSlider"] = "Arraste para aumentar ou diminuir a velocidade do jogador selecionado.",
    ["tt_ScaleSlider"] = "Arraste para aumentar ou diminuir a escala do jogador selecionado.",
    ["tt_ItemButton"] = "Clique e uma janela abrir-se-р com a funусo de procurar e gerir os teus items favoritos.",
    ["tt_ItemSetButton"] = "Click to toggle a popup with the function to search for itemsets and manage your favorites.",
    ["tt_SpellButton"] = "Clique e uma janela abrir-se-р com a funусo de procurar e gerir os teus feitьуos favoritos.",
    ["tt_QuestButton"] = "Click to toggle a popup with the function to search for quests and manage your favorites.",
    ["tt_CreatureButton"] = "Click to toggle a popup with the function to search for creatures and manage your favorites.",
    ["tt_ObjectButton"] = "Click to toggle a popup with the function to search for objects and manage your favorites.",
    ["tt_SearchDefault"] = "Agora insira uma palavra-chave e comeуe a procura.",
    ["tt_AnnounceButton"] = "Clique para anunciar uma mensagem de systema.",
    ["tt_KickButton"] = "Clique para \"kickar\" um jogador do servidor.",
    ["tt_ShutdownButton"] = "Clique para desligar o servidor de acordo com o tempo em segundos escolhidos no campo (se nenhum, entсo desligar-se-р instantaneamente)!",
    ["ma_ItemButton"] = "Procurar Itens",
    ["ma_ItemSetButton"] = "ItemSet-Search",
    ["ma_SpellButton"] = "Procurar Feitьуos",
    ["ma_QuestButton"] = "Quest-Search",
    ["ma_CreatureButton"] = "Creature-Search",
    ["ma_ObjectButton"] = "Object-Search",
    ["ma_TeleSearchButton"] = "Teleport-Search",
    ["ma_LanguageButton"] = "Mudar de Idioma",
    ["ma_GMOnButton"] = "GM Ligar",
    ["ma_FlyOnButton"] = "Voar Ligar",
    ["ma_HoverOnButton"] = "Sobreposiусo Ligar",
    ["ma_WhisperOnButton"] = "Whisper Ligar",
    ["ma_InvisOnButton"] = "Invisibilidade Ligar",
    ["ma_TaxiOnButton"] = "Taxicheat Ligar",    
    ["ma_ScreenshotButton"] = "Screenshot",
    ["ma_BankButton"] = "Banco",
    ["ma_OffButton"] = "Desligar",
    ["ma_LearnAllButton"] = "Todos os feitiуos",
    ["ma_LearnCraftsButton"] = "Todas as profissшes e receitas",
    ["ma_LearnGMButton"] = "Feitiуos padrсo de GM",
    ["ma_LearnLangButton"] = "Todas as lьnguas",
    ["ma_LearnClassButton"] = "Todos os feitьуos da classe",
    ["ma_SearchButton"] = "Procurar...",
    ["ma_ResetButton"] = "Reniciar",
    ["ma_KickButton"] = "Kick",
    ["ma_KillButton"] = "Kill",
    ["ma_DismountButton"] = "Dismount",
    ["ma_ReviveButton"] = "Revive",
    ["ma_SaveButton"] = "Save",
    ["ma_AnnounceButton"] = "Anunciar",
    ["ma_ShutdownButton"] = "Desligar!",
    ["ma_ItemVar1Button"] = "Amount",
    ["ma_ObjectVar1Button"] = "Loot Template",
    ["ma_ObjectVar2Button"] = "Spawn Time",
    ["ma_LoadTicketsButton"] = "Show Tickets",
    ["ma_GetCharTicketButton"] = "Get Player",
    ["ma_GoCharTicketButton"] = "Go to Player",
    ["ma_AnswerButton"] = "Answer",
    ["ma_DeleteButton"] = "Delete",
    ["ma_TicketCount"] = "|cFF00FF00Tickets:|r ",
    ["ma_TicketsNoNew"] = "You have no new tickets.",
    ["ma_TicketsNewNumber"] = "You have |cffeda55f%s|r new tickets!",
    ["ma_TicketsGoLast"] = "Go to last ticket creator (%s).",
    ["ma_TicketsGetLast"] = "Bring %s to you.",
    ["ma_IconHint"] = "|cffeda55fClick|r to open MangAdmin. |cffeda55fShift-Click|r to reload the user interface. |cffeda55fAlt-Click|r to reset the ticket count.",
    ["ma_Reload"] = "Reload",
    ["ma_LoadMore"] = "Load more...",
    ["ma_MailRecipient"] = "Recipient",
    ["ma_Mail"] = "Send a Mail",
    ["ma_Send"] = "Send",
    ["ma_MailSubject"] = "Subject",
    ["ma_MailYourMsg"] = "Here your message!",
    ["ma_Online"] = "Online",
    ["ma_Offline"] = "Offline",
    ["ma_TicketsInfoPlayer"] = "|cFF00FF00Player:|r ",
    ["ma_TicketsInfoStatus"] = "|cFF00FF00Status:|r ",
    ["ma_TicketsInfoAccount"] = "|cFF00FF00Account:|r ",
    ["ma_TicketsInfoAccLevel"] = "|cFF00FF00Account-Level:|r ",
    ["ma_TicketsInfoLastIP"] = "|cFF00FF00Last IP:|r ",
    ["ma_TicketsInfoPlayedTime"] = "|cFF00FF00Played time:|r ",
    ["ma_TicketsInfoLevel"] = "|cFF00FF00Level:|r ",
    ["ma_TicketsInfoMoney"] = "|cFF00FF00Money:|r ",
    ["ma_TicketsInfoLatency"] = "|cFF00FF00Latency:|r ",
    ["ma_TicketsNoInfo"] = "No ticket info available...",
    ["ma_TicketsNotLoaded"] = "No ticket loaded...",
    ["ma_TicketsNoTickets"] = "There are no tickets available!",
    ["ma_TicketTicketLoaded"] = "|cFF00FF00Loaded Ticket-Nr:|r %s\n\nPlayer Information\n\n",
    ["ma_FavAdd"] = "Add selected",
    ["ma_FavRemove"] = "Remove selected",
    ["ma_SelectAllButton"] = "Select all",
    ["ma_DeselectAllButton"] = "Deselect all",
    ["ma_MailBytesLeft"] = "Bytes left: ",
    ["ma_WeatherFine"] = "Fine",
    ["ma_WeatherFog"] = "Fog",
    ["ma_WeatherRain"] = "Rain",
    ["ma_WeatherSnow"] = "Snow",
    ["ma_WeatherSand"] = "Sand",
    ["ma_LevelUp"] = "Level up",
    ["ma_LevelDown"] = "Level down",
    ["ma_Money"] = "Money",
    ["ma_Energy"] = "Energy",
    ["ma_Rage"] = "Rage",
    ["ma_Mana"] = "Mana",
    ["ma_Healthpoints"] = "Healthpoints",
    ["ma_Talents"] = "Talents",
    ["ma_Stats"] = "Stats",
    ["ma_Spells"] = "Spells",
    ["ma_Honor"] = "Honor",
    ["ma_Level"] = "Level",
    ["ma_AllLang"] = "All Languages",
    -- languages
    ["Common"] = "Common",
    ["Orcish"] = "Orcish",
    ["Taurahe"] = "Taurahe",
    ["Darnassian"] = "Darnassian",
    ["Dwarvish"] = "Dwarvish",
    ["Thalassian"] = "Thalassian",
    ["Demonic"] = "Demonic",
    ["Draconic"] = "Draconic",
    ["Titan"] = "Titan",
    ["Kalimag"] = "Kalimag",
    ["Gnomish"] = "Gnomish",
    ["Troll"] = "Troll",
    ["Gutterspeak"] = "Gutterspeak",
    ["Draenei"] = "Draenei",
    ["ma_NoFavorites"] = "There are currently no saved favorites!",
    ["ma_NoZones"] = "No zones!",
    ["ma_NoSubZones"] = "No subzones!",
    ["favoriteResults"] = "|cFF00FF00Favorites:|r ",
    ["Zone"] = "|cFF00FF00Zone:|r ",
    ["tt_DisplayAccountLevel"] = "Display your account level",
    ["tt_TicketOn"] = "Announce new tickets.",
    ["tt_TicketOff"] = "Don't announce new tickets.",
    ["info_revision"] = "|cFF00FF00MaNGOS Revision:|r ",
    ["info_platform"] = "|cFF00FF00Server Platform:|r ",
    ["info_online"] = "|cFF00FF00Players Online:|r ",
    ["info_maxonline"] = "|cFF00FF00Maximum Online:|r ",
    ["info_uptime"] = "|cFF00FF00Uptime:|r ",
    ["cmd_toggle"] = "Toggle the main window",
    ["cmd_transparency"] = "Toggle the basic transparency (0.5 or 1.0)",
    ["cmd_tooltip"] = "Toggle wether the button tooltips are shown or not",
    ["tt_SkillButton"] = "Toggle a popup with the function to search for skills and manage your favorites.",
    ["tt_RotateLeft"] = "Rotate left.",
    ["tt_RotateRight"] = "Rotate right.",
    ["tt_FrmTrSlider"] = "Change frame transparency.",
    ["tt_BtnTrSlider"] = "Change button transparency.",
    ["ma_SkillButton"] = "Skill-Search",
    ["ma_SkillVar1Button"] = "Skill",
    ["ma_SkillVar2Button"] = "Max Skill",
    ["tt_DisplayAccountLvl"] = "Display your account level.",
    --linkifier
    ["lfer_Spawn"] = "Spawn",
    ["lfer_List"] = "List",
    ["lfer_Goto"] = "Goto",
    ["lfer_Move"] = "Move",
    ["lfer_Turn"] = "Turn",
    ["lfer_Delete"] = "Delete",
    ["lfer_Teleport"] = "Teleport",
    ["lfer_Morph"] = "Morph",
    ["lfer_Add"] = "Add",
    ["lfer_Remove"] = "Remove",
    ["lfer_Learn"] = "Learn",
    ["lfer_Unlearn"] = "Unlearn",
    ["lfer_Error"] = "Error Search String Matched but an error occured or unable to find type"
  }
end
