/****** Object:  StoredProcedure [dbo].[sp_list_SHINVELL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SHINVELL]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SHINVELL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

/*
=========================================================
Program ID	: sp_list_SHINVELL 
Description   	: Print ELLIWELL INVOICE
Programmer  	: PIC
Create Date   	: 
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      Initial  	Description                          
=========================================================    
09/06/2003 Allan Yuen   Add Ship Date Information
*/

CREATE PROCEDURE [dbo].[sp_list_SHINVELL] 

@cocde as nvarchar(10),
@datefrom as nvarchar(10),
@dateto as nvarchar(10),
@InvTyp as nvarchar(10),
@usrid as nvarchar(30)
AS
SELECT
hie_cocde,
hie_invno,
case when hie_invtyp = 'EA' then 'Sample Invoice' else 'Normal Invoice' end as 'hie_invtyp',
hie_invdat,
hie_invsts,
hie_curcde,
hie_ttlamt,
hie_disamt,
hie_netamt,
hie_upddat,
hie_oriinv,
hie_credat,
case when hie_invtyp = 'EL' 
then
	hih_cus1no + case when A.cbi_cussna = '' then '' else ' - ' + A.cbi_cussna end 
else
	sih_cus1no + case when B.cbi_cussna = '' then '' else ' -  ' + B.cbi_cussna end
end	as 'hih_cus1no',

@datefrom as 'DateFrom',
@dateto as 'DateTo',
@InvTyp as 'InvTyp',
hih_slnonb


FROM SHINVELL
LEFT JOIN SHINVHDR on hie_cocde = hiv_cocde and hie_oriinv = hiv_invno
LEFT JOIN SHIPGHDR on hih_cocde = hiv_cocde and hih_shpno = hiv_shpno
LEFT JOIN SAINVHDR on hie_cocde =  sih_cocde and hie_oriinv = sih_invno
--LEFT JOIN CUBASINF A on hie_cocde = A.cbi_cocde and hih_cus1no = A.cbi_cusno and A.cbi_custyp = 'P'
--LEFT JOIN CUBASINF B on sih_cocde = B.cbi_cocde and sih_cus1no = B.cbi_cusno and B.cbi_custyp = 'P'
LEFT JOIN CUBASINF A on hih_cus1no = A.cbi_cusno and A.cbi_custyp = 'P'
LEFT JOIN CUBASINF B on sih_cus1no = B.cbi_cusno and B.cbi_custyp = 'P'


WHERE


--hie_cocde = @cocde and
hie_cocde = 'UCP' and
hie_upddat between case when @datefrom = '  /  /    ' then '01/01/1900' else @datefrom end and case  when  @dateto = '  /  /    ' then '01/01/2999' else @dateto + ' 23:59:59.998' end and
hie_invtyp = case when @InvTyp = 'ALL' then hie_invtyp else @InvTyp end

ORDER BY 

hie_cocde,
hie_invtyp,
hie_invno,
hie_invdat





GO
GRANT EXECUTE ON [dbo].[sp_list_SHINVELL] TO [ERPUSER] AS [dbo]
GO
