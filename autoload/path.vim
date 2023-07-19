vim9script

export def Completor(findstart: number, base: string): any
    if findstart == 2
	return 1
    elseif findstart == 1
	var line = getline('.')->strpart(0, col('.') - 1)
	var prefix = line->matchstr('\f\+$')
	if prefix == '' || prefix =~ '?$' || prefix =~ '^\k\+$'
	    return -2
	endif
	return col('.') - prefix->strlen()
    endif

    var prefix = base
    var citems = []
    for path in getcompletion(prefix, 'file', 1)
	citems->add({
	    word: path,
	    kind: 'P',
	})
    endfor
    return citems
enddef

import '../autoload/completor.vim'
completor.Register('path', Completor, ['*'], 10)