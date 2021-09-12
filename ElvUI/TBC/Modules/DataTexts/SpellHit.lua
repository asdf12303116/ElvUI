local E, L, V, P, G = unpack(select(2, ...)) --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local DT = E:GetModule("DataTexts")

local strjoin = strjoin
local GetCombatRatingBonus = GetCombatRatingBonus

local CR_HIT_SPELL = CR_HIT_SPELL
local STAT_CATEGORY_ENHANCEMENTS = STAT_CATEGORY_ENHANCEMENTS

local displayString = ""
local lastPanel

local function OnEvent(self)
	lastPanel = self

	self.text:SetFormattedText(displayString, GetCombatRatingBonus(CR_HIT_SPELL) or 0)
end

local function ValueColorUpdate(hex)
	displayString = strjoin("", L["Spell Hit"], ": ", hex, "%.2f%%|r")

	if lastPanel ~= nil then
		OnEvent(lastPanel)
	end
end
E.valueColorUpdateFuncs[ValueColorUpdate] = true

DT:RegisterDatatext("Spell Hit", STAT_CATEGORY_ENHANCEMENTS, {"COMBAT_RATING_UPDATE"}, OnEvent, nil, nil, nil, nil, "Spell Hit")
