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
    return xml.div {class="container"} {
        xml.table {
            function ()
                for name, bet in pairs(betting.bets) do
                    yield (xml.table {
                        xml.tr {
                            xml.td "Gambler";
                            xml.td {name}
                        };

                        xml.tr {
                            xml.td "Amount";
                            xml.td {string.format("$%.2f", bet.amount)}
                        };

                        xml.tr {
                            xml.td "In Favour?";
                            xml.td {bet.in_favour and "Yes" or "No"}
                        };

                        xml.tr {
                            xml.td "Comment";
                            xml.td {bet.comment or ""}
                        };
                    })

                    yield(xml.tr {xml.td {colspan=2, xml.hr}})
                end


                yield(xml.tr {
                    xml.td "Total in USD: ";
                    xml.td {string.format("$%.2f", betting.get_total())};
                    xml.br;
                });



                local percent_for = 0

                for _, bet in pairs(betting.bets) do
                    if bet.in_favour then
                        percent_for = percent_for + 1
                    end
                end

                percent_for = percent_for / #tablex.keys(betting.bets) * 100

                yield(xml.tr {
                    xml.td "Percent in Favour: ";
                    xml.td {string.format("%.2f%%", percent_for)}
                });
            end;
        };
        xml.br;
        xml.h2 "Make new bet";
        xml.form {action="/bet", method="post"} {
            xml.div {class="form-group"} {
                xml.label {["for"]="name"} "Name",
                xml.input {type="text", class="form-control", id="name", name="name", required=true}
            },

            xml.div {class="form-group"} {
                xml.label {["for"]="amount"} "Amount (in USD)";
                xml.input {type="number", class="form-control", id="amount", name="amount", required=true, min=5, max=1000}
            },

            xml.div {class="form-group"} {
                xml.label {["for"]="comment"} "Comment";
                xml.input {type="text", class="form-control", id="comment", name="comment"}
            };

            xml.div {class="form-group"} {
                xml.label {["for"]="in_favour"} "In Favour? ";
                xml.input {class="form-check-input", type="checkbox", id="in_favour", name="in_favour"}
            },
            xml.button {type="submit", class="btn btn-primary"} "Submit"
        }
    }
end)
