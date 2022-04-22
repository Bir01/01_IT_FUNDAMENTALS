/*===================================================
        JOINS
====================================================*/
    
--     Join islemleri farkli tablolardan secilen sutunlar ile yeni bir tablo 
--     olusturmak icin kullanilabilir.
--     
--     JOIN islemleri Iliskisel Veritabanlari icin cok onemli bir ozelliktir. Çunku
--    	Foreign Key'ler ile iliskili olan tablolardan istenilen sutunlari cekmek 
--     icin JOIN islemleri kullanilabilir.

--     Standart SQL'de en çok kullanılan Join islemleri:
--     1) FULL JOIN:  Tablodaki tum sonuclari gosterir
--     2) INNER JOIN:  Tablolardaki ortak olan sonuc kumesini gosterir
--     3) LEFT JOIN:  Ilk tabloda (Sol) olup digerinde olmayan sonuclari gosterir
--     4) RIGHT JOIN: Sadece Ikinci tabloda olan tum sonuclari gosterir.

--NOT: SQLite Sadece INNER ve LEFT JOIN İşlemlerini desteklemektedir.


/* Chinook veritabanındaki tracks tablosunda bulunan her bir şarkının türü (genre)
listeleyiniz.*/

--SELECT * FROM tracks;
--SELECT * FROM genres;


SELECT tracks.Name, genres.name
FROM tracks
INNER JOIN genres
ON tracks.GenreId = genres.GenreId;


-- aynı sorgu kısaltma kullanarak yazmak istersek;

SELECT t.Name, g.name
FROM tracks t
INNER JOIN genres g
ON t.GenreId = g.GenreId;


-- aynı sorgu alias kullanarak daha kısa yazmak istersek;

SELECT t.Name AS SongName,
       g.name AS GenreName
FROM tracks t
INNER JOIN genres g
ON t.GenreId = g.GenreId;




 /* Araclar veritabanını kullanarak Markalar ve Siparisler tablolarındaki 
 marka_id’si ayni olan kayıtların marka_id, marka_adi, siparis_adedi ve siparis_tarihi   
 bilgilerini  listeleyen bir sorgu yaziniz.*/

--SELECT * FROM markalar;
--SELECT * FROM siparisler;

SELECT siparisler.marka_id, markalar.marka_adi,
       siparisler.siparis_adedi, siparisler.siparis_tarihi
FROM markalar 
JOIN siparisler
ON markalar.marka_id = siparisler.marka_id;


-- aynı sorgu kısaltma kullanarak yazmak istersek;

SELECT s.marka_id, m.marka_adi,
       s.siparis_adedi, s.siparis_tarihi
FROM markalar m
JOIN siparisler s
ON m.marka_id = s.marka_id;





/* Chinook veritabanındaki invoice tablosundaki faturaların her birinin müşteri adını (FirstName),
ve fatura id sini listeleyen sorguyu yazınız */

--SELECT * FROM invoices;
--SELECT * FROM customers;

SELECT c.FirstName,
       c.LastName,
       i.InvoiceId
FROM invoices i
JOIN customers c
ON i.CustomerId = c.CustomerId;




/* Chinook veritabanındaki invoice tablosundaki faturaların her birinin müşteri adını (FirstName),
 soyadını (lastName), fatura tarihi (InvoiceDate) ve fatura meblağını (total) 
 listeleyen sorguyu yazınız */
 
 --SELECT * FROM invoices;
--SELECT * FROM customers;
 
 SELECT c.FirstName, c.LastName,i.InvoiceDate,sum(i.total) AS total_amount
 FROM invoices i
 JOIN customers c
 ON i.CustomerId = c.CustomerId
 GROUP BY c.FirstName;
 
 
 
 
 
 /* Araclar veritabanındaki Markalar ve Siparisler tablolarındaki tüm araç markalarının siparis bilgilerini
   (marka_id,marka_adi,siparis_adedi,siparis_tarihi) listeleyen bir sorgu yaziniz.(LEFT JOIN kullanalım)*/
	
--SELECT * FROM markalar;
--SELECT * FROM siparisler;


SELECT markalar.marka_id,
       markalar.marka_adi,
       siparisler.siparis_tarihi,
       siparisler.siparis_adedi
FROM markalar 
LEFT JOIN siparisler
ON siparisler.marka_id = markalar.marka_id;


-- bir başka şekilde kısa yazmak istersek;
SELECT m.marka_id,
       m.marka_adi,
       s.siparis_tarihi,
       s.siparis_adedi
FROM siparisler s
LEFT JOIN markalar m
ON s.marka_id = s.marka_id;




/* Company2 veritabanındaki verileri kullanarak çalışanların first_name, last_name,salary ve 
dept_name lerini sorgulalayan tabloyu çıkarınız */


--Burada SQLite da birden fazla database kullandığımız için "veri_tabanı.tablo_adı.sütun_adı" şeklinde belirtmemiz gerekiyor, yoksa hangi db, hangi tablo anlamaz

--SELECT * FROM company_2.employees;  
--SELECT * FROM company_2.departments;
SELECT company_2.employees.first_name,
       company_2.employees.last_name,
       company_2.employees.salary,
       company_2.departments.dept_name
