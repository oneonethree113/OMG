/****** Object:  StoredProcedure [dbo].[sp_select_SHM03]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SHM03]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHM03]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/****** Object:  Stored Procedure dbo.sp_select_SHM03    Script Date: 05/06/2003 18:10:18 ******/
-- Modified by	: Solo So As at 2002-08-21
-- Description 	: If @from = 'Batch' & @to = 'Batch' then all invoice will be closed on condition that getdate - sailing on/abt date > 30
--
/*

-- Checked by Allan Yuen at 27/07/2003


=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
 6 May 2003	Lewis To		Modify do not update SC and PO
				Status in Batch Processing     
12 May 2003	Lewis To		Add New Update SC  and PO  status
				Rule  
				SC ordqty = shpqty then Close
				PO ordqty = recqty and related SC has closed then close    
=========================================================     
*/
CREATE PROCEDURE [dbo].[sp_select_SHM03] 

@cocde	nvarchar(6),
@from	nvarchar(20),
@to	nvarchar(20),
@fntyp	nvarchar(1)

AS

BEGIN

	Declare @currdat	datetime
	Set @currdat = getdate()

	IF @fntyp = 'Y' 
	BEGIN
		
		DECLARE -- SHIPGDTL
		@hid_ordno	nvarchar(20), 
		@hid_ordseq	int, 
		@hid_shpqty	int

		DECLARE cur_SHIPGDTL CURSOR
		FOR SELECT 
		d.hid_ordno,	
		d.hid_ordseq,
		sum(d.hid_shpqty)
		FROM SHIPGDTL d, SHIPGHDR h
		Where	h.hih_shpsts = 'OPE' AND h.hih_cocde = @cocde
		AND 	d.hid_shpno = h.hih_shpno AND d.hid_cocde = h.hih_cocde
		AND	((h.hih_shpno >= @from AND h.hih_shpno <= @to  and @from <> 'Batch') or 
			(@currdat - h.hih_slnonb > 30 and @from = 'Batch'))
		Group by d.hid_ordno, d.hid_ordseq

		OPEN cur_SHIPGDTL
		FETCH NEXT FROM cur_SHIPGDTL INTO 
		@hid_ordno, 
		@hid_ordseq,
		@hid_shpqty
	
		WHILE @@fetch_status = 0
		BEGIN
	
			UPDATE SCORDDTL SET
-- ************     Change Invoice QTY not accumulated by Shp QTY in Shp Dtl, Replace by Shp Qty in SC                by Lewis on 6 May 2003 ***************  
--			sod_invqty = sod_invqty + @hid_shpqty,
			sod_invqty = sod_shpqty ,
			sod_updusr = 'SYSTEM',
			sod_upddat = getdate()
			WHERE 
			sod_cocde = @cocde AND
			sod_ordno = @hid_ordno AND
			sod_ordseq = @hid_ordseq
		
			FETCH NEXT FROM cur_SHIPGDTL INTO 
			@hid_ordno, 
			@hid_ordseq,
			@hid_shpqty

			END
		
		CLOSE cur_SHIPGDTL                                   
		DEALLOCATE cur_SHIPGDTL 

		-------------------------------------


	





--**************************************************************************
--***** Add a condition to prevent run in Batch Processing  by Lewis on 6 May 2003  ******
--**************************************************************************
	If @from <> 'Batch' 
	     Begin	
		DECLARE 
		@pod_netqty int
		
		DECLARE cur_SCORDHDR cursor
		FOR SELECT distinct d.hid_ordno
		FROM SHIPGDTL d, SHIPGHDR h
		Where	h.hih_shpsts = 'OPE' AND h.hih_cocde = @cocde
		AND 	d.hid_shpno = h.hih_shpno AND d.hid_cocde = h.hih_cocde
		AND	((h.hih_shpno >= @from AND h.hih_shpno <= @to  and @from <> 'Batch') or 
			(@currdat - h.hih_slnonb > 30 and @from = 'Batch'))
		ORDER BY d.hid_ordno
		
		OPEN cur_SCORDHDR
		FETCH NEXT FROM cur_SCORDHDR INTO
		@hid_ordno
		
		WHILE @@fetch_status = 0
		BEGIN
	
		
			SELECT @pod_netqty = SUM(CASE WHEN (dtl.sod_ordqty - dtl.sod_invqty)>0 THEN (dtl.sod_ordqty - dtl.sod_invqty) ELSE 0 END)
			FROM SCORDDTL dtl
			WHERE
			dtl.sod_cocde = @cocde AND
			dtl.sod_ordno = @hid_ordno
			
		/*
--***********Remark to not update SC Status by Lewis on 14 May 2003 **************************************
			IF @pod_netqty = 0
			BEGIN
			
				UPDATE SCORDHDR
				SET soh_ordsts = 'CLO',
				soh_updusr = 'SYSTEM',
				soh_upddat = getdate()
				WHERE 
				soh_cocde = @cocde AND
				soh_ordno = @hid_ordno
		
	
			END
		*/
			FETCH NEXT FROM cur_SCORDHDR INTO
			@hid_ordno
		END
		
		CLOSE cur_SCORDHDR
		DEALLOCATE cur_SCORDHDR

		
			
		-------------------------------------
		DECLARE
		@hid_purord nvarchar(20)
		/*
--***********Remark to not update PO Status by Lewis on 14 May 2003 **************************************
		
		DECLARE cur_POORDHDR cursor
		FOR SELECT distinct d.hid_purord
		FROM SHIPGDTL d, SHIPGHDR h
		Where	h.hih_shpsts = 'OPE' AND h.hih_cocde = @cocde
		AND 	d.hid_shpno = h.hih_shpno AND d.hid_cocde = h.hih_cocde
		AND	((h.hih_shpno >= @from AND h.hih_shpno <= @to  and @from <> 'Batch') or 
			(@currdat - h.hih_slnonb > 30 and @from = 'Batch'))
		ORDER BY d.hid_purord
		
		
		OPEN cur_POORDHDR
		FETCH NEXT FROM cur_POORDHDR INTO
		@hid_purord
		
		WHILE @@fetch_status = 0
		BEGIN
	
		
			SELECT @pod_netqty = SUM(CASE WHEN (dtl.pod_ordqty - dtl.pod_recqty)>0 THEN (dtl.pod_ordqty - dtl.pod_recqty) ELSE 0 END)
			FROM POORDDTL dtl
			WHERE
			dtl.pod_cocde = @cocde AND
			dtl.pod_purord = @hid_purord
			
		
			IF @pod_netqty = 0
			BEGIN


				UPDATE POORDHDR
				SET poh_pursts = 'CLO',
				poh_updusr = 'SYSTEM',
				poh_upddat = getdate()
				WHERE 
				poh_cocde = @cocde AND
				poh_purord = @hid_purord
		
				UPDATE POBOMHDR
				SET pbh_bomsts = 'CLO',
				pbh_updusr = 'SYSTEM',
				pbh_upddat = getdate()
				WHERE
				pbh_purord IN (	SELECT distinct pdb_bompno 
				FROM PODTLBOM WHERE
				pdb_cocde = @cocde AND
				pdb_purord = @hid_purord )
			END
			FETCH NEXT FROM cur_POORDHDR INTO
			@hid_purord
		END
		
		CLOSE cur_POORDHDR
		DEALLOCATE cur_POORDHDR
	*/
	        END
	Else
