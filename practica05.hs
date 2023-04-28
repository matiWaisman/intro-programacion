-- Ejercicio 1

longitud :: [t] -> Integer
longitud [] = 0
longitud (x : xs) = longitud xs + 1

ultimo :: [t] -> t
ultimo [x] = x
ultimo (x : xs) = ultimo xs

principio :: [t] -> [t]
principio (x : xs) = [x]

reverso :: [t] -> [t]
reverso [] = []
reverso (x : xs) = reverso xs ++ [x]

-- Ejercicio 2

pertenece :: (Eq t) => t -> [t] -> Bool
pertenece e [] = False
pertenece e l
  | head l == e = True
  | otherwise = pertenece e (tail l)

todosIguales :: (Eq t) => [t] -> Bool
todosIguales [x] = True
todosIguales (x : y : xs)
  | x /= y = False
  | otherwise = todosIguales (y : xs)

todosDistintos :: (Eq t) => [t] -> Bool
todosDistintos [x] = True
todosDistintos (x : xs) = verificarDistinto x xs
  where
    verificarDistinto :: (Eq t) => t -> [t] -> Bool
    verificarDistinto _ [] = True
    verificarDistinto e (y : ys)
      | y == e = False
      | otherwise = verificarDistinto e ys

hayRepetidos :: (Eq t) => [t] -> Bool
hayRepetidos [x] = False
hayRepetidos (x : xs) = verificarRepetidos x xs
  where
    verificarRepetidos :: (Eq t) => t -> [t] -> Bool
    verificarRepetidos _ [] = False
    verificarRepetidos e (y : ys)
      | y == e = True
      | otherwise = verificarRepetidos e ys

quitar :: (Eq t) => t -> [t] -> [t]
quitar _ [] = []
quitar e (y : ys)
  | y == e = ys
  | otherwise = y : quitar e ys

quitarTodos :: (Eq t) => t -> [t] -> [t]
quitarTodos e [] = []
quitarTodos e (x : xs)
  | x == e = quitarTodos e xs
  | otherwise = x : quitarTodos e xs

-- eliminarRepetidos :: (Eq t) => [t] -> [t]
-- eliminarRepetidos

-- buscarRepetidos :: (Eq t) => [t] -> [t]
-- buscarRepetidos [x] = []
-- buscarRepetidos (x : xs) = encontrarRepetidos x (x : xs)

-- encontrarRepetidos :: (Eq t) => t -> [t] -> [t]
-- encontrarRepetidos _ [] = []
-- encontrarRepetidos e (y : ys)
--  | y == e = y : encontrarRepetidos e ys
--  | otherwise = encontrarRepetidos e ys

mismosElementos :: (Eq t) => [t] -> [t] -> Bool
mismosElementos [x] y = True
mismosElementos (x : xs) y
  | not (pertenece x y) = False
  | otherwise = mismosElementos xs y

capicua :: (Eq t) => [t] -> Bool
capicua l
  | l == reverso l = True
  | otherwise = False

-- Ejercicio 3

sumatoria :: [Integer] -> Integer
sumatoria [x] = x
sumatoria (x : xs) = x + sumatoria xs

productoria :: [Integer] -> Integer
productoria [x] = x
productoria (x : xs) = x * productoria xs

maximo :: [Integer] -> Integer
maximo (x : xs) = calcularMaximo x xs
  where
    calcularMaximo :: Integer -> [Integer] -> Integer
    calcularMaximo max (x : xs)
      | null xs && max > x = max
      | null xs && max < x = x
      | max < x = calcularMaximo x xs
      | otherwise = calcularMaximo max xs

sumarN :: Integer -> [Integer] -> [Integer]
sumarN n xs = map (+ n) xs

sumarElPrimero :: [Integer] -> [Integer]
sumarElPrimero (x : xs) = x + x : sumarN x xs

sumarElUltimo :: [Integer] -> [Integer]
sumarElUltimo [] = []
sumarElUltimo (x : xs) = x + conseguirElUltimo (x : xs) : sumarElUltimo xs -- : sumarN conseguirElUltimo (x : xs) xs tambien deberia funcionar
  where
    conseguirElUltimo :: [Integer] -> Integer
    conseguirElUltimo [x] = x -- Podria usar last pero lo hago por el amor al arte!!!
    conseguirElUltimo (x : xs) = conseguirElUltimo xs

