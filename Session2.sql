/*===================================================
			WHERE
====================================================*/
/*Composer'ı Jimi Hendrix olan şarkıların isimlerini (name) sorgulayiniz*/
SELECT *
FROM tracks;


SELECT Composer, name  
FROM tracks  
WHERE Composer='Jimi Hendrix';


/*invoices tablosunda Total değeri 10$'dan büyük olan faturaların tüm bilgilerini sorgulayiniz */
SELECT *
FROM invoices
WHERE total>10;


/*invoices tablosunda Total değeri 10$'dan büyük olan kayıtların CustomerId, BillingAddress ve 
total bilgilerini sorgulayiniz */
SELECT CustomerId, BillingAddress, total
FROM invoices
WHERE total>10;


/*===================================================
			LIMIT
====================================================*/
/*invoices tablosunda Total değeri 10$'dan büyük olan faturaların tüm bilgilerinin ilk 4 kaydını sorgulayiniz */
SELECT *
FROM invoices
WHERE total>10
LIMIT 4;


/*invoices tablosunda Total değeri 10$'dan küçük olan ilk 5 kayıt'ın InvoiceId, 
InvoiceDate ve total bilgilerini sorgulayiniz */
SELECT InvoiceId, InvoiceDate, total
FROM invoices
WHERE total<10
LIMIT 5;

/*===================================================
	ORDER BY
====================================================*/
/*invoices tablosunda Total değeri 10$'dan büyük olan kayıtları Total değerine göre 
AZALAN sırada sıralayarak sorgulayiniz */
SELECT *
FROM invoices
WHERE total>10
ORDER BY total DESC;


/*invoices tablosunda Total değeri 10$'dan büyük olan kayıtlardan işlem tarihi 
(InvoiceDate) en yeni olan 10 kaydın tüm bilgilerini listeyiniz */ 
SELECT *
FROM invoices
WHERE total>10
ORDER BY InvoiceDate DESC
LIMIT 10;


/*===================================================
	LOGICAL OPERATORS (AND,OR,NOT)
====================================================*/

/* invoices tablosunda ülkesi (BillingCountry) USA olmayan kayıtları total değerine
göre  AZALAN sırada listeyiniz */ 
SELECT *
FROM invoices
WHERE NOT BillingCountry='USA'
ORDER BY total DESC;


SELECT *
FROM invoices
WHERE BillingCountry <>'USA'  --NOT yerine <> yada =! kullanabiliriz
ORDER BY total DESC;


/* invoices tablosunda, ülkesi (BillingCountry) USA veya Germany olan kayıtları, 
InvoiceId sırasına göre artan sırada listeyiniz */ 
SELECT *
FROM invoices
WHERE BillingCountry='USA' OR BillingCountry='GERMANY'
ORDER BY InvoiceId;  --ORDER BY defult olarak ASC gibi çalışır


/* invoices tablosunda BillingState sutunu AB olmayan VEYA NULL olan tüm verileri 
sorgulayınız.*/
SELECT *
FROM invoices
WHERE NOT BillingState='AB' OR BillingState IS NULL;

	
/*===================================================
	BETWEEN, NOT BETWEEN
====================================================*/
/* invoices tablosunda fatura tarihi (InvoiceDate) 2009 ila 2011 tarihleri arasındaki
en yeni faturayı listeleyen sorguyu yazınız */ 
SELECT *
FROM invoices
WHERE InvoiceDate BETWEEN '2009-01-01 00:00:00' AND '2011-12-31 23:59:59' --DATETIME veri tipi kullanılacak ise en son saat/dakika saniye yazılır
ORDER BY InvoiceDate DESC;
LIMIT 1;


SELECT *
FROM invoices
WHERE InvoiceDate BETWEEN '2009-01-01 00:00:00' AND '2012-01-01'  --DATE veri tipi kullanacaksak garanti olsun diye bir gün sonrası alınır
ORDER BY InvoiceDate DESC;
LIMIT 1;


/* invoices tablosunda fatura tarihi (InvoiceDate) 01-01-2012 ile 02-01-2013 
tarihleri arasındaki faturaların tüm bilgilerini listeleyiniz */ 
SELECT *
FROM invoices
WHERE InvoiceDate>= "2009-01-01" AND InvoiceDate<= "2011-12-31 23:59:59";   


/* students Tablosunda Grade sutunu 89 ila 96 arasında olan ogrencilerin tum 
bilgilerini sorgulayınız.*/
SELECT *
FROM students
WHERE Grade BETWEEN 89 AND 96
ORDER BY Grade;


/*===================================================
	IN
====================================================*/
/* customers tablosunda Belgium, Norway, Canada veya USA ülkelerinden sipariş veren
müşterilerin FirstName ve LastName bilgilerini listeyiniz	*/
SELECT FirstName, LastName, country
FROM customers
WHERE country IN ('Belgium','Norway', 'Canada', 'USA');  --IN ile kullandık


SELECT FirstName, LastName, country
FROM customers
WHERE country='Belgium' OR country='Norway' OR country='Canada' OR country='USA'; --OR ile kullandık

	
/*===================================================
	LIKE
====================================================*/
/* tracks tablosunda Composer sutunu Bach ile biten kayıtların Name bilgilerini 
listeyen sorguyu yazınız*/
SELECT name, Composer
FROM tracks
WHERE Composer LIKE '%Bach';


/* tracks tablosunda Composer sutunu içinde Bach geçen kayıtların Name bilgilerini 
listeyen sorguyu yazınız*/
SELECT name, Composer
FROM tracks
WHERE Composer LIKE '%Bach%';


/* albums tablosunda Title (başlık) sutununda Greatest içeren kayıtların tüm bilgilerini 
listeyen sorguyu yazınız*/
SELECT *
FROM albums
WHERE Title LIKE '%Greatest%';


/* customers tablosunda, isimleri (FirstName) üç harfli olan müşterilerin FirstName, 
LastName ve City bilgilerin listeleyen sorguyu yazınız */
SELECT FirstName, LastName, City
FROM customers
WHERE FirstName LIKE '___';

	
/* customers tablosunda B veya U harfi ile başlayan ülkelerinden sipariş veren
müşterilerin FirstName, LastName ve Country bilgilerini listeyiniz */

SELECT FirstName,LastName, country
FROM customers
WHERE country LIKE 'B%' OR country LIKE 'U%';


/* invoices tablosunda, 2010 ve 2019 arası bir tarihte (InvoiceDate) Sadece şubat
aylarında gerçekleşmiş olan faturaların	tüm bilgilerini listeleyen sorguyu yazınız*/

SELECT *
FROM invoices
WHERE InvoiceDate LIKE "201_-02%";


/* customers tablosunda, soyisimleri Sch veya Go ile başlayan müşterilerin FirstName, 
LastName ve City bilgilerini listeleyen sorguyu yazınız*/

SELECT FirstName, LastName, City
FROM customers
WHERE LastName LIKE 'Sch%' OR LastName LIKE 'Go%';























	








































































































































