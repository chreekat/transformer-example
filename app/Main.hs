module Main where

import Control.Monad.Trans.State
import Control.Monad.Trans.Class
import Control.Monad.Writer

main :: IO ()
main = do
    print "Starting with 3"
    -- wResult :: Writer Int Int
    let (result, inters) = runWriter (execStateT doSomeStateAndWrite 3)
    putStr "Intermediates: "
    print inters
    putStr "Result: "
    print result

doSomeStateAndWrite :: StateT Int (Writer [Int]) ()
doSomeStateAndWrite = do
    tellget
    add3
    tellget
    remove4
    tellget
    add5
    tellget

tellget = do
    a <- get
    lift $ tell [a]

add3, remove4, add5 :: (Monad m) => StateT Int m ()
add3 = modify (+3)
remove4 = modify (subtract 4)
add5 = modify (+5)
