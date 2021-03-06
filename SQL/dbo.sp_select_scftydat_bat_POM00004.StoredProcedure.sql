/****** Object:  StoredProcedure [dbo].[sp_select_scftydat_bat_POM00004]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_scftydat_bat_POM00004]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_scftydat_bat_POM00004]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- This stored procedure is the same as sp_select_POM00004

CREATE  PROCEDURE [dbo].[sp_select_scftydat_bat_POM00004] 

@cocde	nvarchar(6),
@from	nvarchar(20),
@to	nvarchar(20),
@fntyp	nvarchar(1),
@usrid	nvarchar(30)
AS

BEGIN
---------------------------------------------------------------------------------------------------
	IF @fntyp = 'Y' 
	BEGIN

    		DECLARE 
    		@ret_code nvarchar(20),
    		@job_code int,
    		@vbi_tsttim int,
		@vbi_bufday int,
		@runno varchar(20)

		DECLARE -- PODTLBOM HDR
		@hdr_purord 	nvarchar(20),
		@hdr_venno  	nvarchar(6),
		@hdr_bompno 	nvarchar(20),
		@hdr_bpolne 	int
				
		DECLARE -- PODTLBOM DTL
		@dtl_purord 	nvarchar(20),
		@dtl_seq    	int,
		@dtl_assitm	nvarchar(20),
		@dtl_bompno	nvarchar(20),
		@dtl_bomitm	nvarchar(20),
		@dtl_bpolne	int,
		@dtl_colcde	nvarchar(30),
		@dtl_ordqty	int,
		@dtl_ftyprc	numeric(13,4),
		@dtl_pckunt	nvarchar(6),
		@dtl_bomqty	int,
		@dtl_venno	nvarchar(6),
		@dtl_bomcst	numeric(13,4),
		@dtl_bcurcde	varchar(6),
		@dtl_imftyprc	numeric(13,4),
		@dtl_imcurcde	varchar(6)

		DECLARE
		@dtl_bompoflg	char(1) 
	
		DECLARE -- POBOMHDR
		@pbh_bompo	nvarchar(20),
		@pbh_bomsts	nvarchar(9),
		@pbh_issdat	datetime,
		@pbh_rvsdat	datetime,
		@pbh_bvenno	nvarchar(6),
		@pbh_bvenadr	nvarchar(200),
		@pbh_bvenstt	nvarchar(20),
		@pbh_bvencty	nvarchar(6),
		@pbh_bvenpst	nvarchar(20),
		@pbh_oriven	nvarchar(6),
		@pbh_shpadr	nvarchar(200),
		@pbh_ovenstt	nvarchar(20),
		@pbh_ovencty	nvarchar(6),
		@pbh_ovenpst	nvarchar(20),
		@pbh_ctp1		nvarchar(50),
		@pbh_ctp2		nvarchar(50),
		@pbh_prctrm	nvarchar(6),
		@pbh_paytrm	nvarchar(6),
		@pbh_ttlamt	numeric(13,4),
		@pbh_disprc	numeric(6,3),
		@pbh_disamt	numeric(11,4),
		@pbh_refno	nvarchar(20),
		@pbh_cuspo	nvarchar(20),
		@pbh_cpodat	nvarchar(20),
		@pbh_candat	datetime,
		@pbh_curcde	nvarchar(6),
		@pbh_shpstr	datetime,
		@pbh_shpend	datetime,
		@pbh_rmk		nvarchar(200),
		@pbh_ocndat	datetime,
		@pbh_ostdat	datetime,
		@pbh_oeddat	datetime,
		@pbh_purord	nvarchar(20)

		
		DECLARE -- POBOMDTL
		@pbd_cocde	nvarchar(6),
		@pbd_bompo	nvarchar(20), 
		@pbd_bomseq	int,
		@pbd_itmno	nvarchar(20), 
		@pbd_venitm	nvarchar(20), 
		@pbd_rvenitm	nvarchar(20),
		@pbd_engdsc	nvarchar(300),
		@pbd_chndsc	nvarchar(600),
		@pbd_vencol	nvarchar(30),
		@pbd_vcodsc	nvarchar(200),
		@pbd_untcde	nvarchar(6),
		@pbd_adjqty	int,
		@pbd_ordqty	int,
		@pbd_bomamt	numeric(13,4),
		@pbd_ftyprc	numeric(13,4),
		@pbd_negprc	numeric(13,4),
		@pbd_assitm	nvarchar(20),
		@pbd_shpstr	datetime,
		@pbd_shpend	datetime,
		@pbd_candat	datetime,
		@pbd_regitm	nvarchar(20), 
		@pbd_engrid	nvarchar(300),
		@pbd_chnrid	nvarchar(600),
		@pbd_colcde	nvarchar(30),
		@pbd_coldsc	nvarchar(200),
		@pbd_refpo	nvarchar(20), 
		@pbd_rioqty	int,
		@pbd_pqbom	int,
		@pbd_rcvqty	int,
		@pbd_lnecde	int ,
		@pbd_bomcst	numeric(13,4),
		@pbd_bcurcde	varchar(6) ,
		@pbd_imftyprc	numeric(13,4),
		@pbd_imcurcde	varchar(6),
		@pbd_wastage	numeric(5,2),
		@pbd_orgordqty	int



		DECLARE 
		@startflag int,
		@seqno int,
		@pod_scno nvarchar(20)
		



		SET @seqno = 0
		
		UPDATE 	POORDHDR SET 
		poh_creusr = poh_creusr
		WHERE 
		poh_pursts = 'OPE' AND
		poh_purord >= @from AND
		poh_purord <= @to AND
		poh_cocde = @cocde

		IF @@rowcount = 0
		BEGIN
			PRINT 'PO No Not Found'
			RETURN(99)
		END

		DECLARE cur_PODTLBOMHDR CURSOR
		FOR 
		-- i) PO # , ii) Vendor #, iii) BOM PO # (if Exist), iv) max seq #
		SELECT DISTINCT d.pdb_purord, d.pdb_venno, d.pdb_bompno, max(d.pdb_bpolne)+1
		FROM PODTLBOM d, POORDHDR h
		WHERE 
		h.poh_pursts = 'OPE' AND
		h.poh_purord >= @from AND
		h.poh_purord <= @to AND
		h.poh_cocde = @cocde AND
		d.pdb_purord = h.poh_purord AND
		d.pdb_cocde = h.poh_cocde 
		GROUP BY d.pdb_purord, d.pdb_venno, d.pdb_bompno
		ORDER BY d.pdb_purord, d.pdb_venno
		
		OPEN cur_PODTLBOMHDR
		FETCH NEXT FROM cur_PODTLBOMHDR INTO 
		-- i) PO # , ii) Vendor #, iii) BOM PO # (if Exist), iv) max seq #
		@hdr_purord, @hdr_venno, @hdr_bompno, @hdr_bpolne

		WHILE @@fetch_status = 0 AND @hdr_venno <> 'Z'
		BEGIN

			-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			-- Lester Wu 2006-05-19
			-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx			
			Update 	
				bom
			Set 	
				bom.pbd_ordqty = 0 , 
				bom.pbd_adjqty = 0 , 
				bom.pbd_bomamt = 0 ,
				bom.pbd_upddat = getdate() , 
				bom.pbd_updusr = @usrid
			From
				POBOMDTL bom , PODTLBOM dtl
			where 
				dtl.pdb_bompno = bom.pbd_bompo and 
				dtl.pdb_bpolne = bom.pbd_bomseq and
				dtl.pdb_bomitm = bom.pbd_itmno and
				pdb_bompoflg = 'N' AND
				pdb_purord = @hdr_purord AND
				pdb_cocde = @cocde AND
				pdb_venno = @hdr_venno

			
			-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			

			SET @seqno = 1		-- Pre-set @seqno
									
			DECLARE cur_PODTLBOM CURSOR
			FOR 
			/* Lester Wu 2006-04-27, apply PO Flag (in Item Master folder 4[Assortment/BOM])*/

			SELECT 
				pdb_seq, 		pdb_assitm, 
				pdb_bompno, 	pdb_bomitm, 
				pdb_bpolne, 	pdb_colcde, 
				pdb_ordqty, 	
						pdb_ftyprc, 
				pdb_pckunt,	pdb_bomqty, 
				pdb_venno,	pdb_bcurcde,
				pdb_bomcst,	pdb_purord,
				pdb_imcurcde,	pdb_imftyprc

			FROM 
				PODTLBOM 
			WHERE 
				pdb_bompoflg = 'Y' AND
				pdb_purord = @hdr_purord AND
				pdb_cocde = @cocde AND
				pdb_venno = @hdr_venno
				

			ORDER BY 
				pdb_bompno, pdb_bpolne, pdb_seq

			/*SELECT 
				
				pdb_seq, 		pdb_assitm, 
				pdb_bompno, 	pdb_bomitm, 
				pdb_bpolne, 	pdb_colcde, 
				pdb_ordqty, 	pdb_ftyprc, 
				pdb_pckunt,	pdb_bomqty, 
				pdb_venno,	pdb_bcurcde,
				pdb_bomcst,	pdb_purord,
				pdb_imcurcde,	pdb_imftyprc 
				--, isnull(iba_genpo,'') 
			FROM 
				PODTLBOM 
				LEFT JOIN IMBOMASS on pdb_assitm = iba_itmno and pdb_bomitm = iba_assitm and pdb_colcde = iba_colcde and iba_typ = 'BOM'
			where 
				pdb_purord = @hdr_purord AND
				pdb_cocde = @cocde AND
				pdb_venno = @hdr_venno AND
				pdb_assitm <> '' and 
				iba_itmno is not null 
				and isnull(iba_genpo,'') = 'Y'
				
			UNION 
			
			SELECT 
				pdb_seq, 		pdb_assitm, 
				pdb_bompno, 	pdb_bomitm, 
				pdb_bpolne, 	pdb_colcde, 
				pdb_ordqty, 	pdb_ftyprc, 
				pdb_pckunt,	pdb_bomqty, 
				pdb_venno,	pdb_bcurcde,
				pdb_bomcst,	pdb_purord,
				pdb_imcurcde,	pdb_imftyprc 
				--, isnull(iba_genpo,'') 
			FROM 
				PODTLBOM 
				LEFT JOIN POORDDTL on pdb_purord = pod_purord and pdb_cocde = pod_cocde and pdb_seq = pod_purseq
				LEFT JOIN IMBOMASS on pod_itmno = iba_itmno and pdb_bomitm = iba_assitm and pdb_colcde = iba_colcde and iba_typ = 'BOM'
			where 
				pdb_purord = @hdr_purord AND
				pdb_cocde = @cocde AND
				pdb_venno = @hdr_venno AND
				pdb_assitm = '' and 
				pod_itmno is not null and 
				iba_itmno is not null 
				and isnull(iba_genpo,'') = 'Y' 
			
			ORDER BY 
				pdb_bompno, pdb_bpolne, pdb_seq
			*/
			
			OPEN cur_PODTLBOM
			FETCH NEXT FROM cur_PODTLBOM INTO 
			@dtl_seq,			-- Corresponding PO Detail Seq #
			@dtl_assitm, 		-- Assortment Item #, if any
			@dtl_bompno,		-- BOM PO #, exists if BOM PO already generated b4
			@dtl_bomitm,		-- BOM Item #
			@dtl_bpolne,		-- BOM PO Seq #, exists if BOM PO already generated b4
			@dtl_colcde,		-- 
			@dtl_ordqty,		-- Order Qty
			@dtl_ftyprc,		-- 
			@dtl_pckunt,		--
			@dtl_bomqty,		-- BOM Qty
			@dtl_venno,		--
			@dtl_bcurcde,		--
			@dtl_bomcst,		--
			@dtl_purord,		--
			@dtl_imcurcde,		--
			@dtl_imftyprc		--

					
			WHILE @@fetch_status = 0
			BEGIN   	
				
				IF NOT (@dtl_bompno <> '' AND @dtl_bpolne <> 0)
				BEGIN
					IF @seqno = 1
					BEGIN
						--EXECUTE sp_select_doc_gen_po @cocde, "BP", @purord = @ret_code OUTPUT
						
						SELECT @job_code = cast ( MAX(RIGHT(pdb_bompno, 3)) as int)
						FROM PODTLBOM
						WHERE pdb_cocde = @cocde AND
						pdb_bompno is not null and
						pdb_bompno <> '' and
						pdb_bompno like @hdr_purord + '%'
					--	LEFT(pdb_bompno, (LEN(pdb_bompno)-5)) = @hdr_purord
						
						------------------------------------------------------------						
						--SET BOM PO #
						------------------------------------------------------------
						if @job_code IS NULL
						BEGIN
							SET @job_code = 0
						END
						
						SET @job_code = @job_code + 1
						
						declare @b nvarchar(3)
			
						set @b = @job_code
			
						set @b = right('000'+@b, 3)
						
						IF @dtl_bompno = ''
						BEGIN
							SET @dtl_bompno = @hdr_purord
						END
						
						SET @ret_code = @dtl_bompno	+ '-B' + @b
						------------------------------------------------------------

						
						
					END
					
					UPDATE PODTLBOM SET pdb_bompno = @ret_code, pdb_bpolne = @seqno 
					WHERE pdb_cocde = @cocde AND
					pdb_purord = @hdr_purord AND
					pdb_venno = @hdr_venno AND
					pdb_seq = @dtl_seq AND
					pdb_assitm = @dtl_assitm AND
					pdb_bomitm = @dtl_bomitm AND
					pdb_colcde = @dtl_colcde
				
				END
				
				IF @dtl_bompno <> '' AND @dtl_bpolne <> 0 
				BEGIN
					SET @ret_code = @dtl_bompno
					SET @seqno = @dtl_bpolne
				END


				IF @seqno = 1
				BEGIN
									
					SET @pbh_bompo	 = @ret_code
					SET @pbh_bomsts	 = 'OPE'

