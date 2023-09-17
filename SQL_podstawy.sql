##########################################################
#####################CZĘŚĆ PIERWSZA#######################
##########################################################
#wyświetlanie danych z tabeli
-- SELECT username FROM users;
#po SELECT podajemy kolumnę którą chcemy wyświetlić a po FROM nazwę tabeli w której znajduje się ta kolumna
#jeśli chcemy wyświetlić inne kolumny to wymieniamy je po przecinku, jeśli chcemy wyświetlić wszystkie
#kolumny to podajemy gwiazdkę * (gwizadki nie używamy kiedy piszemy już aplikacje, gwizdkę stosuje się na
#etapie testowania co mamy w danej tabeli
-- aby wykonać kod klikamy ikonę z błyskawicą albo wciskamy ctrl + enter 

#dodawanie rekordów do tabeli
-- INSERT INTO users(username, display_name, year_of_birth) VALUES('kamil b', 'Kamil Brzezinski', 1988);
-- #po podaniu nazwy tabeli w nawiasie podajemy kolumny w których chcemy podać wartość następnie po VALUES
-- # w odpowiedniej kolejności podajemy wartości jakie chcemy wpisać do tych kolumn, jeśli podajemy stringi to
-- #podajemy je w cudzysłowach, natomaist liczby podajemy po prostu

-- #dodawanie wierszy do tabeli
-- #jeden wiersz jedna komenda:  
-- INSERT INTO users(username, display_name, year_of_birth) VALUES('marik1234', 'Mariusz', 1990);
-- INSERT INTO users(username, display_name, year_of_birth) VALUES('blazej', 'Błażej', 1992);

-- #wiele wierszy za pomocą jednej komendy:
-- INSERT INTO users(username, display_name, year_of_birth) VALUES
-- ('domino88', 'Dominik', 1980),
-- ('marco', 'Marek', 1988),
-- ('adam', 'Adam', 1988);
-- INSERT INTO users(username, display_name) VALUES('andrew','Andrzej'); 
#precyzyjne wyszukiwanie
#SELECT * FROM users WHERE year_of_birth > 1988;
# powyżej zostaną wyświetlleni użytkownicy których data urodzenia jest więskza od 1988
#gdbyśmy chcieli wyświetlić tych których data urodzenia jest równa 1988 użylibyśmy znaku równości =
# zamiast >
-- w SQL jako operatora porónania używa się pojedyńczego znaku równości =

#łączenie filtrów
# warunek OR (lub)
-- SELECT * FROM users WHERE year_of_birth = 1988 OR year_of_birth = 1990;
#Wyświetl wszystkich użytkowników których rok urodzenia to 1988 lub 1990

# warunek AND (i)
-- SELECT * FROM users WHERE year_of_birth = 1988 AND display_name='Adam'; 
#wyświetl użytkowników których rok urodzenia to 1988 i wyświetlane imię to Adam

#Wyświetlanie danych zaczynających się konkretnymi znakami
-- SELECT * FROM users WHERE username LIKE 'k%';
#wyświetl wszystkich użytkowników których username zaczyna się od litery k...

#wyświetlanie danych zawierających jakiś ciąg znaków w elemencie
-- SELECT * FROM users WHERE username LIKE '%am%'; 
#wyświetlanie wszystkich uzytkowników posiadających ciąg "am" w słowie  

#wyświetlanie dannych róznych od:
-- SELECT * FROM users WHERE year_of_birth != 1988;
#wyświetl wszystkich użytkowników dla których rok urodzenia jest inny od 1988
-- SELECT * FROM users WHERE username NOT LIKE 'k%';
#wyświelanie wszytkich użytkowników których username zaczyna sięn a inną litere niż k.

