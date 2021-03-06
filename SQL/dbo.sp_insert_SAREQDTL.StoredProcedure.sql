/****** Object:  StoredProcedure [dbo].[sp_insert_SAREQDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SAREQDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SAREQDTL]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








-- Checked by Allan Yuen at 28/07/2003

/*	Author	:	Tommy Ho	*/
/*	Date    	: 	29 Jan 2002	*/

CREATE PROCEDURE [dbo].[sp_insert_SAREQDTL] 

@srd_cocde	nvarchar(6),	@srd_reqno	nvarchar(20),	@srd_itmno	nvarchar(20),	 	
@srd_itmsts	nvarchar(4),	

--Added by Mark Lau
@srd_alsitmno	nvarchar(20),	@srd_alscolcde	nvarchar(30),

@srd_venitm	nvarchar(20),	@srd_engdsc	nvarchar(800),
@srd_chndsc	nvarchar(1600), 	@srd_colcde	nvarchar(30),	@srd_cuscol	nvarchar(30),
@srd_coldsc	nvarchar(300),	@srd_pckseq	int,		@srd_untcde	nvarchar(6),	
@srd_inrqty	int,		@srd_mtrqty	int,		@srd_cft 		numeric(11,4),
@srd_smpqty	int,		@srd_stkqty	int,		@srd_cusqty	int,
@qud_fcurcde	nvarchar(6),	@srd_ftyprc	numeric(13,4),	@srd_ftycst 	numeric(13,4),	
@srd_smpunt	nvarchar(6),
@srd_note		nvarchar(300),	@srd_tbm		nvarchar(1),	@sas_qutno	nvarchar(20),
@sas_qutseq	int,		@srd_vencol	nvarchar(30),	@srd_cus1no	nvarchar(6),	
@srd_cus2no	nvarchar(6),	@sas_cus1na	nvarchar(20),	@sas_cus2na	nvarchar(20),	
@sas_smpselprc	numeric(13,4),	@qud_ftyprc	numeric(13,4),	@ycf_value	int,		
@qutitmsts	nvarchar(10),	@qud_curcde	nvarchar(6),	@yst_charge	nvarchar(1),
@yst_chgval	int,		@srd_itmtyp	nvarchar(4),	@srd_cusitm	nvarchar(20),
@qud_venno	nvarchar(6),	@qud_subcde	nvarchar(10),	
@qud_cusven	nvarchar(6),	@qud_cussub	nvarchar(10),
@srd_creusr	nvarchar(30)

AS

declare 	@reqseq	int,	@seqno 	int,	@selrat 	numeric(12,4),	@def	nvarchar(6),
	@sumqty	int,	@freqty	int,	@chgqty	int,		@avail	int

-- Marco Added at 20040325
declare @itmventyp char(1)

set @freqty = 0 
set @chgqty = 0

if @ycf_value is null or @ycf_value = 0 
begin
	set @ycf_value = 1
end

if @yst_chgval is null
begin
 	set @yst_chgval = 0 
end

set @reqseq = (Select isnull(max(srd_reqseq),0)  + 1 from SAREQDTL where srd_cocde = @srd_cocde and srd_reqno = @srd_reqno)

insert into [SAREQDTL]
(
srd_cocde ,	srd_reqno ,	srd_reqseq ,
srd_itmno ,	srd_itmsts ,	

--Added by Mark Lau
srd_alsitmno,	srd_alscolcde,

srd_venitm ,
srd_engdsc ,	srd_chndsc ,	srd_vencol ,
srd_cuscol ,	srd_coldsc ,	srd_pckseq ,
srd_untcde ,	srd_inrqty ,	srd_mtrqty ,
srd_cft ,		srd_stkqty ,	srd_smpunt ,
srd_cusqty ,	srd_smpqty ,	srd_curcde ,
srd_ftyprc ,	srd_ftycst, 		srd_smpftyprc ,
srd_note ,		srd_tbm ,	
srd_canflg ,	srd_qutno,		srd_qutseq,
srd_creusr ,	srd_updusr ,	srd_credat ,	
srd_upddat ,	srd_itmtyp ,	srd_qutitmsts ,
srd_cusitm ,	srd_colcde, 
srd_prdven ,	srd_prdsub
)
values
(
@srd_cocde,	@srd_reqno,	@reqseq,
@srd_itmno, 	@srd_itmsts,	

--Added by Mark Lau
@srd_alsitmno,	@srd_alscolcde,

@srd_venitm,
@srd_engdsc,	@srd_chndsc, 	@srd_vencol,
@srd_cuscol,	@srd_coldsc,	@srd_pckseq,
@srd_untcde,	@srd_inrqty,	@srd_mtrqty,
@srd_cft,		@srd_stkqty,	@srd_smpunt,
@srd_cusqty,	@srd_smpqty,	@qud_fcurcde,
@srd_ftyprc,	@srd_ftycst,	(case @srd_cocde when 'UCPP'  then @srd_ftyprc/@ycf_value else @srd_ftycst/@ycf_value end) ,	
@srd_note,	@srd_tbm,		
'N',		@sas_qutno,	@sas_qutseq,
@srd_creusr,	@srd_creusr,	getdate(),
getdate(),		@srd_itmtyp ,	@qutitmsts,
@srd_cusitm,	@srd_colcde, 
@qud_venno,	@qud_subcde
)

