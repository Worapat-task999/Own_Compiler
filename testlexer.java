import java.io.*;
import java.util.*;
public class testlexer
{
        public static void main(String[] args)
      {
          Scanner scan = new Scanner(System.in);
          System.out.print("Enter your file : ");
          String dirFile = scan.nextLine();
          System.out.println();
          
          try{
              Automata lexer = new Automata(new FileReader(dirFile));
          lexer.yylex();
            }
          catch (IOException ex) {
          }
        }
}