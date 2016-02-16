/**
 * How to run:
 *
 *   ./bin/syntax \
 *     --grammar examples/s-expression.g \
 *     --mode slr1 \
 *     --parse '(+ 1 15)'
 *
 *   > ['+', 1, 15]
 *
 * See also recursive descent version for this grammar:
 * https://gist.github.com/DmitrySoshnikov/2a434dda67019a4a7c37
 */

{
  "lex": {
    "rules": [
      ["\\s+", "/* skip whitespace */"],
      ["\\d+", "return 'NUMBER';"],
      ["[a-zA-Z\\-\\+\\*\\?\\=/]+\\d*", "return 'SYMBOL';"],
      ["\\(", "return '('"],
      ["\\)", "return ')'"],
    ]
  },

  "bnf": {
    "s-exp": [["atom", "console.log('in atom', $1); return $$ = $1;"],
              ["list", "console.log('in list', $1); return $$ = $1;"]],

     "list": [["( list-entries )", "$$ = []; $$.push.apply($$, $2);"]],

     "list-entries": [["s-exp list-entries", "$$ = []; $$.push($1); $$.push.apply($$, $2);"],
                      ["ε", "$$ = [];"]],

     "atom": [["NUMBER", "console.log('XXX', yytext); $$ = Number(yytext);"],
              ["SYMBOL", "console.log('YYY', yytext); $$ = String(yytext);"]]
  }
}