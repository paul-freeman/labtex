/* The following code was generated by JFlex 1.6.1 */

/* JFlex file: Labtex language lexer specification */
/* http://www.jflex.de/manual.html#CUPWork */

package nz.ac.auckland.labtex.generated;
import java_cup.runtime.*;

/**
 * A lexer class for the custom Labtex language used by Lablet
 */

public class LabLexer implements java_cup.runtime.Scanner {

  /** This character denotes the end of file */
  public static final int YYEOF = -1;

  /** initial size of the lookahead buffer */
  private static final int ZZ_BUFFERSIZE = 16384;

  /** lexical states */
  public static final int YYINITIAL = 0;
  public static final int TITLE = 2;
  public static final int TITLED = 4;
  public static final int SHEET = 6;
  public static final int YYINITIAL2 = 8;
  public static final int STRING = 10;

  /**
   * ZZ_LEXSTATE[l] is the state in the DFA for the lexical state l
   * ZZ_LEXSTATE[l+1] is the state in the DFA for the lexical state l
   *                  at the beginning of a line
   * l is of the form l = 2*k, k a non negative integer
   */
  private static final int ZZ_LEXSTATE[] = { 
     0,  0,  1,  1,  2,  2,  3,  3,  4,  4,  5, 5
  };

  /** 
   * Translates characters to character classes
   */
  private static final String ZZ_CMAP_PACKED = 
    "\11\0\1\3\1\2\1\0\1\3\1\1\22\0\1\3\1\0\1\36"+
    "\2\0\1\0\12\0\12\35\7\0\32\35\1\4\1\10\1\5\3\0"+
    "\1\20\1\15\1\31\1\24\1\14\1\35\1\16\1\22\1\12\1\35"+
    "\1\32\1\13\1\35\1\17\1\25\1\26\1\35\1\30\1\21\1\11"+
    "\1\35\1\23\1\34\1\27\1\35\1\33\1\6\1\0\1\7\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uff92\0";

  /** 
   * Translates characters to character classes
   */
  private static final char [] ZZ_CMAP = zzUnpackCMap(ZZ_CMAP_PACKED);

  /** 
   * Translates DFA states to action switch labels.
   */
  private static final int [] ZZ_ACTION = zzUnpackAction();

  private static final String ZZ_ACTION_PACKED_0 =
    "\7\0\2\1\1\0\1\2\1\3\1\4\2\1\1\0"+
    "\3\5\1\6\1\7\1\5\1\10\1\11\1\12\1\13"+
    "\1\14\2\1\12\0\1\15\40\0\1\16\6\0\1\16"+
    "\12\0\2\1\3\0\2\1\45\0\1\17\15\0\1\20"+
    "\1\21\10\0\1\17\1\22\15\0\1\20\1\21\2\0"+
    "\1\23\10\0\1\22\13\0\1\24\10\0\1\25\14\0"+
    "\1\26\4\0\1\26\31\0\1\27\1\0\1\30\1\27"+
    "\1\30";