--					SELECT 
--						@pbh_issdat = pod_shpstr - 30,
--						 @pbh_rvsdat = pod_shpend -30
--					from
--						poorddtl 
--					where 
--						pod_purord = @dtl_purord
--						and pod_purseq = @dtl_seq 

					SET @pbh_issdat	 = convert(char(10),getdate(),101)
					SET @pbh_rvsdat	 = convert(char(10),getdate(),101)
					SET @pbh_bvenno	 = @hdr_venno
					
					SELECT
					-- Changed by Mark Lau 20090102
					--@pbh_bvenadr = vci_adr,
					@pbh_bvenadr = case when isnull( vci_chnadr,'') <> '' then isnull(vci_chnadr,'') else vci_adr end,
					@pbh_bvenstt = vci_stt,
					@pbh_bvencty = vci_cty,
					@pbh_bvenpst = vci_zip,
					@pbh_ctp1 = vci_cntctp
					FROM VNCNTINF
					WHERE 
					--vci_cocde = @cocde AND
					vci_venno = @hdr_venno 
					-- 2004-07-28	Allan Yuen 	Add vci_cnttyp = 'M' in select vendor address.
					and vci_cnttyp = 'M'					
					------------------------------------------------------------------------------------------------------------------------------
						
					SELECT @pbh_oriven = poh_venno,
					@pbh_refno = poh_reppno,
					@pbh_cuspo = poh_cuspno,
					@pbh_cpodat = poh_cpodat,
					--@pbh_candat = poh_pocdat ,
					@pbh_shpstr = poh_shpstr -30 ,
					@pbh_shpend = poh_shpend -30,
					@pbh_candat  = 
					case 	convert(char(10), poh_pocdat,101)
						when '01/01/1900' then  poh_pocdat
						else  poh_pocdat-30
					end,
					@pbh_ocndat  = poh_pocdat,
					@pbh_ostdat  = poh_shpstr,
					@pbh_oeddat  = poh_shpend
					FROM POORDHDR
					WHERE poh_cocde = @cocde AND
					poh_purord = @hdr_purord
			

					--- Check Ship Start & End Date ---
					IF CONVERT(CHAR(10),@pbh_shpstr,111) <  CONVERT(CHAR(10),@pbh_issdat,111) 
					begin 
						set @pbh_shpstr = @pbh_issdat
						set @pbh_shpend = @pbh_issdat
					end
					--------------------------------------------

					--- Check Cancel Date ---
					IF convert(char(10), @pbh_candat,101) <>  '01/01/1900'  AND  CONVERT(CHAR(10),@pbh_candat,111) <  CONVERT(CHAR(10),@pbh_issdat,111) 
					begin
						set @pbh_candat = @pbh_issdat
					end
					------------------------------



					--SET @pbh_ocndat = @pbh_cpodat
					--SET @pbh_ostdat = @pbh_shpstr
					--SET @pbh_oeddat = @pbh_shpend
					
					SET @pbh_purord = @hdr_purord
					
					SELECT 	
					-- Changed by Mark Lau 20090102
					--@pbh_shpadr = vci_adr,
					@pbh_shpadr = case when isnull( vci_chnadr,'') <> '' then isnull(vci_chnadr,'') else vci_adr end,
					
					@pbh_ovenstt = vci_stt,
					@pbh_ovencty = vci_cty,
					@pbh_ovenpst = vci_zip,
					@pbh_ctp2 = vci_cntctp
					FROM VNCNTINF
					WHERE 
					--vci_cocde = @cocde AND
					vci_venno = @pbh_oriven AND
					vci_cnttyp = 'M'
					
					SELECT @pbh_disprc = vbi_discnt,
					@vbi_tsttim = vbi_tsttim,
					@vbi_bufday = vbi_bufday,
					@pbh_prctrm	= vbi_prctrm,
					@pbh_paytrm	= vbi_paytrm,
					@pbh_curcde	= vbi_curcde
					FROM VNBASINF
					WHERE 
					--vbi_cocde = @cocde AND
					vbi_venno = @hdr_venno
					
					--SET @pbh_candat	= @pbh_candat - @vbi_tsttim - @vbi_bufday
					--SET @pbh_shpstr	= @pbh_shpstr - @vbi_tsttim - @vbi_bufday
					--SET @pbh_shpend	= @pbh_shpend - @vbi_tsttim - @vbi_bufday
					--
					--IF GETDATE() > @pbh_candat
					--BEGIN
					--	SET @pbh_candat = CONVERT(datetime, GETDATE(), 101)
					--END
					--
					--IF GETDATE() > @pbh_shpstr
					--BEGIN
					--	SET @pbh_shpstr = CONVERT(datetime, GETDATE(), 101)
					--END
					--
					--iF GETDATE() > @pbh_shpend
					--BEGIN
					--	SET @pbh_shpend = CONVERT(datetime, GETDATE(), 101)
					--END
						
					SET @pbh_disamt	 = 0
					SET @pbh_ttlamt  = 0

					UPDATE POBOMHDR SET																					
					pbh_bomsts      =  @pbh_bomsts,																					
					--pbh_issdat	=  @pbh_issdat,																					
					pbh_rvsdat	=  @pbh_rvsdat,																					
					pbh_bvenno	=  @pbh_bvenno,																					
					pbh_bvenadr    =  @pbh_bvenadr,   																				 
					pbh_bvenstt    =  @pbh_bvenstt,   																				 
					pbh_bvencty    =  @pbh_bvencty,   																				 
					pbh_bvenpst    =  @pbh_bvenpst,   																				 
					pbh_oriven	=  @pbh_oriven,																					
					pbh_shpadr	=  @pbh_shpadr,																					
					pbh_ovenstt    =  @pbh_ovenstt,   																				 
					pbh_ovencty    =  @pbh_ovencty,   																				 
					pbh_ovenpst    =  @pbh_ovenpst,   																				 
					pbh_ctp1	=  @pbh_ctp1,																					
					pbh_ctp2	=  @pbh_ctp2,																					
					pbh_prctrm	=  @pbh_prctrm,																					
					pbh_paytrm	=  @pbh_paytrm,																					
					pbh_ttlamt	=  @pbh_ttlamt,																					
					pbh_disprc	 =  @pbh_disprc,																					
					pbh_disamt = case @pbh_disprc when 0 then @pbh_ttlamt else round(@pbh_ttlamt * (1 + (@pbh_disprc / 100)),2) end,	
					pbh_refno	=  @pbh_refno,																					
					pbh_cuspo	=  @pbh_cuspo,																					
					pbh_cpodat	=  @pbh_cpodat,																					
					pbh_candat	=  @pbh_candat,																					
					pbh_curcde	=  @pbh_curcde,																					
					pbh_shpstr	=  @pbh_shpstr,																					
					pbh_shpend     =  @pbh_shpend,    																				 
					--pbh_creusr     =  'SYSTEM',       																				 
					pbh_updusr     =  @usrid,       																				 
					pbh_rmk        =  '',             																				 
					pbh_ocndat     =  @pbh_ocndat,    																				 
					pbh_ostdat     =  @pbh_ostdat,    																			 
					pbh_oeddat     =  @pbh_oeddat,    																				 
					pbh_purord      =  @pbh_purord,
					pbh_upddat  = getdate()     																				 
					WHERE
					pbh_cocde = @cocde AND		                                                	
					pbh_bompo = @pbh_bompo
					
					IF @@rowcount = 0 
					BEGIN
						INSERT INTO POBOMHDR (
						pbh_cocde,		
						pbh_bompo,	
						pbh_bomsts,
						pbh_issdat,	
						pbh_rvsdat,	
						pbh_bvenno,	
						pbh_bvenadr,
						pbh_bvenstt,
						pbh_bvencty,
						pbh_bvenpst,
						pbh_oriven,	
						pbh_shpadr,	
						pbh_ovenstt,
						pbh_ovencty,
						pbh_ovenpst,
						pbh_ctp1,	
						pbh_ctp2,	
						pbh_prctrm,	
						pbh_paytrm,	
						pbh_ttlamt,	
						pbh_disprc,	
						pbh_disamt,	
						pbh_refno,	
						pbh_cuspo,	
						pbh_cpodat,	
						pbh_candat,	
						pbh_curcde,	
						pbh_shpstr,	
						pbh_shpend,
						pbh_creusr,
						pbh_updusr,
						pbh_rmk,
						pbh_ocndat,
						pbh_ostdat,
						pbh_oeddat,
						pbh_purord
						) VALUES (
						@cocde,		
						@pbh_bompo,	
						@pbh_bomsts,	
						@pbh_issdat,	
						@pbh_rvsdat,	
						@pbh_bvenno,	
						@pbh_bvenadr,
						@pbh_bvenstt,
						@pbh_bvencty,
						@pbh_bvenpst,
						@pbh_oriven,	
						@pbh_shpadr,	
						@pbh_ovenstt,
						@pbh_ovencty,
						@pbh_ovenpst,
						@pbh_ctp1,	
						@pbh_ctp2,	
						@pbh_prctrm,	
						@pbh_paytrm,	
						@pbh_ttlamt,	
						@pbh_disprc,	
--						@pbh_disamt,	
						case @pbh_disprc when 0 then @pbh_ttlamt else round(@pbh_ttlamt * (1 + (@pbh_disprc / 100)),2) end,	
						@pbh_refno,	
						@pbh_cuspo,	
						@pbh_cpodat,	
						@pbh_candat,	
						@pbh_curcde,	
						@pbh_shpstr,	
						@pbh_shpend,
						@usrid,
						@usrid,
						'',
						@pbh_ocndat,
						@pbh_ostdat,
						@pbh_oeddat,
						@pbh_purord
						)
					END
						
										
					IF @@ERROR <> 0 
					BEGIN
					   -- Return 99 to the calling program to indicate failure.
					   PRINT 'An error occurred when inserting into POBOMHDR'
					   RETURN(99)
					END
				
				END
					
					
				SET @pbd_bomseq	= @seqno
				SET @pbd_itmno	= @dtl_bomitm


				--- Get Wastage % ---				
				SET @pbd_wastage     = 0				
				select 
					@pbd_wastage = isnull(ibi_wastage,0)  
				from 
					imbasinf
				where
					ibi_itmno = @pbd_itmno
				--------------------------

				SELECT 
				@pbd_chndsc = ibi_chndsc,
				@pbd_engdsc = ibi_engdsc,
				@pbd_venitm = isnull(ivi_venitm, ''),
				@pbd_rvenitm = isnull(ivi_venitm, '')
				FROM IMBASINF, IMVENINF
				WHERE 
				--ibi_cocde = @cocde AND
				ibi_itmno = @dtl_bomitm AND
				--ivi_cocde = @cocde AND
				ivi_itmno = @dtl_bomitm AND
				ivi_venno = @hdr_venno


				
				SELECT 
					@pbd_vencol = icf_vencol,
					@pbd_vcodsc = icf_coldsc
				FROM IMCOLINF 
				WHERE 
				--icf_cocde = @cocde AND
				icf_itmno = @dtl_bomitm AND
				--icf_colcde = @dtl_colcde 
				icf_vencol = @dtl_colcde 
				
				SET @pbd_untcde	= @dtl_pckunt
				
				declare @dummy_qty numeric(13,4)
				set @dummy_qty   = @dtl_ordqty 
				-- Add Wastage % into Order Qty --
				SET @pbd_ordqty	= @dtl_ordqty + round(((@dummy_qty   /100) * @pbd_wastage)+0.4,0)
				SET @pbd_adjqty	= @pbd_ordqty

				SET @pbd_ftyprc	= @dtl_ftyprc
