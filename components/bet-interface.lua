-- Copyright (c) 2024 Amrit Bhogal
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local xml_gen = require("xml-generator")
local xml = xml_gen.xml
local tablex = require("pl.tablex")
local betting = require("betting")

local yield = coroutine.yield

return xml_gen.component(function ()
    return xml.div {class="max-w-4xl mx-auto"} {
        xml.table {class="table-auto w-full text-left shadow-lg"} {
            function ()
                for name, bet in pairs(betting.bets) do
                    yield (xml.table {class="mb-4"} {
                        xml.tr {
                            xml.td {class="font-bold"} "Gambler";

                            xml.td {class="text-right", name}
                        };

                        xml.tr {
                            xml.td {class="font-bold"} "Amount";
                            xml.td {class="text-right", string.format("$%.2f", bet.amount)}
                        };

                        xml.tr {
                            xml.td {class="font-bold"} "In Favour?";
                            xml.td {class="text-right", bet.in_favour and "Yes" or "No"}
                        };

                        xml.tr {
                            xml.td {class="font-bold"} "Comment";
                            xml.td {class="text-right", bet.comment or ""}
                        };
                    })

                    yield(xml.tr {xml.td {colspan=2, class="py-2", xml.hr {class="border-t"}}})
                end



                yield(xml.div {class="flex justify-between"} {
                    function ()
                        local for_total = betting.get_total(function(bet) return bet.in_favour end)
                        local against_total = betting.get_total(function(bet) return not bet.in_favour end)
                        local total = betting.get_total()
                        yield(xml.div {class="font-bold"} { "$USD for: ", string.format("$%.2f (%.2f%%)", for_total, for_total / total * 100) })
                        yield(xml.div {class="font-bold text-2xl"} { "$USD total: ", string.format("$%.2f", total) })
                        yield(xml.div {class="font-bold"} { "$USD against: ", string.format("$%.2f (%.2f%%)", against_total, against_total / total * 100) })
                    end
                })

                local percent_for = 0

                for _, bet in pairs(betting.bets) do
                    if bet.in_favour then
                        percent_for = percent_for + 1
                    end
                end

                percent_for = percent_for / #tablex.keys(betting.bets) * 100

                yield(xml.div {class="flex justify-between"} {
                    function ()
                        yield(xml.div {class="font-bold"} { "Percent for: ", string.format("%.2f%%", percent_for) })
                        yield(xml.div {class="font-bold"} { "Percent against: ", string.format("%.2f%%", 100 - percent_for) })
                    end
                })
            end;
        };
        xml.br;
        xml.h2 {class="text-3xl font-semibold mt-5 mb-3", "Make new bet"};
        xml.form {action="/bet", method="post", class="space-y-4"} {
            xml.div {class="flex flex-col"} {
                xml.label {["for"]="name", class="font-bold mb-1"}, "Name",
                xml.input {type="text", class="form-input mt-1 block w-full", id="name", name="name", required=true}
            },

            xml.div {class="flex flex-col"} {
                xml.label {["for"]="amount", class="font-bold mb-1"}, "Amount (in USD)";
                xml.input {type="number", class="form-input mt-1 block w-full", id="amount", name="amount", required=true, min=5, max=1000}
            },

            xml.div {class="flex flex-col"} {
                xml.label {["for"]="comment", class="font-bold mb-1"}, "Comment";
                xml.input {type="text", class="form-input mt-1 block w-full", id="comment", name="comment"}
            };

            xml.div {class="flex items-center mt-2"} {
                xml.label {["for"]="in_favour", class="font-bold mr-2"}, "In Favour? ";
                xml.input {class="form-checkbox", type="checkbox", id="in_favour", name="in_favour"}
            },
            xml.button {type="submit", class="mt-4 px-4 py-2 bg-blue-500 text-white font-bold rounded hover:bg-blue-700"} "Submit" -- Button styling
        }
    }
end)