  private static int [] zzUnpackAction() {
    int [] result = new int[256];
    int offset = 0;
    offset = zzUnpackAction(ZZ_ACTION_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackAction(String packed, int offset, int [] result) {
    int i = 0;       /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int count = packed.charAt(i++);
      int value = packed.charAt(i++);
      do result[j++] = value; while (--count > 0);
    }
    return j;
  }


  /** 
   * Translates a state to a row index in the transition table
   */
  private static final int [] ZZ_ROWMAP = zzUnpackRowMap();

  private static final String ZZ_ROWMAP_PACKED_0 =
    "\0\0\0\37\0\76\0\135\0\174\0\233\0\272\0\331"+
    "\0\370\0\u0117\0\u0136\0\174\0\174\0\u0155\0\u0174\0\u0193"+
    "\0\174\0\u01b2\0\u01d1\0\174\0\u01f0\0\u020f\0\174\0\174"+
    "\0\u022e\0\174\0\174\0\u024d\0\174\0\370\0\u026c\0\u028b"+
    "\0\u02aa\0\u0174\0\u02c9\0\u02e8\0\u01b2\0\u020f\0\u01d1\0\174"+
    "\0\u0307\0\u0326\0\u0345\0\u0364\0\u0383\0\u03a2\0\u03c1\0\u03e0"+
    "\0\u03ff\0\u041e\0\u043d\0\u045c\0\u047b\0\u049a\0\u04b9\0\u04d8"+
    "\0\u04f7\0\u0516\0\u0535\0\u0554\0\u0573\0\u0592\0\u05b1\0\u05d0"+
    "\0\u05ef\0\u060e\0\u062d\0\u064c\0\u066b\0\u068a\0\u06a9\0\u06c8"+
    "\0\272\0\u06e7\0\u0706\0\u0725\0\u0744\0\u0763\0\u0782\0\174"+
    "\0\u07a1\0\u07c0\0\u07df\0\u07fe\0\u081d\0\u083c\0\u085b\0\u087a"+
    "\0\u0899\0\u08b8\0\u08d7\0\u0899\0\u08f6\0\u0915\0\u0934\0\u0953"+
    "\0\u0934\0\u0972\0\u0991\0\u09b0\0\u09cf\0\u09ee\0\u0a0d\0\u0a2c"+
    "\0\u0a4b\0\u0a6a\0\u0a89\0\u0aa8\0\u0ac7\0\u0ae6\0\u0b05\0\u0b24"+
    "\0\u0b43\0\u0b62\0\u0b81\0\u0ba0\0\u0bbf\0\u0bde\0\u0bfd\0\u0c1c"+
    "\0\u0c3b\0\u0c5a\0\u0c79\0\u0c98\0\u0cb7\0\u0cd6\0\u0cf5\0\u0d14"+
    "\0\u0d33\0\u0d52\0\u0d71\0\u0d90\0\u0daf\0\u0dce\0\u0ded\0\u0e0c"+
    "\0\u0e2b\0\u0e4a\0\u0e69\0\u0e88\0\u0ea7\0\u0ec6\0\u0ee5\0\u0f04"+
    "\0\u0f23\0\u0f42\0\u0f61\0\u0f80\0\u0f9f\0\u0fbe\0\u0fdd\0\u0ffc"+
    "\0\u101b\0\u103a\0\u1059\0\u1078\0\u1097\0\u10b6\0\174\0\u10d5"+
    "\0\u10f4\0\u1113\0\u1132\0\u1151\0\u1170\0\u118f\0\u11ae\0\u11cd"+
    "\0\u11ec\0\u120b\0\u122a\0\u1249\0\u1268\0\174\0\174\0\u1287"+
    "\0\u12a6\0\174\0\u12c5\0\u12e4\0\u1303\0\u1322\0\u1341\0\u1360"+
    "\0\u137f\0\u139e\0\174\0\u13bd\0\u13dc\0\u13fb\0\u141a\0\u1439"+
    "\0\u1458\0\u1477\0\u1496\0\u14b5\0\u14d4\0\u14f3\0\174\0\u1512"+
    "\0\u1531\0\u1550\0\u156f\0\u158e\0\u15ad\0\u15cc\0\u15eb\0\174"+
    "\0\u160a\0\u1629\0\u1648\0\u1667\0\u1686\0\u16a5\0\u16c4\0\u16e3"+
    "\0\u1702\0\u1721\0\u1740\0\u175f\0\272\0\u177e\0\u179d\0\u17bc"+
    "\0\u17db\0\174\0\u17fa\0\u1819\0\u1838\0\u1857\0\u1876\0\u1895"+
    "\0\u18b4\0\u18d3\0\u18f2\0\u1911\0\u1930\0\u194f\0\u196e\0\u198d"+
    "\0\u19ac\0\u19cb\0\u19ea\0\u1a09\0\u1a28\0\u1a47\0\u1a66\0\u1a85"+
    "\0\u1aa4\0\u1ac3\0\u1ae2\0\272\0\u1b01\0\272\0\174\0\174";

  private static int [] zzUnpackRowMap() {
    int [] result = new int[256];
    int offset = 0;
    offset = zzUnpackRowMap(ZZ_ROWMAP_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackRowMap(String packed, int offset, int [] result) {
    int i = 0;  /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int high = packed.charAt(i++) << 16;
      result[j++] = high | packed.charAt(i++);
    }
    return j;
  }

  /** 
   * The transition table of the DFA
   */
  private static final int [] ZZ_TRANS = zzUnpackTrans();

  private static final String ZZ_TRANS_PACKED_0 =
    "\1\7\1\10\1\11\1\1\4\7\1\12\26\7\6\13"+
    "\1\14\1\15\27\13\1\7\1\16\1\17\1\3\4\7"+
    "\1\20\26\7\1\21\3\22\1\23\1\21\1\24\1\25"+
    "\1\26\25\27\1\21\37\0\1\30\3\31\3\30\1\32"+
    "\26\30\1\33\1\7\1\34\1\35\34\7\1\0\1\36"+
    "\1\11\1\36\4\0\1\37\27\0\3\36\4\0\1\37"+
    "\26\0\1\7\1\34\1\35\6\7\1\40\3\7\1\41"+
    "\21\7\6\13\2\0\27\13\1\0\1\42\1\17\1\42"+
    "\4\0\1\43\27\0\3\42\4\0\1\43\26\0\1\7"+
    "\1\34\1\35\12\7\1\44\21\7\1\0\3\45\4\0"+
    "\1\46\26\0\5\47\1\50\31\47\1\0\3\25\46\0"+
    "\1\51\1\52\5\0\1\53\15\0\3\31\35\0\1\35"+
    "\45\0\1\54\3\0\1\55\21\0\1\7\1\34\1\35"+
    "\7\7\1\56\25\7\1\34\1\35\11\7\1\57\22\7"+
    "\15\0\1\60\21\0\1\7\1\34\1\35\11\7\1\61"+
    "\22\7\20\0\1\62\35\0\1\63\44\0\1\64\23\0"+
    "\1\65\40\0\1\66\22\0\1\7\1\34\1\35\6\7"+
    "\1\67\26\7\1\34\1\35\13\7\1\70\20\7\14\0"+
    "\1\71\22\0\1\7\1\34\1\35\13\7\1\72\20\7"+
    "\15\0\1\73\45\0\1\74\42\0\1\75\17\0\1\76"+
    "\43\0\1\77\20\0\1\7\1\34\1\35\10\7\1\100"+
    "\24\7\1\34\1\35\7\7\1\101\24\7\16\0\1\102"+
    "\20\0\1\7\1\34\1\35\7\7\1\103\24\7\13\0"+
    "\1\104\31\0\1\105\42\0\1\106\37\0\1\107\35\0"+
    "\1\110\24\0\1\7\1\34\1\35\11\7\1\111\23\7"+
    "\1\34\1\35\14\7\1\112\17\7\12\0\1\113\24\0"+
    "\1\7\1\34\1\35\14\7\1\114\17\7\14\0\1\115"+
    "\35\0\1\116\56\0\1\117\17\0\1\120\41\0\1\121"+
    "\17\0\1\7\1\34\1\35\1\7\1\122\1\7\1\123"+
    "\30\7\17\0\1\124\17\0\1\7\1\34\1\35\1\7"+
    "\1\125\1\7\1\123\30\7\11\0\1\126\45\0\1\127"+
    "\43\0\1\130\15\0\1\131\1\0\1\132\30\0\1\122"+
    "\1\133\1\134\2\122\1\135\31\122\1\7\1\34\1\35"+
    "\10\7\1\136\23\7\4\0\1\137\1\0\1\132\30\0"+
    "\1\125\1\140\1\141\2\125\1\142\31\125\11\0\1\143"+
    "\10\0\1\144\1\145\5\0\1\146\22\0\1\147\40\0"+
    "\1\150\17\0\5\131\1\151\31\131\13\0\1\152\23\0"+
    "\2\131\1\134\2\131\1\151\31\131\1\7\1\34\1\35"+
    "\3\7\1\153\31\7\1\34\1\35\15\7\1\154\16\7"+
    "\5\137\1\155\33\137\1\141\2\137\1\155\31\137\1\7"+
    "\1\34\1\35\3\7\1\156\30\7\14\0\1\157\36\0"+
    "\1\160\34\0\1\161\46\0\1\162\27\0\1\163\34\0"+
    "\1\164\33\0\1\165\50\0\1\166\16\0\1\7\1\34"+
    "\1\35\10\7\1\167\24\7\1\34\1\35\12\7\1\170"+
    "\21\7\6\0\1\171\30\0\1\7\1\34\1\35\10\7"+
    "\1\172\23\7\27\0\1\173\27\0\1\174\42\0\1\175"+
    "\26\0\1\176\36\0\1\177\42\0\1\200\31\0\1\201"+
    "\40\0\1\202\21\0\1\7\1\34\1\35\15\7\1\203"+
    "\17\7\1\34\1\35\10\7\1\204\23\7\13\0\1\205"+
    "\23\0\1\7\1\34\1\35\15\7\1\206\16\7\11\0"+
    "\1\207\51\0\1\210\26\0\1\211\53\0\1\212\16\0"+
    "\1\213\40\0\1\214\43\0\1\215\31\0\1\216\23\0"+
    "\1\7\1\34\1\35\12\7\1\217\22\7\1\34\1\35"+
    "\11\7\1\220\22\7\20\0\1\221\16\0\1\7\1\34"+
    "\1\35\12\7\1\222\21\7\4\0\1\223\46\0\1\224"+
    "\47\0\1\225\43\0\1\226\25\0\1\227\26\0\1\230"+
    "\42\0\1\231\35\0\1\232\22\0\1\7\1\34\1\35"+
    "\10\7\1\233\24\7\1\34\1\35\6\7\1\234\25\7"+
    "\15\0\1\235\21\0\1\7\1\34\1\35\10\7\1\236"+
    "\23\7\5\223\1\237\31\223\30\0\1\240\12\0\1\241"+
    "\36\0\1\242\54\0\1\243\36\0\1\244\11\0\1\245"+
    "\15\0\1\246\34\0\1\247\25\0\1\7\1\34\1\35"+
    "\11\7\1\250\23\7\1\34\1\35\16\7\1\251\1\7"+
    "\1\252\13\7\13\0\1\253\23\0\1\7\1\34\1\35"+
    "\11\7\1\254\22\7\4\0\1\255\32\0\5\241\1\256"+
    "\31\241\5\242\1\257\31\242\14\0\1\260\52\0\1\261"+
    "\33\0\1\262\25\0\1\263\43\0\1\264\1\0\1\265"+
    "\13\0\1\7\1\34\1\35\6\7\1\266\26\7\1\34"+
    "\1\35\17\7\1\267\15\7\1\34\1\35\7\7\1\270"+
    "\24\7\14\0\1\271\22\0\1\7\1\34\1\35\6\7"+
    "\1\272\25\7\5\255\1\273\31\255\14\0\1\274\36\0"+
    "\1\275\33\0\1\276\47\0\1\277\26\0\1\300\24\0"+
    "\1\7\1\34\1\35\16\7\1\251\1\7\1\301\14\7"+
    "\1\34\1\35\11\7\1\302\23\7\1\34\1\35\21\7"+
    "\1\303\12\7\11\0\1\304\25\0\1\7\1\34\1\35"+
    "\16\7\1\251\1\7\1\305\13\7\11\0\1\306\41\0"+
    "\1\307\43\0\1\264\1\0\1\310\27\0\1\311\46\0"+
    "\1\312\12\0\1\7\1\34\1\35\7\7\1\313\25\7"+
    "\1\34\1\35\11\7\1\314\23\7\1\34\1\35\11\7"+
    "\1\315\22\7\21\0\1\264\1\0\1\316\13\0\1\7"+
    "\1\34\1\35\7\7\1\317\24\7\7\0\1\320\41\0"+
    "\1\321\40\0\1\322\36\0\1\323\22\0\1\7\1\34"+
    "\1\35\21\7\1\324\13\7\1\34\1\35\6\7\1\325"+
    "\26\7\1\34\1\35\22\7\1\326\11\7\12\0\1\327"+
    "\24\0\1\7\1\34\1\35\21\7\1\330\12\7\24\0"+
    "\1\331\23\0\1\332\52\0\1\333\11\0\1\7\1\34"+
    "\1\35\11\7\1\334\23\7\1\34\1\35\4\7\1\335"+
    "\30\7\1\34\1\35\23\7\1\336\10\7\24\0\1\337"+
    "\12\0\1\7\1\34\1\35\11\7\1\340\22\7\14\0"+
    "\1\341\31\0\1\342\55\0\1\343\10\0\1\7\1\34"+
    "\1\35\22\7\1\344\12\7\1\34\1\35\15\7\1\345"+
    "\16\7\14\0\1\346\22\0\1\7\1\34\1\35\22\7"+
    "\1\347\11\7\25\0\1\350\31\0\1\351\16\0\1\7"+
    "\1\34\1\35\23\7\1\352\11\7\1\34\1\35\13\7"+
    "\1\353\20\7\25\0\1\354\11\0\1\7\1\34\1\35"+
    "\23\7\1\355\10\7\26\0\1\356\26\0\1\357\20\0"+
    "\1\7\1\34\1\35\15\7\1\360\17\7\1\34\1\35"+
    "\11\7\1\325\22\7\26\0\1\361\10\0\1\7\1\34"+
    "\1\35\15\7\1\362\16\7\20\0\1\363\32\0\1\332"+
    "\22\0\1\7\1\34\1\35\13\7\1\364\20\7\20\0"+
    "\1\365\16\0\1\7\1\34\1\35\13\7\1\366\20\7"+
    "\16\0\1\367\20\0\1\7\1\34\1\35\11\7\1\370"+
    "\22\7\16\0\1\371\20\0\1\7\1\34\1\35\11\7"+
    "\1\372\22\7\14\0\1\373\22\0\1\7\1\34\1\35"+
    "\4\7\1\374\27\7\14\0\1\375\22\0\1\7\1\34"+
    "\1\35\4\7\1\376\27\7\7\0\1\377\36\0\1\u0100"+
    "\27\0";

  private static int [] zzUnpackTrans() {
    int [] result = new int[6944];
    int offset = 0;
    offset = zzUnpackTrans(ZZ_TRANS_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackTrans(String packed, int offset, int [] result) {
    int i = 0;       /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int count = packed.charAt(i++);
      int value = packed.charAt(i++);
      value--;
      do result[j++] = value; while (--count > 0);
    }
    return j;
  }


  /* error codes */
  private static final int ZZ_UNKNOWN_ERROR = 0;
  private static final int ZZ_NO_MATCH = 1;
  private static final int ZZ_PUSHBACK_2BIG = 2;

  /* error messages for the codes above */
  private static final String ZZ_ERROR_MSG[] = {
    "Unknown internal scanner error",
    "Error: could not match input",
    "Error: pushback value was too large"
  };

  /**
   * ZZ_ATTRIBUTE[aState] contains the attributes of state <code>aState</code>
   */
  private static final int [] ZZ_ATTRIBUTE = zzUnpackAttribute();

  private static final String ZZ_ATTRIBUTE_PACKED_0 =
    "\4\0\1\10\2\0\2\1\1\0\1\1\2\11\2\1"+
    "\1\0\1\11\2\1\1\11\2\1\2\11\1\1\2\11"+
    "\1\1\1\11\12\0\1\11\40\0\1\1\6\0\1\11"+
    "\12\0\2\1\3\0\2\1\45\0\1\1\15\0\2\1"+
    "\10\0\1\11\1\1\15\0\2\11\2\0\1\11\10\0"+
    "\1\11\13\0\1\11\10\0\1\11\14\0\1\1\4\0"+
    "\1\11\31\0\1\1\1\0\1\1\2\11";

  private static int [] zzUnpackAttribute() {
    int [] result = new int[256];
    int offset = 0;
    offset = zzUnpackAttribute(ZZ_ATTRIBUTE_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackAttribute(String packed, int offset, int [] result) {
    int i = 0;       /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int count = packed.charAt(i++);
      int value = packed.charAt(i++);
      do result[j++] = value; while (--count > 0);
    }
    return j;
  }

  /** the input device */
  private java.io.Reader zzReader;

  /** the current state of the DFA */
  private int zzState;

  /** the current lexical state */
  private int zzLexicalState = YYINITIAL;

  /** this buffer contains the current text to be matched and is
      the source of the yytext() string */
  private char zzBuffer[] = new char[ZZ_BUFFERSIZE];

  /** the textposition at the last accepting state */
  private int zzMarkedPos;

  /** the current text position in the buffer */
  private int zzCurrentPos;

  /** startRead marks the beginning of the yytext() string in the buffer */
  private int zzStartRead;

  /** endRead marks the last character in the buffer, that has been read
      from input */
  private int zzEndRead;

  /** number of newlines encountered up to the start of the matched text */
  private int yyline;

  /** the number of characters up to the start of the matched text */
  private int yychar;

  /**
   * the number of characters from the last newline up to the start of the 
   * matched text
   */
  private int yycolumn;

  /** 
   * zzAtBOL == true <=> the scanner is currently at the beginning of a line
   */
  private boolean zzAtBOL = true;

  /** zzAtEOF == true <=> the scanner is at the EOF */
  private boolean zzAtEOF;

  /** denotes if the user-EOF-code has already been executed */
  private boolean zzEOFDone;
  
  /** 
   * The number of occupied positions in zzBuffer beyond zzEndRead.
   * When a lead/high surrogate has been read from the input stream
   * into the final zzBuffer position, this will have a value of 1;
   * otherwise, it will have a value of 0.
   */
  private int zzFinalHighSurrogate = 0;

  /* user code: */
	StringBuffer string = new StringBuffer();

	private Symbol symbol(int type) {
		return new Symbol(type, yyline, yycolumn);
	}
	private Symbol symbol(int type, Object value) {
		return new Symbol(type, yyline, yycolumn, value);
	}


  /**
   * Creates a new scanner
   *
   * @param   in  the java.io.Reader to read input from.
   */
  public LabLexer(java.io.Reader in) {
    this.zzReader = in;
  }


  /** 
   * Unpacks the compressed character translation table.
   *
   * @param packed   the packed character translation table
   * @return         the unpacked character translation table
   */
  private static char [] zzUnpackCMap(String packed) {
    char [] map = new char[0x110000];
    int i = 0;  /* index in packed string  */
    int j = 0;  /* index in unpacked array */
    while (i < 132) {
      int  count = packed.charAt(i++);
      char value = packed.charAt(i++);
      do map[j++] = value; while (--count > 0);
    }
    return map;
  }


  /**
   * Refills the input buffer.
   *
   * @return      <code>false</code>, iff there was new input.
   * 
   * @exception   java.io.IOException  if any I/O-Error occurs
   */
  private boolean zzRefill() throws java.io.IOException {

    /* first: make room (if you can) */
    if (zzStartRead > 0) {
      zzEndRead += zzFinalHighSurrogate;
      zzFinalHighSurrogate = 0;
      System.arraycopy(zzBuffer, zzStartRead,
                       zzBuffer, 0,
                       zzEndRead-zzStartRead);

      /* translate stored positions */
      zzEndRead-= zzStartRead;
      zzCurrentPos-= zzStartRead;
      zzMarkedPos-= zzStartRead;
      zzStartRead = 0;
    }

    /* is the buffer big enough? */
    if (zzCurrentPos >= zzBuffer.length - zzFinalHighSurrogate) {
      /* if not: blow it up */
      char newBuffer[] = new char[zzBuffer.length*2];
      System.arraycopy(zzBuffer, 0, newBuffer, 0, zzBuffer.length);
      zzBuffer = newBuffer;
      zzEndRead += zzFinalHighSurrogate;
      zzFinalHighSurrogate = 0;
    }

    /* fill the buffer with new input */
    int requested = zzBuffer.length - zzEndRead;
    int numRead = zzReader.read(zzBuffer, zzEndRead, requested);

    /* not supposed to occur according to specification of java.io.Reader */
    if (numRead == 0) {
      throw new java.io.IOException("Reader returned 0 characters. See JFlex examples for workaround.");
    }
    if (numRead > 0) {
      zzEndRead += numRead;
      /* If numRead == requested, we might have requested to few chars to
         encode a full Unicode character. We assume that a Reader would
         otherwise never return half characters. */
      if (numRead == requested) {
        if (Character.isHighSurrogate(zzBuffer[zzEndRead - 1])) {
          --zzEndRead;
          zzFinalHighSurrogate = 1;
        }
      }
      /* potentially more input available */
      return false;
    }

    /* numRead < 0 ==> end of stream */
    return true;
  }

    
  /**
   * Closes the input stream.
   */
  public final void yyclose() throws java.io.IOException {
    zzAtEOF = true;            /* indicate end of file */
    zzEndRead = zzStartRead;  /* invalidate buffer    */

    if (zzReader != null)
      zzReader.close();
  }


  /**
   * Resets the scanner to read from a new input stream.
   * Does not close the old reader.
   *
   * All internal variables are reset, the old input stream 
   * <b>cannot</b> be reused (internal buffer is discarded and lost).
   * Lexical state is set to <tt>ZZ_INITIAL</tt>.
   *
   * Internal scan buffer is resized down to its initial length, if it has grown.
   *
   * @param reader   the new input stream 
   */
  public final void yyreset(java.io.Reader reader) {
    zzReader = reader;
    zzAtBOL  = true;
    zzAtEOF  = false;
    zzEOFDone = false;
    zzEndRead = zzStartRead = 0;
    zzCurrentPos = zzMarkedPos = 0;
    zzFinalHighSurrogate = 0;
    yyline = yychar = yycolumn = 0;
    zzLexicalState = YYINITIAL;
    if (zzBuffer.length > ZZ_BUFFERSIZE)
      zzBuffer = new char[ZZ_BUFFERSIZE];
  }


  /**
   * Returns the current lexical state.
   */
  public final int yystate() {
    return zzLexicalState;
  }


  /**
   * Enters a new lexical state
   *
   * @param newState the new lexical state
   */
  public final void yybegin(int newState) {
    zzLexicalState = newState;
  }


  /**
   * Returns the text matched by the current regular expression.
   */
  public final String yytext() {
    return new String( zzBuffer, zzStartRead, zzMarkedPos-zzStartRead );
  }


  /**
   * Returns the character at position <tt>pos</tt> from the 
   * matched text. 
   * 
   * It is equivalent to yytext().charAt(pos), but faster
   *
   * @param pos the position of the character to fetch. 
   *            A value from 0 to yylength()-1.
   *
   * @return the character at position pos
   */
  public final char yycharat(int pos) {
    return zzBuffer[zzStartRead+pos];
  }


  /**
   * Returns the length of the matched text region.
   */
  public final int yylength() {
    return zzMarkedPos-zzStartRead;
  }


  /**
   * Reports an error that occured while scanning.
   *
   * In a wellformed scanner (no or only correct usage of 
   * yypushback(int) and a match-all fallback rule) this method 
   * will only be called with things that "Can't Possibly Happen".
   * If this method is called, something is seriously wrong
   * (e.g. a JFlex bug producing a faulty scanner etc.).
   *
   * Usual syntax/scanner level error handling should be done
   * in error fallback rules.
   *
   * @param   errorCode  the code of the errormessage to display
   */
  private void zzScanError(int errorCode) {
    String message;
    try {
      message = ZZ_ERROR_MSG[errorCode];
    }
    catch (ArrayIndexOutOfBoundsException e) {
      message = ZZ_ERROR_MSG[ZZ_UNKNOWN_ERROR];
    }

    throw new Error(message);
  } 


  /**
   * Pushes the specified amount of characters back into the input stream.
   *
   * They will be read again by then next call of the scanning method
   *
   * @param number  the number of characters to be read again.
   *                This number must not be greater than yylength()!
   */
  public void yypushback(int number)  {
    if ( number > yylength() )
      zzScanError(ZZ_PUSHBACK_2BIG);

    zzMarkedPos -= number;
  }


  /**
   * Contains user EOF-code, which will be executed exactly once,
   * when the end of file is reached
   */
  private void zzDoEOF() throws java.io.IOException {
    if (!zzEOFDone) {
      zzEOFDone = true;
      yyclose();
    }
  }


  /**
   * Resumes scanning until the next regular expression is matched,
   * the end of input is encountered or an I/O-Error occurs.
   *
   * @return      the next token
   * @exception   java.io.IOException  if any I/O-Error occurs
   */
  public java_cup.runtime.Symbol next_token() throws java.io.IOException {
    int zzInput;
    int zzAction;

    // cached fields:
    int zzCurrentPosL;
    int zzMarkedPosL;
    int zzEndReadL = zzEndRead;
    char [] zzBufferL = zzBuffer;
    char [] zzCMapL = ZZ_CMAP;

    int [] zzTransL = ZZ_TRANS;
    int [] zzRowMapL = ZZ_ROWMAP;
    int [] zzAttrL = ZZ_ATTRIBUTE;

    while (true) {
      zzMarkedPosL = zzMarkedPos;

      boolean zzR = false;
      int zzCh;
      int zzCharCount;
      for (zzCurrentPosL = zzStartRead  ;
           zzCurrentPosL < zzMarkedPosL ;
           zzCurrentPosL += zzCharCount ) {
        zzCh = Character.codePointAt(zzBufferL, zzCurrentPosL, zzMarkedPosL);
        zzCharCount = Character.charCount(zzCh);
        switch (zzCh) {
        case '\u000B':
        case '\u000C':
        case '\u0085':
        case '\u2028':
        case '\u2029':
          yyline++;
          yycolumn = 0;
          zzR = false;
          break;
        case '\r':
          yyline++;
          yycolumn = 0;
          zzR = true;
          break;
        case '\n':
          if (zzR)
            zzR = false;
          else {
            yyline++;
            yycolumn = 0;
          }
          break;
        default:
          zzR = false;
          yycolumn += zzCharCount;
        }
      }

      if (zzR) {
        // peek one character ahead if it is \n (if we have counted one line too much)
        boolean zzPeek;
        if (zzMarkedPosL < zzEndReadL)
          zzPeek = zzBufferL[zzMarkedPosL] == '\n';
        else if (zzAtEOF)
          zzPeek = false;
        else {
          boolean eof = zzRefill();
          zzEndReadL = zzEndRead;
          zzMarkedPosL = zzMarkedPos;
          zzBufferL = zzBuffer;
          if (eof) 
            zzPeek = false;
          else 
            zzPeek = zzBufferL[zzMarkedPosL] == '\n';
        }
        if (zzPeek) yyline--;
      }
      zzAction = -1;

      zzCurrentPosL = zzCurrentPos = zzStartRead = zzMarkedPosL;
  
      zzState = ZZ_LEXSTATE[zzLexicalState];

      // set up zzAction for empty match case:
      int zzAttributes = zzAttrL[zzState];
      if ( (zzAttributes & 1) == 1 ) {
        zzAction = zzState;
      }


      zzForAction: {
        while (true) {
    
          if (zzCurrentPosL < zzEndReadL) {
            zzInput = Character.codePointAt(zzBufferL, zzCurrentPosL, zzEndReadL);
            zzCurrentPosL += Character.charCount(zzInput);
          }
          else if (zzAtEOF) {
            zzInput = YYEOF;
            break zzForAction;
          }
          else {
            // store back cached positions
            zzCurrentPos  = zzCurrentPosL;
            zzMarkedPos   = zzMarkedPosL;
            boolean eof = zzRefill();
            // get translated positions and possibly new buffer
            zzCurrentPosL  = zzCurrentPos;
            zzMarkedPosL   = zzMarkedPos;
            zzBufferL      = zzBuffer;
            zzEndReadL     = zzEndRead;
            if (eof) {
              zzInput = YYEOF;
              break zzForAction;
            }
            else {
              zzInput = Character.codePointAt(zzBufferL, zzCurrentPosL, zzEndReadL);
              zzCurrentPosL += Character.charCount(zzInput);
            }
          }
          int zzNext = zzTransL[ zzRowMapL[zzState] + zzCMapL[zzInput] ];
          if (zzNext == -1) break zzForAction;
          zzState = zzNext;

          zzAttributes = zzAttrL[zzState];
          if ( (zzAttributes & 1) == 1 ) {
            zzAction = zzState;
            zzMarkedPosL = zzCurrentPosL;
            if ( (zzAttributes & 8) == 8 ) break zzForAction;
          }

        }
      }

      // store back cached position
      zzMarkedPos = zzMarkedPosL;

      if (zzInput == YYEOF && zzStartRead == zzCurrentPos) {
        zzAtEOF = true;
            zzDoEOF();
              {
                return symbol(LabParserSym.EOF);
              }
      }
      else {
        switch (zzAction < 0 ? zzAction : ZZ_ACTION[zzAction]) {
          case 1: 
            { /* System.out.println("LINE: "+yytext()); */
            }
          case 25: break;
          case 2: 
            { System.out.print("Lablet = {\n    interface = 1.0,\n    title = ");
        System.out.print("\"(TeX) "+yytext()+"\"\n}\n\n\n");
            }
          case 26: break;
          case 3: 
            { string.setLength(0);
            }
          case 27: break;
          case 4: 
            { yybegin(TITLED);
            }
          case 28: break;
          case 5: 
            { //System.out.print(yytext());
            }
          case 29: break;
          case 6: 
            { // System.out.println("LCURLY");
        return symbol(LabParserSym.LCURLY);
            }
          case 30: break;
          case 7: 
            { // System.out.println("RCURLY");
        return symbol(LabParserSym.RCURLY);
            }
          case 31: break;
          case 8: 
            { string.setLength(0);
        yybegin(STRING);
        yypushback(1);
            }
          case 32: break;
          case 9: 
            { // System.out.println("Found a non-string thing: "+yytext());
        string.append(yytext());
            }
          case 33: break;
          case 10: 
            { // System.out.println("Found a whitespace thing: "+yytext());
        string.append(' ');
            }
          case 34: break;
          case 11: 
            { yybegin(SHEET);
        yypushback(1);
        // System.out.println("STRING "+string.toString());
        return symbol(LabParserSym.STRING, string.toString());
            }
          case 35: break;
          case 12: 
            { /* need to escape quotes in Lua strings */
        string.append('\\');
        string.append('\"');
            }
          case 36: break;
          case 13: 
            { return symbol(LabParserSym.SQUARESTRING, yytext());
            }
          case 37: break;
          case 14: 
            { //System.out.println("TITLE");
        yybegin(TITLE);
        return symbol(LabParserSym.TITLE);
            }
          case 38: break;
          case 15: 
            { return symbol(LabParserSym.LABLETTEXT);
            }
          case 39: break;
          case 16: 
            { // System.out.println("VIDEO found");
        return symbol(LabParserSym.LABLETVIDEO);
            }
          case 40: break;
          case 17: 
            { return symbol(LabParserSym.LABLETCHECK);
            }
          case 41: break;
          case 18: 
            { return symbol(LabParserSym.LABLETHEADER);
            }
          case 42: break;
          case 19: 
            { return symbol(LabParserSym.HORIZONTALTWO);
            }
          case 43: break;
          case 20: 
            { return symbol(LabParserSym.HORIZONTALTHREE);
            }
          case 44: break;
          case 21: 
            { yybegin(TITLED);
        // System.out.println("END");
        return symbol(LabParserSym.END);
            }
          case 45: break;
          case 22: 
            { yybegin(SHEET);
        //System.out.println("BEGIN");
        return symbol(LabParserSym.BEGIN);
            }
          case 46: break;
          case 23: 
            { yybegin(SHEET);
        //System.out.println("BEGIN");
        String s = yytext().substring(7, yytext().length()-18);
        System.out.println("SQUARE "+s);
        return symbol(LabParserSym.VIDEO_OP, s);
            }
          case 47: break;
          case 24: 
            { yybegin(SHEET);
        //System.out.println("BEGIN");
        String s = yytext().trim();
        s = s.substring(7, s.length()-18);
        System.out.println("SQUARE "+s);
        return symbol(LabParserSym.VIDEO_OP, s);
            }
          case 48: break;
          default:
            zzScanError(ZZ_NO_MATCH);
        }
      }
    }
  }


}
