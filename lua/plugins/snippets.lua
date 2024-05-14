return {
    {
        'L3MON4D3/LuaSnip',
        lazy = true,
        version = "v2.*",
        keys = {
            { '<Leader>se', ':edit! ~/.config/nvim/lua/plugins/snippets.lua<CR>' },
        },
        config = function()
            local ls = require("luasnip")
            -- some shorthands...
            local s = ls.snippet
            local sn = ls.snippet_node
            local t = ls.text_node
            local i = ls.insert_node
            local f = ls.function_node
            local c = ls.choice_node
            local d = ls.dynamic_node
            local r = ls.restore_node
            local l = require("luasnip.extras").lambda
            local rep = require("luasnip.extras").rep
            local p = require("luasnip.extras").partial
            local m = require("luasnip.extras").match
            local n = require("luasnip.extras").nonempty
            local dl = require("luasnip.extras").dynamic_lambda
            local fmt = require("luasnip.extras.fmt").fmt
            local fmta = require("luasnip.extras.fmt").fmta
            local types = require("luasnip.util.types")
            local conds = require("luasnip.extras.conditions")
            local conds_expand = require("luasnip.extras.conditions.expand")

            -- Somewhere in your Neovim startup, e.g. init.lua
            ls.config.set_config({
                -- Setting LuaSnip config

                -- Enable autotriggered snippets
                enable_autosnippets = true,

                -- Use Tab (or some other key if you prefer) to trigger visual selection
                -- store_selection_keys = "<Tab>",
            })

            vim.keymap.set("i", "<c-l>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end)

            local function replace_keycodes(c)
                return vim.api.nvim_replace_termcodes(c, true, true, true)
            end

            -- function _G.tab_binding()
            --     if ls.expand_or_jumpable() then
            --         return replace_keycodes('<Plug>luasnip-expand-or-jump')
            --     else
            --         return replace_keycodes('<Plug>(Tabout)')
            --     end
            -- end
            --
            -- function _G.s_tab_binding()
            --     if ls.jumpable(-1) then
            --         return replace_keycodes('<Plug>luasnip-jump-prev')
            --     else
            --         return replace_keycodes('<Plug>(TaboutBack)')
            --     end
            -- end

            -- vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_binding()', { expr = true })
            -- vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_binding()', { expr = true })

            require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets/" })

            -- args is a table, where 1 is the text in Placeholder 1, 2 the text in
            -- placeholder 2,...
            local function copy(args)
                return args[1]
            end

            ls.add_snippets("rust", {
                s("pre", {
                    t("use crate::prelude::*;")
                }),
                s("#", {
                    t("#["),
                    i(0),
                    t("]"),
                }),
                s("der", {
                    t("#[derive("),
                    i(0),
                    t(")]")
                }),
                s("mod", {
                    t("mod "),
                    i(0),
                    t(";"),
                }),
                s("let", {
                    c(1, {
                        sn(nil, {
                            t("let "),
                            i(1)
                        }),
                        sn(nil, {
                            t("let mut "),
                            i(1)
                        })
                    }),
                    t(" = "),
                    i(0),
                    t(";"),
                }),
                s("struct", {
                    c(1, {
                        t({ "#[derive(Debug, Clone)]", "" }),
                        t({ "#[derive(Debug, Clone, Serialize, Deserialize)]", "" }),
                    }),
                    c(2, {
                        sn(nil, {
                            t({ "struct " }),
                            i(1)
                        }),
                        sn(nil, {
                            t({ "pub struct " }),
                            i(1)
                        })
                    }),
                    t({ " {", "\t" }),
                    i(0),
                    t({ "", "}" }),
                }),
                s("enum", {
                    c(1, {
                        t({ "#[derive(Debug, Clone)]", "" }),
                        t({ "#[derive(Debug, Clone, Serialize, Deserialize)]", "" }),
                    }),
                    c(2, {
                        sn(nil, {
                            t({ "enum " }),
                            i(1)
                        }),
                        sn(nil, {
                            t({ "pub enum " }),
                            i(1)
                        })
                    }),
                    t({ " {", "\t" }),
                    i(0),
                    t({ "", "}" }),
                }),
                s("if", {
                    c(1, {
                        sn(nil, {
                            t({ "if " }),
                            i(1),
                        }),
                        sn(nil, {
                            t({ "if let Some(" }),
                            i(1),
                            t({ ") = " }),
                            i(2),
                        })
                    }),
                    t({ " {", "\t" }),
                    i(0),
                    t({ "", "}" }),
                }),
                s("fn", {
                    c(1, {
                        t("fn "),
                        t("pub fn "),
                        t("async fn "),
                        t("pub async fn "),
                    }),
                    i(2),
                    t("("),
                    i(3),
                    t(")"),
                    c(4, {
                        t({ " {", "\t" }),
                        sn(nil, {
                            t(" -> "),
                            i(1),
                            t({ " {", "\t" }),
                        })
                    }),
                    i(0),
                    t({ "", "\ttodo!()", "" }),
                    t("}"),
                }),
                s("match", {
                    t("match "),
                    c(1, {
                        sn(nil, {
                            i(1),
                            t({ " {", "" }),
                            t({ "\tOk(_) => {todo!()}", "\t" }),
                            t("Err(_) => {todo!()}"),
                        }),
                        sn(nil, {
                            i(1),
                            t({ " {", "" }),
                            t({ "\tSome(_) => {todo!()}", "\t" }),
                            t("None => {todo!()}"),
                        }),
                        sn(nil, {
                            i(1),
                            t({ " {", "" }),
                            t("\t_ => {todo!()}"),
                        })
                    }),
                    t({ "", "}" }),
                    i(0),
                }),
                s("?test", {
                    t({ "#[cfg(test)]", "" }),
                    t({ "mod tests {", "", "" }),
                    t({ "\tuse super::*;", "", "" }),
                    t({ "\t#[test]", "" }),
                    t({ "\tfn " }),
                    i(1),
                    t({ "() {", "\t\t" }),
                    i(0),
                    t({ "", "\t\tassert_eq!(true, true);", "" }),
                    t({ "\t}", "" }),
                    t({ "}" }),
                })
            }, {
                key = "rust",
            })
        end,
    },
}
