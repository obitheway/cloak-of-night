" omarchy.vim — plain Vim follows the active Omarchy theme.
"
" Omarchy themes Neovim with a generated aether.nvim spec, but the `vim`
" binary has its own runtime and reads no Omarchy state. This colorscheme
" parses ~/.local/state/omarchy/current/theme/colors.toml on load, so plain
" Vim matches whatever theme is active without being regenerated.

if exists('g:colors_name')
  hi clear
endif
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'omarchy'
set background=dark

" Truecolor terminals (all of Omarchy's) use the gui colors below. A
" 256-color terminal falls back to the ANSI slots mapped at the bottom.
if ($COLORTERM ==# 'truecolor' || $COLORTERM ==# '24bit') && has('termguicolors')
  set termguicolors
endif

" Fallback palette, used only if Omarchy's state cannot be read. These are
" Cloak of Night; every value is overwritten when the state file exists.
let s:p = {}
let s:p.background         = '#0b0614'
let s:p.dark_background    = '#070310'
let s:p.darker_background  = '#04020a'
let s:p.lighter_background = '#1c1030'
let s:p.foreground         = '#efe2fa'
let s:p.dark_foreground    = '#8f7da8'
let s:p.light_foreground   = '#f5ebfc'
let s:p.bright_foreground  = '#fbf5ff'
let s:p.muted              = '#6b5a80'
let s:p.accent             = '#ff2e97'
let s:p.selection          = '#3a1747'
let s:p.selection_foreground = '#fbf5ff'
let s:p.selection_background = '#3a1747'
let s:p.purple             = '#b26bff'
let s:p.bright_purple      = '#d6a8ff'
let s:p.ember              = '#FF991C'
let s:p.red                = '#e01b3c'
let s:p.yellow             = '#ffc857'
let s:p.orange             = '#ff7a45'
let s:p.green              = '#3fd08a'
let s:p.cyan               = '#1ce6e9'
let s:p.blue               = '#4d7cff'
let s:p.magenta            = '#ff2e97'
let s:p.bright_red         = '#ff4d6a'
let s:p.bright_yellow      = '#ffd97a'
let s:p.bright_green       = '#6ee7b0'
let s:p.bright_cyan        = '#5ff6fa'
let s:p.bright_blue        = '#7aa2ff'
let s:p.bright_magenta     = '#ff6ab5'

let s:colors_file = expand('~/.local/state/omarchy/current/theme/colors.toml')
if filereadable(s:colors_file)
  for s:line in readfile(s:colors_file)
    let s:m = matchlist(s:line, '^\s*\(\w\+\)\s*=\s*"\?\(#\x\{6\}\)"\?')
    if !empty(s:m) && has_key(s:p, s:m[1])
      let s:p[s:m[1]] = s:m[2]
    endif
  endfor
endif

" Map the sixteen terminal colors back to ANSI slots for cterm fallbacks.
let s:ansi = {}
let s:slots = {}
let s:slots.background        = 0
let s:slots.red               = 1
let s:slots.green             = 2
let s:slots.yellow            = 3
let s:slots.blue              = 4
let s:slots.magenta           = 5
let s:slots.cyan              = 6
let s:slots.foreground        = 7
let s:slots.dark_foreground   = 8
let s:slots.bright_red        = 9
let s:slots.bright_green      = 10
let s:slots.bright_yellow     = 11
let s:slots.bright_blue       = 12
let s:slots.bright_magenta    = 13
let s:slots.bright_cyan       = 14
let s:slots.bright_foreground = 15
for [s:key, s:slot] in items(s:slots)
  let s:ansi[s:p[s:key]] = s:slot
endfor

function! s:Hi(group, fg, ...) abort
  let l:cmd = 'highlight ' . a:group
  if a:fg !=# ''
    let l:cmd .= ' guifg=' . a:fg
    if has_key(s:ansi, a:fg)
      let l:cmd .= ' ctermfg=' . s:ansi[a:fg]
    endif
  endif
  if a:0 >= 1 && a:1 !=# ''
    let l:cmd .= ' guibg=' . a:1
    if has_key(s:ansi, a:1)
      let l:cmd .= ' ctermbg=' . s:ansi[a:1]
    endif
  endif
  if a:0 >= 2 && a:2 !=# ''
    let l:cmd .= ' gui=' . a:2 . ' cterm=' . a:2
  endif
  execute l:cmd
endfunction

" Syntax ---------------------------------------------------------------------
call s:Hi('Normal',           s:p.foreground,        s:p.background)
call s:Hi('NormalNC',         s:p.foreground,        s:p.dark_background)
call s:Hi('Comment',          s:p.muted,             '',              'italic')
call s:Hi('Constant',         s:p.orange)
call s:Hi('String',           get(s:p, 'ember', s:p.orange))
call s:Hi('Character',        get(s:p, 'ember', s:p.orange))
call s:Hi('Number',           s:p.orange)
call s:Hi('Boolean',          s:p.orange)
call s:Hi('Float',            s:p.orange)
call s:Hi('Identifier',       s:p.blue)
call s:Hi('Function',         s:p.blue)
call s:Hi('Statement',        s:p.bright_magenta)
call s:Hi('Conditional',      s:p.bright_magenta)
call s:Hi('Repeat',           s:p.bright_magenta)
call s:Hi('Label',            s:p.bright_magenta)
call s:Hi('Operator',         s:p.cyan)
call s:Hi('Keyword',          s:p.bright_magenta)
call s:Hi('Exception',        s:p.bright_red)
call s:Hi('PreProc',          s:p.cyan)
call s:Hi('Include',          s:p.cyan)
call s:Hi('Define',           s:p.cyan)
call s:Hi('Macro',            s:p.cyan)
call s:Hi('PreCondit',        s:p.cyan)
call s:Hi('Type',             s:p.yellow)
call s:Hi('StorageClass',     s:p.yellow)
call s:Hi('Structure',        s:p.yellow)
call s:Hi('Typedef',          s:p.yellow)
call s:Hi('Special',          s:p.bright_cyan)
call s:Hi('SpecialChar',      s:p.bright_cyan)
call s:Hi('Tag',              s:p.bright_yellow)
call s:Hi('Delimiter',        s:p.light_foreground)
call s:Hi('SpecialComment',   s:p.muted)
call s:Hi('Debug',            s:p.bright_red)
call s:Hi('Underlined',       s:p.blue,              '',              'underline')
call s:Hi('Ignore',           s:p.dark_foreground)
call s:Hi('Error',            s:p.bright_red,        s:p.background,  'bold')
call s:Hi('Todo',             s:p.yellow,            s:p.background,  'bold')

" Editor chrome --------------------------------------------------------------
call s:Hi('Visual',           s:p.selection_foreground, s:p.selection_background)
call s:Hi('VisualNOS',        s:p.selection_foreground, s:p.selection_background)
call s:Hi('Search',           s:p.background,       s:p.yellow)
call s:Hi('IncSearch',        s:p.background,       s:p.cyan)
call s:Hi('MatchParen',       s:p.bright_foreground, s:p.accent,      'bold')
call s:Hi('Cursor',           s:p.background,       s:p.bright_foreground)
call s:Hi('CursorLine',       '',                    s:p.lighter_background)
call s:Hi('CursorLineNr',     s:p.accent,           s:p.lighter_background, 'bold')
call s:Hi('LineNr',           s:p.dark_foreground,   s:p.background)
call s:Hi('SignColumn',       '',                    s:p.background)
call s:Hi('Folded',           s:p.muted,            s:p.dark_background)
call s:Hi('FoldColumn',       s:p.muted,            s:p.background)
call s:Hi('NonText',          s:p.dark_foreground)
call s:Hi('SpecialKey',       s:p.dark_foreground)
call s:Hi('Whitespace',       s:p.dark_foreground)
call s:Hi('VertSplit',        s:p.muted,            s:p.background)
call s:Hi('ColorColumn',      '',                    s:p.dark_background)
call s:Hi('StatusLine',       s:p.foreground,       s:p.darker_background, 'bold')
call s:Hi('StatusLineNC',     s:p.dark_foreground,   s:p.dark_background)
call s:Hi('TabLine',          s:p.dark_foreground,   s:p.dark_background)
call s:Hi('TabLineFill',      '',                    s:p.dark_background)
call s:Hi('TabLineSel',       s:p.bright_foreground, s:p.accent,      'bold')
call s:Hi('Pmenu',            s:p.foreground,       s:p.dark_background)
call s:Hi('PmenuSel',         s:p.bright_foreground, s:p.accent,      'bold')
call s:Hi('PmenuSbar',        '',                    s:p.lighter_background)
call s:Hi('PmenuThumb',       '',                    s:p.bright_blue)
call s:Hi('WildMenu',         s:p.background,       s:p.cyan)
call s:Hi('Directory',        s:p.blue,             '',              'bold')
call s:Hi('Title',            s:p.yellow,           '',              'bold')
call s:Hi('WarningMsg',       s:p.bright_yellow)
call s:Hi('ErrorMsg',         s:p.bright_red)
call s:Hi('ModeMsg',          s:p.cyan)
call s:Hi('MoreMsg',          s:p.cyan)
call s:Hi('Question',         s:p.cyan)

" Diffs and spelling ---------------------------------------------------------
call s:Hi('DiffAdd',          s:p.green,            s:p.darker_background)
call s:Hi('DiffChange',       s:p.yellow,           s:p.darker_background)
call s:Hi('DiffDelete',       s:p.red,              s:p.darker_background)
call s:Hi('DiffText',         s:p.bright_cyan,      s:p.lighter_background, 'bold')
call s:Hi('SpellBad',         '',                    '',              'undercurl')
call s:Hi('SpellCap',         '',                    '',              'undercurl')
call s:Hi('SpellRare',        '',                    '',              'undercurl')
call s:Hi('SpellLocal',       '',                    '',              'undercurl')
