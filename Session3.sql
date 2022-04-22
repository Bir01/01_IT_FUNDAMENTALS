/*===================================================
	AGGREGATE FUNCTION COUNT,SUM,MIN,MAX, AVG)
====================================================*/
	
-- COUNT
-------------------------------------------------------------------------------------------------	
SELECT COUNT(*)
FROM invoices;

SELECT COUNT(InvoiceId) AS num_of_records
FROM invoices;

SELECT COUNT(BillingState)
FROM invoices;

/* tracks tablosunda kaç adet besteci (composer) olduğunu döndüren sorguyu yazınız*/
SELECT *
FROM tracks;

SELECT COUNT(*)  --3503 satır döndü
FROM tracks;

SELECT COUNT(Composer)  --2525 satır döndü
FROM tracks;

-- Üsttekinin yerine alttaki gibi sorgu yazılabilir, aynı değeri verir

SELECT COUNT(*)
FROM tracks
WHERE Composer IS NOT NULL;  --  = 'NULL' bu ifade yanlış, bunun yerine "IS NULL" kullanılır,  2525 satır döndü


SELECT COUNT(*)
FROM tracks
WHERE Composer IS NULL;   --978 satır döndü,Composer sütunundaki NULL değerleri sayar



/* invoices tablosunda ülke(BillingState) değeri olmayan kaç veri olduğunu döndüren sorguyu yazınız*/
SELECT COUNT(*) 
FROM invoices
WHERE BillingState IS NOT NULL;


/* tracks tablosunda kaç adet farklı Composer bulunduğunu döndüren sorguyu yazınız*/
SELECT COUNT(DISTINCT Composer) AS Besteci_Sayisi
FROM tracks;


/* tracks tablosundaki şarkı süresi en kısa olan şarkının adını ve süresini listeleyen
sorguyu yaziniz */
SELECT name As Song_Name, MIN(Milliseconds) As Min_Duration
FROM tracks;


/* tracks tablosundaki şarkı süresi en uzun olan şarkının adını ve süresini listeleyen
sorguyu yaziniz */
SELECT name As Song_Name, MAX(Milliseconds) As Max_Duration
FROM tracks;


/* employees tablosundaki (company_2.db) en düşük ve en yüksek maaşı listeleyen sorguyu yazınız */
SELECT MIN(salary) AS min_salary, MAX(salary) AS max_salary
FROM company_2.employees;


/*students tablosundaki en düşük ve en yüksek notu listeleyen sorguyu yazınız */
SELECT MIN(Grade), MAX(Grade)
FROM students;


-- SUM,AVG
	-------------------------------------------------------------------------------------------------	
/* invoices  tablosundaki faturaların toplam değerini listeyiniz */

SELECT SUM(total) as total_invoices
FROM invoices;


/* tracks  tablosundaki şarkıların ortalama duration değerini sorgulayınız */

SELECT ROUND(AVG(Milliseconds),2) AS ort_duration
FROM tracks;


/* tracks tablosundaki şarkıların ortalama süresinden daha uzun olan 
şarkıların adlarını listeleyiniz */

SELECT Name, Milliseconds
FROM tracks
WHERE Milliseconds > 393599.21


/* Bu yöntem hard-coded olduğu için çok mantıklı bir çözüm değil. 
alt-sorgu (sub-query) ile daha doğru bir yaklaşım olacaktır sonraki 
bölümlerde alt-sorguyu ayrıntılı bir şekilde inceleyeceğiz.*/


SELECT Name, Milliseconds
FROM tracks
WHERE Milliseconds > (SELECT AVG(Milliseconds)    --Subquery kullanarak yaptık, burada önce iç döngü sonra dış döngü çalışır
                      FROM tracks);

		      													
/*===================================================
 GROUP BY
====================================================*

/* tracks tablosundaki her bir Bestecisinin (Composer) toplam şarkı sayısını 
Besteci adına göre gruplandırarak listeleyen sorguyu yazınız. */

SELECT Composer, COUNT(Name) AS Sarki_sayisi
FROM tracks
WHERE Composer IS NOT NULL
GROUP BY Composer;

/* customers tablosundaki müşterilerin sayılarını Ülkelerine (Country) göre gruplandırarak 
ve müşteri sayısına göre AZALAN şekilde sıralayarak listeleyen sorguyu yazınız*/

SELECT country, COUNT(CustomerID) As num_of_customersid
FROM customers
GROUP BY country
ORDER BY num_of_customersid DESC, country ASC;

--Aynısı

SELECT country, COUNT(CustomerID) 
FROM customers
GROUP BY country


/* tracks tablosundaki herbir albumü AlbumId'lerine göre gruplandırarak 
her albumdeki minumum şarkı sürelerini listeleyen sorguyu yazınız */

SELECT AlbumId, MIN(Milliseconds)
FROM tracks
GROUP BY AlbumId;


SELECT AlbumId, Composer, MIN(Milliseconds)
FROM tracks
WHERE Composer IS NOT NULL
GROUP BY AlbumId;


/* invoices tablosundaki her bir ülkenin (BillingCountry) fatura ortalamalarını 
hesaplayan ve ülke bilgileri ile listeleyen sorguyu yazınız.*/
SELECT BillingCountry, AVG(total)
FROM invoices
GROUP BY BillingCountry;


















ORDER BY COUNT(CustomerID) DESC, country ASC;





















		      
		      
		      
		      
		      
		      
		      
		      
		      
		      




















	
	
	
	
	
	























































