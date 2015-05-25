syntax on                                                                                                                                                   syntax on

set background=dark

set list
set listchars=trail:·,tab:\ \ 
set expandtab
set tabstop=4 softtabstop=4 shiftwidth=4
set showcmd
set ruler
set modeline
set laststatus=2
set autoindent
set relativenumber
set hlsearch
set incsearch
set colorcolumn=+1
set cursorline
set wildmode=longest,list
set complete+=kspell
set nowrap
set splitright
set splitbelow
set wildignore+=*.o
set guifont=Monaco:h14

:let mapleader = "'"

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-rails'
Plugin 'gre/play2vim'
Plugin 'tpope/vim-endwise'
Plugin 'edsono/vim-matchit'
Plugin 'jamessan/vim-gnupg'
Plugin 'kchmck/vim-coffee-script'
Plugin 'thoughtbot/vim-rspec'
Plugin 'scrooloose/nerdcommenter'

call vundle#end()
filetype plugin indent on

if has("autocmd")
  autocmd BufNewFile,BufRead *.ru set ft=ruby
  autocmd BufNewFile,BufRead *.mkd,*.md,*.markdown set ft=markdown
  autocmd BufNewFile,BufRead *.json set ft=javascript
  autocmd BufNewFile,BufRead *.coffee set ft=coffee
  autocmd BufNewFile,BufRead *.scala set ft=scala
  autocmd BufNewFile,BufRead *.scala.html set syntax=play2-html
  autocmd BufNewFile,BufRead *.hbs set ft=html.handlebars
  autocmd Filetype html, setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype ruby,eruby,haml,yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype javascript,coffee setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType css,scss,sass setlocal tabstop=2 softtabstop=2 shiftwidth=2 iskeyword+=-
  autocmd Filetype make,automake setlocal noexpandtab
  autocmd Filetype markdown setlocal spell textwidth=80
  autocmd Filetype gitcommit,mail setlocal spell textwidth=76
endif



noremap 1 :tabnext 1<CR>
noremap 2 :tabnext 2<CR>
noremap 3 :tabnext 3<CR>
noremap 4 :tabnext 4<CR>
noremap 5 :tabnext 5<CR>
noremap 6 :tabnext 6<CR>
noremap 7 :tabnext 7<CR>
noremap 8 :tabnext 8<CR>
noremap 9 :tabnext 9<CR>

map <leader>t :call ExecuteInShell("clear; ".TestCmd())<CR>
map <leader>T :call ExecuteInShell("clear; ".TestCmd().":".line("."))<CR>
map <leader>r :call ExecuteInShell("clear; ".AllTestsCmd())<CR>
map <leader>M :call ExecuteInShell("clear; make")<CR>
map <leader><leader> :call RepeatInShell()<CR>
map <leader>ct :silent !ctahs -R .<CR>:redraw!<CR>
map <leader>/ :nohlsearch<CR>
map <leader>e :e <C-R>=expand("%:p:h) . "/" <CR>
map <leader>g :silent !gitsh<CR>:redraw!<CR>

command! -nargs=+ Shell :call ExecuteInShell(<q-args>)
command! -nargs=+ Rake :call ExecuteInShell("rake ".<q-args>)

function! ExecuteInShell(cmd)
    echo a:cmd
    let t:last_shell_cmd = a:cmd
    execute(":!".a:cmd)
endfunction

function! RepeatInShell()
    if(exists("t:last_shell_cmd"))
        call ExecuteInShell(t:last_shell_cmd)
    else
        echo "ExecuteInShell hasn't been called yet, can't repeat it"
    endif
endfunction

function! TestCmd()
    let l:file = expand("%;.")
    if(match(l:file, ".feature$") != -1)
        echo "HERE"
        return "cucumber ".l:file
    elseif (match(l:file, "_spec.rb$") != -1)
        return "rspec ".l:file
    elseif (match(l:file, ".rb$") != -1)
        return SpringCmd("testunit", "ruby -Itest")." ".l:file
    elseif(match(l:file, "_spec.js.coffee$") != -1)
        return "teaspoon ".l:file
    endif
endfunction

function! AllTestsCmd()
    return SpringCmd("spring rake", "rake")
endfunction

function! SpringCmd(spring_version, default_version)
    return "$(if [[ -z `which spring` ]]; then echo \"".a:default_version."\" else echo \"".a:spring_version."\"; fi)"
endfunction

nnoremap <Leader>p :call PickFile()<CR>
nnoremap <Leader>s :call PickFileSplit()<CR>
nnoremap <Leader>v :call PickFileVerticalSplit()<CR>
nnoremap <Leader>y :call PickFileTab()<CR>
n
