
/*===================================================
  DDL COMMANDS (CREATE TABLE, DROP TABLE,ALTER TABLE)
====================================================*/	
	
/*---------------------------------------------------
/*  CREATE TABLE
/*---------------------------------------------------

/*personel adinda bir tablo oluşturunuz.  Tabloda first_name, last_name 
age(INT) ve hire_date (Date) sutunuları bulunmalıdır.*/

CREATE TABLE personel (
	first_name VARCHAR(20),
	last_name TEXT,
	age INT,
	hire_date date
	);
	
	
		
CREATE TABLE personel (
	first_name VARCHAR(20),
	last_name VARCHAR(30),
	age INT,
	hire_date date
	);
	
	
	
/* Aynı isimle yeniden bir veritabanı oluşturulmak istenirse hata verir. Bu hatayı
almamak için IF NOT EXISTS keywordu kullanılabilir */

CREATE TABLE IF NOT EXISTS personel (
	first_name VARCHAR(20),
	last_name VARCHAR(30),
	age INT,
	hire_date date
	);

	
	
/*Veritabanında vacation_plan adında yeni bir tablo oluşturunuz.  Sutun isimleri
place_id, country, hotel_name, employee_id, vacation_length, budget olsun */

CREATE TABLE vacation_plan (
	place_id INTEGER,
	country TEXT,
	hotel_name TEXT,
	employee_id INTEGER,
	vacation_length INT,
	budget REAL
	);
	
	
/*--------------------------------------------------------------
/*  DROP TABLE
/*--------------------------------------------------------------


/* personel tablosunu siliniz */

DROP TABLE personel;



/* Bir tabloyu silerken tablo bulunamazsa hata verir. Bu hatayı görmemek için
IF EXISTS keywordu kullanılabilir.*/

DROP TABLE IF EXISTS personel;



-- NOT: SQL'de TRUNCATE TABLE komutu bulunmasına karşın SQLite bu komutu 
-- desteklememektedir. Truncate komutu  bir tabloyu değil içindeki tüm verileri silmek için kullanılır.


/*------------------------------------------------------------
/*  INSERT INTO
/*----------------------------------------------------------*/

/* vacation_plan tablosuna 2 kayıt girişi yapınız */

INSERT INTO vacation_plan VALUES (34, 'TURKEY', 'Happy Hotel', 1, 7, 3000);



-- NOT: Aynı komut tekrar çalıştırılırsa herhangi bir kısıt yoksa aynı veriler tekrar tabloya girilmiş olur. 

INSERT INTO vacation_plan VALUES (42, 'TURKEY', 'Hotel Mevlana', 2, 4, 2000);



/* vacation_plan tablosuna vacation_lenght,budget sutunlarını 
eksik olarak veri girişi yapınız */

INSERT INTO vacation_plan (place_id, country, hotel_name, employee_id)
	            VALUES (06, 'TURKEY', 'Hotel Başkent', 3);
		    
--Giriş yapılan değerlerin sütun başlıkları ile aynı sırada olması önemli 
--Giriş yapılmayan sutunlara NULL atanır.    
		    
		    
/*--------------------------------------------------------------------------
/*  CONSTRAINTS - KISITLAMALAR 
/*--------------------------------------------------------------------------
  
  NOT NULL - Bir Sütunun NULL içermemesini garanti eder. 

  UNIQUE - Bir sütundaki tüm değerlerin BENZERSİZ olmasını garanti eder.  

  PRIMARY KEY - Bir sütünün NULL içermemesini ve sütundaki verilerin 
                  BENZERSİZ olmasını garanti eder.(NOT NULL ve UNIQUE birleşimi gibi)

  FOREIGN KEY - Başka bir tablodaki Primary Key’i referans göstermek için kullanılır. 
                  Böylelikle, tablolar arasında ilişki kurulmuş olur. 

  DEFAULT - Herhangi bir değer atanmadığında Başlangıç değerinin atanmasını sağlar.
  
 /*----------------------------------------------------------------------------------------*/
  
CREATE TABLE workers (
	id INTEGER PRIMARY KEY,
	id_number VARCHAR(11) UNIQUE NOT NULL,
	name TEXT DEFAULT 'Noname',
	salary INT NOT NULL
	);
	
