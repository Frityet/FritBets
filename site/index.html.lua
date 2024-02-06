---@diagnostic disable: undefined-global

local header = require("components.header")
local betting = require("components.bet-interface")

return html {charset="utf8"} {
    header {title="FritBets"};

    body {
        h1 {class="text-center text-8xl"} "FritBets";

        main {class="mx-auto"} {
            h1 {class="text-center text-5xl"} "Do you think that the girl likes frit?";
            betting;
        };
    };
}
