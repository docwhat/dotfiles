" Author: Christian Höltje (https://docwhat.org/)
" Description: HTML Language server integration for ALE
scriptencoding utf-8

call ale#Set('html_lsp_executable', 'html-languageserver')
call ale#Set('html_lsp_use_global', get(g:, 'ale_use_global_executables', 0))

function! ale_linters#html#lsp#GetExecutable(buffer) abort
    return ale#node#FindExecutable(a:buffer, 'html_lsp', [
    \   'node_modules/.bin/html-languageserver',
    \])
endfunction

function! ale_linters#html#lsp#GetCommand(buffer) abort
    let l:exe = ale#Escape(ale_linters#html#lsp#GetExecutable(a:buffer))

    return l:exe . ' --stdio'
endfunction

function! ale_linters#html#lsp#GetProjectRoot(buffer) abort
    let l:git_path = ale#path#FindNearestDirectory(a:buffer, '.git')

    return !empty(l:git_path) ? fnamemodify(l:git_path, ':h:h') : ''
endfunction

call ale#linter#Define('html', {
\   'name': 'lsp',
\   'lsp': 'stdio',
\   'executable_callback': 'ale_linters#html#lsp#GetExecutable',
\   'command_callback': 'ale_linters#html#lsp#GetCommand',
\   'project_root_callback': 'ale_linters#html#lsp#GetProjectRoot',
\})
