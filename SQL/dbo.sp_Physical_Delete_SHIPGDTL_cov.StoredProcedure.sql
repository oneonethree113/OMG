/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_SHIPGDTL_cov]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_Physical_Delete_SHIPGDTL_cov]
GO
/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_SHIPGDTL_cov]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




------------------------------------------------- 
CREATE procedure [dbo].[sp_Physical_Delete_SHIPGDTL_cov]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@hid_cocde	nvarchar(6),
@hid_ctrcfs	nvarchar(30) 

----------------------------------------------  
AS
BEGIN
DECLARE @tltcnt INT = 0;


------------------------ Make a loop for trigger SHIPGDTL_COV tr_delete----------------------
----------- added by Michael 20170421
set @tltcnt = (select count(hid_shpseq)
				from SHIPGDTL
				where @hid_ctrcfs = hid_ctrcfs and @hid_cocde=hid_cocde )

CREATE table #TEMP(hid_shpseq int)

INSERT INTO #TEMP
SELECT hid_shpseq as 'hid_shpseq_temp'
FROM SHIPGDTL
WHERE  @hid_ctrcfs = hid_ctrcfs and @hid_cocde=hid_cocde


DECLARE @cnt INT = 0;

WHILE @cnt < @tltcnt
	BEGIN
   		Delete SHIPGDTL_cov
		Where 
		hid_cocde=@hid_cocde
			and hid_ctrcfs=@hid_ctrcfs
			and hid_shpseq = (Select top (@cnt+1) * From #TEMP 
								EXCEPT
								Select top (@cnt) * From #TEMP)
		

		SET @cnt = @cnt + 1;
	END


---------------------------------------------------------- 
end










GO
GRANT EXECUTE ON [dbo].[sp_Physical_Delete_SHIPGDTL_cov] TO [ERPUSER] AS [dbo]
GO
