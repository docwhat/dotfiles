" Return the root of the git repository.
function! GetGitRoot()
  let root = split(system('git rev-parse --show-toplevel'), '\n')[0]
  return v:shell_error ? '' : root
endfunction
