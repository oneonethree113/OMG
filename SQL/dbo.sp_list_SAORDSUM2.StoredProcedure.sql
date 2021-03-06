/****** Object:  StoredProcedure [dbo].[sp_list_SAORDSUM2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SAORDSUM2]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SAORDSUM2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/************************************************************************
Author:		Carlos Lui
Date:		Aug 31, 2012
Description:	Select data from SAORDSUM
Parameter:		1. Company
		2. Primary customer
***********************************************************************
*/

CREATE procedure [dbo].[sp_list_SAORDSUM2]
                                                                                                                                                                                                                                                               
@sas_cocde	nvarchar(6) ,
@sas_cus1no	nvarchar(20) 
 
AS

begin
	select	'   '  as 'DEL',	sas_cocde,		sas_cus1no,
		sas_cus1na,	sas_itmno,		sas_itmdsc,
		sas_colcde,		sas_cusqty - sas_shpqty as 'sas_outshpqty',
						sas_freqty - sas_shpfreqty as 'sas_outfreqty',
		sas_chgqty - sas_shpchgqty as 'sas_outchgqty',
				sas_freqty,		sas_creusr,
		sas_itmno + ' / ' + sas_itmnotmp + ' / ' + sas_itmnoven + ' / ' + sas_itmnovenno  + ' : ' + ltrim(rtrim(sas_colcde)) as 'sas_itmcol',
				sas_itmtyp,		ibi_itmsts  as 'ibi_itmsts',
		sas_alsitmno,	sas_alscolcde,	sas_imu_cus1no,
		sas_imu_cus2no,	sas_imu_hkprctrm,	sas_imu_ftyprctrm,
		sas_imu_trantrm,	sas_imu_effdat,	sas_imu_expdat
	from	SAORDSUM (nolock)
	left join	IMBASINF (nolock) on	sas_itmno = ibi_itmno
	where	sas_cocde  = @sas_cocde					and 
		sas_cus1no in (	select	cbi_cusno
				from	cubasinf (nolock)
				where	cbi_cusno = @sas_cus1no	or
					cbi_cusali =  @sas_cus1no)		and
		sas_cusqty - sas_shpqty <> 0					and
		ibi_itmsts is not null
		and ibi_itmsts <> ''
		and sas_itmno <> '' --and sas_itmnotmp = '' and sas_itmnoven = ''
	union
