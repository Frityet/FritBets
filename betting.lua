-- Copyright (c) 2024 Amrit Bhogal
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local path = require("path-utilities")
local pretty = require("pl.pretty")

local export = {}

export.BET_FILE = path.current_directory / "bets" / "bets.lua";

(export.BET_FILE - 1):create_directory(true)

---@class Bet
---@field amount number
---@field comment string?
---@field in_favour boolean

---@param bets { [string] : Bet}?
function export.save_bets(bets)
	local bet_file = assert(export.BET_FILE:open("file", "wb")) --[[@as file*]]
	bet_file:write("return ", pretty.write(bets or export.bets))
	bet_file:close()
end

---@return { [string] : Bet }
function export.load_bets()
	if not export.BET_FILE:exists() then
		export.save_bets({})
		return {}
	end
	return assert(dofile(tostring(export.BET_FILE))) --[[@return Bet[]]
end

export.bets = export.load_bets()

---@param pred (fun(bet: Bet, from: string): boolean)?
---@return number
function export.get_total(pred)
	local total = 0
	for name, bet in pairs(export.bets) do
		if not pred or pred(bet, name) then
			total = total + bet.amount
		end
	end
	return total
end

return export