pares :: [Integer] -> [Integer]
pares [] = []
pares (x : xs)
  | even x = x : pares xs
  | otherwise = pares xs

multiplosDeN :: Integer -> [Integer] -> [Integer]
multiplosDeN n [] = []
multiplosDeN n (x : xs)
  | x `mod` n == 0 = x : multiplosDeN n xs
  | otherwise = multiplosDeN n xs

ordenar :: [Integer] -> [Integer]
ordenar [] = []
ordenar [x] = [x]
ordenar (x : y : xs)
  | x > y = y : x : ordenar xs
  | otherwise = ordenar (y : xs)

-- Ejercicio 4

sacarBlancosRepetidos :: String -> String
sacarBlancosRepetidos [] = []
sacarBlancosRepetidos [x] = [x]
sacarBlancosRepetidos (x : y : xs)
  | x == ' ' && y == ' ' = y : sacarBlancosRepetidos xs
  | otherwise = x : y : sacarBlancosRepetidos xs

contarPalabras :: String -> Integer
contarPalabras [] = 1
contarPalabras (x : xs)
  | x == ' ' = 1 + contarPalabras xs
  | otherwise = contarPalabras xs

-- palabraMasLarga :: [Char] -> [Char] -- Idea: primero encontrar donde estan los espacios con la funcion encontrarEspacios, despues dado la lista con los espacios encontrar que palabra entre dos espacios es mas grande con calcularRangoPalabraMasLarga que devuelve una lista con dos elementos, la primera y ultima posicion de la lista de los espacios y por ultimo dados esos dos numeros reconstruir la palabra con otra funcion
-- palabraMasLarga = calcularRangoPalabraMasLarga

-- calcularRangoPalabraMasLarga :: [Integer] -> Integer -> [Integer]
-- calcularRangoPalabraMasLarga (x:xs) l -- xs = Lista con los 0s, l = lenght de la lista

encontrarEspacios :: Integer -> String -> [Integer]
encontrarEspacios i xs
  | i == 0 = []
  | xs !! fromIntegral i == ' ' = i : encontrarEspacios (i + 1) xs
  | otherwise = encontrarEspacios (i + 1) xs

aplanar :: [String] -> String
aplanar [x] = x
aplanar (x : xs) = x ++ aplanar xs

aplanarConBlancos :: [String] -> String
aplanarConBlancos [x] = x
aplanarConBlancos (x : xs) = x ++ [' '] ++ aplanar xs

aplanarConNBlancos :: [String] -> Integer -> String
aplanarConNBlancos [x] n = x
aplanarConNBlancos (x : xs) n = x ++ generarNBlancos n ++ aplanarConNBlancos xs n

generarNBlancos :: Integer -> String
generarNBlancos 1 = [' ']
generarNBlancos n = ' ' : generarNBlancos (n - 1)

-- Ejercicio 5

nat2bin :: Integer -> [Integer]
nat2bin n
  | n < 2 = [1]
  | n == 0 = [0]
  | otherwise = nat2bin (n `div` 2) ++ [n `mod` 2]

bin2nat :: [Integer] -> Integer
bin2nat [x] = 1 * x
bin2nat (x : xs) = (2 ^ length xs) * x + bin2nat xs

nat2hex :: Integer -> [Char] -- Me devuelve un caracter unicode, ver como resolver
nat2hex n
  | n < 16 = [pasarNumeroAHexa n]
  | otherwise = nat2hex (n `div` 16) ++ [pasarNumeroAHexa (n `mod` 16)]
  where
    pasarNumeroAHexa :: Integer -> Char -- La idea es que el valor este si o si entre 0 y 16
    pasarNumeroAHexa n
      | n < 10 = toEnum (fromInteger n)
      | n == 10 = 'A'
      | n == 11 = 'B'
      | n == 12 = 'C'
      | n == 13 = 'D'
      | n == 14 = 'E'
      | n == 15 = 'F'