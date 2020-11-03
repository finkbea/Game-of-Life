import System.Random
import Control.Monad
--random :: (RandomGen g, Random a) => g -> (a, g)
--random (mkStdGen 10) :: (Boolean, StdGen)
makeBool :: Int -> IO [Bool]
makeBool n = replicateM n randomIO

main = do
    useBoolList :: [Bool] -> String
    useBoolList [] = ""
    useBoolList (x:xs) = (if x == True then "T" else "F") ++ useBoolList xs

    printlist = do
        1 <- makeBool 10
        putStrLn $ useBoolList 1


