""""""""
"Palette
""""""""
let s:white={ "xterm": 255, "hex": "#eeeeee" }
let s:lgray={ "xterm": 248, "hex": "#a8a8a8" }
let s:gray={ "xterm": 238, "hex": "#444444" }
let s:dgray={ "xterm": 234, "hex": "#1c1c1c" }
let s:black={ "xterm": 232, "hex": "#080808" }
let s:blue={ "xterm": 81, "hex": "#5fd7ff" }
let s:dblue={ "xterm": 32, "hex": "#0087d7" }
let s:green={ "xterm": 157, "hex": "#afffaf" }
let s:yellow={ "xterm": 228, "hex": "#ffff87" }
let s:orange={ "xterm": 215, "hex": "ffaf5f" }
let s:red={ "xterm": 203, "hex": "#ff5f5f" }
let s:purple={ "xterm": 140, "hex": "#af87d7" }

function! s:hl( group, fg, bg, attr )
	let l:ctermfg = type( a:fg ) == type({}) ? get( a:fg, "xterm" ) : 'none'
	let l:ctermbg = type( a:bg ) == type({}) ? get( a:bg, "xterm" ) : 'none'
	let l:guifg = type( a:fg ) == type({}) ? get( a:fg, "hex" ) : 'none'
	let l:guibg = type( a:bg ) == type({}) ? get( a:bg, "hex" ) : 'none'
	let l:attr = exists( a:attr ) ? a:attr : 'none'
	exec 'hi! ' . a:group . ' cterm=' . l:attr . ' gui=' . l:attr .
		\ ' ctermfg=' . l:ctermfg . ' ctermbg=' . l:ctermbg .
		\ ' guifg=' . l:guifg . ' guibg=' . l:guibg
endfunction

call s:hl( 'Cursor', '', s:lgray, '' )
call s:hl( 'CursorLine', '', '', '' )
call s:hl( 'CursorLineNr', s:lgray, s:dgray, '' )
call s:hl( 'StatusLine', s:black, s:dgray, '' )
call s:hl( 'StatusLineNC', '', s:dgray, '' )
call s:hl( 'VertSplit', s:black, '', '' )
call s:hl( 'LineNr', s:gray, '', '' )
call s:hl( 'SignColumn', s:gray, '', '' )
call s:hl( 'FoldColumn', s:dgray, '', '' )
call s:hl( 'Folded', s:gray, '', 'bold' )
call s:hl( 'MatchParen', '', s:gray, '' )
call s:hl( 'DiffAdd', s:green, '', '' )
call s:hl( 'DiffDelete', s:red, '', '' )
call s:hl( 'DiffChange', s:yellow, '', '' )
call s:hl( 'DiffText', s:white, '', '' )
call s:hl( 'Search', s:dgray, s:yellow, '' )
call s:hl( 'IncSearch', s:dgray, s:yellow, '' )
call s:hl( 'ErrorMsg', s:white, s:red, '' )
call s:hl( 'WarningMsg', s:dgray, s:yellow, '' )
call s:hl( 'Question', s:blue, '', '' )
call s:hl( 'Pmenu', s:white, s:black, '' )
call s:hl( 'PmenuSel', s:white, s:gray, '' )
call s:hl( 'Directory', s:dblue, '', '' )

call s:hl( 'Normal', s:white, '', '' )
call s:hl( 'NonText', s:gray, '', '' )
call s:hl( 'SpecialKey', s:gray, '', '' )
call s:hl( 'Comment', s:gray, '', '' )
call s:hl( 'Constant', s:white, '', '' )
call s:hl( 'String', s:green, '', '' )
call s:hl( 'Character', s:green, '', '' )
call s:hl( 'Number', s:yellow, '', '' )
call s:hl( 'Float', s:yellow, '', '' )
call s:hl( 'Boolean', s:blue, '', '' )
call s:hl( 'Identifier', s:red, '', '' )
call s:hl( 'Function', s:purple, '', '' )
call s:hl( 'Statement', s:purple, '', '' )
call s:hl( 'Conditional', s:purple, '', '' )
call s:hl( 'PreCondit', s:purple, '', '' )
call s:hl( 'Repeat', s:purple, '', '' )
call s:hl( 'Label', s:purple, '', '' )
call s:hl( 'Operator', s:white, '', '' )
call s:hl( 'Keyword', s:red, '', '' )
call s:hl( 'Exception', s:orange, '', '' )
call s:hl( 'PreProc', s:orange, '', '' )
call s:hl( 'Include', s:blue, '', '' )
call s:hl( 'Define', s:blue, '', '' )
call s:hl( 'Macro', s:blue, '', '' )
call s:hl( 'Type', s:yellow, '', '' )
call s:hl( 'TypeDef', s:yellow, '', '' )
call s:hl( 'StorageClass', s:yellow, '', '' )
call s:hl( 'Structure', s:yellow, '', '' )
call s:hl( 'Special', s:orange, '', '' )
call s:hl( 'SpecialChar', s:white, '', '' )
call s:hl( 'Tag', s:white, '', '' )
call s:hl( 'Delimiter', s:white, '', '' )
call s:hl( 'SpecialComment', s:white, '', '' )
call s:hl( 'Underlined', s:white, '', '' )
call s:hl( 'Ignore', s:lgray, '', '' )
call s:hl( 'Error', s:white, s:red, '' )
call s:hl( 'Todo', s:dgray, s:yellow, '' )

""""
"Git
""""
call s:hl( 'gitcommitComment', s:gray, '', '' )
call s:hl( 'gitcommitUnmerged', s:red, '', '' )
call s:hl( 'gitcommitOnBranch', s:white, '', '' )
call s:hl( 'gitcommitBranch', s:purple, '', '' )
call s:hl( 'gitcommitDiscardedType', s:red, '', '' )
call s:hl( 'gitcommitSelectedType', s:green, '', '' )
call s:hl( 'gitcommitHeader', s:white, '', '' )
call s:hl( 'gitcommitUntrackedFile', s:gray, '', '' )
call s:hl( 'gitcommitDiscardedFile', s:red, '', '' )
call s:hl( 'gitcommitSelectedFile', s:green, '', '' )
call s:hl( 'gitcommitUnmergedFile', s:yellow, '', '' )
call s:hl( 'gitcommitFile', s:white, '', '' )
hi! link gitcommitNoBranch gitcommitBranch
hi! link gitcommitUntracked gitcommitComment
hi! link gitcommitDiscarded gitcommitComment
hi! link gitcommitSelected gitcommitComment
hi! link gitcommitDiscardedArrow gitcommitDiscardedFile
hi! link gitcommitSelectedArrow gitcommitSelectedFile
hi! link gitcommitUnmergedArrow gitcommitUnmergedFile
