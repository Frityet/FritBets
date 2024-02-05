-- Copyright (c) 2024 Amrit Bhogal
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local path = require("path-utilities")
local pretty = require("pl.pretty")

local export = {}

export.BET_FILE = path.current_directory/"bets.lua";

---@class Bet
---@field amount number
---@field currency string
---@field in_favour boolean

---@param bets { [string] : Bet}
function export.save_bets(bets)
    local bet_file = assert(export.BET_FILE:open("file", "wb")) --[[@as file*]]
    bet_file:write("return ", pretty.write(bets))
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

return export
