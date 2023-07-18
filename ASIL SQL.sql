create database hastane
use hastane
-----------TABLOLAR-----------------
create table AalýnanRandevular(
randevuID int identity(10,1)primary key,
TC varchar(255),
poliklinikAdi varchar(255),
DoktorAdi varchar(255),
Tarih varchar(255),
Saat varchar(255))

drop table if exists poliklinikler;
create table poliklinikler(
poliklinikID int identity(1,1) primary key not null,
poliklinikAdi varchar(255)default null);
set implicit_transactions on insert into poliklinikler(poliklinikAdi) values 
 ('Çocuk Saðlýðý Ve Hastalýklarý'),
 ('Deri Ve Zührevi Hastalýklarý (Cildiye)'),
 ('Enfeksiyon Hastalýklarý'),
 ('Onkoloji'),
 ('Fizik Tedavi Ve Rehabilitasyon'),
 ('Genel Cerrahi'),
 ('Ýç Hastalýklarý (Dahiliye)'),
 ('Kadýn Hastalýklarý ve Doðum'),
 ('Kalp ve Damar Cerrahisi'),
 ('Kardiyoloji'),
 ('Kulak Burun Boðaz Hastalýklarý'),
 ('Nöroloji'),
 ('Ortopedi Ve Travmatoloji'),
 ('Ruh Saðlýðý Ve Hastalýklarý (Psikiyatri)'),
 ('Üroloji')
 if (@@ERROR>0)
	rollback transaction
else
	commit transaction
select * from poliklinikler
Delete from poliklinikler where poliklinikID = 21

drop table if exists ddoktorlar
create table ddoktorlar(
doktorID int primary key identity(4001,1) not null,
Sifre varchar(255) default null,
doktorAdiSoyadi varchar(255) default null,
poliklinikID int default null)

set implicit_transactions on insert into ddoktorlar values
('1235','Arda Ekin','1'),
('1236','Elif Yýlmaz','1'),
('1237','Sevinç Ak','2'),
('1238','Kayýhan Akarcalý','2'),
('1239','Cihan Akpýnar','3'),
('1240','Emir Kor','3'),
('1241','Mehmet Akay','4'),
('1242','Osman Çelik','4'),
('1243','Mert Yýlmaz','5'),
('1244','Eda Ýçli','5'),
('1245','Irmak Kaþlý','6'),
('1246','Pýnar Yaðmur','6'),
('1247','Emre Çalýþkan','7'),
('1248','Özge Özkanlý','7'),
('1249','Þule Temel','8'),
('1250','Batuhan Ak','8'),
('1251','Ceren Yýldýz','9'),
('1252','Çaðla Eroðlu','9'),
('1253','Berkan Bolatoðlu','10'),
('1254','Burak Bursalý','10'),
('1255','Deniz Kara','11'),
('1256','Deniz Öztürk','11'),
('1257','Devrim Yýlhan','12'),
('1258','Ömer Akýn','12'),
('1259','Fatih Derviþ','13'),
('1260','Cansu Canan','13'),
('1261','Derin Devrim','14'),
('1262','Yusuf Gün','14'),
('1263','Korkut Eliaçýk','15'),
('1264','Ýhsan Ay','15')
if (@@ERROR>0)
	rollback transaction
else
	commit transaction
select * from ddoktorlar


drop table if exists hhastalar
create table hhastalar(
TC bigint primary key not null,
adi varchar(255) default null,
soyadi varchar(255) default null,
DogumTarihi varchar(255) default null,
DogumYeri varchar(255) default null,
anneAdi varchar(255) default null,
babaAdi varchar(255) default null,
CepTel varchar(255) default null,
Cinsiyeti varchar(255) default null,
Parola varchar(255) default null
)
set implicit_transactions on insert into hhastalar values 
(12345678902,'Akýn','Akça','23.10.1998','Ýstanbul','Ayþe','Erman','05347861020','Erkek','1234'),
(12345678904,'Elif','Yýlmaz','05.11.1988','Ankara','Feriha','Faruk','05347861021','Kadýn','1235'),
(12345678906,'Aslý','Eliuzun','21.05.1979','Ýzmir','Ayþe','Ali','05347861022','Kadýn','1236'),
(12345678908,'Birsen','Birdir','10.10.1978','Bursa','Azra','Burak','05347861023','Kadýn','1237'),
(12345678910,'Utku','Alper','03.12.1998','Adýyaman','Ceylan','Deniz','05347861024','Erkek','1238'),
(12345678912,'Melih','Altun','11.01.1958','Adana','Esra','Furkan','05347861025','Erkek','1239'),
(12345678914,'Mustafa','Koçak','21.10.1990','Eskiþehir','Gamze','Halis','05347861026','Erkek','1240'),
(12345678916,'Ceyda','Tok','03.05.1969','Ýstanbul','Iþýk','Ýsmail','05347861027','Kadýn','1241')
if (@@ERROR>0)
	rollback transaction