select @reqseq -- Cannot delete this coding
/*
--select @def = ysi_cde from SYSETINF where ysi_cocde = @srd_cocde  and ysi_typ = '06' and ysi_def = 'Y'
select @def = ysi_cde from SYSETINF where ysi_typ = '06' and ysi_def = 'Y'

if @qud_curcde <> @qud_fcurcde
begin
	if @qud_curcde = @def 
	begin
--		select @selrat = ysi_selrat from sysetinf where ysi_cocde = @srd_cocde  and ysi_typ = '06' and ysi_cde = @qud_fcurcde
		select @selrat = ysi_selrat from sysetinf where  ysi_typ = '06' and ysi_cde = @qud_fcurcde
		if @selrat is null or @selrat = 0 
		begin
			set @selrat = 1
		end		
		set @qud_ftyprc =  (case @srd_cocde when 'UCPP' then @qud_ftyprc else @srd_ftycst end) * @selrat
	end
	else
	begin
--		select @selrat = ysi_selrat from sysetinf where ysi_cocde = @srd_cocde  and ysi_typ = '06' and ysi_cde = @qud_curcde
		select @selrat = ysi_selrat from sysetinf where ysi_typ = '06' and ysi_cde = @qud_curcde
		if @selrat is null or @selrat = 0 
		begin
			set @selrat = 1
		end		
		select @qud_ftyprc =  (case @srd_cocde when 'UCPP' then @qud_ftyprc else @srd_ftycst end) / @selrat
	end
end
else
begin
	set @selrat = 1
	if @srd_cocde = 'UCP'
	begin
		set @qud_ftyprc = @srd_ftycst
	end
end
*/

if @srd_cocde = 'UCP'
begin
	set @qud_ftyprc = @srd_ftycst
end