--				SET @pbd_negprc	= @pbd_ftyprc

				SET @pbd_bomcst	= @dtl_bomcst
				SET @pbd_bcurcde	= @dtl_bcurcde
				SET @pbd_negprc	= @dtl_bomcst

				SET @pbd_imcurcde   = @dtl_imcurcde
				SET @pbd_imftyprc    = @dtl_imftyprc

				SET @pbd_bomamt	= round(@pbd_adjqty * @pbd_negprc,2)


				SELECT
				@pbd_regitm 	= pod_itmno,
				@pbd_colcde 	= pod_vencol,
				@pbd_shpstr	= pod_shpstr -30,
				@pbd_shpend	= pod_shpend -30,
				@pbd_candat	= 
				case 	convert(char(10),pod_candat,101)
					when '01/01/1900' then pod_candat
					else pod_candat -30
				end,
				@pbd_engrid 	= pod_engdsc,				
				@pbd_chnrid	= pod_chndsc,
				@pbd_coldsc 	= pod_coldsc
				FROM POORDDTL 
				WHERE pod_cocde = @cocde AND
				pod_purord = @hdr_purord AND
				pod_purseq = @dtl_seq

		
				IF CONVERT(CHAR(10),@pbd_shpstr,112) <  CONVERT(CHAR(10),@pbh_issdat,112) 
				begin 
					set @pbd_shpstr = @pbh_issdat
					set @pbd_shpend = @pbh_issdat
				end


				--- Check Cancel Date ---
				IF convert(char(10), @pbd_candat,101) <>  '01/01/1900'  AND  CONVERT(CHAR(10),@pbd_candat,111) <  CONVERT(CHAR(10),@pbh_issdat,111) 
				begin
					set @pbd_candat = @pbh_issdat
				end
				------------------------------



				
				SET @pbd_assitm = ''
				set @pbd_assitm = @dtl_assitm

				
