/****** Object:  StoredProcedure [dbo].[sp_select_SYTIESTR]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYTIESTR]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYTIESTR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 15 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
20030715	Allan Yuen		For Merge Porject
*/

/*
Samuel Chan
*/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_SYTIESTR]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@yts_cocde	nvarchar(6) = ' ', 
@yts_venno	nvarchar(6),
@yts_tirtyp	nvarchar(1)

---------------------------------------------- 
 
AS
declare @yts_timstp int

--Set  @yts_timstp = (Select max(cast(yts_timstp as int)) from sytiestr where yts_cocde = @yts_cocde)
Set  @yts_timstp = (Select max(cast(yts_timstp as int)) from sytiestr where yts_cocde = ' ')


begin
 Select 
yts_creusr as 'yts_status',
yts_cocde,
yts_venno,
yts_tirtyp,
yts_tirseq,
case yts_itmtyp
	when 'R' then 'Regular'
	when 'A' then 'Assortment'
	when 'B' then 'BOM'
	when 'L' then 'All'
ELSE '          '
END as 'yts_itmtyp',	
yts_qtyfr,
yts_qtyto,
yts_MOQ,
yts_MOA,
yts_comrat,
yts_moqchgfr,
yts_moqchgto,
yts_moqchg,
yts_moqrbe,
yts_effdat,
yts_creusr,
yts_updusr,
yts_credat,
yts_upddat,
@yts_timstp as 'yts_timstp' 
/*
yci_creusr as 'yci_status'
*/
 -- added by Mark Lau 20090203
,isnull(yts_unttyp,'') as 'yts_unttyp'
--------------------------------- 
 from SYTIESTR
 where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- yts_cocde = @yts_cocde and
yts_cocde = ' ' and
yts_venno = @yts_venno and
yts_tirtyp = @yts_tirtyp 

order by 
yts_cocde,
yts_venno,
yts_itmtyp,
yts_tirtyp
-------------------------- 

                                                           
end


GO
GRANT EXECUTE ON [dbo].[sp_select_SYTIESTR] TO [ERPUSER] AS [dbo]
GO
