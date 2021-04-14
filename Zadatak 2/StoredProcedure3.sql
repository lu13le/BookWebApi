Use KadroviTX
go
--kreiranje procedure
create procedure dbo.uspNajboljePlacenaRM 
 @pBrojRM int 
as
 declare @lSifRM numeric, @lNaziv varchar(20), 
 @lsifraOP numeric, @lprosPrimanja numeric(10,4), 
 @lBrojac int = 0, 
 @lBrojRM int = 0; 
 declare c_RM CURSOR FOR 
 --selektovanje podataka
 SELECT sifraRM,
 avg(plata + isNull(premija, 0)) as prosecna_primanja_RM 
 FROM Radnik r JOIN Angazovanje a 
 ON r.sifraZap = a.sifraZap 
 GROUP BY sifraRM
 ORDER BY avg(plata + isNull(premija, 0)) desc ; 
 begin 
 OPEN c_RM ; 
 FETCH NEXT FROM c_RM INTO @lSifRM, @lprosPrimanja ;
 while @@FETCH_STATUS = 0 and @lBrojac < @pBrojRM 
 begin 
 select @lNaziv = nazivRM, @lsifraOP = sifraProf 
 from radno_mesto 
 where sifraRM = @lSifRM ; 
--ispis povratne informacije
 print 'Naziv radnog mesta: ' + @lNaziv + ', sifra profila: ' + 
 cast(@lsifraOP as varchar) + ', Prosecna primanja RM: ' + 
 cast(@lprosPrimanja as varchar) ; 
 set @lBrojac = @lBrojac + 1 ; 
 FETCH NEXT FROM c_RM INTO @lSifRM, @lprosPrimanja ;
 end ; 
 close c_RM ; 
 deallocate c_RM ;
 end;