--				select @hdr_bompno , @pbd_shpstr, @pbd_shpend 

-- Anita Request to use PO's information, rather than use item master information --
-- 2004-09 BOM Assortment enhancement project.
--				IF @dtl_assitm <> '' 
--				BEGIN
--					SET @pbd_assitm	= @dtl_assitm
--				
--					SELECT @pbd_chnrid = ibi_chndsc,
--					@pbd_engrid	= ibi_engdsc
--					FROM IMBASINF
--					WHERE 
--					--ibi_cocde = @cocde AND
--					ibi_itmno = @pbd_assitm
--					
----						SET @pbd_colcde = @dtl_colcde
--					
--					SELECT 
--					@pbd_coldsc = icf_coldsc
--					FROM IMCOLINF 
--					WHERE 
--					--icf_cocde = @cocde AND
--					icf_itmno = @pbd_assitm AND
--					icf_colcde = @dtl_colcde 
--					
--				END
--				ELSE
--				BEGIN
--					SELECT @pbd_chnrid = ibi_chndsc,
--					@pbd_engrid	= ibi_engdsc
--					FROM IMBASINF
--					WHERE 
--					--ibi_cocde = @cocde AND
--					ibi_itmno = @pbd_regitm
--					
--					SELECT 
--					@pbd_coldsc = icf_coldsc
--					FROM IMCOLINF 
--					WHERE 
--					--icf_cocde = @cocde AND
--					icf_itmno = @pbd_regitm AND
--					icf_colcde = @pbd_colcde
--				END
------------------------------------------------------------------------------------------------------------------------------------------------------------------