-- Complete and not TBM Item (Insert to Sampler Order Summary and Detail)
if @srd_tbm = 'N' and @qutitmsts = 'COMPLETE'
begin
	if ( select count(*) from SAORDSUM where sas_cocde = @srd_cocde and 
			sas_cus1no in (select cbi_cusno from cubasinf (nolock) where cbi_cusali = @srd_cus1no or cbi_cusno = @srd_cus1no 
			               UNION 
			               SELECT cbi_cusali from cubasinf (nolock) where cbi_cusno = @srd_cus1no ) AND
			sas_itmno in (Select ibi_itmno  from imbasinf where ibi_itmno = @srd_itmno or ibi_alsitmno = @srd_itmno
				      union
			              select bas.ibi_alsitmno from imbasinf bas left join imbasinf als on bas.ibi_alsitmno = als.ibi_itmno where bas.ibi_itmno = @srd_itmno and als.ibi_itmsts<>'OLD' ) and
			--sas_colcde = @srd_colcde ) = 1
			sas_colcde = @srd_vencol ) = 1
	begin
		set @sumqty = (select isnull(sum(isnull(sas_freqty,0)),0) from SAORDSUM where sas_cocde = @srd_cocde and 
					sas_cus1no in (select cbi_cusno from cubasinf (nolock) where cbi_cusali = @srd_cus1no or cbi_cusno = @srd_cus1no 
					               UNION 
					               SELECT cbi_cusali from cubasinf (nolock) where cbi_cusno = @srd_cus1no ) AND
					sas_itmno in (Select ibi_itmno  from imbasinf where ibi_itmno = @srd_itmno or ibi_alsitmno = @srd_itmno
						      union
					             select bas.ibi_alsitmno from imbasinf bas left join imbasinf als on bas.ibi_alsitmno = als.ibi_itmno where bas.ibi_itmno = @srd_itmno and als.ibi_itmsts<>'OLD' )  and
					--sas_colcde = @srd_colcde)
					sas_colcde = @srd_vencol)
	end
	else
	begin
		set @sumqty = (select isnull(sum(isnull(sad_freqty,0)),0) from SAORDDTL where sad_cocde = @srd_cocde and 
					sad_cus1no in (select cbi_cusno from cubasinf (nolock) where cbi_cusali = @srd_cus1no or cbi_cusno = @srd_cus1no 
					               UNION 
					               SELECT cbi_cusali from cubasinf (nolock) where cbi_cusno = @srd_cus1no ) AND
					sad_itmno in (Select ibi_itmno  from imbasinf where ibi_itmno = @srd_itmno or ibi_alsitmno = @srd_itmno
						      union
					              select bas.ibi_alsitmno from imbasinf bas left join imbasinf als on bas.ibi_alsitmno = als.ibi_itmno where bas.ibi_itmno = @srd_itmno and als.ibi_itmsts<>'OLD' )  and
					--sad_colcde = @srd_colcde and sad_delflg in ('N', 'Q') )
					sad_colcde = @srd_vencol and sad_delflg in ('N', 'Q') )
	end

	if @sumqty < @yst_chgval
	begin
		set @avail = @yst_chgval - @sumqty	

		if @srd_smpqty < @avail

		begin
			set @freqty = @srd_smpqty
		end
		else
		begin
			set @freqty = @avail
		end
	end
	else
	begin
		set @freqty = 0
	end

	set @chgqty = @srd_cusqty - @freqty

	if @chgqty <= 0 
	begin
		set @chgqty = 0 
	end	

	Set  @seqno = (Select isnull(max(sad_seqno),0)  + 1 from SAORDDTL where sad_cocde = @srd_cocde and sad_cus1no = @srd_cus1no) --and 
								--sad_orgitm = @srd_itmno and sad_itmno = @srd_itmno and sad_colcde = @srd_colcde)


	set @itmventyp = (select isnull(vbi_ventyp, '') from VNBASINF (nolock) where vbi_venno = @qud_venno)

	insert into [SAORDDTL]
	(
	sad_cocde ,	sad_qutno ,	sad_qutseq ,
	sad_seqno ,	sad_delflg,
	sad_cus1no ,	sad_cus1na ,	sad_cus2no ,
	sad_cus2na ,	sad_orgitm,	sad_itmno ,
	sad_itmdsc ,	sad_colcde ,	

	--Added by Mark Lau 20060923
	sad_alsitmno,	sad_alscolcde,

	sad_untcde ,
	sad_inrqty ,	sad_mtrqty ,	sad_cft ,	
	sad_curcde ,	sad_smpuntcde ,	sad_smpselprc ,
	sad_smpftyprc ,	sad_smpqty ,	sad_shpqty ,
	sad_chgqty ,	sad_freqty ,	sad_stkqty ,	
	sad_cusqty ,	sad_reqno ,	sad_reqseq,	
	sad_creusr ,	sad_updusr ,	sad_credat ,	
	sad_upddat ,	sad_itmtyp ,	sad_fcurcde ,
	sad_cuscol,	sad_coldsc,	sad_venno,
	sad_subcde,	sad_cusven, 	sad_cussub, 
	sad_cusitm, sad_itmventyp		)
	values
	(
	@srd_cocde,	@sas_qutno,	@sas_qutseq,
	@seqno,		'N',
	@srd_cus1no,	@sas_cus1na,	@srd_cus2no,
	@sas_cus2na,	@srd_itmno,	@srd_itmno,
--	@srd_engdsc,	@srd_colcde,	@srd_untcde,
	@srd_engdsc,	@srd_vencol,	

	--Added by Mark Lau 20060923
	@srd_alsitmno,	@srd_alscolcde,

	@srd_untcde,
	@srd_inrqty,	@srd_mtrqty,	@srd_cft,	
	@qud_curcde,	@srd_smpunt,	@sas_smpselprc,
	@qud_ftyprc/@ycf_value,	@srd_smpqty,	0,
	@chgqty,		@freqty,		@srd_stkqty,
	@srd_cusqty,	@srd_reqno,	@reqseq,	
	@srd_creusr,	@srd_creusr,	getdate(),	
	getdate(),		@srd_itmtyp,	@qud_fcurcde,
	@srd_cuscol,	@srd_coldsc,	@qud_venno,
	@qud_subcde,	@qud_cusven,	@qud_cussub,
	@srd_cusitm, @itmventyp
	)
	
	if (	select 
			count(1) 
		from 
			SAORDSUM 
		where 	
			sas_cocde = @srd_cocde and 
			--sas_itmno = @srd_itmno and 
			sas_cus1no  in 
			--(select cbi_cusno from cubasinf where cbi_cusno = @srd_cus1no or cbi_cusali =  @srd_cus1no)  and
			(select cbi_cusno from cubasinf (nolock)   where cbi_cusali = @srd_cus1no  or cbi_cusno = @srd_cus1no 
		   	UNION
		   	SELECT cbi_cusali from cubasinf (nolock) where cbi_cusno = @srd_cus1no ) AND

			--sas_itmno  in (Select ibi_itmno  from imbasinf where ibi_itmno = @srd_itmno  or ibi_alsitmno = @srd_itmno) and
			sas_itmno in
			(Select ibi_itmno  from imbasinf where ibi_itmno = @srd_itmno or ibi_alsitmno = @srd_itmno
			union
			 select bas.ibi_alsitmno from imbasinf bas left join imbasinf als on bas.ibi_alsitmno = als.ibi_itmno where bas.ibi_itmno = @srd_itmno and als.ibi_itmsts<>'OLD' )  and
			--sas_colcde = @srd_colcde
			sas_colcde = @srd_vencol
	) = 0
			
	begin
		insert into [SAORDSUM]
		(
		sas_cocde ,		sas_cus1no ,	sas_cus1na ,
		sas_itmno ,	sas_itmdsc ,	sas_colcde ,	

		--Added by Mark Lau 20060923
		sas_alsitmno,	sas_alscolcde,

		sas_smpqty ,	sas_shpqty ,	sas_chgqty ,
		sas_freqty ,	sas_stkqty ,	sas_cusqty ,	
		sas_creusr ,	sas_updusr ,	sas_credat ,	
		sas_upddat ,	sas_itmtyp ,	sas_smpunt
		)
		values
		(
		@srd_cocde,	@srd_cus1no,	@sas_cus1na,
--		@srd_itmno,	@srd_engdsc,	@srd_colcde,
		@srd_itmno,	@srd_engdsc,	@srd_vencol,

		--Added by Mark Lau 20060923
		@srd_alsitmno,	@srd_alscolcde,
	
		@srd_smpqty,	0,		@chgqty,
		@freqty,		@srd_stkqty,	@srd_cusqty,	
		@srd_creusr,	@srd_creusr,	getdate(),		
		getdate(),		@srd_itmtyp,	(case @srd_smpunt when 'PC' then 'PC' else '' end)
		)
	end
	else
	begin
		update 	SAORDSUM 	
		set 	
			sas_itmdsc = @srd_engdsc, 
			sas_itmno = @srd_itmno, 


			--Added by Mark Lau 20060923
			sas_alsitmno = @srd_alsitmno,	sas_alscolcde=@srd_alscolcde,

			sas_itmtyp = @srd_itmtyp,
			sas_smpqty = sas_smpqty  + @srd_smpqty, 	
			sas_chgqty = sas_chgqty + @chgqty,
			sas_freqty = sas_freqty + @freqty,	
			sas_stkqty = sas_stkqty + @srd_stkqty,					
			sas_cusqty = sas_cusqty + @srd_cusqty, 	sas_updusr = @srd_creusr, 
			sas_upddat = getdate(), 	
			sas_smpunt = 
			(case sas_smpunt when '' then '' else
				(case @srd_smpunt when 'PC' then 'PC' else '' end)
			end)
			--(case @srd_smpunt when 'PC' then 'PC' else '' end)
		where	
			sas_cocde = @srd_cocde and 
			sas_cus1no  in 
			--(select cbi_cusno from cubasinf where cbi_cusno = @srd_cus1no or cbi_cusali =  @srd_cus1no) and
			(select cbi_cusno from cubasinf (nolock)   where cbi_cusali = @srd_cus1no  or cbi_cusno = @srd_cus1no 
		   	UNION
		   	SELECT cbi_cusali from cubasinf (nolock) where cbi_cusno = @srd_cus1no ) AND

			sas_itmno in
			(Select ibi_itmno  from imbasinf where ibi_itmno = @srd_itmno or ibi_alsitmno = @srd_itmno
			union
			 select bas.ibi_alsitmno from imbasinf bas left join imbasinf als on bas.ibi_alsitmno = als.ibi_itmno where bas.ibi_itmno = @srd_itmno and als.ibi_itmsts<>'OLD' )  and
			--sas_colcde = @srd_colcde
			sas_colcde = @srd_vencol
			--sas_itmno  in (Select ibi_itmno  from imbasinf where ibi_itmno = @srd_itmno  or ibi_alsitmno = @srd_itmno) 
			--sas_itmno = @srd_itmno and 
			--sas_cus1no = @srd_cus1no and

	end