INSERT INTO workers VALUES (1, '123456789', 'Birgül Taze', 12000);

--Unique Const Violation
INSERT INTO workers VALUES (1, '1234666789', 'Birgül Taze', 12000);

INSERT INTO workers VALUES (3, '123496789', 'Ahmet Çakır', 8000);
INSERT INTO workers VALUES (4, '123426789', 'Edip Erbil', 13000);

--name kısmına NONAME yazıldı (default)   --name kısmını girmedik
INSERT INTO workers  (id, id_number,salary) VALUES (4, '123477789', 11000);



/* vacation_plan tablosunu place_id sütunu PK ve employee_id sütununu ise FK olarak değiştirerek vacation_plan2 
adında yeni bir tablo oluşturunuz. Bu tablo employees tablosu ile ilişkili olmalıdır*/
	
CREATE TABLE vacation_plan2 (
	place_id INTEGER,
	country TEXT,
	hotel_name VARCHAR(40),
	employee_id INTEGER,
	vacation_length INT,
	budget REAL,
	PRIMARY KEY (place_id ),
	FOREIGN KEY (employee_id) REFERENCES employees (EmployeeId)
	);
	
	
/* Employees tablosundaki EmployeeID'si 1 olan kişi için bir tatil planı giriniz */

INSERT INTO vacation_plan2 VALUES (37, 'Turkey', 'Hotel Sunrise', 1, 5, 5000);



/* Employees tablosunda bulunmayan bir kişi için (EmployeeID=9) olan kişi için bir tatil planı giriniz */

--HATA (Foreign Key constraint failed)
INSERT INTO vacation_plan2 VALUES (39, 'Turkey', 'Hotel Delray', 9, 4, 7000);


/* JOIN işlemi ile 2 tablodan veri çekme */
/* FirstName, LastName, vacation_length, hotel_name */

SELECT e.FirstName, e.LastName, v.vacation_length, v.hotel_name
FROM employees e
JOIN vacation_plan2 v
ON e.EmployeeId = v.employee_id;


/*----------------------------------------------------------------------------------
/*  ALTER TABLE (ADD, RENAME TO, DROP)
/*  --SQLITE MODIFY VE DELETE KOMUTLARINI DOĞRUDAN DESTEKLENMEZ
/*----------------------------------------------------------------------------------

/*vacation_plan2 tablosuna "name" adında ve DEFAULT değeri noname olan 
yeni bir sutun ekleyelim */

ALTER TABLE vacation_plan2
ADD name TEXT DEFAULT 'isimsiz';


/*vacation_plan2 tablosundaki name sutununu siliniz*/

--sütun ismini değiştirdik

ALTER TABLE vacation_plan2
RENAME COLUMN name TO city;


--tablo ismini değiştirdik

ALTER TABLE vacation_plan2
RENAME TO vacation_plan3;

/*vacation_plan3 tablosundaki city sutununu siliniz*/

ALTER TABLE vacation_plan3
DROP COLUMN city;


 /* workers tablosunun adını people olarak değiştiriniz */
 
ALTER TABLE workers
RENAME TO people;


/*------------------------------------------------------------------------------------------
-- UPDATE,DELETE

-- UPDATE tablo_adı
-- SET sutun1 = yeni_deger1, sutun2 = yeni_deger2,...  
-- WHERE koşul;
		
--DELETE tablo_adı
--WHERE koşul;
/*-----------------------------------------------------------------------------------------*/

/*vacation_plan3 tablosundaki employee_id=1 olan kaydin hotel_name'ini
 Komagene Hotel olarak güncelleyiniz.*/

 UPDATE vacation_plan3
 SET hotel_name = 'Komagene Hotel'
 WHERE employee_id = 1;

 
/* people tablosunda salary sutunu 11000 ve fazla olanların salary(maaşına)
%10 zam yapacak sorguyu yazınız*/ 

UPDATE people
SET salary = salary*1.1
WHERE salary >= 11000;


/*people tablosundaki tüm kayıtların salary sutununu 10000 olarak güncelleyiniz */

UPDATE people
SET salary = 10000;


/* people tablosundaki id=1 olan kaydı siliniz*/

DELETE FROM people
WHERE id =1;
































 





















	
	
	
	
	
	
	
	
	
  
  
  
  


















	







	
	



