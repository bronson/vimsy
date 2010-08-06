" Language:    CoffeeScript
" Maintainer:  Mick Koch <kchmck@gmail.com>
" URL:         http://github.com/kchmck/vim-coffee-script
" License:     WTFPL

if exists("b:current_syntax")
  finish
endif

if version < 600
  syntax clear
endif

let b:current_syntax = "coffee"

syntax sync minlines=100

" CoffeeScript allows dollar signs in identifiers
setlocal isident+=$

syntax keyword coffeeStatement return break continue throw
highlight default link coffeeStatement Statement

syntax keyword coffeeRepeat for while until loop
highlight default link coffeeRepeat Repeat

syntax keyword coffeeConditional if else unless switch when then
highlight default link coffeeConditional Conditional

syntax keyword coffeeException try catch finally
highlight default link coffeeException Exception

syntax keyword coffeeOperator instanceof typeof delete
highlight default link coffeeOperator Operator

syntax keyword coffeeKeyword new in of by where and or not is isnt
\                            class extends super all
highlight default link coffeeKeyword Keyword

syntax keyword coffeeBoolean true on yes false off no
highlight default link coffeeBoolean Boolean

syntax keyword coffeeGlobal null undefined
highlight default link coffeeGlobal Type

syntax cluster coffeeReserved contains=coffeeStatement,coffeeRepeat,
\                                      coffeeConditional,coffeeException,
\                                      coffeeOperator,coffeeKeyword,
\                                      coffeeBoolean,coffeeGlobal

syntax keyword coffeeAssignmentMod and or contained
syntax match coffeeAssignmentMod /&&\|||\|?\|+\|-\|\/\|\*\|%/ contained
highlight default link coffeeAssignmentMod SpecialChar

syntax match coffeeAssignmentChar /:\|=/ contained
highlight default link coffeeAssignmentChar SpecialChar

syntax keyword coffeeVar this prototype arguments
" Matches @-variables like @abc
syntax match coffeeVar /@\%(\I\i*\)\?/
highlight default link coffeeVar Type

syntax match coffeeAssignment /@\?\I\%(\i\|::\|\.\|\[.\+\]\)*\s*\%(::\@!\|[^ \t=]\{,3}==\@!\)/
\                             contains=@coffeeIdentifier,coffeeAssignmentMod,
\                                       coffeeAssignmentChar,coffeeBrackets
highlight default link coffeeAssignment Identifier

" Matches class-like names that start with a capital letter, like Array or
" Object
syntax match coffeeObject /\<\u\w*\>/
highlight default link coffeeObject Structure

" Matches constant-like names in SCREAMING_CAPS
syntax match coffeeConstant /\<\u[A-Z0-9_]\+\>/
highlight default link coffeeConstant Constant

syntax match coffeePrototype /::/
highlight default link coffeePrototype SpecialChar

" What can make up a variable name
syntax cluster coffeeIdentifier contains=coffeeVar,coffeeObject,coffeeConstant,
\                                        coffeePrototype

syntax match coffeeFunction /->\|=>/
highlight default link coffeeFunction Function

syntax keyword coffeeTodo TODO FIXME XXX contained
highlight default link coffeeTodo Todo

syntax match coffeeComment /#.*/ contains=@Spell,coffeeTodo
syntax match coffeeComment /####\@!\_.\{-}###/ contains=@Spell,coffeeTodo
highlight default link coffeeComment Comment

syntax region coffeeEmbed start=/`/ end=/`/
highlight default link coffeeEmbed Special

" Matches numbers like -10, -10e8, -10E8, 10, 10e8, 10E8
syntax match coffeeNumber /\<-\?\d\+\%([eE][+-]\?\d\+\)\?\>/
" Matches hex numbers like 0xfff, 0x000
syntax match coffeeNumber /\<0[xX]\x\+\>/
highlight default link coffeeNumber Number

" Matches floating-point numbers like -10.42e8, 10.42e-8
syntax match coffeeFloat /-\?\d*\.\@<!\.\d\+\%([eE][+-]\?\d\+\)\?/
highlight default link coffeeFloat Float

syntax region coffeeInterpolation matchgroup=coffeeInterpDelim
\                                 start=/\#{/ end=/}/
\                                 contained contains=TOP
highlight default link coffeeInterpDelim Delimiter

syntax match coffeeInterpSimple /\#@\?\I\%(\i\|\.\)*/ contained
highlight default link coffeeInterpSimple Identifier

syntax match coffeeEscape /\\\d\d\d\|\\x\x\{2\}\|\\u\x\{4\}\|\\./ contained
highlight default link coffeeEscape SpecialChar

syntax cluster coffeeSimpleString contains=@Spell,coffeeEscape
syntax cluster coffeeInterpString contains=@coffeeSimpleString,coffeeInterpSimple,
\                                          coffeeInterpolation

syntax region coffeeRegExp start=/\// end=/\/[gimy]\{,4}/ oneline
\                          contains=@coffeeInterpString
highlight default link coffeeRegExp String

syntax region coffeeString start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=@coffeeInterpString
syntax region coffeeString start=/'/ skip=/\\\\\|\\'/ end=/'/ contains=@coffeeSimpleString
highlight default link coffeeString String

syntax region coffeeHeredoc start=/"""/ end=/"""/ contains=@coffeeInterpString
syntax region coffeeHeredoc start=/'''/ end=/'''/ contains=@coffeeSimpleString
highlight default link coffeeHeredoc String

syntax region coffeeCurlies start=/{/ end=/}/ contains=TOP
syntax region coffeeBrackets start=/\[/ end=/\]/ contains=ALLBUT,coffeeAssignment
syntax region coffeeParens start=/(/ end=/)/ contains=TOP

" Displays an error for trailing whitespace
if !exists("coffee_no_trailing_space_error")
  syntax match coffeeSpaceError /\s\+$/ display
  highlight default link coffeeSpaceError Error
endif

" Displays an error for trailing semicolons
if !exists("coffee_no_trailing_semicolon_error")
  syntax match coffeeSemicolonError /;$/ display
  highlight default link coffeeSemicolonError Error
endif

" Displays an error for reserved words
if !exists("coffee_no_reserved_words_error")
  syntax keyword coffeeReservedError case default do function var void with const
  \                                  let enum export import native __hasProp
  \                                  __extends __slice
  highlight default link coffeeReservedError Error
endif

" Reserved words can be used as dot-properties
syntax match coffeeDot /\.\@<!\.\i\+/ transparent
\                                     contains=ALLBUT,@coffeeReserved,
\                                                      coffeeReservedError