end
else	-- Incomplete or TBM Item
begin
	Set  @seqno = (Select isnull(max(sad_seqno),0)  + 1 from SAORDDTL where sad_cocde = @srd_cocde and sad_cus1no = @srd_cus1no) --and 
								--sad_orgitm = @srd_itmno and sad_itmno = @srd_itmno and sad_colcde = @srd_colcde)

	set @itmventyp = (select isnull(vbi_ventyp, '') from VNBASINF (nolock) where vbi_venno = @qud_venno)

	insert into [SAORDDTL]
	(
	sad_cocde ,	sad_qutno ,	sad_qutseq ,
	sad_seqno ,	sad_delflg,
	sad_cus1no ,	sad_cus1na ,	sad_cus2no ,
	sad_cus2na ,	sad_orgitm,	sad_itmno ,
	sad_itmdsc ,	sad_colcde ,	

	--Added by Mark Lau 20060923
	sad_alsitmno,	sad_alscolcde,

	sad_untcde ,
	sad_inrqty ,	sad_mtrqty ,	sad_cft ,	
	sad_curcde ,	sad_smpuntcde ,	sad_smpselprc ,
	sad_smpftyprc ,	sad_smpqty ,	sad_shpqty ,
	sad_chgqty ,	sad_freqty ,	sad_stkqty ,
	sad_cusqty ,	sad_reqno ,	sad_reqseq ,
	sad_creusr ,	sad_updusr ,	sad_credat ,	
	sad_upddat ,	sad_itmtyp ,	sad_fcurcde ,
	sad_cuscol,	sad_coldsc,	sad_venno,
	sad_subcde,	sad_cusven,	sad_cussub,
	sad_cusitm, sad_itmventyp		)
	values
	(
	@srd_cocde,	@sas_qutno,	@sas_qutseq,
	@seqno,		'N',
	@srd_cus1no,	@sas_cus1na,	@srd_cus2no,
	@sas_cus2na,	@srd_itmno,	'',
	--@srd_engdsc,	@srd_colcde,	@srd_untcde,
	@srd_engdsc,	@srd_vencol,	

	--Added by Mark Lau 20060923
	@srd_alsitmno,	@srd_alscolcde,

	@srd_untcde,
	@srd_inrqty,	@srd_mtrqty,	@srd_cft,	
	@qud_curcde,	@srd_smpunt,	@sas_smpselprc,
	@qud_ftyprc/@ycf_value,	@srd_smpqty,	0,
	@srd_smpqty,	0,		@srd_stkqty,
	@srd_cusqty,	@srd_reqno,	@reqseq,	
	@srd_creusr,	@srd_creusr,	getdate(),	
	getdate(),		@srd_itmtyp,	@qud_fcurcde,
	@srd_cuscol,	@srd_coldsc,	@qud_venno,
	@qud_subcde,	@qud_cusven,	@qud_cussub,
	@srd_cusitm, @itmventyp
	)

end



GO
GRANT EXECUTE ON [dbo].[sp_insert_SAREQDTL] TO [ERPUSER] AS [dbo]
GO
