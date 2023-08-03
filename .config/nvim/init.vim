" =================================================================================================
" Common config
let mapleader = ","
inoremap kj <ESC>

" Plug config
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin()
" use normal easymotion when in VIM mode
Plug 'easymotion/vim-easymotion', Cond(!exists('g:vscode'))
" use VSCode easymotion when in VSCode mode

Plug 'tpope/vim-surround'
Plug 'terryma/vim-expand-region'
Plug 'preservim/nerdcommenter', Cond(!exists('g:vscode'))
call plug#end()
" =================================================================================================


" =================================================================================================
if exists('g:vscode')
    " VSCode extension

    set nobackup

    " Better Navigation
    nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
    xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
    nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
    xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
    nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
    xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
    nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
    xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>

    nnoremap <silent> <space> :call VSCodeNotify('whichkey.show')<CR>
    xnoremap <silent> <space> :call VSCodeNotify('whichkey.show')<CR>

    nnoremap <silent> <Leader>xm <Cmd>call VSCodeNotify('workbench.action.showCommands')<CR>
    xnoremap <silent> <Leader>xm <Cmd>call VSCodeNotify('workbench.action.showCommands')<CR>

    nmap <Leader>ci <Plug>VSCodeCommentaryLine
    xmap <Leader>ci <Plug>VSCodeCommentary
    omap <Leader>ci <Plug>VSCodeCommentary

    nnoremap <Leader>qq <Cmd>call VSCodeNotify('workbench.action.findInFiles', {'query': expand('<cword>')})<CR>
    xnoremap <Leader>qq <Cmd>call VSCodeNotify('workbench.action.findInFiles', 0)<CR>

    nnoremap <Leader>ss <Cmd>call VSCodeNotify('actions.find', {'query': expand('<cword>')})<CR>
    xnoremap <Leader>ss <Cmd>call VSCodeNotify('actions.find', 0)<CR>

    xnoremap <Leader>aa <Cmd>call VSCodeNotify('editor.action.clipboardCopyAction', 0)<CR>
    xnoremap <Leader>va <Cmd>call VSCodeNotify('git.stageSelectedRanges', 0)<CR>
    xnoremap <Leader>vk <Cmd>call VSCodeNotify('git.unstageSelectedRanges', 0)<CR>

    nnoremap <Leader>sc <Cmd>call VSCodeNotify('workbench.action.files.newUntitledFile')<CR><Cmd>call VSCodeNotify('workbench.action.editor.changeLanguageMode')<CR>
    nnoremap <Leader>xb <Cmd>call VSCodeNotify('workbench.action.showAllEditorsByMostRecentlyUsed')<CR>
    nnoremap <Leader>fp <Cmd>call VSCodeNotify('workbench.action.files.copyPathOfActiveFile')<CR>
    nnoremap <Leader>fn <Cmd>call VSCodeNotify('copyRelativeFilePath')<CR>
    nnoremap <Leader>tp <Cmd>call VSCodeNotify('workbench.action.togglePanel')<CR>
    nnoremap <Leader>ta <Cmd>call VSCodeNotify('workbench.action.toggleActivityBarVisibility')<CR>
    nnoremap <Leader>tb <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
    nnoremap <Leader>xs <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>
    nnoremap <Leader>xf <Cmd>call VSCodeNotify('workbench.action.files.openFile')<CR>
    nnoremap <Leader>xk <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
    nnoremap <Leader>rr <Cmd>call VSCodeNotify('workbench.action.openRecent')<CR>
    nnoremap <Leader>kk <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
    nnoremap <Leader>ii <Cmd>call VSCodeNotify('workbench.action.gotoSymbol')<CR>
    nnoremap <Leader>x0 <Cmd>call VSCodeNotify('workbench.action.closeGroup')<CR>
    nnoremap <Leader>x1 <Cmd>call VSCodeNotify('workbench.action.editorLayoutSingle')<CR>
    nnoremap <Leader>x2 <Cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>
    nnoremap <Leader>x3 <Cmd>call VSCodeNotify('workbench.action.splitEditorRight')<CR>
    nnoremap <Leader>x4 <Cmd>call VSCodeNotify('workbench.action.editorLayoutTwoByTwoGrid')<CR>
    nnoremap <Leader>xz <Cmd>call VSCodeNotify('workbench.action.terminal.focus')<CR>
    nnoremap <Leader>tfm <Cmd>call VSCodeNotify('workbench.action.toggleZenMode')<CR>
    nnoremap <Leader>wq <Cmd>call VSCodeNotify('workbench.action.files.save')<CR><Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
    nnoremap <Leader>pe <Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>
    nnoremap <Leader>ne <Cmd>call VSCodeNotify('editor.action.marker.next')<CR>
    nnoremap <Leader>va <Cmd>call VSCodeNotify('git.stage')<CR>
    nnoremap <Leader>vk <Cmd>call VSCodeNotify('git.unstage')<CR>
else
    " ordinary Neovim
    set mouse=a
    " Keybindings
    nnoremap ; <Plug>(easymotion-prefix)
    xnoremap ; <Plug>(easymotion-prefix)
endif

"if executable('im-select-mspy.exe')
  "augroup ImSelectSetup
    "autocmd!
    "autocmd VimEnter * :silent !im-select-mspy.exe 英语模式
    "autocmd InsertLeave * :silent !im-select-mspy.exe 英语模式
  "augroup END
"endif
"if executable('im-select-mspy.exe')
  "augroup ImSelectSetup
    "autocmd!
    "autocmd VimEnter * let g:input_mode = system('im-select-mspy.exe') | silent !im-select-mspy.exe 英语模式
    "autocmd InsertEnter * execute 'silent !im-select-mspy.exe' g:input_mode
    "autocmd InsertLeave * let g:input_mode = system('im-select-mspy.exe') | silent !im-select-mspy.exe 英语模式
    "autocmd VimLeave * execute 'silent !im-select-mspy.exe' g:input_mode
  "augroup END
"endif


" clipboard setting base on: https://neovim.io/doc/user/provider.html#provider-clipboard
set clipboard+=unnamedplus
if executable('win32yank.exe')
let g:clipboard = {
    \ 'name': 'WslClipboard',
    \   'copy': {
    \      '+': 'win32yank.exe -i --crlf',
    \      '*': 'win32yank.exe -i --crlf',
    \    },
    \   'paste': {
    \      '+': 'win32yank.exe -o --lf',
    \      '*': 'win32yank.exe -o --lf',
    \   },
    \   'cache_enabled': 0,
    \ }
elseif
let g:clipboard = {
    \ 'name': 'WslClipboard',
    \   'copy': {
    \      '+': 'clip.exe',
    \      '*': 'clip.exe',
    \    },
    \   'paste': {
    \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    \   },
    \   'cache_enabled': 0,
    \ }
endif

" Expand
nnoremap <Leader>xx <Plug>(expand_region_expand)
xnoremap xx <Plug>(expand_region_expand)
nnoremap <Leader>zz <Plug>(expand_region_expand)
xnoremap zz <Plug>(expand_region_shrink)
" =================================================================================================
