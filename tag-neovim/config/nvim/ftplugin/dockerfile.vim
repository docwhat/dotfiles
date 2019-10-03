" Prevents multiple invocations
let s:guard = 'b:did_ftplugin_dockerfile' | if exists(s:guard) | finish | endif

if has_key(g:plugs, 'ale')
  let b:ale_fix_on_save = 1
  let b:ale_enabled = 1

  let b:ale_dockerfile_hadolint_use_docker = 'yes'
  let b:ale_dockerfile_hadolint_docker_image = 'docker.io/hadolint/hadolint:latest'

  let b:ale_fixers = ['remove_trailing_lines']
endif


let {s:guard} = 1 " EOF
