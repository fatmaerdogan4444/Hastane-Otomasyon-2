create database hastane
use hastane
-----------TABLOLAR-----------------
create table Aal�nanRandevular(
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
 ('�ocuk Sa�l��� Ve Hastal�klar�'),
 ('Deri Ve Z�hrevi Hastal�klar� (Cildiye)'),
 ('Enfeksiyon Hastal�klar�'),
 ('Onkoloji'),
 ('Fizik Tedavi Ve Rehabilitasyon'),
 ('Genel Cerrahi'),
 ('�� Hastal�klar� (Dahiliye)'),
 ('Kad�n Hastal�klar� ve Do�um'),
 ('Kalp ve Damar Cerrahisi'),
 ('Kardiyoloji'),
 ('Kulak Burun Bo�az Hastal�klar�'),
 ('N�roloji'),
 ('Ortopedi Ve Travmatoloji'),
 ('Ruh Sa�l��� Ve Hastal�klar� (Psikiyatri)'),
 ('�roloji')
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
('1236','Elif Y�lmaz','1'),
('1237','Sevin� Ak','2'),
('1238','Kay�han Akarcal�','2'),
('1239','Cihan Akp�nar','3'),
('1240','Emir Kor','3'),
('1241','Mehmet Akay','4'),
('1242','Osman �elik','4'),
('1243','Mert Y�lmaz','5'),
('1244','Eda ��li','5'),
('1245','Irmak Ka�l�','6'),
('1246','P�nar Ya�mur','6'),
('1247','Emre �al��kan','7'),
('1248','�zge �zkanl�','7'),
('1249','�ule Temel','8'),
('1250','Batuhan Ak','8'),
('1251','Ceren Y�ld�z','9'),
('1252','�a�la Ero�lu','9'),
('1253','Berkan Bolato�lu','10'),
('1254','Burak Bursal�','10'),
('1255','Deniz Kara','11'),
('1256','Deniz �zt�rk','11'),
('1257','Devrim Y�lhan','12'),
('1258','�mer Ak�n','12'),
('1259','Fatih Dervi�','13'),
('1260','Cansu Canan','13'),
('1261','Derin Devrim','14'),
('1262','Yusuf G�n','14'),
('1263','Korkut Elia��k','15'),
('1264','�hsan Ay','15')
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
(12345678902,'Ak�n','Ak�a','23.10.1998','�stanbul','Ay�e','Erman','05347861020','Erkek','1234'),
(12345678904,'Elif','Y�lmaz','05.11.1988','Ankara','Feriha','Faruk','05347861021','Kad�n','1235'),
(12345678906,'Asl�','Eliuzun','21.05.1979','�zmir','Ay�e','Ali','05347861022','Kad�n','1236'),
(12345678908,'Birsen','Birdir','10.10.1978','Bursa','Azra','Burak','05347861023','Kad�n','1237'),
(12345678910,'Utku','Alper','03.12.1998','Ad�yaman','Ceylan','Deniz','05347861024','Erkek','1238'),
(12345678912,'Melih','Altun','11.01.1958','Adana','Esra','Furkan','05347861025','Erkek','1239'),
(12345678914,'Mustafa','Ko�ak','21.10.1990','Eski�ehir','Gamze','Halis','05347861026','Erkek','1240'),
(12345678916,'Ceyda','Tok','03.05.1969','�stanbul','I��k','�smail','05347861027','Kad�n','1241')
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
------------V�EW-------------
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
-----------TR�GGER-----------
use hastane
create trigger Kay�tOl
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
values(23456789012,'Fatma','Erdo�an','21.12.2023','Aksaray','Halime','Yusuf','5348158219','Kad�n','2121')
select * from hhastalar*/
/*delete from hhastalar where adi = 'fatma'*/
create trigger RandevuAl�ptal
on Al�nanRandevular
after delete,insert
as 
begin
	delete from Aal�nanRandevular
	where randevuID in (select randevuID from deleted);
end
begin
	insert into Aal�nanRandevular(TC,poliklinikAdi,DoktorAdi,Tarih,Saat)
	select TC,poliklinikAdi,doktorAdi,Tarih,Saat
	from inserted;
end
/*delete from Aal�nanRandevular where randevuID = 11
select * from Aal�nanRandevular

insert Aal�nanRandevular(TC,poliklinikAdi,DoktorAdi,Tarih,Saat) 
values('12345678902','Enfeksiyon Hastal�klar�','Cihan Akp�nar','21.12.2023','11.00')
select * from Aal�nanRandevular*/

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

--insert ddoktorlar(Sifre,doktorAdiSoyadi,poliklinikID) values('2121','Fatma Erdo�an','4')
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
values('21212121213','Fatmaa', 'Erdo�an','21.12.2021','Aksaray','Halime','Yusuf','0349125010','Kad�n','2121') */
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

--------------PROSED�RLER------------
create proc doktorG�ncelle2(
@doktorID int ,
@Sifre varchar(255),
@doktorAdiSoyadi varchar(255),
@poliklinikID int
)
as update ddoktorlar set Sifre = @Sifre,
doktorAdiSoyadi = @doktorAdiSoyadi,
poliklinikID = @poliklinikID where doktorID = @doktorID

--exec doktorG�ncelle '4001','2121','Ceylan Ak�n','1'
--select * from doktorlar

create proc HastaGiri�
    @TC varchar(255),
    @Parola varchar(255),
    @giri�Ba�ar�l� bit output
as
begin
    set @giri�Ba�ar�l� = 0;
    if EXISTS (select 1 from hastalar where TC = @TC AND Parola = @Parola)
    begin
        set @giri�Ba�ar�l� = 1;
    end
    else
    begin
        set @giri�Ba�ar�l� = 0;
    end
end;

/*declare @Giri�Yap�ld� bit;
exec HastaGiri�'12345678902', '1234',@Giri�Yap�ld� output;
if @Giri�Yap�ld�= 1
    print 'Giri� ba�ar�l�.';
else
    print 'Giri� ba�ar�s�z.';*/

create proc DoktorGiri�i2
	@doktorID varchar(255),
    @Sifre varchar(255),
    @giri�Ba�ar�l� bit output
as
begin
    set @giri�Ba�ar�l� = 0;
    if EXISTS (select 1 from ddoktorlar where doktorID= @doktorID AND Sifre = @Sifre)
    begin
        set @giri�Ba�ar�l� = 1;
    end
    else
    begin
        set @giri�Ba�ar�l� = 0;
    end
end;

/*declare @Giri�Yap�ld� bit;
exec DoktorGiri�i2'4037', '2121',@Giri�Yap�ld� output;
if @Giri�Yap�ld�= 1
    print 'Giri� ba�ar�l�.';
else
    print 'Giri� ba�ar�s�z.'; */

create proc PersonelGiri�i
	@personelID varchar(255),
    @parola varchar(255),
    @giri�Ba�ar�l� bit output
as
begin
    set @giri�Ba�ar�l� = 0;
    if EXISTS (select 1 from Personeller where personelID= @personelID AND parola = @parola)
    begin
        set @giri�Ba�ar�l� = 1;
    end
    else
    begin
        set @giri�Ba�ar�l� = 0;
    end
end;

/*declare @Giri�Yap�ld� bit;
exec PersonelGiri�i'4000', '1234',@Giri�Yap�ld� output;
if @Giri�Yap�ld�= 1
    print 'Giri� ba�ar�l�.';
else
    print 'Giri� ba�ar�s�z.';*/
-----------------FONKS�YONLAR-----------------------
create function DoktorRandevulari(@doktorID VARCHAR(255))
returns table
as
return
	select r.*
	from Aal�nanRandevular as r
	join ddoktorlar as d on r.DoktorAdi = d.doktorAdiSoyadi
	where d.doktorID = @doktorID

--select * from dbo.DoktorRandevulari(4005);



