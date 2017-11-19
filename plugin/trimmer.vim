if exists('g:trimmer_loaded')
  finish
endif
let g:trimmer_loaded = 1

command! -nargs=? -bang -complete=customlist,trimmer#complete Trimmer call trimmer#command(<q-bang>, <q-args>, <q-mods>)