--				SET @pbd_shpstr	= @pbd_shpstr - @vbi_tsttim - @vbi_bufday
--				SET @pbd_shpend	= @pbd_shpend - @vbi_tsttim - @vbi_bufday
--				SET @pbd_candat	= @pbd_candat - @vbi_tsttim - @vbi_bufday

				
--				IF GETDATE() > @pbd_shpstr
--				BEGIN
--					SET @pbd_shpstr = CONVERT(datetime, GETDATE(), 101)
--				END
				
--				IF GETDATE() > @pbd_shpend
--				BEGIN
--					SET @pbd_shpend = CONVERT(datetime, GETDATE(), 101)
--				END
				
--				IF GETDATE() > @pbd_candat
--				BEGIN
--					SET @pbd_candat = CONVERT(datetime, GETDATE(), 101)
--				END
					
				SET @pbd_pqbom	= @dtl_bomqty
				SET @pbd_rioqty = @dtl_ordqty / @pbd_pqbom
				SET @pbd_rcvqty = 0
				SET @pbd_lnecde	= @dtl_bpolne
				SET @pbd_orgordqty = @dtl_ordqty 

				SET @pbd_refpo = @hdr_purord
				
				UPDATE POBOMDTL SET
				pbd_itmno = @pbd_itmno,	
				pbd_venitm = isnull(@pbd_venitm, ''),	
				pbd_rvenitm = isnull(@pbd_rvenitm, ''),   
				pbd_engdsc = isnull(@pbd_engdsc, ''),	
				pbd_chndsc = isnull(@pbd_chndsc, ''),	
				pbd_vencol = @pbd_vencol,	
				pbd_vcodsc = @pbd_vcodsc,	
				pbd_untcde = @pbd_untcde,	
				pbd_adjqty = @pbd_adjqty,	
				pbd_wastage = @pbd_wastage,
				pbd_ordqty = @pbd_ordqty,	
				pbd_orgordqty = @pbd_orgordqty ,
				pbd_bomamt = @pbd_bomamt,	
				pbd_ftyprc = @pbd_ftyprc,
				pbd_bomcst = @pbd_bomcst,
				pbd_bcurcde = @pbd_bcurcde,
				pbd_negprc = @pbd_negprc,	
				pbd_assitm = @pbd_assitm,	
				pbd_shpstr = @pbd_shpstr,	
				pbd_shpend = @pbd_shpend,	
				pbd_candat = @pbd_candat,	
				pbd_regitm = @pbd_regitm,	
				pbd_engrid = @pbd_engrid,	
				pbd_chnrid = @pbd_chnrid,	
				pbd_colcde = @pbd_colcde,	
				pbd_coldsc = @pbd_coldsc,	
				pbd_refpo = @pbd_refpo,     
				pbd_rioqty = @pbd_rioqty,    
				pbd_pqbom = @pbd_pqbom,     
				pbd_rcvqty = @pbd_rcvqty,	
				pbd_lnecde = @pbd_lnecde,  
				pbd_imcurcde = @pbd_imcurcde,
				pbd_imftyprc = @pbd_imftyprc,
				--pbd_creusr = 'SYSTEM',       
				pbd_updusr = @usrid,
				pbd_upddat = getdate()
				WHERE 
				pbd_cocde = @cocde AND                                       
				pbd_bompo = @ret_code AND
				pbd_bomseq = @pbd_bomseq

				IF @@rowcount = 0 
				BEGIN
					INSERT INTO POBOMDTL (
					pbd_cocde,	
					pbd_bompo,	
					pbd_bomseq,	
					pbd_itmno,	
					pbd_venitm,	
					pbd_rvenitm,
					pbd_engdsc,	
					pbd_chndsc,	
					pbd_vencol,	
					pbd_vcodsc,	
					pbd_untcde,	
					pbd_adjqty,	
					pbd_ordqty,
					pbd_orgordqty,
					pbd_wastage,
					pbd_bomamt,	
					pbd_ftyprc,
					pbd_bcurcde,
					pbd_bomcst,	
					pbd_negprc,	
					pbd_assitm,	
					pbd_shpstr,	
					pbd_shpend,	
					pbd_candat,	
					pbd_regitm,	
					pbd_engrid,	
					pbd_chnrid,	
					pbd_colcde,	
					pbd_coldsc,	
					pbd_refpo,
					pbd_rioqty,
					pbd_pqbom,	
					pbd_rcvqty,
					pbd_lnecde,
					pbd_imcurcde,
					pbd_imftyprc,

					pbd_creusr,
					pbd_updusr
					) VALUES (
					@cocde,	
					@ret_code,	
					@pbd_bomseq,	
					@pbd_itmno,	
					@pbd_venitm,	
					@pbd_rvenitm,
					@pbd_engdsc,	
					@pbd_chndsc,	
					@pbd_vencol,	
					@pbd_vcodsc,	
					@pbd_untcde,	
					@pbd_adjqty,	
					@pbd_ordqty,
					@pbd_orgordqty,
					@pbd_wastage,
					@pbd_bomamt,	
					@pbd_ftyprc,
					@pbd_bcurcde,
					@pbd_bomcst,		
					@pbd_negprc,	
					@pbd_assitm,	
					@pbd_shpstr,	
					@pbd_shpend,	
					@pbd_candat,	
					@pbd_regitm,	
					@pbd_engrid,	
					@pbd_chnrid,	
					@pbd_colcde,	
					@pbd_coldsc,	
					@pbd_refpo,
					@pbd_rioqty,
					@pbd_pqbom,
					@pbd_rcvqty,	
					@pbd_lnecde,
					@pbd_imcurcde,
					@pbd_imftyprc,
					@usrid,
					@usrid
					)
				END
			
					
				IF @@ERROR <> 0 
				BEGIN
				   -- Return 99 to the calling program to indicate failure.
				   PRINT 'An error occurred when inserting into POBOMDTL'
				   RETURN(99)
				END
								
				SET @seqno = @seqno + 1
					        
						                                        
				FETCH NEXT FROM cur_PODTLBOM INTO 
				@dtl_seq,
				@dtl_assitm, 	
				@dtl_bompno,	
				@dtl_bomitm,	
				@dtl_bpolne,	
				@dtl_colcde,	
				@dtl_ordqty,	
				@dtl_ftyprc,	
				@dtl_pckunt,	
				@dtl_bomqty,	
				@dtl_venno,
				@dtl_bcurcde,
				@dtl_bomcst,
				@dtl_purord,
				@dtl_imcurcde,
				@dtl_imftyprc
			END
			
			CLOSE cur_PODTLBOM                                   
			DEALLOCATE cur_PODTLBOM        

			FETCH NEXT FROM cur_PODTLBOMHDR INTO 
			@hdr_purord, @hdr_venno, @hdr_bompno, @hdr_bpolne
		END                                                     
		CLOSE cur_PODTLBOMHDR                                   
		DEALLOCATE cur_PODTLBOMHDR                
		
		

		DECLARE cur_PODTLBOMHDR CURSOR
		FOR 
		SELECT DISTINCT d.pdb_purord, d.pdb_venno, d.pdb_bompno, max(d.pdb_bpolne)+1
		FROM PODTLBOM d, POORDHDR h
		WHERE 
		h.poh_pursts = 'OPE' AND
		h.poh_purord >= @from AND
		h.poh_purord <= @to AND
		h.poh_cocde = @cocde AND
		d.pdb_purord = h.poh_purord AND
		d.pdb_cocde = h.poh_cocde 
		GROUP BY d.pdb_purord, d.pdb_venno, d.pdb_bompno
		ORDER BY d.pdb_purord, d.pdb_venno
		
		OPEN cur_PODTLBOMHDR
		FETCH NEXT FROM cur_PODTLBOMHDR INTO 
		@hdr_purord, @hdr_venno, @hdr_bompno, @hdr_bpolne


		WHILE @@fetch_status = 0 
		BEGIN

			select 
				@pbh_candat = min(pbd_candat) 
			from 
				pobomdtl 
			where
				pbd_cocde = @cocde AND                                       
				pbd_bompo = @hdr_bompno


			select 
				@pbh_shpstr = min(pbd_shpstr) 
			from 
				pobomdtl 
			where
				pbd_cocde = @cocde AND                                       
				pbd_bompo = @hdr_bompno

			select 
				@pbh_shpend = max(pbd_shpend) 
			from 
				pobomdtl 
			where
				pbd_cocde = @cocde AND                                       
				pbd_bompo = @hdr_bompno

			
			UPDATE 
				POBOMHDR 
			SET 
				pbh_creusr = pbh_creusr,
				pbh_candat = @pbh_candat ,
				pbh_shpstr = @pbh_shpstr ,
				pbh_shpend = @pbh_shpend,
				pbh_updusr = @usrid,
				pbh_upddat = getdate()
			WHERE 
				pbh_cocde = @cocde AND		                                                	
				pbh_bompo = @hdr_bompno


		FETCH NEXT FROM cur_PODTLBOMHDR INTO 
			@hdr_purord, @hdr_venno, @hdr_bompno, @hdr_bpolne
		END                                                     
		CLOSE cur_PODTLBOMHDR                                   
		DEALLOCATE cur_PODTLBOMHDR 		
		        
		----------------------------
		SET @startflag = 0
			
		DECLARE	cur_jobno CURSOR
		FOR SELECT
	 	dtl.pod_purord, dtl.pod_purseq
		FROM POORDHDR hdr, POORDDTL dtl
		WHERE hdr.poh_cocde = dtl.pod_cocde AND
		hdr.poh_purord = dtl.pod_purord AND
		hdr.poh_pursts = 'OPE' AND
		(dtl.pod_jobord is NULL OR dtl.pod_jobord = '') AND
