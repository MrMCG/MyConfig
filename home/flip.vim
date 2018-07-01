if exists( "load_flip" )
    finish
endif

if ( v:progname == "ex" )
    finish
endif

let load_flip = 1

let s:subdirs = [ ".", "include", "..", "../include" ]
let s:switches = {
            \'cpp' : [ 'hpp', 'h', 'H' ],
            \'ipp' : [ 'hpp', 'h', 'H' ],
            \  'C' : [ 'H', 'h', 'hpp' ],
            \  'c' : [ 'h', 'h', 'hpp' ],
            \'hpp' : [ 'cpp', 'ipp', 'C' ],
            \  'H' : [ 'C', 'cpp' ],
            \  'h' : [ 'c', 'cpp' ]
\ }

function! s:DoesFileExist(file)
    if filereadable( a:file )
        return 1
    endif
    return 0
endfunction

function! Flip()
    let l:orig = expand( "%" )
    let l:base = expand( "%:t:r" )
    let l:base_dir = expand( "%:p:h" )
    let l:ext = expand( "%:e" )
    let l:flip_dir = ""
    let l:flip_ext = ""
    let l:flip_found = 0

    " echom "base = " . l:base . ", ext = " . l:ext . ", base_dir = " . l:base_dir

    if has_key( s:switches, l:ext )
        for l:switch_ext in s:switches[ l:ext ]
            for l:dir in s:subdirs
                " echom "l:dir = " . l:dir

                let l:flip_file = l:base_dir . "/" . l:dir . "/" . l:base . "." . l:switch_ext

                " echom "checking " . l:flip_file

                if s:DoesFileExist( l:flip_file )
                    let l:flip_dir = l:base_dir . "/" . l:dir
                    let l:flip_ext = l:switch_ext
                    let l:flip_found = 1

                    " echom "found"
                endif

                if l:flip_found
                    break
                endif

            endfor

            if l:flip_found
                break
            endif

        endfor
    endif

    if l:flip_found
        if l:flip_dir == "."
            let l:flip_dir = ""
        else
            let l:flip_dir = l:flip_dir . "/"
        endif

        let l:other = l:flip_dir . l:base . "." . l:flip_ext

        " echom "other = " . l:other

        let l:other = substitute( system( "realpath --relative-to=" . getcwd() . " " . l:other ), '[\]\|[[:cntrl:]]', '', 'g')

        " echom "other after = " . l:other

        let l:buf = -1
        let l:lstbuf = bufnr( "$" )
        let l:i = 1
        while l:i <= l:lstbuf
            if ( expand( "#" . l:i . ":p" ) == l:other )
                let l:buf = i
                break
            endif
            let l:i = l:i + 1
        endwhile

        if ( l:buf == -1 )
            if ( findfile( l:other ) != "" )
                " silent! execute ":e " . l:other
                execute ":e " . l:other
                if ( v:errmsg != "" )
                   echom v:errmsg
                endif
            endif
        else
            silent! execute "buffer " . l:buf
        endif
    endif

endfunction

map <silent> <F4> :call Flip()<CR>
