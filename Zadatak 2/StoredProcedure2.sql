use KadroviTX
go

--kreiranje procedure
create procedure dbo.uspNajboljePlaceniRadnici 
@pSifOdeljenja int, @pBrojRadnika int
as
--deklarisanje parametara
 declare @lSifZap numeric, @lIme varchar(20), @lPrezime 
varchar(20), @lPplata numeric, @lBrojac int = 0 ;
--deklarisanje kursora
 declare c_Radnik CURSOR FOR SELECT sifrazap, ime, 
prezime, plata
 FROM Radnik WHERE sifraodelj = @pSifOdeljenja order by 
plata desc ;begin 
 OPEN c_Radnik ; 
 FETCH NEXT FROM c_Radnik INTO @lSifZap, @lIme, @lPrezime, @lPplata ; 
 if @@FETCH_STATUS = 0 
 print 'Šifra odeljenja: ' + cast(@pSifOdeljenja as varchar) ;
 while @@FETCH_STATUS = 0 and @lBrojac < @pBrojRadnika 
 begin 
 --ispis povratnih informacija
 print 'Radnik : ' + cast(@lSifZap as varchar) + ' ' + 
 @lIme + ' ' + @lPrezime + ' ima platu: ' + cast (@lPplata as 
 varchar); 
 set @lBrojac = @lBrojac + 1 ; 
 FETCH NEXT FROM c_Radnik INTO @lSifZap, @lIme, @lPrezime, @lPplata ; 
 end ; 
 --zatvaranje kursora i dealokacija
close c_Radnik ; 
deallocate c_Radnik ; 
end ;