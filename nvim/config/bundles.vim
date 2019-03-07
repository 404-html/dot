"
"
"    ee   e e  eeeeeee eeeee e     e   e eeeee
"    88   8 8  8  8  8 8   8 8     8   8 8   8
"    88  e8 8e 8e 8  8 8eee8 8e    8e  8 8e
"     8  8  88 88 8  8 88    88    88  8 88 "8
"     8ee8  88 88 8  8 88    88eee 88ee8 88ee8
"
"    https://github.com/junegunn/vim-plug

"    🧞 krry

" vim-plug autoconfig if not already installed
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
      silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      augroup vimplugger
          autocmd!
          autocmd VimEnter * PlugInstall --sync | nested source $MYVIMRC
      augroup END
    endif

" Setup
    scriptencoding utf-8
    set background=dark                   " for colorschemes
    filetype off                          " must precede vimplug
    call plug#begin('~/.local/share/nvim/bundles') " let's get ready to BUNDLE!

" Completion
    Plug 'ervandew/supertab'              " tabtastic completion
    if !has('nvim')
        Plug 'roxma/nvim-yarp'            " supports deoplete for neovim
        Plug 'roxma/vim-hug-neovim-rpc'   " supports deoplete for neovim
    endif
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
    Plug 'deoplete-plugins/deoplete-jedi' " python lang serv completion
    Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
    Plug 'Shougo/neosnippet.vim'          " snippet support for Deoplete
    Plug 'Shougo/neosnippet-snippets'     " snippets for neosnippets
    Plug 'mattn/emmet-vim'                " HTML/CSS hackery
    Plug 'heracek/HTML-AutoCloseTag'      " Never close a tag again

" Git / Versioning
    Plug 'tpope/vim-fugitive'          " git slicker
    Plug 'airblade/vim-gitgutter'      " mark lines with changes
    Plug 'Xuyuanp/nerdtree-git-plugin' " NERDtree shows git statuses

" File / Project Navigation
    Plug 'Shougo/denite.nvim'          " fuzzy search for anything
    Plug 'scrooloose/nerdtree'         " filesystem navigation
    Plug 'vim-scripts/mru.vim'         " Most Recently Used files viewer
    Plug 'bogado/file-line'            " Jump to a line in a file!
    Plug 'mhinz/vim-startify'          " start screen
    Plug 'farmergreg/vim-lastplace'    " return to the last place
    Plug 'xolox/vim-misc'              " supports vim-session
    Plug 'tpope/vim-obsession'             " slicker sessions
    Plug 'vimwiki/vimwiki'             " linkable, publishable notes

" Language / syntax
    Plug 'w0rp/ale'                      " asynchronous lint engine
    Plug 'sheerun/vim-polyglot'          " on-demand language packs
    Plug 'godlygeek/tabular'             " table-maker for markdown
    Plug 'plasticboy/vim-markdown'       " Improved markdown support
    Plug 'iamcco/markdown-preview.nvim'  " preview markdown en el browsero
    Plug 'fatih/vim-go'                  " Go tools

" Rust
    Plug 'rust-lang/rust.vim'            " Syntastic, Tagbar, rustfmt integration
    Plug 'racer-rust/vim-racer'          " completions for rust
    Plug 'sebastianmarkow/deoplete-rust' " completions from racer to deoplete

" Langs
    Plug 'tranvansang/octave.vim'         " octave syntax/indent support

" Magic tricks
    Plug 'tpope/vim-sensible'             " sensible defaults
    Plug 'tpope/vim-repeat'               " ( for {surrounding} 'text' )
    Plug 'tpope/vim-surround'             " ( for {surrounding} 'text' )
    Plug 'Raimondi/delimitMate'           " surround for insert mode
    Plug 'Yggdroot/indentLine'            " shows vertical lines for indents
    Plug 'easymotion/vim-easymotion'      " show motions in realtime
    Plug 'scrooloose/nerdcommenter'       " comment ease and grace
    Plug 'tpope/vim-commentary'           " simpler commenting
    Plug 'gcmt/wildfire.vim'             " growing text object selection
    Plug 'svermeulen/vim-easyclip'        " makes sense of copy-paste
    Plug 'terryma/vim-multiple-cursors'   " Sublime multi-cursor action
    Plug 'christoomey/vim-tmux-navigator' " move seamlessly from vim to tmux

" Hygiene
    Plug 'bronson/vim-trailing-whitespace' " FixWhitespace, highlight it red
    Plug 'valloric/MatchTagAlways'         " highlight matching close tag
    Plug 'reedes/vim-wordy'                " highlight bad word usage

" Cosmetics
    Plug 'tomasr/molokai'                  " high-contrast theme
    Plug 'romainl/Apprentice'              " low-contrast theme
    Plug 'NLKNguyen/papercolor-theme'      " inspired by material design
    Plug 'fadein/vim-FIGlet'               " for headers
    Plug 'itchyny/lightline.vim'           " lightweight statusline
    Plug 'junegunn/vim-easy-align'         " easy vertical alignments
    Plug 'junegunn/goyo.vim'               " distraction-free writing in vim
    Plug 'curiousleo/vim-zenroom2'         " iA Writer-like; deps on Goyo
    Plug 'nathanaelkane/vim-indent-guides' " nice-lookin indent signifiers

" Tags / Tagging
    Plug 'majutsushi/tagbar'          " puts ctags in a rightside bar
    Plug 'krry/vim-easytags'          " tag generation and highlighting
    " made a patched fork since repo is unmaintained
    " original repo 'xolox/vim-easytags'

call plug#end()                       " leaving Vimplugville