--*****	Add for Update SC Status by Lewis on 12 MAY 2003 *************************************** 
	       Begin
		Declare 
		@soh_cocde	varchar(6),
		@soh_ordno	varchar(20)

		DECLARE cur_SCORDHDR CURSOR
		FOR 
		SELECT
		soh_cocde,
		soh_ordno
		from SCORDHDR
		left join SCORDDTL on sod_cocde = soh_cocde and sod_ordno = soh_ordno
		where soh_ordsts = 'REL' 
		group by soh_cocde, soh_ordno having sum(sod_ordqty) - sum(sod_shpqty) = 0 and sum(sod_ordqty) >  0
 
		OPEN cur_SCORDHDR
		FETCH NEXT FROM cur_SCORDHDR INTO 
		@soh_cocde,
		@soh_ordno 
	
		WHILE @@fetch_status = 0
		     BEGIN

			UPDATE SCORDHDR SET
			soh_ordsts = 'CLO',
			soh_updusr = 'SYSTEM',
			soh_upddat = getdate()
			Where 	soh_cocde = @soh_cocde AND
				soh_ordno = @soh_ordno 

		        FETCH NEXT FROM cur_SCORDHDR INTO 
		       @soh_cocde,
		       @soh_ordno 
		   END
		CLOSE cur_SCORDHDR                                   
		DEALLOCATE cur_SCORDHDR 
	    END		

--******	Add for run Close PO Status in Batch mode by Lewis on 12 May 2003 **********************
		declare 
		@poh_cocde 	varchar(6),
		@poh_purord	varchar(20)

		DECLARE cur_POORDHDR cursor
		FOR 
		SELECT  
		poh_cocde,
		poh_purord		
		FROM POORDHDR 
		left join  POORDDTL on pod_cocde = poh_cocde and pod_purord = poh_purord
		left join SCORDHDR on soh_cocde = poh_cocde and soh_ordno = poh_ordno
		where poh_pursts = 'REL' and soh_ordsts = 'CLO'
		group by poh_cocde, poh_purord  having sum(pod_ordqty) - sum(pod_recqty) = 0 
		
		OPEN cur_POORDHDR
		FETCH NEXT FROM cur_POORDHDR INTO 
		@poh_cocde,
		@poh_purord 
	
		WHILE @@fetch_status = 0
		     BEGIN
	                       
			UPDATE POORDHDR SET
			poh_pursts = 'CLO',
			poh_updusr = 'SYSTEM',
			poh_upddat = getdate()
			Where 	poh_cocde = @poh_cocde AND
				poh_purord = @poh_purord 

		        FETCH NEXT FROM cur_POORDHDR INTO 
		       @poh_cocde,
		       @poh_purord 
		   END
   		CLOSE cur_POORDHDR                                   
		DEALLOCATE cur_POORDHDR 

--****** End of New PO Status update by Lewis **************************************


--**********************************************************
--****      END of not to run in Batch   by Lewis on 6 May 2003      *****
--**********************************************************
		-------------------------------------



		Update	 SHIPGHDR 
		SET	hih_shpsts = 'REL',
			hih_upddat = @currdat
		Where	hih_shpsts = 'OPE' AND hih_cocde = @cocde
		AND	((hih_shpno >= @from AND hih_shpno <= @to  and @from <> 'Batch') or 
			(@currdat - hih_slnonb > 30 and @from = 'Batch'))

	END

END



GO
GRANT EXECUTE ON [dbo].[sp_select_SHM03] TO [ERPUSER] AS [dbo]
GO
