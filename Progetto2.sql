CREATE TABLE Vendite(
ID_transazione INT(20),
categoria_prodotto TEXT(30),
costo DECIMAL(10, 2),
sconto INT(20),
nome_prodotto TEXT(20)
);

INSERT INTO Vendite (ID_transazione, categoria_prodotto, costo, sconto, nome_prodotto)
VALUES
  (1, 'Elettronica', 800.00, 10, 'Smartphone'),
  (2, 'Abbigliamento', 79.99, 5, 'Maglietta'),
  (3, 'Cucina', 199.99, 60, 'Frullatore'),
  (4, 'Libri', 29.99, NULL, 'Viaggio'),
  (5, 'Sport', 149.50, 40, 'Scarpe'),
  (6, 'Giocattoli', 39.99, 5, 'Puzzle'),
  (7, 'Casa', 1200.00, 50, 'Aspirapolvere'),
  (8, 'Gioielli', 799.50, 20, 'Collana'),
  (9, 'Fotografia', 899.99, 18, 'Fotocamera'),
  (10, 'Musica', 15.99, NULL, 'CD'),
  (11, 'Cucina', 149.99, 20, 'Bollitore elettrico'),
  (12, 'Elettronica', 630.00, 45, 'TV'),
  (13, 'Abbigliamento', 49.95, 10, 'Cappello'),
  (14, 'Sport', 199.99, 15, 'Pallone'),
  (15, 'Casa', 699.50, 20, 'Lavatrice'),
  (16, 'Casa', 399.99, 10, 'Asciugatrice'),
  (17, 'Elettronica', 129.99, 15, 'Auricolari'),
  (18, 'Abbigliamento', 75.00, NULL, 'Giacca'),
  (19, 'Sport', 45.50, 8, 'Tappetino'),
  (20, 'Gioielli', 599.50, 60, 'Orecchini'),
  (21, 'Cucina', 220.00, 50, 'Set pentole'),
  (22, 'Libri', 19.99, 3, 'Piatti'),
  (23, 'Fotografia', 499.99, 12, 'Videocamera'),
  (24, 'Musica', 12.99, NULL, 'Vinile'),
  (25, 'Giocattoli', 29.99, 5, 'Peluche'),
  (26, 'Elettronica', 349.99, 30, 'Tablet'),
  (27, 'Abbigliamento', 59.95, 15, 'Scarpe sportive'),
  (28, 'Casa', 149.99, 5, 'Cuscini'),
  (29, 'Sport', 129.99, 10, 'Fune'),
  (30, 'Fotografia', 499.99, 50, 'Fotocamera');
  
  

CREATE TABLE Dettagli_vendite(
ID_transazione INT(20),
data_acquisto DATE,
quantita INT

);

INSERT INTO Dettagli_vendite (ID_transazione, data_acquisto, quantita)
VALUES
  (1, '2023-01-08', 2),
  (2, '2023-02-09', 1),
  (3, '2023-03-10', 3),
  (4, '2023-05-11', 1),
  (5, '2023-06-12', 2),
  (6, '2023-10-13', 1),
  (7, '2023-12-14', 5),
  (8, '2023-01-08', 1),
  (9, '2023-02-09', 6),
  (10, '2023-03-10', 4),
  (11, '2023-05-11', 1),
  (12, '2023-06-19', 2),
  (13, '2023-09-20', 3),
  (14, '2023-05-21', 1),
  (15, '2023-08-22', 3),
  (16, '2023-01-23', 5),
  (17, '2023-05-11', 2),
  (18, '2023-01-25', 1),
  (19, '2023-01-26', 3),
  (20, '2023-10-13', 1),
  (21, '2023-01-28', 2),
  (22, '2023-01-29', 1),
  (23, '2023-06-10', 1),
  (24, '2023-10-13', 1),
  (25, '2023-02-01', 4),
  (26, '2023-05-11', 3),
  (27, '2023-02-03', 2),
  (28, '2023-02-04', 1),
  (29, '2023-02-04', 1),
  (30, '2023-06-06', 1);
  
  #Seleziona tutte le vendite avvenute in una specifica data.
  
  SELECT nome_prodotto, data_acquisto
  FROM Vendite 
  JOIN dettagli_vendite ON Vendite.ID_transazione = dettagli_vendite.ID_transazione
  WHERE data_acquisto = '2023-01-08';
  
#Elenco delle vendite con sconti maggiori del 50%.

SELECT categoria_prodotto,nome_prodotto,costo,sconto
FROM Vendite 
WHERE sconto >50;

#Calcola il totale delle vendite (costo) per categoria

SELECT categoria_prodotto,sum(costo) AS TOT_vendite
FROM Vendite 
GROUP BY categoria_prodotto 
ORDER BY TOT_vendite ASC;

