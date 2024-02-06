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
        xml.link {
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css",
            rel="stylesheet",
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN",
            crossorigin="anonymous"
        };
        xml.script {
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js",
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL",
            crossorigin="anonymous"
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

        xml.script {
            src="https://cdn.plot.ly/plotly-2.27.0.min.js",
            charset="utf-8"
        };

        kids;

        luajs;
    }
end)
