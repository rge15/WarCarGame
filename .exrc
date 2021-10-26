let s:cpo_save=&cpo
set cpo&vim
inoremap <silent> <expr> <Plug>(coc-snippets-expand-jump) coc#_insert_key('notify', 'snippets-expand-jump', 1)
inoremap <silent> <expr> <Plug>(coc-snippets-expand) coc#_insert_key('notify', 'snippets-expand', 1)
inoremap <Plug>(emmet-merge-lines) =emmet#util#closePopup()=emmet#mergeLines()
inoremap <Plug>(emmet-anchorize-summary) =emmet#util#closePopup()=emmet#anchorizeURL(1)
inoremap <Plug>(emmet-anchorize-url) =emmet#util#closePopup()=emmet#anchorizeURL(0)
inoremap <Plug>(emmet-remove-tag) =emmet#util#closePopup()=emmet#removeTag()
inoremap <Plug>(emmet-split-join-tag) :call emmet#splitJoinTag()
inoremap <Plug>(emmet-toggle-comment) =emmet#util#closePopup()=emmet#toggleComment()
inoremap <Plug>(emmet-image-encode) =emmet#util#closePopup()=emmet#imageEncode()
inoremap <Plug>(emmet-image-size) =emmet#util#closePopup()=emmet#imageSize()
inoremap <Plug>(emmet-move-prev-item) :call emmet#moveNextPrevItem(1)
inoremap <Plug>(emmet-move-next-item) :call emmet#moveNextPrevItem(0)
inoremap <Plug>(emmet-move-prev) =emmet#util#closePopup()=emmet#moveNextPrev(1)
inoremap <Plug>(emmet-move-next) =emmet#util#closePopup()=emmet#moveNextPrev(0)
inoremap <Plug>(emmet-balance-tag-outword) :call emmet#balanceTag(-1)
inoremap <Plug>(emmet-balance-tag-inward) :call emmet#balanceTag(1)
inoremap <Plug>(emmet-update-tag) =emmet#util#closePopup()=emmet#updateTag()
inoremap <Plug>(emmet-expand-word) =emmet#util#closePopup()=emmet#expandAbbr(1,"")
inoremap <Plug>(emmet-expand-abbr) =emmet#util#closePopup()=emmet#expandAbbr(0,"")
inoremap <silent> <SNR>89_AutoPairsReturn =AutoPairsReturn()
imap <S-Tab> <Plug>(pairify-complete)
inoremap <silent> <Plug>CocRefresh =coc#_complete()
cnoremap <silent> <Plug>(TelescopeFuzzyCommandSearch) e "lua require('telescope.builtin').command_history { default_text = [=[" . escape(getcmdline(), '"') . "]=] }"
inoremap <Plug>TComment_9 :call tcomment#SetOption("count", 9)
inoremap <Plug>TComment_8 :call tcomment#SetOption("count", 8)
inoremap <Plug>TComment_7 :call tcomment#SetOption("count", 7)
inoremap <Plug>TComment_6 :call tcomment#SetOption("count", 6)
inoremap <Plug>TComment_5 :call tcomment#SetOption("count", 5)
inoremap <Plug>TComment_4 :call tcomment#SetOption("count", 4)
inoremap <Plug>TComment_3 :call tcomment#SetOption("count", 3)
inoremap <Plug>TComment_2 :call tcomment#SetOption("count", 2)
inoremap <Plug>TComment_1 :call tcomment#SetOption("count", 1)
inoremap <Plug>TComment_s :TCommentAs =&ft_
inoremap <Plug>TComment_n :TCommentAs =&ft 
inoremap <Plug>TComment_a :TCommentAs 
inoremap <Plug>TComment_b :TCommentBlock mode=#
inoremap <Plug>TComment_i v:TCommentInline mode=#
inoremap <Plug>TComment_r :TCommentRight
inoremap <Plug>TComment_  :TComment 
inoremap <Plug>TComment_p :norm! m`vip:TComment``
inoremap <Plug>TComment_ :TComment
inoremap <silent> <C-Tab> =UltiSnips#ListSnippets()
inoremap <expr> <PageUp> pumvisible() ? "\<PageUp>\\" : "\<PageUp>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\\" : "\<PageDown>"
vnoremap <nowait> <silent> <expr>  coc#float#has_scroll() ? coc#float#scroll(0) : "\"
nnoremap <nowait> <silent> <expr>  coc#float#has_scroll() ? coc#float#scroll(0) : "\"
vnoremap <nowait> <silent> <expr>  coc#float#has_scroll() ? coc#float#scroll(1) : "\"
nnoremap <nowait> <silent> <expr>  coc#float#has_scroll() ? coc#float#scroll(1) : "\"
snoremap <silent>  "_c
xnoremap <silent> 	 :call UltiSnips#SaveLastVisualSelection()gvs
snoremap <silent> 	 :call UltiSnips#ExpandSnippet()
nnoremap <NL> :Telescope find_files
nnoremap  :Telescope current_buffer_fuzzy_find
nnoremap <expr>  &buftype ==# 'quickfix' ? "\" : 'o'
nnoremap  :Clap filer
nnoremap  :Telescope buffers
snoremap  "_c
xnoremap  "hy:.,$s/h//gc<Left><Left><Left>
vmap c <Plug>(emmet-code-pretty)
nmap m <Plug>(emmet-merge-lines)
nmap A <Plug>(emmet-anchorize-summary)
nmap a <Plug>(emmet-anchorize-url)
nmap k <Plug>(emmet-remove-tag)
nmap j <Plug>(emmet-split-join-tag)
nmap / <Plug>(emmet-toggle-comment)
nmap I <Plug>(emmet-image-encode)
nmap i <Plug>(emmet-image-size)
nmap N <Plug>(emmet-move-prev)
nmap n <Plug>(emmet-move-next)
vmap D <Plug>(emmet-balance-tag-outword)
nmap D <Plug>(emmet-balance-tag-outword)
vmap d <Plug>(emmet-balance-tag-inward)
nmap d <Plug>(emmet-balance-tag-inward)
nmap u <Plug>(emmet-update-tag)
nmap ; <Plug>(emmet-expand-word)
vmap , <Plug>(emmet-expand-abbr)
nmap , <Plug>(emmet-expand-abbr)
xnoremap  gc
vmap <silent> 9 <Plug>TComment_9
nmap <silent> 9 <Plug>TComment_9
omap <silent> 9 <Plug>TComment_9
vmap <silent> 8 <Plug>TComment_8
nmap <silent> 8 <Plug>TComment_8
omap <silent> 8 <Plug>TComment_8
vmap <silent> 7 <Plug>TComment_7
nmap <silent> 7 <Plug>TComment_7
omap <silent> 7 <Plug>TComment_7
vmap <silent> 6 <Plug>TComment_6
nmap <silent> 6 <Plug>TComment_6
omap <silent> 6 <Plug>TComment_6
vmap <silent> 5 <Plug>TComment_5
nmap <silent> 5 <Plug>TComment_5
omap <silent> 5 <Plug>TComment_5
vmap <silent> 4 <Plug>TComment_4
nmap <silent> 4 <Plug>TComment_4
omap <silent> 4 <Plug>TComment_4
vmap <silent> 3 <Plug>TComment_3
nmap <silent> 3 <Plug>TComment_3
omap <silent> 3 <Plug>TComment_3
vmap <silent> 2 <Plug>TComment_2
nmap <silent> 2 <Plug>TComment_2
omap <silent> 2 <Plug>TComment_2
vmap <silent> 1 <Plug>TComment_1
nmap <silent> 1 <Plug>TComment_1
omap <silent> 1 <Plug>TComment_1
map <silent> ca <Plug>TComment_ca
map <silent> cc <Plug>TComment_cc
map <silent> s <Plug>TComment_s
map <silent> n <Plug>TComment_n
map <silent> a <Plug>TComment_a
map <silent> b <Plug>TComment_b
map <silent> i <Plug>TComment_i
map <silent> r <Plug>TComment_r
map <silent>   <Plug>TComment_ 
map <silent> p <Plug>TComment_p
vmap <silent>  <Plug>TComment_
nmap <silent>  <Plug>TComment_
omap <silent>  <Plug>TComment_
map  o :!cpct_winape -a
nmap  <F8> <Plug>VimspectorRunToCursor
nmap  <F9> <Plug>VimspectorToggleConditionalBreakpoint
nmap  <F5> <Plug>VimspectorLaunch
vmap <silent>  vR <Plug>EgMapReplaceSelection_R
nmap <silent>  vR <Plug>EgMapReplaceCurrentWord_R
omap <silent>  vR <Plug>EgMapReplaceCurrentWord_R
vmap <silent>  vr <Plug>EgMapReplaceSelection_r
nmap <silent>  vr <Plug>EgMapReplaceCurrentWord_r
omap <silent>  vr <Plug>EgMapReplaceCurrentWord_r
vmap <silent>  vA <Plug>EgMapGrepSelection_A
nmap <silent>  vA <Plug>EgMapGrepCurrentWord_A
omap <silent>  vA <Plug>EgMapGrepCurrentWord_A
vmap <silent>  va <Plug>EgMapGrepSelection_a
nmap <silent>  va <Plug>EgMapGrepCurrentWord_a
omap <silent>  va <Plug>EgMapGrepCurrentWord_a
vmap <silent>  vV <Plug>EgMapGrepSelection_V
nmap <silent>  vV <Plug>EgMapGrepCurrentWord_V
omap <silent>  vV <Plug>EgMapGrepCurrentWord_V
vmap <silent>  vv <Plug>EgMapGrepSelection_v
nmap <silent>  vv <Plug>EgMapGrepCurrentWord_v
omap <silent>  vv <Plug>EgMapGrepCurrentWord_v
map <silent>  vo <Plug>EgMapGrepOptions
map <silent>  _s <Plug>TComment_ _s
map <silent>  _n <Plug>TComment_ _n
map <silent>  _a <Plug>TComment_ _a
map <silent>  _b <Plug>TComment_ _b
map <silent>  _r <Plug>TComment_ _r
xmap <silent>  _i <Plug>TComment_ _i
map <silent>  _  <Plug>TComment_ _ 
map <silent>  _p <Plug>TComment_ _p
xmap <silent>  __ <Plug>TComment_ __
nmap <silent>  __ <Plug>TComment_ __
smap <silent>  __ <Plug>TComment_ __
omap <silent>  __ <Plug>TComment_ __
nnoremap  r :.,$s/\<=expand('<cword>')\>//gc<Left><Left><Left>
nnoremap  / /\<\><Left><Left>
nnoremap  y :Clap yanks
map  d :SignifyHunkDiff
nmap  cc :CMakeClose
nmap  cm :CMakeBuild
nmap  cd :CocDiagnostics
nmap  h :ToggleHexDec
nmap  cl :CocCommand flutter.dev.openDevLog
nmap  ch :CocCommand flutter.dev.hotReload
nmap  cr :CocCommand flutter.dev.hotRestart
nmap  a <Plug>(coc-codeaction-selected)
xmap  a <Plug>(coc-codeaction-selected)
map  tt :CocCommand terminal.Toggle
map  qs :ClapMksession
map  gc :Git checkout 
map  e :NERDTreeToggle
nnoremap  f :!feh <cfile> &
nmap  cf :cexpr []
nmap  gk :diffget //3
nmap  gj :diffget //2
map  ; :FloatermToggle
map  rv :g/^/m'< :noh
map  p :set paste!
map  qa :qall
nnoremap  s :vimgrep  ./**/*<Left><Left><Left><Left><Left><Left><Left>
vmap  h :bprevious
omap  h :bprevious
map  l :bnext
nmap  w :w!
map  tm :tabmove
map  tq :tabclose
map  to :tabonly
map  tn :tabedit %
map <silent>   :noh
map  bd : bp|bd #
nmap # <Plug>(anzu-sharp-with-echo)
omap <silent> % <Plug>(MatchitOperationForward)
xmap <silent> % <Plug>(MatchitVisualForward)
nmap <silent> % <Plug>(MatchitNormalForward)
nmap * <Plug>(anzu-star-with-echo)
vnoremap // y/\V=escape(@",'/\')
nnoremap K :Telescope grep_string
nmap N <Plug>(anzu-N-with-echo)
map Q @:
xmap S <Plug>VSurround
nmap S "_D
map U :UndotreeToggle
map Y y$
omap <silent> [% <Plug>(MatchitOperationMultiBackward)
xmap <silent> [% <Plug>(MatchitVisualMultiBackward)
nmap <silent> [% <Plug>(MatchitNormalMultiBackward)
nmap [C 9999[c
nmap [c <Plug>(signify-prev-hunk)
omap <silent> ]% <Plug>(MatchitOperationMultiForward)
xmap <silent> ]% <Plug>(MatchitVisualMultiForward)
nmap <silent> ]% <Plug>(MatchitNormalMultiForward)
nmap ]C 9999]c
nmap ]c <Plug>(signify-next-hunk)
xmap a% <Plug>(MatchitVisualTextObject)
omap al <Plug>(textobj-line-a)
xmap al <Plug>(textobj-line-a)
nmap cS <Plug>CSurround
nmap cs <Plug>Csurround
nmap ds <Plug>Dsurround
vmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
omap <silent> g% <Plug>(MatchitOperationBackward)
xmap <silent> g% <Plug>(MatchitVisualBackward)
nmap <silent> g% <Plug>(MatchitNormalBackward)
xmap gS <Plug>VgSurround
xmap <silent> g> <Plug>TComment_Comment
nmap <silent> g>b <Plug>TComment_Commentb
nmap <silent> g>c <Plug>TComment_Commentc
nmap <silent> g> <Plug>TComment_Comment
xmap <silent> g< <Plug>TComment_Uncomment
nmap <silent> g<b <Plug>TComment_Uncommentb
nmap <silent> g<c <Plug>TComment_Uncommentc
nmap <silent> g< <Plug>TComment_Uncomment
xmap <silent> gc <Plug>TComment_gc
nmap <silent> gcb <Plug>TComment_gcb
nmap <silent> gcc <Plug>TComment_gcc
nmap <silent> gc9c <Plug>TComment_gc9c
nmap <silent> gc9 <Plug>TComment_gc9
nmap <silent> gc8c <Plug>TComment_gc8c
nmap <silent> gc8 <Plug>TComment_gc8
nmap <silent> gc7c <Plug>TComment_gc7c
nmap <silent> gc7 <Plug>TComment_gc7
nmap <silent> gc6c <Plug>TComment_gc6c
nmap <silent> gc6 <Plug>TComment_gc6
nmap <silent> gc5c <Plug>TComment_gc5c
nmap <silent> gc5 <Plug>TComment_gc5
nmap <silent> gc4c <Plug>TComment_gc4c
nmap <silent> gc4 <Plug>TComment_gc4
nmap <silent> gc3c <Plug>TComment_gc3c
nmap <silent> gc3 <Plug>TComment_gc3
nmap <silent> gc2c <Plug>TComment_gc2c
nmap <silent> gc2 <Plug>TComment_gc2
nmap <silent> gc1c <Plug>TComment_gc1c
nmap <silent> gc1 <Plug>TComment_gc1
nmap <silent> gc <Plug>TComment_gc
map gz :Git add %
map gs :tab :G
map gp pk"_dd
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gI <Plug>(coc-implementation)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gd <Plug>(coc-definition)
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
omap il <Plug>(textobj-line-i)
xmap il <Plug>(textobj-line-i)
omap <silent> ic <Plug>TComment_ic
vmap <silent> ic <Plug>TComment_ic
tnoremap jk 
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nmap <silent> mk <Plug>MarkologyPrevLocalMarkPos
nmap <silent> mj <Plug>MarkologyNextLocalMarkPos
nmap mm :MarkologyLocationList
nmap n <Plug>(anzu-n-with-echo)
nmap ss "_dd
map s "_d
nmap ySS <Plug>YSsurround
nmap ySs <Plug>YSsurround
nmap yss <Plug>Yssurround
nmap yS <Plug>YSurround
nmap ys <Plug>Ysurround
vnoremap <silent> <Plug>(coc-snippets-select) :call coc#rpc#notify('doKeymap', ['snippets-select'])
xnoremap <silent> <Plug>(coc-convert-snippet) :call coc#rpc#notify('doKeymap', ['convert-snippet'])
tnoremap <silent> <Plug>(fzf-normal) 
tnoremap <silent> <Plug>(fzf-insert) i
nnoremap <silent> <Plug>(fzf-normal) <Nop>
nnoremap <silent> <Plug>(fzf-insert) i
vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))
nnoremap <silent> <Plug>(CMakeClose) :call cmake#console#Close()
nnoremap <silent> <Plug>(CMakeOpen) :call cmake#console#Open(0)
nnoremap <Plug>(CMakeSwitch) :CMakeSwitch 
nnoremap <Plug>(CMakeBuildTarget) :CMakeBuild 
nnoremap <silent> <Plug>(CMakeInstall) :call cmake#Install(0, 0)
nnoremap <silent> <Plug>(CMakeBuild) :call cmake#Build(0, 0, 0)
nnoremap <silent> <Plug>(CMakeClean) :call cmake#Clean()
nnoremap <silent> <Plug>(CMakeGenerate) :call cmake#Generate(0, 0, 0)
nnoremap <silent> <Plug>(conflict-marker-prev-hunk) :ConflictMarkerPrevHunk
nnoremap <silent> <Plug>(conflict-marker-next-hunk) :ConflictMarkerNextHunk
nnoremap <silent> <Plug>(conflict-marker-none) :ConflictMarkerNone
nnoremap <silent> <Plug>(conflict-marker-both-rev) :ConflictMarkerBoth!
nnoremap <silent> <Plug>(conflict-marker-both) :ConflictMarkerBoth
nnoremap <silent> <Plug>(conflict-marker-ourselves) :ConflictMarkerOurselves
nnoremap <silent> <Plug>(conflict-marker-themselves) :ConflictMarkerThemselves
nnoremap <silent> <Plug>TagalongReapply :call tagalong#Reapply()
xmap <silent> <Plug>(MatchitVisualTextObject) <Plug>(MatchitVisualMultiBackward)o<Plug>(MatchitVisualMultiForward)
onoremap <silent> <Plug>(MatchitOperationMultiForward) :call matchit#MultiMatch("W",  "o")
onoremap <silent> <Plug>(MatchitOperationMultiBackward) :call matchit#MultiMatch("bW", "o")
xnoremap <silent> <Plug>(MatchitVisualMultiForward) :call matchit#MultiMatch("W",  "n")m'gv``
xnoremap <silent> <Plug>(MatchitVisualMultiBackward) :call matchit#MultiMatch("bW", "n")m'gv``
nnoremap <silent> <Plug>(MatchitNormalMultiForward) :call matchit#MultiMatch("W",  "n")
nnoremap <silent> <Plug>(MatchitNormalMultiBackward) :call matchit#MultiMatch("bW", "n")
onoremap <silent> <Plug>(MatchitOperationBackward) :call matchit#Match_wrapper('',0,'o')
onoremap <silent> <Plug>(MatchitOperationForward) :call matchit#Match_wrapper('',1,'o')
xnoremap <silent> <Plug>(MatchitVisualBackward) :call matchit#Match_wrapper('',0,'v')m'gv``
xnoremap <silent> <Plug>(MatchitVisualForward) :call matchit#Match_wrapper('',1,'v')m'gv``
nnoremap <silent> <Plug>(MatchitNormalBackward) :call matchit#Match_wrapper('',0,'n')
nnoremap <silent> <Plug>(MatchitNormalForward) :call matchit#Match_wrapper('',1,'n')
vnoremap <Plug>(emmet-code-pretty) :call emmet#codePretty()
nnoremap <Plug>(emmet-merge-lines) :call emmet#mergeLines()
nnoremap <Plug>(emmet-anchorize-summary) :call emmet#anchorizeURL(1)
nnoremap <Plug>(emmet-anchorize-url) :call emmet#anchorizeURL(0)
nnoremap <Plug>(emmet-remove-tag) :call emmet#removeTag()
nnoremap <Plug>(emmet-split-join-tag) :call emmet#splitJoinTag()
nnoremap <Plug>(emmet-toggle-comment) :call emmet#toggleComment()
nnoremap <Plug>(emmet-image-encode) :call emmet#imageEncode()
nnoremap <Plug>(emmet-image-size) :call emmet#imageSize()
nnoremap <Plug>(emmet-move-prev-item) :call emmet#moveNextPrevItem(1)
nnoremap <Plug>(emmet-move-next-item) :call emmet#moveNextPrevItem(0)
nnoremap <Plug>(emmet-move-prev) :call emmet#moveNextPrev(1)
nnoremap <Plug>(emmet-move-next) :call emmet#moveNextPrev(0)
vnoremap <Plug>(emmet-balance-tag-outword) :call emmet#balanceTag(-1)
nnoremap <Plug>(emmet-balance-tag-outword) :call emmet#balanceTag(-1)
vnoremap <Plug>(emmet-balance-tag-inward) :call emmet#balanceTag(1)
nnoremap <Plug>(emmet-balance-tag-inward) :call emmet#balanceTag(1)
nnoremap <Plug>(emmet-update-tag) :call emmet#updateTag()
nnoremap <Plug>(emmet-expand-word) :call emmet#expandAbbr(1,"")
vnoremap <Plug>(emmet-expand-abbr) :call emmet#expandAbbr(2,"")
nnoremap <Plug>(emmet-expand-abbr) :call emmet#expandAbbr(3,"")
nmap <F12> <Plug>VimspectorStepOut
nmap <F11> <Plug>VimspectorStepInto
nmap <F10> <Plug>VimspectorStepOver
nmap <F8> <Plug>VimspectorAddFunctionBreakpoint
nmap <F9> <Plug>VimspectorToggleBreakpoint
nmap <F6> <Plug>VimspectorPause
nmap <F4> <Plug>VimspectorRestart
nmap <F3> <Plug>VimspectorStop
nmap <F5> <Plug>VimspectorContinue
nnoremap <silent> <Plug>VimspectorDownFrame :call vimspector#DownFrame()
nnoremap <silent> <Plug>VimspectorUpFrame :call vimspector#UpFrame()
xnoremap <silent> <Plug>VimspectorBalloonEval :call vimspector#ShowEvalBalloon( 1 )
nnoremap <silent> <Plug>VimspectorBalloonEval :call vimspector#ShowEvalBalloon( 0 )
nnoremap <silent> <Plug>VimspectorRunToCursor :call vimspector#RunToCursor()
nnoremap <silent> <Plug>VimspectorStepOut :call vimspector#StepOut()
nnoremap <silent> <Plug>VimspectorStepInto :call vimspector#StepInto()
nnoremap <silent> <Plug>VimspectorStepOver :call vimspector#StepOver()
nnoremap <silent> <Plug>VimspectorAddFunctionBreakpoint :call vimspector#AddFunctionBreakpoint( expand( '<cexpr>' ) )
nnoremap <silent> <Plug>VimspectorToggleConditionalBreakpoint :call vimspector#ToggleBreakpoint( { 'condition': input( 'Enter condition expression: ' ),   'hitCondition': input( 'Enter hit count expression: ' ) } )
nnoremap <silent> <Plug>VimspectorToggleBreakpoint :call vimspector#ToggleBreakpoint()
nnoremap <silent> <Plug>VimspectorPause :call vimspector#Pause()
nnoremap <silent> <Plug>VimspectorRestart :call vimspector#Restart()
nnoremap <silent> <Plug>VimspectorStop :call vimspector#Stop()
nnoremap <silent> <Plug>VimspectorLaunch :call vimspector#Launch( v:true )
nnoremap <silent> <Plug>VimspectorContinue :call vimspector#Continue()
nnoremap <silent> <Plug>SurroundRepeat .
nnoremap <silent> <Plug>window:location:toggle :call togglequickfix#ToggleLocation()
nnoremap <silent> <Plug>window:quickfix:toggle :call togglequickfix#ToggleQuickfix()
nnoremap <silent> <Plug>window:quickfix:loop :call togglequickfix#Loop()
nnoremap <silent> <Plug>(anzu-mode) :call anzu#mode#start(@/, "", "", "")
nnoremap <silent> <Plug>(anzu-mode-N) :call anzu#mode#start(@/, "N", "", "")
nnoremap <silent> <Plug>(anzu-mode-n) :call anzu#mode#start(@/, "n", "", "")
noremap <silent> <expr> <Plug>(anzu-echohl_search_status) (mode() =~ '[iR]' ? "\" : "") . ":call anzu#echohl_search_status()\"
nnoremap <silent> <Plug>(anzu-smart-sign-matchline) :AnzuSignMatchLine
nnoremap <silent> <Plug>(anzu-clear-sign-matchline) :AnzuClearSignMatchLine
nnoremap <silent> <Plug>(anzu-sign-matchline) :AnzuSignMatchLine!
nnoremap <silent> <expr> <Plug>(anzu-jump-sharp) ":normal! *N\" . anzu#mapexpr_jump(v:count, '\<Plug>(anzu-sharp)')
nnoremap <silent> <expr> <Plug>(anzu-jump-star) ":normal! *N\" . anzu#mapexpr_jump(v:count, '\<Plug>(anzu-star)')
nnoremap <silent> <expr> <Plug>(anzu-jump-N) anzu#mapexpr_jump(v:count, '\<Plug>(anzu-N)')
nnoremap <silent> <expr> <Plug>(anzu-jump-n) anzu#mapexpr_jump(v:count, '\<Plug>(anzu-n)')
nnoremap <silent> <expr> <Plug>(anzu-jump) anzu#mapexpr_jump(v:count, '')
nmap <silent> <Plug>(anzu-N-with-echo) <Plug>(anzu-N)<Plug>(anzu-echo-search-status)
nmap <silent> <Plug>(anzu-n-with-echo) <Plug>(anzu-n)<Plug>(anzu-echo-search-status)
nmap <silent> <Plug>(anzu-sharp-with-echo) <Plug>(anzu-sharp)<Plug>(anzu-echo-search-status)
nmap <silent> <Plug>(anzu-star-with-echo) <Plug>(anzu-star)<Plug>(anzu-echo-search-status)
nnoremap <silent> <Plug>(anzu-clear-search-cache) :AnzuClearSearchCache
nnoremap <silent> <Plug>(anzu-clear-search-status) :AnzuClearSearchStatus
nmap <silent> <Plug>(anzu-update-search-status-with-echo) <Plug>(anzu-update-search-status)<Plug>(anzu-echo-search-status)
nnoremap <silent> <Plug>(anzu-update-search-status) :AnzuUpdateSearchStatus
nnoremap <silent> <Plug>(anzu-echo-search-status) :call anzu#echohl_search_status()
nnoremap <silent> <Plug>MarkologyLineHighlightToggle :MarkologyLineHighlightToggle
nnoremap <silent> <Plug>MarkologyQuickFix :MarkologyQuickFix
nnoremap <silent> <Plug>MarkologyLocationList :MarkologyLocationList
nnoremap <silent> <Plug>MarkologyPrevLocalMarkByAlpha :MarkologyPrevLocalMarkByAlpha
nnoremap <silent> <Plug>MarkologyNextLocalMarkByAlpha :MarkologyNextLocalMarkByAlpha
nnoremap <silent> <Plug>MarkologyPrevLocalMarkPos :MarkologyPrevLocalMarkPos
nnoremap <silent> <Plug>MarkologyNextLocalMarkPos :MarkologyNextLocalMarkPos
nnoremap <silent> <Plug>MarkologyClearAll :MarkologyClearAll
nnoremap <silent> <Plug>MarkologyClearMark :MarkologyClearMark
nnoremap <silent> <Plug>MarkologyPlaceMark :MarkologyPlaceMark
nnoremap <silent> <Plug>MarkologyPlaceMarkToggle :MarkologyPlaceMarkToggle
nnoremap <silent> <Plug>MarkologyToggle :MarkologyToggle
nnoremap <silent> <Plug>MarkologyDisable :MarkologyDisable
nnoremap <silent> <Plug>MarkologyEnable :MarkologyEnable
xnoremap <silent> <Plug>(signify-motion-outer-visual) :call sy#util#hunk_text_object(1)
onoremap <silent> <Plug>(signify-motion-outer-pending) :call sy#util#hunk_text_object(1)
xnoremap <silent> <Plug>(signify-motion-inner-visual) :call sy#util#hunk_text_object(0)
onoremap <silent> <Plug>(signify-motion-inner-pending) :call sy#util#hunk_text_object(0)
nnoremap <silent> <expr> <Plug>(signify-prev-hunk) &diff ? '[c' : ":\call sy#jump#prev_hunk(v:count1)\"
nnoremap <silent> <expr> <Plug>(signify-next-hunk) &diff ? ']c' : ":\call sy#jump#next_hunk(v:count1)\"
onoremap <silent> <Plug>(coc-classobj-a) :call coc#rpc#request('selectSymbolRange', [v:false, '', ['Interface', 'Struct', 'Class']])
onoremap <silent> <Plug>(coc-classobj-i) :call coc#rpc#request('selectSymbolRange', [v:true, '', ['Interface', 'Struct', 'Class']])
vnoremap <silent> <Plug>(coc-classobj-a) :call coc#rpc#request('selectSymbolRange', [v:false, visualmode(), ['Interface', 'Struct', 'Class']])
vnoremap <silent> <Plug>(coc-classobj-i) :call coc#rpc#request('selectSymbolRange', [v:true, visualmode(), ['Interface', 'Struct', 'Class']])
onoremap <silent> <Plug>(coc-funcobj-a) :call coc#rpc#request('selectSymbolRange', [v:false, '', ['Method', 'Function']])
onoremap <silent> <Plug>(coc-funcobj-i) :call coc#rpc#request('selectSymbolRange', [v:true, '', ['Method', 'Function']])
vnoremap <silent> <Plug>(coc-funcobj-a) :call coc#rpc#request('selectSymbolRange', [v:false, visualmode(), ['Method', 'Function']])
vnoremap <silent> <Plug>(coc-funcobj-i) :call coc#rpc#request('selectSymbolRange', [v:true, visualmode(), ['Method', 'Function']])
nnoremap <silent> <Plug>(coc-cursors-position) :call coc#rpc#request('cursorsSelect', [bufnr('%'), 'position', 'n'])
nnoremap <silent> <Plug>(coc-cursors-word) :call coc#rpc#request('cursorsSelect', [bufnr('%'), 'word', 'n'])
vnoremap <silent> <Plug>(coc-cursors-range) :call coc#rpc#request('cursorsSelect', [bufnr('%'), 'range', visualmode()])
nnoremap <silent> <Plug>(coc-refactor) :call       CocActionAsync('refactor')
nnoremap <silent> <Plug>(coc-command-repeat) :call       CocAction('repeatCommand')
nnoremap <silent> <Plug>(coc-float-jump) :call       coc#float#jump()
nnoremap <silent> <Plug>(coc-float-hide) :call       coc#float#close_all()
nnoremap <silent> <Plug>(coc-fix-current) :call       CocActionAsync('doQuickfix')
nnoremap <silent> <Plug>(coc-openlink) :call       CocActionAsync('openLink')
nnoremap <silent> <Plug>(coc-references-used) :call       CocActionAsync('jumpUsed')
nnoremap <silent> <Plug>(coc-references) :call       CocActionAsync('jumpReferences')
nnoremap <silent> <Plug>(coc-type-definition) :call       CocActionAsync('jumpTypeDefinition')
nnoremap <silent> <Plug>(coc-implementation) :call       CocActionAsync('jumpImplementation')
nnoremap <silent> <Plug>(coc-declaration) :call       CocActionAsync('jumpDeclaration')
nnoremap <silent> <Plug>(coc-definition) :call       CocActionAsync('jumpDefinition')
nnoremap <silent> <Plug>(coc-diagnostic-prev-error) :call       CocActionAsync('diagnosticPrevious', 'error')
nnoremap <silent> <Plug>(coc-diagnostic-next-error) :call       CocActionAsync('diagnosticNext',     'error')
nnoremap <silent> <Plug>(coc-diagnostic-prev) :call       CocActionAsync('diagnosticPrevious')
nnoremap <silent> <Plug>(coc-diagnostic-next) :call       CocActionAsync('diagnosticNext')
nnoremap <silent> <Plug>(coc-diagnostic-info) :call       CocActionAsync('diagnosticInfo')
nnoremap <silent> <Plug>(coc-format) :call       CocActionAsync('format')
nnoremap <silent> <Plug>(coc-rename) :call       CocActionAsync('rename')
nnoremap <Plug>(coc-codeaction-cursor) :call       CocActionAsync('codeAction',         'cursor')
nnoremap <Plug>(coc-codeaction-line) :call       CocActionAsync('codeAction',         'line')
nnoremap <Plug>(coc-codeaction) :call       CocActionAsync('codeAction',         '')
vnoremap <silent> <Plug>(coc-codeaction-selected) :call       CocActionAsync('codeAction',         visualmode())
vnoremap <silent> <Plug>(coc-format-selected) :call       CocActionAsync('formatSelected',     visualmode())
nnoremap <Plug>(coc-codelens-action) :call       CocActionAsync('codeLensAction')
nnoremap <Plug>(coc-range-select) :call       CocActionAsync('rangeSelect',     '', v:true)
vnoremap <silent> <Plug>(coc-range-select-backward) :call       CocActionAsync('rangeSelect',     visualmode(), v:false)
vnoremap <silent> <Plug>(coc-range-select) :call       CocActionAsync('rangeSelect',     visualmode(), v:true)
nnoremap <Plug>PlenaryTestFile :lua require('plenary.test_harness').test_directory(vim.fn.expand("%:p"))
nnoremap <Plug>TComment_gc9c :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_gc9cg@
nnoremap <Plug>TComment_gc8c :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_gc8cg@
nnoremap <Plug>TComment_gc7c :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_gc7cg@
nnoremap <Plug>TComment_gc6c :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_gc6cg@
nnoremap <Plug>TComment_gc5c :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_gc5cg@
nnoremap <Plug>TComment_gc4c :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_gc4cg@
nnoremap <Plug>TComment_gc3c :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_gc3cg@
nnoremap <Plug>TComment_gc2c :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_gc2cg@
nnoremap <Plug>TComment_gc1c :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_gc1cg@
vnoremap <Plug>TComment_9 :call tcomment#SetOption("count", 9)
nnoremap <Plug>TComment_9 :call tcomment#SetOption("count", 9)
onoremap <Plug>TComment_9 :call tcomment#SetOption("count", 9)
vnoremap <Plug>TComment_8 :call tcomment#SetOption("count", 8)
nnoremap <Plug>TComment_8 :call tcomment#SetOption("count", 8)
onoremap <Plug>TComment_8 :call tcomment#SetOption("count", 8)
vnoremap <Plug>TComment_7 :call tcomment#SetOption("count", 7)
nnoremap <Plug>TComment_7 :call tcomment#SetOption("count", 7)
onoremap <Plug>TComment_7 :call tcomment#SetOption("count", 7)
vnoremap <Plug>TComment_6 :call tcomment#SetOption("count", 6)
nnoremap <Plug>TComment_6 :call tcomment#SetOption("count", 6)
onoremap <Plug>TComment_6 :call tcomment#SetOption("count", 6)
vnoremap <Plug>TComment_5 :call tcomment#SetOption("count", 5)
nnoremap <Plug>TComment_5 :call tcomment#SetOption("count", 5)
onoremap <Plug>TComment_5 :call tcomment#SetOption("count", 5)
vnoremap <Plug>TComment_4 :call tcomment#SetOption("count", 4)
nnoremap <Plug>TComment_4 :call tcomment#SetOption("count", 4)
onoremap <Plug>TComment_4 :call tcomment#SetOption("count", 4)
vnoremap <Plug>TComment_3 :call tcomment#SetOption("count", 3)
nnoremap <Plug>TComment_3 :call tcomment#SetOption("count", 3)
onoremap <Plug>TComment_3 :call tcomment#SetOption("count", 3)
vnoremap <Plug>TComment_2 :call tcomment#SetOption("count", 2)
nnoremap <Plug>TComment_2 :call tcomment#SetOption("count", 2)
onoremap <Plug>TComment_2 :call tcomment#SetOption("count", 2)
vnoremap <Plug>TComment_1 :call tcomment#SetOption("count", 1)
nnoremap <Plug>TComment_1 :call tcomment#SetOption("count", 1)
onoremap <Plug>TComment_1 :call tcomment#SetOption("count", 1)
nnoremap <Plug>TComment_gC :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_gCg@
nnoremap <Plug>TComment_gc :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_gcg@
xnoremap <Plug>TComment_gc :TCommentMaybeInline
nnoremap <Plug>TComment_gcb :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_gcbg@
nnoremap <Plug>TComment_gcc :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_gccg@$
noremap <Plug>TComment_ic :call tcomment#textobject#InlineComment()
xnoremap <Plug>TComment_Comment :if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | '<,'>TCommentMaybeInline!
nnoremap <Plug>TComment_Commentb :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_Commentbg@
nnoremap <Plug>TComment_Commentc :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_Commentcg@$
nnoremap <Plug>TComment_Commentl :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_Commentlg@$
nnoremap <Plug>TComment_Comment :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_Commentg@
xnoremap <Plug>TComment_Uncomment :if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | call tcomment#SetOption("mode_extra", "U") | '<,'>TCommentMaybeInline
nnoremap <Plug>TComment_Uncommentb :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_Uncommentbg@
nnoremap <Plug>TComment_Uncommentc :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_Uncommentcg@$
nnoremap <Plug>TComment_Uncomment :call tcomment#ResetOption() | if v:count > 0 | call tcomment#SetOption("count", v:count) | endif | let w:tcommentPos = getpos(".") |set opfunc=TCommentOpFunc_Uncommentg@
noremap <Plug>TComment_ _s :TCommentAs =&ft_
noremap <Plug>TComment_ _n :TCommentAs =&ft 
noremap <Plug>TComment_ _a :TCommentAs 
noremap <Plug>TComment_ _b :TCommentBlock
noremap <Plug>TComment_ _r :TCommentRight
xnoremap <Plug>TComment_ _i :TCommentInline
noremap <Plug>TComment_ _  :TComment 
noremap <Plug>TComment_ _p vip:TComment
xnoremap <Plug>TComment_ __ :TCommentMaybeInline
nnoremap <Plug>TComment_ __ :TComment
snoremap <Plug>TComment_ __ :TComment
onoremap <Plug>TComment_ __ :TComment
noremap <Plug>TComment_ca :call tcomment#SetOption("as", input("Comment as: ", &filetype, "customlist,tcomment#complete#Complete"))
noremap <Plug>TComment_cc :call tcomment#SetOption("count", v:count1)
noremap <Plug>TComment_s :TCommentAs =&ft_
noremap <Plug>TComment_n :TCommentAs =&ft 
noremap <Plug>TComment_a :TCommentAs 
noremap <Plug>TComment_b :TCommentBlock
noremap <Plug>TComment_i v:TCommentInline mode=I#
noremap <Plug>TComment_r :TCommentRight
noremap <Plug>TComment_  :TComment 
noremap <Plug>TComment_p m`vip:TComment``
vnoremap <Plug>TComment_ :TCommentMaybeInline
nnoremap <Plug>TComment_ :TComment
onoremap <Plug>TComment_ :TComment
snoremap <silent> <Del> "_c
snoremap <silent> <BS> "_c
snoremap <silent> <C-Tab> :call UltiSnips#ListSnippets()
nnoremap <silent> <Plug>(startify-open-buffers) :call startify#open_buffers()
vnoremap <F3> :!./run.sh
onoremap <F3> :!./run.sh
inoremap <nowait> <silent> <expr>  coc#float#has_scroll() ? "\=coc#float#scroll(0)\" : "\<Left>"
imap  <Del>
inoremap <nowait> <silent> <expr>  coc#float#has_scroll() ? "\=coc#float#scroll(1)\" : "\<Right>"
imap S <Plug>ISurround
imap s <Plug>Isurround
inoremap <silent> 	 =UltiSnips#ExpandSnippet()
inoremap  u[s1z=`]au
inoremap <expr>  complete_info()["selected"] != "-1" ? "\" : "\u\"
imap  <Plug>Isurround
inoremap  u
inoremap  u
imap m <Plug>(emmet-merge-lines)
imap A <Plug>(emmet-anchorize-summary)
imap a <Plug>(emmet-anchorize-url)
imap k <Plug>(emmet-remove-tag)
imap j <Plug>(emmet-split-join-tag)
imap / <Plug>(emmet-toggle-comment)
imap I <Plug>(emmet-image-encode)
imap i <Plug>(emmet-image-size)
imap N <Plug>(emmet-move-prev)
imap n <Plug>(emmet-move-next)
imap D <Plug>(emmet-balance-tag-outword)
imap d <Plug>(emmet-balance-tag-inward)
imap u <Plug>(emmet-update-tag)
imap ; <Plug>(emmet-expand-word)
imap , <Plug>(emmet-expand-abbr)
imap <silent> 9 <Plug>TComment_9
imap <silent> 8 <Plug>TComment_8
imap <silent> 7 <Plug>TComment_7
imap <silent> 6 <Plug>TComment_6
imap <silent> 5 <Plug>TComment_5
imap <silent> 4 <Plug>TComment_4
imap <silent> 3 <Plug>TComment_3
imap <silent> 2 <Plug>TComment_2
imap <silent> 1 <Plug>TComment_1
imap <silent> s <Plug>TComment_s
imap <silent> n <Plug>TComment_n
imap <silent> a <Plug>TComment_a
imap <silent> b <Plug>TComment_b
imap <silent> i <Plug>TComment_i
imap <silent> r <Plug>TComment_r
imap <silent>   <Plug>TComment_ 
imap <silent> p <Plug>TComment_p
imap <silent>  <Plug>TComment_
imap JK 
imap jk 
cnoreabbr make make recode
let &cpo=s:cpo_save
unlet s:cpo_save
set commentstring=;;%s
set completeopt=menu,noselect,menuone,longest,noinsert
set dictionary=/usr/share/dict/spanish,/usr/share/dict/american-english
set expandtab
set fillchars=vert:▏
set helplang=es
set hidden
set ignorecase
set iskeyword=a-z,A-Z,48-57,',.,_
set lazyredraw
set listchars=tab:┊\ ,nbsp:␣,trail:⌁,precedes:«,extends:»
set omnifunc=syntaxcomplete#Complete
set operatorfunc=TCommentOpFunc_gc
set pyxversion=3
set runtimepath=~/.config/nvim,~/.vim/plugged/gruvbox,~/.vim/plugged/iceberg.vim,~/.vim/plugged/vim-code-dark,~/.vim/plugged/Colorizer,~/.vim/plugged/vim-z80,~/.vim/plugged/vim-hexdec,~/.vim/plugged/vim-floaterm,~/.vim/plugged/lightline.vim,~/.vim/plugged/vim-gitbranch,~/.vim/plugged/vim-startify,~/.vim/plugged/ultisnips,~/.vim/plugged/tcomment_vim,~/.vim/plugged/vim-eunuch,~/.vim/plugged/vim-easy-align,~/.vim/plugged/numbers.vim,~/.vim/plugged/popup.nvim,~/.vim/plugged/plenary.nvim,~/.vim/plugged/telescope.nvim,~/.vim/plugged/vim-clap,~/.vim/plugged/vim-clap-sessions,~/.vim/plugged/coc.nvim,~/.vim/plugged/vista.vim,~/.vim/plugged/vim-textobj-line,~/.vim/plugged/vim-textobj-user,~/.vim/plugged/vim-pairify,~/.vim/plugged/neomake,~/.vim/plugged/vim-signify,~/.vim/plugged/undotree,~/.vim/plugged/vim-obsession,~/.vim/plugged/nerdtree,~/.vim/plugged/nerdtree-git-plugin,~/.vim/plugged/vim-devicons,~/.vim/plugged/nvim-web-devicons,~/.vim/plugged/vim-markology,~/.vim/plugged/vim-anzu,~/.vim/plugged/vim-easygrep,~/.vim/plugged/vim-toggle-quickfix,~/.vim/plugged/auto-pairs,~/.vim/plugged/vim-surround,~/.vim/plugged/vim-repeat,~/.vim/plugged/vimspector,~/.vim/plugged/emmet-vim,~/.vim/plugged/vim-matchit,~/.vim/plugged/tagalong.vim,~/.vim/plugged/vimtex,~/.vim/plugged/dart-vim-flutter-layout,~/.vim/plugged/nvim-yarp,~/.vim/plugged/vim-hug-neovim-rpc,~/.vim/plugged/vim-godot,~/.vim/plugged/vim-fugitive,~/.vim/plugged/conflict-marker.vim,~/.vim/plugged/vim-cmake,~/.vim/plugged/gv.vim,~/.vim/plugged/vim-flog,~/.vim/plugged/splitjoin.vim,~/.vim/plugged/vim-pasta,/etc/xdg/nvim,~/.local/share/nvim/site,~/.local/share/flatpak/exports/share/nvim/site,/var/lib/flatpak/exports/share/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/var/lib/snapd/desktop/nvim/site,~/.vim/plugged/vim-polyglot,/usr/share/nvim/runtime,/usr/lib/nvim,~/.vim/plugged/vim-polyglot/after,/var/lib/snapd/desktop/nvim/site/after,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/var/lib/flatpak/exports/share/nvim/site/after,~/.local/share/flatpak/exports/share/nvim/site/after,~/.local/share/nvim/site/after,/etc/xdg/nvim/after,~/.config/nvim/after,~/.vim/plugged/ultisnips/after,~/.vim/plugged/nerdtree-git-plugin/after,~/.vim/plugged/vimtex/after,~/.vim/plugged/dart-vim-flutter-layout/after,/usr/share/vim/vimfiles
set scrolloff=3
set shiftwidth=3
set shortmess=filnxtToOFAI
set showmatch
set noshowmode
set smartcase
set spelllang=en_gb
set splitright
set tabline=%!lightline#tabline()
set tabstop=3
set timeoutlen=500
set title
set undodir=~/.vim/undo-dir
set undofile
set updatetime=100
set viewoptions=folds,cursor,curdir
set wildignore=*.o,*~,*.pyc,*.class,.wakatime-project,*.swp,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set wildignorecase
set window=48
set winminheight=0
set winminwidth=0
" vim: set ft=vim :
