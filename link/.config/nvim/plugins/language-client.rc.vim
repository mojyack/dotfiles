set hidden
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
        \ 'c': ['clangd'],
        \ 'cpp': ['clangd', '--compile-commands-dir=debug', '--header-insertion=never'],
\}
