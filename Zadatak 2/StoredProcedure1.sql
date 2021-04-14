use KadroviTX
go
--kreiranje procedure
create procedure dbo.uspPovecanjePlate 
 @pProcPovecanja numeric, @pLimitPlata numeric
as
--deklaracija promenjivih
 declare @lSumaPlata numeric, @lPlata numeric, @lTekucePovecanje 
numeric, @lSifZap int, @lBrojac int = 0 ;
--deklarisanje kursora
 declare c_Radnik CURSOR FOR 
 --select upit koji pokriva trazene parametre
 SELECT sifraZap, plata
 FROM Radnik order by plata ;
begin
--izjednacavanje lokalnih parametara sa stvarnim
 SELECT @lSumaPlata = SUM(plata) FROM Radnik;
 if @lSumaPlata < @pLimitPlata
 begin
 OPEN c_Radnik ;
 FETCH NEXT FROM c_Radnik INTO @lSifZap, @lPlata ;
 while @@FETCH_STATUS = 0 
 begin
 SET @lTekucePovecanje = @lPlata * @pProcPovecanja/100;
 SET @lSumaPlata = @lSumaPlata + @lTekucePovecanje; if @lSumaPlata <= @pLimitPlata
 begin
 UPDATE Radnik
 SET plata = plata + 
@lTekucePovecanje
 WHERE sifraZap = @lSifZap ;
 set @lBrojac = @lBrojac + 1 ;
 FETCH NEXT FROM c_Radnik INTO 
@lSifZap, @lPlata ;
 end;
 else
 break ; 
end ; 
close c_Radnik ; 
end;
--ispisivanje povratne informacije o povecanju
 print 'Plata je povecana za ' + 
cast(@lBrojac as varchar) + 
' radnik(a). ' ; 
 deallocate c_Radnik ;
end ;