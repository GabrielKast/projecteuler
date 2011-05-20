-- file: ch03/add.hs
-- Add all the natural numbers below one thousand that are multiples of 3 or 5.
-- If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
-- Find the sum of all the multiples of 3 or 5 below 1000.

pb1  = sum_of (list_of_naturals 10000)
pb1_of_n :: Int -> Int
pb1_of_n n = sum_of (list_of_naturals n)




------------------------------------------

sum_of :: (Num a) => [a] -> a  
sum_of xs = foldl (+) 0 xs  
--sum' xs = foldl (\acc x -> acc + x) 0 xs  

list_of_naturals :: Int -> [Int]
list_of_naturals n = [x | x <- [1..n] , x `mod` 3 > 0 , x `mod` 5 > 0]