-- Allan Yuen Add venno '0009'
--		((hdr.poh_cocde = 'UCP' AND hdr.poh_venno IN ('0005', '0007')) OR hdr.poh_cocde = 'UCPP') AND
--		((hdr.poh_cocde = 'UCP' AND hdr.poh_venno IN ('0005', '0007', '0009')) OR hdr.poh_cocde = 'UCPP') AND
		(
			(hdr.poh_cocde = 'UCP' AND hdr.poh_venno IN ('0005', '0007', '0009')) 
		OR
			(hdr.poh_cocde = 'UCP'    AND hdr.poh_venno IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',  'U', 'V', 'W', 'X', 'Y', 'Z' ))  
		OR 
			(hdr.poh_cocde = 'UCPP' AND hdr.poh_venno IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',  'U', 'V', 'W', 'X', 'Y', 'Z','0005', '0007', '0009' ))  
		OR
			(hdr.poh_cocde = 'PG' AND hdr.poh_venno IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',  'U', 'V', 'W', 'X', 'Y', 'Z','0005', '0007', '0009' ))  
		OR
			(hdr.poh_cocde = 'EW' AND hdr.poh_venno IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',  'U', 'V', 'W', 'X', 'Y', 'Z','0005', '0007', '0009' ))  
		OR
			(hdr.poh_cocde = 'TT' AND hdr.poh_venno IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',  'U', 'V', 'W', 'X', 'Y', 'Z','0005', '0007', '0009' ))  
		OR
			(hdr.poh_cocde = 'MS' AND hdr.poh_venno IN ('K')) 
		)  AND
		hdr.poh_cocde = @cocde AND
		dtl.pod_ordqty <>  0 AND
		hdr.poh_purord >= @from and hdr.poh_purord <= @to 
		ORDER BY dtl.pod_purord, dtl.pod_purseq
		
		OPEN cur_jobno
		FETCH NEXT FROM cur_jobno INTO
		@dtl_purord,
		@dtl_seq
		
	--	IF @@fetch_status <> 0 and @startflag = 0
	--	BEGIN
	--	   -- Return 99 to the calling program to indicate failure.
	--	   PRINT 'PO NO not found'
	--	   RETURN(99)
	--	END
		
		WHILE @@fetch_status = 0
		BEGIN
		
			SET @startflag = 1	
			--EXECUTE sp_select_doc_gen_po @cocde, "JO", @purord = @job_code OUTPUT


			--- Allan Yuen Add running No.
			SET @runno  = 'DATA'
			EXECUTE  sp_select_DOC_GEN_PO_RINNO @cocde, "JR", @runno OUTPUT
			
			
			SELECT @pod_scno = poh_ordno
			FROM POORDHDR
			WHERE poh_cocde = @cocde AND
			poh_purord = @dtl_purord
			
			SELECT @job_code = cast ( MAX(RIGHT(pod_jobord, 3)) as int)	
			FROM POORDDTL
			WHERE pod_cocde = @cocde AND
			pod_jobord is not null and
			pod_jobord <> '' and
			pod_jobord like @pod_scno + '%'
		--	LEFT(pod_jobord, (LEN(pod_jobord)-5)) = @pod_scno 

				
			if @job_code IS NULL
			BEGIN
				SET @job_code = 0
			END
			
			SET @job_code = @job_code + 1
			
			declare @a nvarchar(3)

			set @a = @job_code

			set @a = right('000'+@a, 3)
			
			UPDATE POORDDTL SET 
				pod_jobord = @pod_scno + '-J' + @a,
				pod_runno = @runno
			WHERE 
				pod_cocde = @cocde AND
				pod_purord = @dtl_purord AND
				pod_purseq = @dtl_seq

			---- Update Running No. to S/C ----

			UPDATE 
				SCORDDTL 
			SET
				SOD_RUNNO =  @runno
			WHERE
				SOD_cocde = @cocde AND
				SOD_PURORD = @dtl_purord AND
				SOD_PURSEQ = @dtl_seq

			-------------------------------------------

			FETCH NEXT FROM cur_jobno INTO
			@dtl_purord,
			@dtl_seq
			
		END
		
		CLOSE cur_jobno
		DEALLOCATE cur_jobno
				
		----------------------------
		UPDATE POORDHDR SET 
		poh_pursts = 'REL', 
		poh_updusr = @usrid, 
		poh_upddat = GETDATE() 
		WHERE
		poh_purord >= @from AND
		poh_purord <= @to AND
		poh_pursts = 'OPE'

			                                                            
	END                                                         
	                                                            
	IF @fntyp = 'N'                                             
	BEGIN                                                       
		
		UPDATE POORDHDR SET 
		poh_pursts = 'OPE', 
		poh_issdat = GETDATE(),
		poh_updusr = @usrid, 
		poh_upddat = GETDATE() 
		WHERE
		poh_purord >= @from AND
		poh_purord <= @to AND
		poh_pursts = 'REL'		
                                

          	  	IF @@rowcount = 0                      
            		BEGIN
			PRINT 'PO No Not Found'
			RETURN(99)
		END      
	END                                                         

---------------------------------------------------------------------------------------------------
END




GO
GRANT EXECUTE ON [dbo].[sp_select_scftydat_bat_POM00004] TO [ERPUSER] AS [dbo]
GO
