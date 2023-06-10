{-# LANGUAGE StandaloneDeriving #-}

module DebugInstances () where

import qualified AST.Canonical as Can
import qualified AST.Optimized as Opt
import qualified AST.Utils.Shader
import qualified Data.Index
import qualified Data.Name as Name
import qualified Data.Utf8 as Utf8
import qualified Elm.ModuleName
import qualified Elm.String as ES
import qualified Optimize.DecisionTree as DT
import qualified Reporting.Annotation
import GHC.Show (showSpace)

instance Show (Utf8.Utf8 tipe) where
  show = show . Utf8.toChars

instance Show Opt.Global where
  showsPrec _ (Opt.Global (Elm.ModuleName.Canonical _ mod) n) =
    showChar '"'
      . showString (Name.toChars mod)
      . showChar '.'
      . showString (Name.toChars n)
      . showChar '"'

instance Show Elm.ModuleName.Canonical where
  showsPrec n (Elm.ModuleName.Canonical pkg mod) =
    showString "<Canonical _ "
      . showString (Name.toChars mod)
      . showChar '>'

instance Show Can.Def where
  showsPrec n (Can.Def _ pats expr ) = showParen (n >= 11) 
        ( showString "Def _ "
        . showsPrec 11 pats
        . showSpace 
        . showsPrec 11 expr
        )
  showsPrec n _ = showString "<TypeDef>" 


instance Show Data.Index.ZeroBased where
  show = show . Data.Index.toHuman

instance Show Reporting.Annotation.Region where
  show _ = "<Region>"

instance Show (Reporting.Annotation.Located a) where
  show _ = "<Located>"

instance Show AST.Utils.Shader.Source where
  show _ = "<Shader Source>"

deriving instance Show Can.CtorOpts



deriving instance Show DT.Test

deriving instance Show DT.Path

deriving instance Show Opt.Expr

deriving instance Show Opt.Def

deriving instance Show Opt.Destructor

deriving instance Show Opt.Path

deriving instance Show a => Show (Opt.Decider a)

deriving instance Show Opt.Choice