#Trova il numero totale di prodotti venduti per ogni categoria

SELECT categoria_prodotto,sum(quantita) AS TOT_prodotti
FROM Vendite
JOIN dettagli_vendite ON Vendite.ID_transazione = dettagli_vendite.ID_transazione
GROUP BY categoria_prodotto
ORDER BY TOT_prodotti ASC;

#Seleziona le vendite dell'ultimo trimestre

SELECT categoria_prodotto,nome_prodotto,data_acquisto,costo
FROM Vendite 
JOIN dettagli_vendite ON Vendite.ID_transazione = dettagli_vendite.ID_transazione
WHERE data_acquisto > subdate(curdate(),INTERVAL 3 MONTH);

#Raggruppa le vendite per mese e calcola il totale delle vendite per ogni mese.

SELECT MONTH(data_acquisto) AS MESE, sum(costo) AS TOT_vendite
FROM Vendite 
JOIN dettagli_vendite ON Vendite.ID_transazione = dettagli_vendite.ID_transazione
GROUP BY MONTH(data_acquisto)
ORDER BY MESE;


#Trova la categoria con lo sconto medio più alto.

SELECT MAX(MEDIA) AS MAX_SCONTO
FROM (
SELECT avg(sconto) AS MEDIA 
FROM Vendite 
GROUP BY categoria_prodotto
) sconto ;

#ALTERNATIVA
#SELECT TOP 1 NON ME LO RICONOSCE, NON SUPPORTATO DA MYSQL

SELECT avg(sconto) AS Media 
FROM Vendite 
GROUP BY categoria_prodotto
ORDER BY Media DESC 
LIMIT 1 ;

#Confronta le vendite mese per mese per vedere l'incremento o il decremento delle vendite. Calcola l’incremento o 
#decremento mese per mese


SELECT MESE,
       TOT_vendite,
       LAG(TOT_vendite) OVER (ORDER BY MESE) AS MESEPRIMA,
       TOT_vendite - LAG(TOT_vendite) OVER (ORDER BY MESE) AS variazione
FROM(
SELECT month(data_acquisto) AS MESE, sum(costo) AS TOT_vendite
FROM Vendite 
JOIN dettagli_vendite ON Vendite.ID_transazione = dettagli_vendite.ID_transazione
GROUP BY MONTH(data_acquisto)
ORDER BY MESE ASC 
) TOTMESE
;


#Confronta le vendite totali in diverse stagioni

#CONSIDERO OGNI QUARTER(3 MESI) UNA STAGIONE 
SELECT stagione,
       TOT_vendite,
	   LAG(TOT_vendite) OVER (ORDER BY stagione) AS stagioneprima, 
	   TOT_vendite - LAG(TOT_vendite) OVER (ORDER BY stagione) AS variazione
FROM (
SELECT quarter(data_acquisto) AS stagione,sum(costo) AS TOT_vendite
FROM Vendite 
JOIN dettagli_vendite ON Vendite.ID_transazione = dettagli_vendite.ID_transazione
GROUP BY quarter(data_acquisto)
ORDER BY stagione) TOTSTAGIONI
;

#Supponendo di avere una tabella clienti con i campi IDCliente e IDVendita, scrivi una query per trovare 
#i top 5 clienti con il maggior numero di acquisti.

CREATE TABLE Cliente (
IDCliente INT(20),
IDVendita INT (20)
);

INSERT INTO Cliente (IDCliente, IDVendita)
VALUES
  (1, 5),
  (2, 12),
  (3, 7),
  (4, 15),
  (5, 22),
  (6, 3),
  (7, 18),
  (8, 10),
  (9, 26),
  (10, 14),
  (1, 9),
  (2, 21),
  (3, 27),
  (4, 4),
  (1, 20),
  (2, 11),
  (3, 30),
  (3, 8),
  (9, 2),
  (6, 23),
  (7, 19),
  (1, 6),
  (3, 1),
  (10, 29),
  (7, 13),
  (7, 25),
  (1, 17),
  (5, 28),
  (4, 16),
  (9, 24);
  
#SELECT TOP 5 NON ME LO RICONOSCE, NON SUPPORTATO DA MYSQL
SELECT IDCliente AS Cliente,count(IDVendita) AS acquisti 
FROM Cliente
GROUP BY IDCliente 
ORDER BY acquisti DESC
limit 5 ;


#Seconda opzione considerando le altre tabelle

SELECT IDCliente AS cliente,sum(quantita) AS acquisti 
FROM cliente
JOIN dettagli_vendite ON cliente.IDVendita = dettagli_vendite.ID_transazione
GROUP BY IDCliente 
ORDER BY acquisti DESC 
LIMIT 5;




















  

  