else
	commit transaction
select * from hhastalar


create table Randevular(
RandevuID int primary key identity(1,1),
TC varchar(255),
poliklinikID int,
doktorID int,
tarih varchar(255),
saat varchar(255)
constraint TC foreign key(TC) references hastalar(TC),
constraint doktorID foreign key(doktorID) references doktorlar(doktorID),
constraint poliklinikID foreign key(poliklinikID) references poliklinikler(poliklinikID)
)


drop table if exists Personeller;
create table Personeller(
personelID int primary key identity(4000,4),
parola varchar(255)
);

set implicit_transactions on insert into Personeller (parola) values ('1234')
if (@@ERROR>0)
	rollback transaction
else
	commit transaction
select * from Personeller
------------VÝEW-------------
alter view DoktorView3 as
select d.doktorID, d.Sifre, d.doktorAdiSoyadi, p.poliklinikAdi, p.poliklinikID
from ddoktorlar as d
right JOIN poliklinikler as p on d.poliklinikID = p.poliklinikID;
use hastane
select * from DoktorView3

use hastane
create view polikliniklerview
as
select poliklinikID, poliklinikAdi from poliklinikler
--select * from polikliniklerview
-----------TRÝGGER-----------
use hastane
create trigger KayýtOl
on hhastalar
after insert
as 
begin 
	insert into hhastalar(TC,adi,soyadi,DogumTarihi,DogumYeri,anneAdi,babaAdi,CepTel,Cinsiyeti,Parola)
	select TC,adi,soyadi,DogumTarihi,DogumYeri,anneAdi,babaAdi,CepTel,Cinsiyeti,Parola
	from inserted;
end
go
/*insert hhastalar(TC,adi,soyadi,DogumTarihi,DogumYeri,anneAdi,babaAdi,CepTel,Cinsiyeti,Parola) 
values(23456789012,'Fatma','Erdoðan','21.12.2023','Aksaray','Halime','Yusuf','5348158219','Kadýn','2121')
select * from hhastalar*/
/*delete from hhastalar where adi = 'fatma'*/
create trigger RandevuAlÝptal
on AlýnanRandevular
after delete,insert
as 
begin
	delete from AalýnanRandevular
	where randevuID in (select randevuID from deleted);
end
begin
	insert into AalýnanRandevular(TC,poliklinikAdi,DoktorAdi,Tarih,Saat)
	select TC,poliklinikAdi,doktorAdi,Tarih,Saat
	from inserted;
end
/*delete from AalýnanRandevular where randevuID = 11
select * from AalýnanRandevular

insert AalýnanRandevular(TC,poliklinikAdi,DoktorAdi,Tarih,Saat) 
values('12345678902','Enfeksiyon Hastalýklarý','Cihan Akpýnar','21.12.2023','11.00')
select * from AalýnanRandevular*/

create trigger DoktorSilEkle3
on ddoktorlar
after delete, insert
as
begin
    delete from ddoktorlar
    where doktorID in (select doktorID from deleted);
end
begin
	insert into ddoktorlar(Sifre, doktorAdiSoyadi, poliklinikID)
    select Sifre, doktorAdiSoyadi, poliklinikID
    from inserted;
end 
--delete from ddoktorlar where doktorID = 4032
--select * from doktorlar

--insert ddoktorlar(Sifre,doktorAdiSoyadi,poliklinikID) values('2121','Fatma Erdoðan','4')
--select * from ddoktorlar


