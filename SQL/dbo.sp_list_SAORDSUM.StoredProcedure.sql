/****** Object:  StoredProcedure [dbo].[sp_list_SAORDSUM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SAORDSUM]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SAORDSUM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO










-- Checked by Allan Yuen at 28/07/2003


/************************************************************************
Author:		Johnson Lai 
Date:		Feb 8, 2002
Description:	Select data From SORDSUM
Parameter:	1. Company
		2. Primary customer
***********************************************************************
22 Aug 2003	Lewis To		Add Sorting by item no and color
***********************************************************************
*/

CREATE procedure [dbo].[sp_list_SAORDSUM]
                                                                                                                                                                                                                                                               
@sas_cocde nvarchar(6) ,
@sas_cus1no nvarchar(20) 
 
AS
begin
select 

'   '  as 'DEL',
sas_cocde,
sas_cus1no,
sas_cus1na,
sas_itmno,
sas_itmdsc,
sas_colcde,
sas_cusqty - sas_shpqty as 'sas_outshpqty',
sas_freqty - sas_shpfreqty as 'sas_outfreqty',
sas_chgqty - sas_shpchgqty as 'sas_outchgqty',
sas_freqty,
sas_creusr,
sas_itmno + ' : ' + ltrim(rtrim(sas_colcde)) as 'sas_itmcol',
sas_itmtyp,
ibi_itmsts  as 'ibi_itmsts',

--Added by Mark Lau 20060923
sas_alsitmno,
sas_alscolcde

from SAORDSUM
left join IMBASINF (nolock) on sas_itmno = ibi_itmno
where                                                                                                                                                                                                                                                                 
sas_cocde  = @sas_cocde  and 
--sas_cus1no= @sas_cus1no and
sas_cus1no  in (select cbi_cusno from cubasinf where cbi_cusno = @sas_cus1no  or cbi_cusali =  @sas_cus1no )  and
sas_cusqty - sas_shpqty <> 0 and
ibi_itmsts is not null


union

select 

'   '  as 'DEL',
sas_cocde,
sas_cus1no,
sas_cus1na,
sas_itmno,
sas_itmdsc,
sas_colcde,
sas_cusqty - sas_shpqty as 'sas_outshpqty',
sas_freqty - sas_shpfreqty as 'sas_outfreqty',
sas_chgqty - sas_shpchgqty as 'sas_outchgqty',
sas_freqty,
sas_creusr,
sas_itmno + ' : ' + ltrim(rtrim(sas_colcde)) as 'sas_itmcol',
sas_itmtyp,
als.ibi_itmsts as 'ibi_itmsts',

--Added by Mark Lau 20060923
sas_alsitmno,
sas_alscolcde


from SAORDSUM
/*
left join IMBASINF (nolock) on sas_itmno = ibi_alsitmno
*/

--added by Mark  20060919
left join IMBASINF imm (nolock) on sas_itmno = imm.ibi_alsitmno

left join IMBASINF als (nolock) on als.ibi_itmno = imm.ibi_alsitmno

where                                                                                                                                                                                                                                                                 
sas_cocde  = @sas_cocde  and 
--sas_cus1no= @sas_cus1no and
sas_cus1no  in (select cbi_cusno from cubasinf where cbi_cusno = @sas_cus1no  or cbi_cusali =  @sas_cus1no )  and
sas_cusqty - sas_shpqty <> 0 and
imm.ibi_itmsts is not null 



order by  sas_itmno, sas_colcde
end


GO
GRANT EXECUTE ON [dbo].[sp_list_SAORDSUM] TO [ERPUSER] AS [dbo]
GO
