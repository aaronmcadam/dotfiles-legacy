function! test#javascript#teaspoon#test_file(file) abort
 return a:file =~# '\v_spec\.(js|coffee|js.coffee)$'
endfunction

function! test#javascript#teaspoon#build_position(type, position) abort
  if a:type == 'nearest'
    " return [a:position['file'].':'.a:position['line']]
    return [a:position['file']]
  elseif a:type == 'file'
    return [a:position['file']]
  else
    return []
  endif
endfunction

function! test#javascript#teaspoon#build_args(args) abort
  return a:args
endfunction

function! test#javascript#teaspoon#executable() abort
  if filereadable('./bin/teaspoon')
    return './bin/teaspoon'
  elseif filereadable('Gemfile')
    return 'bundle exec teaspoon'
  else
    return 'teaspoon'
  endif
endfunction
