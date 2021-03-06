" _  _ ____ ____ ___  ___ ____ ____ ____
" |\ | |___ |__/ |  \  |  |__/ |___ |___
" | \| |___ |  \ |__/  |  |  \ |___ |___

    " NERDTree makes navigating the filesystem a treat.

    nnoremap <leader>t :NERDTreeFind<CR>
    " nnoremap <C-s> :NERDTreeMapOpenSplit<CR>
    " nnoremap <C-v> :NERDTreeMapOpenVSplit<CR>

    let g:NERDTreeDirArrowExpandable = '⚀'
    let g:NERDTreeDirArrowCollapsible = '␣'
    let g:NERDTreeQuitOnOpen = 1
    let g:NERDTreeAutoDeleteBuffer = 1
    let g:NERDTreeMinimalUI = 1
    let g:NERDTreeMinimalMenu = 1

    let g:NERDTreeDirArrows = 1
    let g:NERDTreeHijackNetrw = 1
    let g:NERDTreeRemoveFileCmd = 'trash '
    let g:NERDTreeRemoveDirCmd = 'trash '

    augroup nerdtree
        autocmd!
        autocmd StdinReadPre * let s:std_in=1
        " open for directories
        autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) &&
                    \ !exists("s:std_in") | exe 'NERDTree' argv()[0] |
                    \ wincmd p | ene | endif
        " close when last open
        autocmd BufEnter * if (winnr("$") == 1 &&
                    \ exists("b:NERDTreeType") &&
                    \ b:NERDTreeType == "primary") | q | endif
    augroup END

    let g:netrw_dirhistmax = 0        " don't save accidental .netrwhist files
