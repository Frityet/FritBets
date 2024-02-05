---@diagnostic disable: undefined-global

local bootstrap_head = require("components.bootstrap-head")
local betting = require("components.bet-interface")

return html {charset="utf8"} {
    bootstrap_head {title="Hello, World!"} {

    };

    body {
        h1 {class="text-center"} "FritBets";

        main {class="container"} {
            h1 "Do you think that the girl likes frit?";
            betting;
        };
    };
}
