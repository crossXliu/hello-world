" ----------------------------------------------------
"                      Basic Conf
" ----------------------------------------------------
" plugins linked to .config/nvim/lua/plugins.lua
lua require('plugins')
lua require('nvim-tree.setting')
" lua require('cockey.init')
let g:mapleader = "," " for leader kermap
" colorthemes
set t_Co=256 " 256 colors terminal
colorscheme gruvbox " enable gruvbox
let g:airline#extensions#tabline#enabled = 1 " enable tabline
let g:airline_theme='gruvbox'
" line num
set nu
set relativenumber
set cc=80
" ----------------------------------------------------
"                    Native tab config
" ----------------------------------------------------
set ts=4
set sts=4
set shiftwidth=4
set expandtab

" ----------------------------------------------------
"                    Native Search Conf
" ----------------------------------------------------
set incsearch
set hls
noremap <leader>6 :nohlsearch<CR>

" ----------------------------------------------------
"                      QuickFix Conf
" ----------------------------------------------------
" noremap <F4> :cn<CR>
" noremap <F3> :cp<CR>
" noremap <leader>3 :copen<CR>
" noremap <leader>4 :ccl<CR>
function ToggleQuickFix()
	let winlist = getwininfo()
	for win in winlist
		if win.quickfix == 1 | :ccl | return | endif
	endfor
	:copen | :exec "normal! \<c-w>j"
endfunction

let g:mouse_enable = 1
function! ToggleMouse()
    if g:mouse_enable
        set mouse=
        set clipboard=
        let g:mouse_enable = 0
        echo "mouse disable"
    else
        set mouse=nvi
        set clipboard+=unnamedplus
        let g:mouse_enable = 1
        echo "mouse enable"
    endif
endfunction

nnoremap <silent> <leader>m :call ToggleMouse()<CR>

" noremap <leader>1 :exec ToggleQuickFix()<CR>

" ----------------------------------------------------
"                      Buffers Conf
" ----------------------------------------------------
noremap <M-p> :bp<CR>
noremap <M-n> :bn<CR>

" ----------------------------------------------------
"                      LeaderF Conf
" ----------------------------------------------------
let g:Lf_HideHelp = 1 " don't show the help in normal mode
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_WindowPosition = 'popup' " popup mode
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
let g:Lf_ShortcutF = "<C-P>" " menu to nevigate files
" search in current file
noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e '%s' ", expand("<cword>"))<CR>
" search in all files
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e '%s'", expand("<cword>"))<CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
" reuse rg results before
noremap go :<C-U>Leaderf! rg --recall<CR>
" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fu :Leaderf gtags --update<CR>
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
" others functions
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
" function list
" noremap <leader>2 :<C-U><C-R>=printf("Leaderf function")<CR><CR>

" ----------------------------------------------------
"                      autocomplete Conf
" ----------------------------------------------------
" noremap <leader>cs :YcmCompleter GoTo<CR>zz
" noremap <leader>cr :YcmCompleter GoToReferences<CR>
" noremap <leader>cf :<C-U><C-R>=printf("YcmCompleter GoToSymbol %s", expand("<cword>"))<CR>
" noremap <leader>cc :YcmCompleter GoToCallers<CR>
" noremap <leader>ct :YcmCompleter GetType<CR>
" noremap <leader>ct :YcmCompleter GetParent<CR>
" noremap <leader>fm :YcmCompleter Format<CR>
" noremap <leader>fx :YcmCompleter FixIt<CR>
" 
" let g:ycm_semantic_triggers = {
" 			\ 'c,cpp': ['re!\w{2}'],
" 			\ }

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)


nmap <silent> <leader>cs <Plug>(coc-definition)
nmap <silent> <leader>cr <Plug>(coc-references)
xnoremap <leader>fm <Plug>(coc-format-selected)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>fx  <Plug>(coc-fix-current)
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <leader>d  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <leader>2  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <F4>  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <F3>  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <leader>3  :<C-u>CocListResume<CR>

nnoremap <space>y :<C-u>CocList -A --normal yank<cr>
" ----------------------------------------------------
"                      Nvim Tree Conf
" ----------------------------------------------------
noremap <leader>1 :NvimTreeOpen<CR>
