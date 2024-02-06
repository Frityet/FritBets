-- Copyright (c) 2024 Amrit Bhogal
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

---<head> with bootstrap dependencies.

local xml_gen = require("xml-generator")
local luajs = require("components.luajs")
local xml = xml_gen.xml

return xml_gen.component(function (args, kids)
    local title = assert(args.title) --[[@as string]]

    return xml.head {
        xml.title {title};
        xml.meta {
            name="viewport",
            content="width=device-width, initial-scale=1"
        };

        --nice looking tables
        xml_gen.style {
            ["table"] = {
                ["width"] = "100%",
                ["margin-bottom"] = "1rem",
                ["color"] = "#212529"
            },
            ["th"] = {
                ["padding"] = "0.75rem",
                ["vertical-align"] = "top",
                ["border-top"] = "1px solid #dee2e6"
            },
            ["td"] = {
                ["padding"] = "0.75rem",
                ["vertical-align"] = "top",
                ["border-top"] = "1px solid #dee2e6"
            },
            ["thead"] = {
                ["background-color"] = "#e9ecef",
                ["color"] = "#495057"
            }
        };

        xml_gen.style {
            ["#in_favour"] = {
                ["display"] = "none"
            },
            [".toggle-btn"] = {
                ["user-select"] = "none"
            },
            ["#in_favour:not(:checked) + .toggle-btn"] = {
                ["background-color"] = "#ff4d4d",
                ["color"] = "white"
            },
            ["#in_favour:not(:checked) + .toggle-btn:after"] = {
                ["content"] = "'Against'",
            },
            ["#in_favour:checked + .toggle-btn"] = {
                ["background-color"] = "#4CAF50",
                ["color"] = "white"
            },
            ["#in_favour:checked + .toggle-btn:after"] = {
                ["content"] = "'In favour'",
            },
            [".toggle-btn:hover"] = {
                ["opacity"] = "0.9"
            }
        };

        xml.script {src="https://cdn.tailwindcss.com"};
        kids;
        luajs;
    }
end)
