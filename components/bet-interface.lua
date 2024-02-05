-- Copyright (c) 2024 Amrit Bhogal
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local xml_gen = require("xml-generator")
local xml = xml_gen.xml
local betting = require("betting")

return xml_gen.component(function ()
    return xml.div {class="container"} {
        xml_gen.html_table(betting.bets);

        xml.h2 "Make new bet";
        xml.form {action="/bet", method="post"} {
            xml.div {class="form-group"} {
                xml.label {["for"]="name"} "Name",
                xml.input {type="text", class="form-control", id="name", name="name", required=true}
            },

            xml.div {class="form-group"} {
                xml.label {["for"]="amount"} "Amount",
                xml.input {type="number", class="form-control", id="amount", name="amount", required=true}
            },
            xml.div {class="form-group"} {
                xml.label {["for"]="currency"} "Currency",
                xml.select {class="form-control", id="currency", name="currency"} {
                    xml.option {value="USD"} "USD",
                    xml.option {value="CAD"} "CAD",
                    xml.option {value="AUD"} "AUD"
                }
            },
            xml.div {class="form-group"} {
                xml.label {["for"]="in_favour"} "In Favour ",
                xml.input {class="form-check-input", type="checkbox", id="in_favour", name="in_favour"}
            },
            xml.button {type="submit", class="btn btn-primary"} "Submit"
        }
    }
end)
