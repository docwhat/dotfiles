" ColorSchemes
if HasPlugin('colorscheme-dracula')
  colorscheme dracula
elseif HasPlugin('colorscheme-gruvbox')
  let g:gruvbox_contrast_dark = 'hard'
  let g:gruvbox_contrast_light = 'hard'
  let g:gruvbox_improved_strings = 0
  let g:gruvbox_improved_warnings = 0
  if $TERM_PROGRAM ==? 'iTerm.app'
    let g:gruvbox_italic=1
  endif
  colorscheme gruvbox
elseif HasPlugin('colorscheme-jellybeans')
  let g:jellybeans_overrides = {}
  let g:jellybeans_overrides['background']           = { 'guibg': 'none' }
  let g:jellybeans_overrides['LineNr']               = { 'attr': 'none', 'guifg': '707090', 'guibg': 'none'   }
  let g:jellybeans_overrides['CursorLineNr']         = { 'attr': 'none', 'guifg': 'a0a0f0', 'guibg': 'none'   }
  let g:jellybeans_overrides['IncSearch']            = { 'attr': 'none', 'guifg': '405060', 'guibg': 'ff8b0f' }
  let g:jellybeans_overrides['Search']               = { 'attr': 'none', 'guifg': '203040', 'guibg': 'f7ff0d' }
  let g:jellybeans_overrides['Boolean']              = { 'attr': 'none', 'guifg': 'c04ccf', 'guibg': 'none'   }

  let g:jellybeans_overrides['SyntasticWarningSign'] = { 'attr': 'none', 'guifg': 'ffdc00', 'guibg': '333333' }
  let g:jellybeans_overrides['SyntasticErrorSign']   = { 'attr': 'none', 'guifg': 'ff4136', 'guibg': '333333' }

  let g:jellybeans_overrides['NeomakeInfoSign']      = { 'attr': 'none', 'guifg': '00dcff', 'guibg': '333333' }
  let g:jellybeans_overrides['NeomakeMessageSign']   = { 'attr': 'none', 'guifg': 'eeeeee', 'guibg': '333333' }
  let g:jellybeans_overrides['NeomakeWarningSign']   = { 'attr': 'none', 'guifg': 'ffdc00', 'guibg': '333333' }
  let g:jellybeans_overrides['NeomakeErrorSign']     = { 'attr': 'none', 'guifg': 'ff4136', 'guibg': '333333' }

  let g:jellybeans_overrides['NeomakeInfo']          = { 'attr': 'none', 'guifg': '0000ff', 'guibg': '333388' }
  let g:jellybeans_overrides['NeomakeMessage']       = { 'attr': 'none', 'guifg': 'ffffff', 'guibg': '333333' }
  let g:jellybeans_overrides['NeomakeWarning']       = { 'attr': 'none', 'guifg': 'ffff00', 'guibg': '888833' }
  let g:jellybeans_overrides['NeomakeError']         = { 'attr': 'none', 'guifg': 'ff0000', 'guibg': '883333' }

  let g:jellybeans_overrides['ALEErrorSign']         = { 'attr': 'none', 'guifg': '990000', 'guibg': '333333' }
  let g:jellybeans_overrides['ALEWarningSign']       = { 'attr': 'none', 'guifg': 'df5f00', 'guibg': '333333' }
  let g:jellybeans_overrides['ALEInfoSign']          = { 'attr': 'none', 'guifg': 'aeee00', 'guibg': '333333' }

  let g:jellybeans_overrides['ALEStyleErrorSign']    = { 'attr': 'none', 'guifg': 'ff0000', 'guibg': '333333' }
  let g:jellybeans_overrides['ALEStyleWarningSign']  = { 'attr': 'none', 'guifg': 'ffff00', 'guibg': '333333' }

  let g:airline_theme='badwolf'
  colorscheme jellybeans
elseif HasPlugin('colorscheme-molokai')
  let g:molokai_original = 1
  let g:rehash256 = 1
  colorscheme molokai
endif