FROM company_2.employees
JOIN company_2.departments
ON company_2.employees.emp_id = company_2.departments.emp_id;



--sadece bayan çalışanlar getir dersek;

SELECT company_2.employees.first_name,
       company_2.employees.last_name,
       company_2.employees.salary,
       company_2.employees.gender,
       company_2.departments.dept_name
FROM company_2.employees
JOIN company_2.departments
ON company_2.employees.emp_id = company_2.departments.emp_id
WHERE company_2.employees.gender = 'Female';



--ismi L ile başlayanları göster dersek;

SELECT company_2.employees.first_name,
       company_2.employees.last_name,
       company_2.employees.salary,
       company_2.employees.gender,
       company_2.departments.dept_name
FROM company_2.employees
JOIN company_2.departments
ON company_2.employees.emp_id = company_2.departments.emp_id
WHERE company_2.employees.first_name LIKE 'L%';




--çalışanlardan maaşı 80000 ve üzeri olanları getir dersek;

SELECT company_2.employees.first_name,
       company_2.employees.last_name,
       company_2.employees.salary,
       company_2.employees.gender,
       company_2.departments.dept_name
FROM company_2.employees
JOIN company_2.departments
ON company_2.employees.emp_id = company_2.departments.emp_id
WHERE company_2.employees.salary >= 80000;




/* Chinook veritabanındaki albums ve artists tablolarından istifade ederek artistleri ve albüm isimlerini
birlikte getiren sorguyu yazınız */

--SELECT * FROM artists;
--SELECT * FROM albums;

SELECT albums.Title, artists.Name
FROM artists
JOIN albums
ON artists.ArtistId = albums.ArtistId;




/* Chinook veritabanındaki invoice tablosundaki faturaların her birinin müşteri adını (FirstName),
 soyadını (lastName) ve fatura meblağlarının toplamının (total) 40 dolardan fazla olanlarını 
azalan sırada listeleyen sorguyu yazınız */

SELECT c.CustomerId,
       c.FirstName,
       c.LastName,
       sum(i.total) AS total_amount         
FROM invoices i
JOIN customers c
ON i.CustomerId = c.CustomerId
-- WHERE total_amount > 40  --aggregate fonksiyon var ise ve bu değeri de koşul olarak kullandı isek WHERE değil HAVING kullanılır, ÖNEMLİ
GROUP BY c.CustomerId
HAVING total_amount > 40
ORDER BY total_amount DESC;



/*===================================================
        SUBQUERIES
====================================================*/


/* albums tablosundaki Title sutunu ‘Faceless’ olan kaydın albumid'sini elde ederek 
tracks tablosunda bu değere eşit olan kayıtların bilgilerini SUBQUERY yazarak listeyiniz.
Listelemede trackid, name ve albumid bilgilerini bulunmalıdır.(SUBQUERY kullanarak) */

SELECT AlbumId
FROM albums
WHERE Title = 'Faceless';


SELECT TrackId, name, AlbumId
FROM tracks
WHERE AlbumId = 88;


-- Ancak bu şekilde 2 farklı sorguyu manuel yapmak uygun değil, Sub-query yada Join kullanarak yapabiliriz.

SELECT TrackId, name, AlbumId
FROM tracks
WHERE AlbumId = (SELECT AlbumId
                 FROM albums
                 WHERE Title = 'Faceless');   --Bu sorguda önce iç sorgu çalışır, sonra çıkan değerler dış sorguda değerlendirilir
		 
		 
		 	 
		 
		 
		 
/* albums tablosundaki Title sutunu ‘Faceless’ olan kaydın albumid'sini elde ederek 
tracks tablosunda bu değere eşit olan kayıtların bilgilerini SUBQUERY yazarak listeyiniz.
Listelemede trackid, name ve albumid bilgilerini bulunmalıdır. (JOIN kullanarak) */

--SELECT * FROM tracks;
--SELECT * FROM albums;

SELECT t.TrackId, t.name, t.AlbumId, a.Title
FROM tracks t
JOIN albums a
ON t.AlbumId = a.AlbumId
WHERE a.Title = 'Faceless';





/* albums tablosundaki Title sutunu Faceless veya Let There Be Rock olan kayıtların 
albumid'lerini elde ederek tracks tablosunda bu id'lere eşit olan kayıtların bilgilerini 
SUBQUERY kullanarak listeyiniz. (SUBQUERY kullanarak */

SELECT TrackId, Name, AlbumId
FROM tracks
WHERE AlbumId IN (SELECT AlbumId
	          FROM albums
	          WHERE title IN ('Faceless','Let There Be Rock'));   --Bu sorguda önce iç sorgu çalışır, sonra çıkan değerler dış sorguda değerlendirilir



		  
/* albums tablosundaki Title sutunu Faceless veya Let There Be Rock olan kayıtların 
albumid'lerini elde ederek tracks tablosunda bu id'lere eşit olan kayıtların bilgilerini 
SUBQUERY kullanarak listeyiniz. (JOIN kullanarak */

--SELECT * FROM tracks;
--SELECT * FROM albums;

SELECT t.TrackId, t.Name, t.AlbumId
FROM tracks t
JOIN albums a 
ON t.AlbumId= a.AlbumId
WHERE a.Title IN ('Faceless' ,'Let There Be Rock');




































