/*
	select	'   '  as 'DEL',	sas_cocde,		sas_cus1no,
		sas_cus1na,	sas_itmno,		sas_itmdsc,
		sas_colcde,		sas_cusqty - sas_shpqty as 'sas_outshpqty',
						sas_freqty - sas_shpfreqty as 'sas_outfreqty',
		sas_chgqty - sas_shpchgqty as 'sas_outchgqty',
				sas_freqty,		sas_creusr,
		sas_itmno + ' / ' + sas_itmnotmp + ' / ' + sas_itmnoven + ' / ' + sas_itmnovenno  + ' : ' + ltrim(rtrim(sas_colcde)) as 'sas_itmcol',
				sas_itmtyp,		als.ibi_itmsts as 'ibi_itmsts',
		sas_alsitmno,	sas_alscolcde,	sas_imu_cus1no,
		sas_imu_cus2no,	sas_imu_hkprctrm,	sas_imu_ftyprctrm,
		sas_imu_trantrm,	sas_imu_effdat,	sas_imu_expdat
	from	SAORDSUM (nolock)

	left join	IMBASINF imm (nolock) on	sas_itmno = imm.ibi_alsitmno 
	left join	IMBASINF als (nolock) on	als.ibi_itmno = imm.ibi_alsitmno

	where	sas_cocde  = @sas_cocde					and 
		sas_cus1no in (	select	cbi_cusno
				from	cubasinf (nolock)
				where	cbi_cusno = @sas_cus1no	or
					cbi_cusali =  @sas_cus1no)		and
		sas_cusqty - sas_shpqty <> 0					and
		imm.ibi_itmsts is not null
	

	union
*/	
		select	'   '  as 'DEL',	sas_cocde,		sas_cus1no,
		sas_cus1na,	sas_itmno,		sas_itmdsc,
		sas_colcde,		sas_cusqty - sas_shpqty as 'sas_outshpqty',
						sas_freqty - sas_shpfreqty as 'sas_outfreqty',
		sas_chgqty - sas_shpchgqty as 'sas_outchgqty',
				sas_freqty,		sas_creusr,
		sas_itmno + ' / ' + sas_itmnotmp + ' / ' + sas_itmnoven + ' / ' + sas_itmnovenno  + ' : ' + ltrim(rtrim(sas_colcde)) as 'sas_itmcol',
				sas_itmtyp,		ibi_itmsts  as 'ibi_itmsts',
		sas_alsitmno,	sas_alscolcde,	sas_imu_cus1no,
		sas_imu_cus2no,	sas_imu_hkprctrm,	sas_imu_ftyprctrm,
		sas_imu_trantrm,	sas_imu_effdat,	sas_imu_expdat
	from	SAORDSUM (nolock)
	left join	IMBASINF (nolock) on	sas_itmnotmp = ibi_itmno
	where	sas_cocde  = @sas_cocde					and 
		sas_cus1no in (	select	cbi_cusno
				from	cubasinf (nolock)
				where	cbi_cusno = @sas_cus1no	or
					cbi_cusali =  @sas_cus1no)		and
		sas_cusqty - sas_shpqty <> 0					and
		ibi_itmsts is not null
		and ibi_itmsts <> ''
		and sas_itmno = ''  and sas_itmnotmp <> '' and sas_itmnoven = ''
		 
	union

	/*select	'   '  as 'DEL',	sas_cocde,		sas_cus1no,
		sas_cus1na,	sas_itmno,		sas_itmdsc,
		sas_colcde,		sas_cusqty - sas_shpqty as 'sas_outshpqty',
						sas_freqty - sas_shpfreqty as 'sas_outfreqty',
		sas_chgqty - sas_shpchgqty as 'sas_outchgqty',
				sas_freqty,		sas_creusr,
		sas_itmno + ' / ' + sas_itmnotmp + ' / ' + sas_itmnoven + ' / ' + sas_itmnovenno  + ' : ' + ltrim(rtrim(sas_colcde)) as 'sas_itmcol',
				sas_itmtyp,		als.ibi_itmsts as 'ibi_itmsts',
		sas_alsitmno,	sas_alscolcde,	sas_imu_cus1no,
		sas_imu_cus2no,	sas_imu_hkprctrm,	sas_imu_ftyprctrm,
		sas_imu_trantrm,	sas_imu_effdat,	sas_imu_expdat
	from	SAORDSUM (nolock)
	left join	IMBASINF imm (nolock) on	sas_itmnotmp = imm.ibi_alsitmno
	left join	IMBASINF als (nolock) on	als.ibi_itmno = imm.ibi_alsitmno
	where	sas_cocde  = @sas_cocde					and 
		sas_cus1no in (	select	cbi_cusno
				from	cubasinf (nolock)
				where	cbi_cusno = @sas_cus1no	or
					cbi_cusali =  @sas_cus1no)		and
		sas_cusqty - sas_shpqty <> 0					and
		imm.ibi_itmsts is not null
	 
	
	union */

	select	'   '  as 'DEL',	sas_cocde,		sas_cus1no,
		sas_cus1na,	sas_itmno,		sas_itmdsc,
		sas_colcde,		sas_cusqty - sas_shpqty as 'sas_outshpqty',
						sas_freqty - sas_shpfreqty as 'sas_outfreqty',
		sas_chgqty - sas_shpchgqty as 'sas_outchgqty',
				sas_freqty,		sas_creusr,
		sas_itmno + ' / ' + sas_itmnotmp + ' / ' + sas_itmnoven + ' / ' + sas_itmnovenno  + ' : ' + ltrim(rtrim(sas_colcde)) as 'sas_itmcol',
				sas_itmtyp,		qud_itmsts  as 'ibi_itmsts',
		sas_alsitmno,	sas_alscolcde,	sas_imu_cus1no,
		sas_imu_cus2no,	sas_imu_hkprctrm,	sas_imu_ftyprctrm,
		sas_imu_trantrm,	sas_imu_effdat,	sas_imu_expdat
	from	SAORDSUM (nolock)
	left join	quotndtl  (nolock) on	sas_itmnoven  = qud_itmnoven and sas_itmnovenno  = qud_itmnovenno 
	where	sas_cocde  = @sas_cocde					and 
		sas_cus1no in (	select	cbi_cusno
				from	cubasinf (nolock)
				where	cbi_cusno = @sas_cus1no	or
					cbi_cusali =  @sas_cus1no)		and
		sas_cusqty - sas_shpqty <> 0					and
		qud_itmsts is not null
		and qud_itmsts <> ''
		and sas_itmno = ''  and sas_itmnotmp = '' and sas_itmnoven <> ''
	 
end




GO
GRANT EXECUTE ON [dbo].[sp_list_SAORDSUM2] TO [ERPUSER] AS [dbo]
GO
