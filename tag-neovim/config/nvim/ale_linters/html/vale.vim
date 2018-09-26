call ale#linter#Define('html', {
            \   'name': 'vale',
            \   'executable': 'vale',
            \   'command': 'vale --output=JSON %t',
            \   'callback': 'ale#handlers#vale#Handle',
            \})
