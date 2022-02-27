set hidden
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
        \ 'c': ['clangd', '--compile-commands-dir=debug', '--header-insertion=never'],
        \ 'cpp': ['clangd', '--compile-commands-dir=debug', '--header-insertion=never'],
        \ 'rust': ['rustup', 'run', 'stable', 'rls'],
\}

function SetLSPShortcuts_cpp()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition({"gotoCmd": "tabedit"})<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :ClangFormat<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

function SetLSPShortcuts_rust()
  nnoremap <leader>lh :call LanguageClient_textDocument_hover()<CR>
  nnoremap <leader>ld :call LanguageClient_textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient_textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient_textDocument_formatting()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c call SetLSPShortcuts_cpp()
  autocmd FileType rust call SetLSPShortcuts_rust()
augroup END
