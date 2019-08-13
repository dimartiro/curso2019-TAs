{
module Grammar where
import Tokens
import qualified Data.Map as Map
import qualified Data.Maybe as Maybe
}

%name parser
%tokentype { Token }
%error { parseError }

%token
    NUM     { TokenDigit $$ }
    PLUS     { TokenPlus }
    MINUS     { TokenMinus }
    STAR     { TokenStar }
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

exp : NUM   { $1 }
 | NEG exp { $2 }
 | exp STAR exp { $1 * $3 }
 | exp PLUS exp { $1 + $3 }
 | exp MINUS exp { $1 - $3 }
 | exp EQ exp { $1 == $3 }
 | exp DIFF exp { $1 }
 | exp AND exp { $1 }
 | exp OR exp { $1 } 
 | OPAREN exp CPAREN { ($2) }

{
parseError :: [Token] -> a
parseError _ = error "Parse error"
}