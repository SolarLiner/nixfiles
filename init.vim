" Configuration adapter for non-home-manager setups
let nvimhome = expand("<sfile>:p:h")
let extrapath = nvimhome . '/home-manager/modules/nvim'
let luainit = extrapath . '/init.lua'

let &runtimepath .= ',' . extrapath
execute "luafile " . luainit