-- #wartość NULL 
-- INSERT INTO users(username, display_name) VALUES('andrew', 'Andrzej');
-- #kiedy dodamy Andrzeja bez podawania jego year_of_birth to domyślnie zostanie wpisana tam wartość NULL
-- SELECT * FROM users WHERE year_of_birth IS NULL;
-- #kiedy zastosujemy takie zapytanie to zostanie wyświetlony Andrzej
-- SELECT * FROM users WHERE year_of_birth IS NOT NULL;
-- #a kiedy takie to wszyscy inni

-- #klauzula IN skracająca stosowanie OR 
-- SELECT * FROM users WHERE year_of_birth = 1980 OR year_of_birth = 1988 OR year_of_birth = 1992; 
-- #powyższe zapytanie z zastosowaniem klauzuli IN zapisany został poniżej:
-- SELECT * FROM users WHERE year_of_birth IN(1980, 1988, 1992);

-- #szukanie pomiędzy wartościami (BETWEEN i operatory >=, <=)
-- SELECT * FROM users WHERE year_of_birth BETWEEN 1980 AND 1990;
-- SELECT * FROM users WHERE year_of_birth >= 1980 AND year_of_birth <= 1990;

-- #wyświetlanie wartosci bez duplikatów DISTINCT
-- SELECT DISTINCT year_of_birth FROM users;

-- #sortowanie ORDER BY
-- SELECT DISTINCT year_of_birth FROM users ORDER BY year_of_birth;
-- #domyślnie od wartości największej do najmniejszej 

-- #sortowanie od najmniejszej do największej
-- SELECT DISTINCT year_of_birth FROM users ORDER BY year_of_birth DESC;

-- #sortowanie wzrastające (tak jak domyślne)
-- SELECT DISTINCT year_of_birth FROM users ORDER BY year_of_birth ASC;

-- #zwracanie wybraej liczby rekordów LIMIT
-- SELECT * FROM users LIMIT 0,1;
-- #pierwwszy argument określa od jakiego wiersza chcemy zacząć a drugi ile rekordów chcemy wyświetlić

##########################################################
############################CZEŚĆ DRUGA###################
##########################################################
#W bazie dannych mamy 3 tabele:
-- users
-- user_groups (Id oraz nazwa grupy)
-- user_to_groups (Id, Id użytkownika oraz Id grupy)
 
 #Wyświetlenie tabel
 SELECT * FROM users;
 SELECT * FROM user_groups;
 SELECT * FROM users_to_groups;
 #Przypisanie użytkowników do grup
 INSERT INTO user_groups(group_name) VALUES('Programiści'), ('Narciarze'),
 ('Miłośnicy polityki'), ('Znawcy historii');
 
 INSERT INTO users_to_groups(user_id, group_id) VALUES(1,1), (1,2), (2,1), (2,3),
 (2,4), (3,3), (4,1);
 
 #Wyświetlenie liczby rekordów w tabeli users
 SELECT COUNT(*) FROM users;
#wyświetlanie liczby rekordów w konkretnej kolumnie
SELECT COUNT(username) FROM users;
#COUNT to tzw funkcja agregując, inne funkcje agregujące w SQL to MIN, MAX, SUM, AVG
	 
#Wyświetlanie najmniejszej wartości 
SELECT MIN(year_of_birth) FROM users;
#wyświetlanie maksymalnej wartości
SELECT MAX(year_of_birth) FROM users;
#wyświetlanie sumy wartości
SELECT SUM(year_of_birth) FROM users;
#wyświetlanie uśrednionej wartości
SELECT AVG(year_of_birth) FROM users;

#podzapytania (SUBQUERY)
SELECT username FROM users WHERE id =
(SELECT user_id FROM users_to_groups WHERE group_id = 2);
##podzapytanie podajemy po znaku równości i zapisujemy je w nawiasach okrągłych ()

