{
module Grammar where
import Tokens
}

%name parser
%tokentype { Token }
%error { parseError }

%token
    NUM     { TokenDigit $$ }
    PLUS     { TokenPlus }
    STAR     { TokenStar }
    MINUS   { TokenMinus }
    EQ     { TokenEq }
    DIFF     { TokenDiff }
    NEG { TokenNeg }
    AND { TokenAnd }
    OR { TokenOr }
    OPAREN { TokenOparen }
    CPAREN { TokenCparen }

%left OR
%left AND
%left EQ DIFF
%left PLUS MINUS
%left STAR
%left NEG
%% 

exp : NUM  { Num $1 }
    | exp STAR exp { Times $1 $3 }
    | exp PLUS exp { Plus $1 $3 }
    | exp MINUS exp { Minus $1 $3 }
    | NEG exp { Neg $2 }
    | exp EQ exp { Eq $1 $3 }
    | exp DIFF exp { Diff $1 $3 }
    | exp AND exp { And $1 $3 }
    | exp OR exp { Or $1 $3 } 
    | OPAREN exp CPAREN { InBrk $2 }

{
data Exp = 
    Num Double
    | Times Exp Exp
    | Plus Exp Exp
    | Minus Exp Exp
    | Neg Exp
    | Eq Exp Exp
    | Diff Exp Exp
    | And Exp Exp
    | Or Exp Exp
    | InBrk Exp
    deriving (Eq, Show)

parseError :: [Token] -> a
parseError _ = error "Parse error"
}