create trigger HastaEkle2
ON hhastalar
after insert
as
begin
    
    insert into hhastalar (TC, adi, soyadi, DogumTarihi, DogumYeri, anneAdi, babaAdi, CepTel, Cinsiyeti,Parola)
    select TC, adi, soyadi, DogumTarihi, DogumYeri, anneAdi, babaAdi, CepTel, Cinsiyeti,Parola
    from inserted;
end;
/*insert into hhastalar(TC, adi, soyadi, DogumTarihi, DogumYeri, anneAdi, babaAdi, CepTel, Cinsiyeti,Parola)
values('21212121213','Fatmaa', 'Erdoðan','21.12.2021','Aksaray','Halime','Yusuf','0349125010','Kadýn','2121') */
--select * from hhastalar
--delete from hhastalar where TC = '21212121213'


create trigger PoliklinikEkle
on doktorlar
after delete ,insert
as
begin
    delete from polikliniklerview
    where poliklinikID IN (select poliklinikID from deleted);
end
begin
	insert into polikliniklerview(poliklinikAdi)
    select poliklinikID
    from inserted;
end 
/*delete from polikliniklerview where poliklinikID = 20
select * from polikliniklerview*/

/*insert polikliniklerview values ('Cerrahi onkoloji')
select * from polikliniklerview*/

--------------PROSEDÜRLER------------
create proc doktorGüncelle2(
@doktorID int ,
@Sifre varchar(255),
@doktorAdiSoyadi varchar(255),
@poliklinikID int
)
as update ddoktorlar set Sifre = @Sifre,
doktorAdiSoyadi = @doktorAdiSoyadi,
poliklinikID = @poliklinikID where doktorID = @doktorID

--exec doktorGüncelle '4001','2121','Ceylan Akýn','1'
--select * from doktorlar

create proc HastaGiriþ
    @TC varchar(255),
    @Parola varchar(255),
    @giriþBaþarýlý bit output
as
begin
    set @giriþBaþarýlý = 0;
    if EXISTS (select 1 from hastalar where TC = @TC AND Parola = @Parola)
    begin
        set @giriþBaþarýlý = 1;
    end
    else
    begin
        set @giriþBaþarýlý = 0;
    end
end;

/*declare @GiriþYapýldý bit;
exec HastaGiriþ'12345678902', '1234',@GiriþYapýldý output;
if @GiriþYapýldý= 1
    print 'Giriþ baþarýlý.';
else
    print 'Giriþ baþarýsýz.';*/

create proc DoktorGiriþi2
	@doktorID varchar(255),
    @Sifre varchar(255),
    @giriþBaþarýlý bit output
as
begin
    set @giriþBaþarýlý = 0;
    if EXISTS (select 1 from ddoktorlar where doktorID= @doktorID AND Sifre = @Sifre)
    begin
        set @giriþBaþarýlý = 1;
    end
    else
    begin
        set @giriþBaþarýlý = 0;
    end
end;

/*declare @GiriþYapýldý bit;
exec DoktorGiriþi2'4037', '2121',@GiriþYapýldý output;
if @GiriþYapýldý= 1
    print 'Giriþ baþarýlý.';
else
    print 'Giriþ baþarýsýz.'; */

create proc PersonelGiriþi
	@personelID varchar(255),
    @parola varchar(255),
    @giriþBaþarýlý bit output
as
begin
    set @giriþBaþarýlý = 0;
    if EXISTS (select 1 from Personeller where personelID= @personelID AND parola = @parola)
    begin
        set @giriþBaþarýlý = 1;
    end
    else
    begin
        set @giriþBaþarýlý = 0;
    end
end;

/*declare @GiriþYapýldý bit;
exec PersonelGiriþi'4000', '1234',@GiriþYapýldý output;
if @GiriþYapýldý= 1
    print 'Giriþ baþarýlý.';
else
    print 'Giriþ baþarýsýz.';*/
-----------------FONKSÝYONLAR-----------------------
create function DoktorRandevulari(@doktorID VARCHAR(255))
returns table
as
return
	select r.*
	from AalýnanRandevular as r
	join ddoktorlar as d on r.DoktorAdi = d.doktorAdiSoyadi
	where d.doktorID = @doktorID

--select * from dbo.DoktorRandevulari(4005);



