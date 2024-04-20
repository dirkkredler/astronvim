vim.cmd [[
    set guicursor=n-v-c:block,i-ci-ve:hor20blinkon250,r-cr:ver20blinkon250,o:hor50
    \,sm:block-blinkwait175-blinkoff150-blinkon175
]]

---@type LazySpec
return {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
        options = {
            opt = {
                shiftwidth = 4,
                tabstop = 4,
                wrap = true,
                spell = true,
                spelllang = { "en", "de" },
            },
        },
    },
}