#JOIN
SELECT * FROM  -- SELECT username, group_name FROM users (wyśweitli wybrane kolumny)
JOIN users_to_groups ON users.id = users_to_groups.user_id
# po JOIN podajemy nazwę tabeli z którą chcemy dokonać złączenia, podajemy słowo
#kluczowe ON i podajemy przy pomocy których pól chcemy dokonać tego złączenia
# tabela.kolumna = tabela2.kolumna 
JOIN user_groups ON users_to_groups.group_id = user_groups.id;
#nie można wyświetlić SELECT id ponieważ MySQL nie wie któej tabeli dotycz to zapytanie
#ponieważ kolumna id występuje w każdej z tyhc 3 połącząnych tabel, trzeba spreczować
# z której tabeli chcemy to id pobrać
-- SELECT users.id, username, group_name FROM users 
#w powyżym zapytaniu za pomocą users.id sprecyzowaliśmy, że chodzi nam o kolumnę id

#ALIAS (nadawanie nowych nazw znalezionym kolumnom
SELECT display_name AS wyswietlane_imie FROM users;
#aliast można utworzyć również bez słowa kluczowe AS
SELECT display_name wyswietlane_imie FROM users;
#ALIASY można tworzyć również dla całych tabel:
SELECT display_name AS wyświetlane_imię FROM users AS użytkownikicy;
#jeśli stosujemy alias dla tabeli to np w SUBQUERY musmy już go stosować, zmaiast
#oryginalnej nazwy tabeli
#słowo AS przy tworzeniu alisów tabeli również jest opcjonalne


#wyświetlanie liczby użytkowników w każdej z grup
SELECT user_groups.group_name, COUNT(users.username) AS numberOfUsers FROM users
JOIN users_to_groups ON users.id = users_to_groups.user_id
JOIN user_groups ON users_to_groups.group_id = user_groups.id
GROUP BY user_groups.group_name ORDER BY numberOfUsers;

#dodawanie kryteriów do pogrupowanych wyników
#wyświetlanie tylko tych grup w których jest więcej niż jeden uzytkownik (HAVING)
SELECT user_groups.group_name, COUNT(users.username) AS numberOfUsers FROM users
JOIN users_to_groups ON users.id = users_to_groups.user_id
JOIN user_groups ON users_to_groups.group_id = user_groups.id
GROUP BY user_groups.group_name 
HAVING numberOfUsers > 1
ORDER BY numberOfUsers;
#ważna jest kolejność wyrażeń: GROP BY -> HAVING -> ORDER BY

#uaktualnianie oraz usuwanie dannych
SELECT * FROM users;
#zmiana username użytkownika o id = 3
UPDATE users SET username='blazej123' WHERE id=3;
#najpierw podajmy tabele w której chcemy dokonać aktualizacji,
#następnie podajmy w jakiej kolumnie podając po znaku równości = wartość 
#i ostatecznie podajemy warunek aby wskazać w któym wierszu (wierszach) dokonać 
#aktualizacji

#zmiana więcej niż jednego pola:
UPDATE users SET username='blazej1234', display_name ='Błażej 2' WHERE id=3;

#usuwanie z bazy
DELETE from users WHERE id=3;
#Błażej został usunięty z bazy

#usuwanie wszystkich rekordów z tabeli:
DELETE from users; -- trzeba wyłaczyć save mode 
SET SQL_SAFE_UPDATES = 0;
#usunięcie wszystkich rekordów z danej tabeli (2 sposób)
TRUNCATE user_groups;

#DELETE i TRUMCATE dają ten sam wynik, TRUNCATE jest zapytaniem szybszym ale
#D.ELETE jest zapytaniem wywoływanym w tzw tranzakcji
#co powoduje, że podczas wykonywania operacji na bardzo dużej bazie dannych nagle
#coś pójdzie nie tak (np zabraknie prądu lub połączenie z serwerem zostanie przerwane)
#niema ryzyka,że dane będą nie spójne, możemy wykonać tzw rollback tranzakcji

#usuwanie całej tabeli:
DROP TABLE users;

departments
