"=========================================================
" File:        browser-reload-linux.vim
" Author:      lordm <lordm2005[at]gmail.com>
" Author:      Stefan Koch <programming@stefan-koch.name>
" Last Change: 27-Feb-2013.
" Version:     1.1
" WebPage:     https://github.com/lordm/vim-browser-reload-linux
" License:     BSD
"==========================================================
"

if !exists('g:returnAppFlag')
    let g:returnAppFlag = 1
endif

if !exists('g:browserUseWindowTitle')
    let g:browserUseWindowTitle = 0
endif

function! s:ReloadBrowser(browser)
    let l:currentWindow = substitute(system('xdotool getactivewindow'), "\n", "", "")

    let l:activateCommand = " windowactivate "
    if ( a:browser == "Chrome" || a:browser == "Chromium-browser" )
        let l:activateCommand = ""
    endif

    if (g:browserUseWindowTitle == 1)
        exec "silent ! xdotool search --onlyvisible --class " . a:browser . l:activateCommand . " key --clearmodifiers ctrl+r"
    else
        exec "silent ! xdotool search --onlyvisible --name " . a:browser . l:activateCommand . " key --clearmodifiers ctrl+r"
    endif

    if g:returnAppFlag
        exec "silent ! xdotool windowactivate " . l:currentWindow
    endif
    redraw!
endfunction

" Google Chrome
command! -bar ChromeReload call s:ReloadBrowser("Chrome")
command! -bar ChromeReloadStart ChromeReloadStop | autocmd BufWritePost <buffer> ChromeReload
command! -bar ChromeReloadStop autocmd! BufWritePost <buffer>

" Chromium
if (g:browserUseWindowTitle == 0) " Classname and Title are different
    command! -bar ChromiumReload call s:ReloadBrowser("Chromium-browser")
else
    command! -bar ChromiumReload call s:ReloadBrowser("Chromium")
endif
command! -bar ChromiumReloadStart ChromiumReloadStop | autocmd BufWritePost <buffer> ChromiumReload
command! -bar ChromiumReloadStop autocmd! BufWritePost <buffer>

" Firefox
command! -bar FirefoxReload call s:ReloadBrowser("Firefox")
command! -bar FirefoxReloadStart FirefoxReloadStop | autocmd BufWritePost <buffer> FirefoxReload
command! -bar FirefoxReloadStop autocmd! BufWritePost <buffer>

" Opera
command! -bar OperaReload call s:ReloadBrowser("Opera")
command! -bar OperaReloadStart OperaReloadStop | autocmd BufWritePost <buffer> OperaReload
command! -bar OperaReloadStop autocmd! BufWritePost <buffer>

" All Browsers
command! -bar AllBrowserReload silent OperaReload | FirefoxReload | ChromeReload | ChromiumReload 
command! -bar AllBrowserReloadStart AllBrowserReloadStop | autocmd BufWritePost <buffer> AllBrowserReload
command! -bar AllBrowserReloadStop autocmd! BufWritePost <buffer>
