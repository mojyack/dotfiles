   call deoplete#enable()
    " No display of the number of competion list
    set shortmess+=c

    " <TAB>: completion.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ deoplete#manual_complete()
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    " <S-TAB>: completion back.
    inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"
    " <C-e>: popup cancel
    inoremap <expr><C-e>       deoplete#cancel_popup()

    call deoplete#custom#source('_', 'matchers', ['matcher_head'])
    call deoplete#custom#source('_', 'converters', [
          \ 'converter_remove_paren',
          \ 'converter_remove_overlap',
          \ 'matcher_length',
          \ 'converter_truncate_abbr',
          \ 'converter_truncate_menu',
          \ 'converter_auto_delimiter',
          \ ])
    call deoplete#custom#option('keyword_patterns', {
          \ '_': '[a-zA-Z_]\k*\(?',
          \ 'tex': '[^\w|\s][a-zA-Z_]\w*',
          \ })
    call deoplete#custom#option('camel_case', v:true)
