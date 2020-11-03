--Adicus Finkbeiner
--CS 410 Functional Programming

--Game of Life Voter Variation
--Has extra 0's around the whole thing that are still printing out
module Main where

import System.IO

--takes input from file and stores in an integer list
main :: IO()
main = do 
    file <- openFile "rand.txt" ReadMode
    line <- hGetLine file
    --f (g x) == f $ g x
    let rand = map read $ words line :: [Int]
    let rand2 = makeList 102 rand
    let rand3 = rowIterator 0 rand2
    print2dList rand3
    
    
--converts a list to 2d list of size 100 x 100
makeList :: Int -> [Int] -> [[Int]]
makeList num rand = take num . chunks num $ rand
    where
        chunks num2 xs = take num2 xs : chunks num2 (drop num2 xs)

--prints a list
printList :: [Int] -> IO()
printList [] = return ()
printList (x:xs) = do putStr (show x)
                      printList xs

--prints a 2d list
print2dList :: [[Int]] -> IO()
print2dList [] = return ()
print2dList (x:xs) = do printList x
                        putStrLn ""
                        print2dList xs

--iterates through each row, calls columnIterator on each and constructs the final 2d list
rowIterator :: Int -> [[Int]] -> [[Int]]
rowIterator 100 rand = [(columnIterator 100 0 rand)]
rowIterator 0 rand = (replicate 102 0):(rowIterator 1 rand)
rowIterator 101 rand = [replicate 102 0]
rowIterator row rand = (columnIterator row 0 rand):(rowIterator (row+1) rand)

--iterates through each column and for each one it gets the next value that should
--be in its place 
columnIterator :: Int -> Int -> [[Int]] -> [Int]
columnIterator row 100 rand = [(nextValue row 100 rand)]
columnIterator row 0 rand = (0):(columnIterator row 1 rand)
columnIterator row 101 rand = [0]
columnIterator row column rand = (nextValue row column rand):(columnIterator row (column+1) rand)

--Conditional
nextValue :: Int -> Int -> [[Int]] -> Int
nextValue row column rand = if (neighborSum row column rand > 4) 
                               then 1 
                               else 0

--Sum of the neighbors
neighborSum :: Int -> Int -> [[Int]] -> Int
neighborSum row col rand = 
        rand!!row!!col + rand!!row!!(col+1) + rand!!row!!(col-1) +
        rand!!(row+1)!!col + rand!!(row+1)!!(col+1) + rand!!(row+1)!!(col-1) + 
        rand!!(row-1)!!col + rand!!(row-1)!!(col+1) + rand!!(row-1)!!(col-1) 



--iterate through each column in each row

--putStr (show x)

--(x:xs) x is the first thing and xs is the rest
--[x] last thing in list
-- : append (count up)
-- !! indexes into list !!0 first element life!!row!!col
