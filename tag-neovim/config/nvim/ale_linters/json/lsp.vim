" Author: Christian Höltje (https://docwhat.org/)
" Description: JSON Language server integration for ALE
scriptencoding utf-8

call ale#Set('json_lsp_executable', 'vscode-json-languageserver')
call ale#Set('json_lsp_use_global', get(g:, 'ale_use_global_executables', 0))

function! ale_linters#json#lsp#GetExecutable(buffer) abort
    return ale#node#FindExecutable(a:buffer, 'json_lsp', [
    \   'node_modules/.bin/vscode-json-languageserver',
    \])
endfunction

function! ale_linters#json#lsp#GetCommand(buffer) abort
    let l:exe = ale#Escape(ale_linters#json#lsp#GetExecutable(a:buffer))

    return l:exe . ' --stdio'
endfunction

function! ale_linters#json#lsp#GetProjectRoot(buffer) abort
    let l:git_path = ale#path#FindNearestDirectory(a:buffer, '.git')

    return !empty(l:git_path) ? fnamemodify(l:git_path, ':h:h') : ''
endfunction

call ale#linter#Define('json', {
\   'name': 'lsp',
\   'lsp': 'stdio',
\   'executable_callback': 'ale_linters#json#lsp#GetExecutable',
\   'command_callback': 'ale_linters#json#lsp#GetCommand',
\   'project_root_callback': 'ale_linters#json#lsp#GetProjectRoot',
\})
