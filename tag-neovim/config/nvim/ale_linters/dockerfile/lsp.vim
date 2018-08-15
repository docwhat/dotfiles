" Author: Christian Höltje (https://docwhat.org/)
" Description: dockerfile Language server integration for ALE
scriptencoding utf-8

call ale#Set('dockerfile_lsp_executable', 'dockerfile-languageserver')
call ale#Set('dockerfile_lsp_use_global', get(g:, 'ale_use_global_executables', 0))

function! ale_linters#dockerfile#lsp#GetExecutable(buffer) abort
    return ale#node#FindExecutable(a:buffer, 'dockerfile_lsp', [
    \   'node_modules/.bin/dockerfile-languageserver',
    \])
endfunction

function! ale_linters#dockerfile#lsp#GetCommand(buffer) abort
    let l:exe = ale#Escape(ale_linters#dockerfile#lsp#GetExecutable(a:buffer))

    return l:exe . ' --stdio'
endfunction

function! ale_linters#dockerfile#lsp#GetProjectRoot(buffer) abort
    let l:git_path = ale#path#FindNearestDirectory(a:buffer, '.git')

    return !empty(l:git_path) ? fnamemodify(l:git_path, ':h:h') : ''
endfunction

call ale#linter#Define('dockerfile', {
\   'name': 'lsp',
\   'lsp': 'stdio',
\   'executable_callback': 'ale_linters#dockerfile#lsp#GetExecutable',
\   'command_callback': 'ale_linters#dockerfile#lsp#GetCommand',
\   'project_root_callback': 'ale_linters#dockerfile#lsp#GetProjectRoot',
\})
