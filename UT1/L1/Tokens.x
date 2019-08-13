{
module Tokens where
}

%wrapper "basic"

$digit = 0-9			-- digits

tokens :-

  $white+				;
  ($digit+)(\.$digit+)?([eE][\+\-]?($digit+)?)?   { \s -> TokenDigit ((read s)::Double) }
  \+					                                { \s -> TokenPlus }
  \-                                            { \s -> TokenMinus }
  \*                                            { \s -> TokenStar }
  \==                                            { \s -> TokenEq }
  \!=                                            { \s -> TokenDiff }
  \!                                             { \s -> TokenNeg }
  \&&                                            { \s -> TokenAnd }
  \|\|                                          { \s -> TokenOr }
  \(                                            { \s -> TokenOparen }
  \)                                            { \s -> TokenCparen }
{

-- The token type:        
data Token =
  TokenDigit Double |
  TokenPlus |
  TokenMinus |
  TokenStar |
  TokenEq |
  TokenDiff |
  TokenNeg |
  TokenAnd |
  TokenOr |
  TokenOparen |
  TokenCparen
}