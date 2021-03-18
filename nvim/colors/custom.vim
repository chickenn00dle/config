""""""""
"Palette
""""""""
let s:white=252
let s:lgray=248
let s:gray=238
let s:dgray=234
let s:black=232
let s:blue=81
let s:dblue=32
let s:green=157
let s:yellow=228
let s:orange=215
let s:red=203
let s:purple=140

function! s:h( group, fg, bg, attr )
	let l:fg = a:fg ? a:fg : 'none'
	let l:bg = a:bg ? a:bg : 'none'
	let l:attr = exists( a:attr ) ? a:attr : 'none'
	exec 'hi! ' . a:group . ' cterm=' . l:attr . ' ctermfg=' . l:fg . ' ctermbg=' . l:bg
endfunction

call s:h( 'Normal', s:white, '', '' )
call s:h( 'Directory', s:dblue, '', '' )
call s:h( 'StatusLine', 238, 235, '' )
call s:h( 'StatusLineNC', '', 235, '' )
call s:h( 'Cursor', '', s:lgray, '' )
call s:h( 'CursorLine', '', '', '' )
call s:h( 'CursorLineNr', s:lgray, s:dgray, '' )
call s:h( 'MatchParen', '', s:gray, '' )
call s:h( 'LineNr', s:gray, s:dgray, '' )
call s:h( 'SignColumn', s:gray, s:dgray, '' )
call s:h( 'FoldColumn', s:dgray, '', '' )
call s:h( 'Folded', s:gray, '', 'bold' )
call s:h( 'Pmenu', s:white, s:dgray, '' )
call s:h( 'PmenuSel', s:white, s:dgray, '' )
call s:h( 'DiffAdd', s:green, '', '' )
call s:h( 'DiffDelete', s:red, '', '' )
call s:h( 'DiffChange', s:yellow, '', '' )
call s:h( 'DiffText', s:white, '', '' )
call s:h( 'Search', s:yellow, '', '' )
call s:h( 'IncSearch', s:yellow, '', '' )
call s:h( 'VertSplit', s:dgray, s:dgray, '' )
call s:h( 'ErrorMsg', s:white, s:red, '' )
call s:h( 'WarningMsg', s:white, s:yellow, '' )
call s:h( 'Question', s:blue, '', '' )

call s:h( 'NonText', s:gray, '', '' )
call s:h( 'SpecialKey', s:gray, '', '' )
call s:h( 'Comment', s:gray, '', '' )
call s:h( 'Constant', s:white, '', '' )
call s:h( 'String', s:green, '', '' )
call s:h( 'Character', s:green, '', '' )
call s:h( 'Number', s:yellow, '', '' )
call s:h( 'Float', s:yellow, '', '' )
call s:h( 'Boolean', s:blue, '', '' )
call s:h( 'Identifier', s:red, '', '' )
call s:h( 'Function', s:purple, '', '' )
call s:h( 'Statement', s:purple, '', '' )
call s:h( 'Conditional', s:purple, '', '' )
call s:h( 'PreCondit', s:purple, '', '' )
call s:h( 'Repeat', s:purple, '', '' )
call s:h( 'Label', s:purple, '', '' )
call s:h( 'Operator', s:white, '', '' )
call s:h( 'Keyword', s:red, '', '' )
call s:h( 'Exception', s:orange, '', '' )
call s:h( 'PreProc', s:orange, '', '' )
call s:h( 'Include', s:blue, '', '' )
call s:h( 'Define', s:blue, '', '' )
call s:h( 'Macro', s:blue, '', '' )
call s:h( 'Type', s:yellow, '', '' )
call s:h( 'TypeDef', s:yellow, '', '' )
call s:h( 'StorageClass', s:yellow, '', '' )
call s:h( 'Structure', s:yellow, '', '' )
call s:h( 'Special', s:orange, '', '' )
call s:h( 'SpecialChar', s:white, '', '' )
call s:h( 'Tag', s:white, '', '' )
call s:h( 'Delimiter', s:white, '', '' )
call s:h( 'SpecialComment', s:white, '', '' )
call s:h( 'Underlined', s:white, '', '' )
call s:h( 'Ignore', s:lgray, '', '' )
call s:h( 'Error', s:white, s:red, '' )
call s:h( 'Todo', s:white, s:yellow, '' )

call s:h( 'gitcommitComment', s:gray, '', '' )
call s:h( 'gitcommitUnmerged', s:red, '', '' )
call s:h( 'gitcommitOnBranch', s:white, '', '' )
call s:h( 'gitcommitBranch', s:purple, '', '' )
call s:h( 'gitcommitDiscardedType', s:red, '', '' )
call s:h( 'gitcommitSelectedType', s:green, '', '' )
call s:h( 'gitcommitHeader', s:white, '', '' )
call s:h( 'gitcommitUntrackedFile', s:gray, '', '' )
call s:h( 'gitcommitDiscardedFile', s:red, '', '' )
call s:h( 'gitcommitSelectedFile', s:green, '', '' )
call s:h( 'gitcommitUnmergedFile', s:yellow, '', '' )
call s:h( 'gitcommitFile', s:white, '', '' )
hi! link gitcommitNoBranch gitcommitBranch
hi! link gitcommitUntracked gitcommitComment
hi! link gitcommitDiscarded gitcommitComment
hi! link gitcommitSelected gitcommitComment
hi! link gitcommitDiscardedArrow gitcommitDiscardedFile
hi! link gitcommitSelectedArrow gitcommitSelectedFile
hi! link gitcommitUnmergedArrow gitcommitUnmergedFile

"""""""""
"NERDTree
"""""""""
call s:h( 'NERDTreeCWD', s:lgray, '', '' )
call s:h( 'NERDTreeBookmark', s:purple, '', '' )
call s:h( 'NERDTreeExecFile', s:red, '', '' )

"""""""
"Vdebug
"""""""
call s:h( 'DbgBreakptLine', '', '', '' )
call s:h( 'DbgCurrentLine', '', '', '' )
call s:h( 'DbgBreakptSign', s:green, '', '' )
call s:h( 'DbgCurrentSign', s:red, '', '' )
