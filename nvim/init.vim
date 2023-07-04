" ----------------------------------------------------
"                      Basic Conf
" ----------------------------------------------------
" plugins linked to .config/nvim/lua/plugins.lua
lua require('plugins')
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
"                    Native Search Conf
" ----------------------------------------------------
set incsearch
set hls
noremap <leader>6 :nohlsearch<CR>

" ----------------------------------------------------
"                      QuickFix Conf
" ----------------------------------------------------
noremap <F4> :cn<CR>
noremap <F3> :cp<CR>
noremap <leader>3 :copen<CR>
noremap <leader>4 :ccl<CR>
function ToggleQuickFix()
	let winlist = getwininfo()
	for win in winlist
		if win.quickfix == 1 | :ccl | return | endif
	endfor
	:copen | :exec "normal! \<c-w>j"
endfunction

noremap <leader>1 :exec ToggleQuickFix()<CR>

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
noremap <leader>2 :<C-U><C-R>=printf("Leaderf function")<CR><CR>

" ----------------------------------------------------
"                      Ycm Conf
" ----------------------------------------------------
noremap <leader>cs :YcmCompleter GoTo<CR>zz
noremap <leader>cr :YcmCompleter GoToReferences<CR>
noremap <leader>cf :<C-U><C-R>=printf("YcmCompleter GoToSymbol %s", expand("<cword>"))<CR>
noremap <leader>cc :YcmCompleter GoToCallers<CR>
noremap <leader>ct :YcmCompleter GetType<CR>
noremap <leader>ct :YcmCompleter GetParent<CR>
noremap <leader>fm :YcmCompleter Format<CR>
