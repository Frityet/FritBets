-- Copyright (c) 2024 Amrit Bhogal
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local export = {}

---@alias Currency.Name
---| '"USD"' # United States Dollar
---| '"GBP"' # British Pound Sterling
---| '"EUR"' # Euro
---| '"CAD"' # Canadian Dollar
---| '"AUD"' # Australian Dollar
---| '"INR"' # Indian Rupee

---@class Currency
---@field prefix string
---@field exchange_rate_to_usd number
---@field country string

---@type { [Currency.Name] : Currency }
export.currencies = {
    ["USD"] = {
        prefix = "$",
        exchange_rate_to_usd = 1,
        country = "United States"
    },
    ["GBP"] = {
        prefix = "£",
        exchange_rate_to_usd = 0.80,
        country = "United Kingdom"
    },
    ["EUR"] = {
        prefix = "€",
        exchange_rate_to_usd = 0.93,
        country = "European Union"
    },
    ["CAD"] = {
        prefix = "C$",
        exchange_rate_to_usd = 1.35,
        country = "Canada"
    },
    ["AUD"] = {
        prefix = "A$",
        exchange_rate_to_usd = 1.54,
        country = "Australia"
    },
    ["INR"] = {
        prefix = "",
        exchange_rate_to_usd = 83.03,
        country = "India"
    }
}

---@param amount number
---@param currency Currency.Name
---@return number
function export.convert_to_usd(amount, currency)
    return amount / export.currencies[currency].exchange_rate_to_usd
end

---@param amount number
---@param currency Currency.Name
---@return number
function export.convert_from_usd(amount, currency)
    return amount * export.currencies[currency].exchange_rate_to_usd
end

---@param amount number
---@param currency Currency.Name
---@return string
function export.format(amount, currency)
    return string.format("%s%.2f %s", export.currencies[currency].prefix, amount, currency)
end

return export
