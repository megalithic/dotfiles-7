setlocal foldexpr=
setlocal foldtext=

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .= '| setlocal '.join([
\  'foldexpr<',
\  'foldtext<',
\])
