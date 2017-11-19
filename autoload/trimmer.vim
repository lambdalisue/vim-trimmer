function! s:trim() abort
  let cursor = getcurpos()
  silent keepjumps %s/\s\+$//e
  call setpos('.', cursor)
endfunction

function! trimmer#enable(quiet) abort
  let b:trimmer = 1
  augroup trimmer_internal
    autocmd! * <buffer>
    autocmd BufWritePre <buffer> call s:trim()
  augroup END
  if !a:quiet
    redraw | echo '[trimmer] Enabled'
  endif
endfunction

function! trimmer#disable(quiet) abort
  silent! unlet! b:trimmer
  augroup trimmer_internal
    autocmd! * <buffer>
  augroup END
  if !a:quiet
    redraw | echo '[trimmer] Disabled'
  endif
endfunction

function! trimmer#toggle(quiet) abort
  if exists('b:trimmer')
    call trimmer#disable(a:quiet)
  else
    call trimmer#enable(a:quiet)
  endif
endfunction

function! trimmer#command(bang, args, mods) abort
  let quiet = a:bang ==# '!' || a:mods =~# '\<silent\>'
  if a:args ==# ''
    call trimmer#toggle(quiet)
  elseif a:args ==# 'enable'
    call trimmer#enable(quiet)
  elseif a:args ==# 'disable'
    call trimmer#disable(quiet)
  else
    echohl ErrorMsg
    echo printf('[trimmer] Unknown sub-command "%s" has specified.', a:args)
    echohl None
  endif
endfunction

function! trimmer#complete(arglead, cmdline, cursorpos) abort
  let subcommands = ['enable', 'disable']
  return filter(subcommands, 'v:val =~# ''^'' . a:arglead')
endfunction

