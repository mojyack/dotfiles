let g:clang_format#style_options = { 
			\ "BasedOnStyle": "LLVM", 
			\ "ColumnLimit": "0", 
			\ "BreakBeforeBraces": "Attach",
			\ "SpaceBeforeParens": "Never", 
			\ "IndentWidth": "4", 
			\ "UseTab": "Never", 
			\ "PointerAlignment": "Left", 
			\ "AllowShortIfStatementsOnASingleLine": "true",
			\ "AlignConsecutiveAssignments": "true",
			\ "AlignConsecutiveDeclarations": "true"
			\ }

function SetLSPShortcuts()
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

augroup LSP
  autocmd!
  autocmd FileType cpp,c call SetLSPShortcuts()
augroup END
