import java.util.*;
%%

%class Automata

%public
%type String
%{
ArrayList simpol_table = new ArrayList();
	private void add_identifier(String identifier_name){
		simpol_table.add(identifier_name); 
}
	private int indentifier_num(String identifier_name){

		int i=0;
  	int number = 0;
  	String item="";
		while (i<simpol_table.size()){
			if(identifier_name.equals(simpol_table.get(i)))
			{
	number++;
	}
			i=i+1;
    }
		return number;
  }

%}

identifiers = [A-Za-z]([A-Za-z0-9])*
LineTerminator = \r|\n|\r\n
WhiteSpace = {LineTerminator} | [ \t\f]
string = (\")(.)*(\")
TraditionalComment = "/*"(.)*"*/" 
EndOfLineComment = "//"(.)*
comment_code = {TraditionalComment} | {EndOfLineComment}
integer = 0 | [1-9][0-9]* | "-"[1-9][0-9]*													[0-9][0-9][0-9][0-9]"-"[0-9][0-9]"-"[0-9][0-9]
																							[0-9][0-9]":"[0-9][0-9]":"[0-9][0-9]
double = [1-9][0-9]*"."[0-9]* | 0"."[0-9]* | "-"[1-9][0-9]*"."[0-9]* | "-"0"."[0-9]*
boolean = true | false 

Operator = "+"|"-"|"*"|"/"|"="|">"|">="|"<"|"<="|"=="|"++"|"--"
SpecialChar = ("_"|"@"|"!"|"~"|"#"|"$"|"%"|"^"|"&"|"."|"'"|","|"?"|":"|"{"|"}"|"["|"]")
error = (.)|\n
error_string = (\")+(.)+
error_invalid_identifiers = {identifiers}{SpecialChar}+(\S)*|{integer}*{SpecialChar}+(\S)*|{integer}*({identifiers})*
error_multiple_operator = {Operator}{SpecialChar}+{Operator}*
Keyword = "if"|"then"|"else"|"endif"|"while"|"do"|"endwhile"|"print"|"newline"|"read"
Bracket = \(|\)
%%
<YYINITIAL> {
		{boolean}		{ System.out.println("boolean: "+yytext()); }
		{string}		{ System.out.println("string: "+yytext()); }
		{WhiteSpace}		{ /* just skip what was found, do nothing */ }

		{comment_code}		{}

		";"			{System.out.println("semicolon: "+yytext()); }
		{Keyword}		{System.out.println("keywords: "+yytext()); }
		{identifiers}		{	String iden = yytext();
						int num = indentifier_num(iden);
						if(num == 0 ) System.out.println("new identifier: "+yytext());
						else System.out.printf("identifier \"%s\" already in symbol table\n",yytext());
						add_identifier(iden);
 }
		{Bracket}		{System.out.println("bracket: "+yytext()); }
		{integer} 		{System.out.println("integer: "+yytext()); }
		{double} 		{System.out.println("double: "+yytext()); }
		{Operator}		{System.out.println("operator: "+yytext()); }
	      }
		{error}|{error_string}|{error_invalid_identifiers}|{error_multiple_operator}		{	System.out.println("error: "+yytext());
		
	      }