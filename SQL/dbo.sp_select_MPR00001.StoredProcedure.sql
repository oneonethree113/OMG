/****** Object:  StoredProcedure [dbo].[sp_select_MPR00001]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MPR00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MPR00001]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/*
=========================================================
Program ID	: sp_select_MPR00001
Description   	: 
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     

*/


--sp_select_MPR00001 'UCPP','','','08/01/2005','08/01/2005'
--select distinct Mxh_MPOFLG from MPOEXPHDR
--select distinct Mxd_MPOFLG from MPOEXPDTL
CREATE   procedure [dbo].[sp_select_MPR00001]
@Code	varchar(6),
@POFm	varchar(20),
@POTo	varchar(20),
@DateFm	varchar(10),
@DateTo	varchar(10),
@Flag	varchar(10)
as
BEGIN

	select @POFm as '@POFm', 
 @POTo as '@POTo',  
 @DateFm as '@DateFm',  
 @DateTo as '@DateTo',  
 * from
	(
	select 'H' as 'Opt', 
isnull(Mxh_PONo, 
Mxd_PONo) as 'PONo', 
isnull(Mxh_Seq, 
Mxd_Seq) as 'Seq', 

	--Header
	Mxh_FilNam as 'Mxh_FilNam',  
 Mxh_seq as 'Mxh_seq',  
 Mxh_PONo as 'Mxh_PONo',  
 Mxh_VenNo as 'Mxh_VenNo',  
 Mxh_PODat as 'Mxh_PODat',  
 Mxh_POUsr as 'Mxh_POUsr',  
 Mxh_ConUsr as 'Mxh_ConUsr',  
 Mxh_ConDat as 'Mxh_ConDat',  
 Mxh_CntUsr as 'Mxh_CntUsr',  

	Mxh_Curr as 'Mxh_Curr',  
 Mxh_ImpFty as 'Mxh_ImpFty',  
 Mxh_ShpPlc as 'Mxh_ShpPlc',  
 Mxh_Rmk as 'Mxh_Rmk',  
 Mxh_UpdFlg as 'Mxh_UpdFlg',  
 Mxh_Expt as 'Mxh_Expt',  

	case ltrim(rtrim(isnull(Mxh_MPOFlg, 
''))) when 'A' then 'Approve' when 'R' then 'Reject' when 'E' then 'Wait for Approve' when 'D' then 'Reject (delete)' else '' end as 'Mxh_MPOFlg', 

	Mxh_MPONO as 'Mxh_MPONO',  
 Mxh_CreDat as 'Mxh_CreDat',  

	Mxh_CreUsr as 'Mxh_CreUsr',  
 Mxh_UpdDat as 'Mxh_UpdDat',  
 Mxh_UpdUsr as 'Mxh_UpdUsr',  

	--Detail
	Mxd_FilNam as 'Mxd_FilNam',  
 Mxd_seq as 'Mxd_seq',  
 Mxd_PONo as 'Mxd_PONo',  
 Mxd_POSeq as 'Mxd_POSeq',  
 Mxd_ReqNo as 'Mxd_ReqNo',  
 isnull(Mxd_ItmNo, 
'') as 'Mxd_ItmNo', 
 Mxd_ItmNam as 'Mxd_ItmNam',  
 Mxd_ItmDsc as 'Mxd_ItmDsc',  
 Mxd_ColCde as 'Mxd_ColCde',  

	Mxd_UM as 'Mxd_UM',  
 Mxd_Qty as 'Mxd_Qty',  
 Mxd_UntPrc as 'Mxd_UntPrc',  
 Mxd_PckMth as 'Mxd_PckMth',  
 Mxd_Dept as 'Mxd_Dept',  
 Mxd_PrdNo as 'Mxd_PrdNo',  
 Mxd_Rmk as 'Mxd_Rmk',  
 Mxd_UpdFlg as 'Mxd_UpdFlg',  
 Mxd_Expt as 'Mxd_Expt',  

	case ltrim(rtrim(isnull(Mxd_MPOFlg, 
''))) when 'A' then 'Approve' when 'R' then 'Reject' when 'E' then 'Wait for Approve' when 'D' then 'Reject (delete)' else '' end as 'Mxd_MPOFlg', 

	Mxd_MPONO as 'Mxd_MPONO',  
 Mxd_CreDat as 'Mxd_CreDat',  
 Mxd_CreUsr as 'Mxd_CreUsr',  
 Mxd_UpdDat as 'Mxd_UpdDat',  
 Mxd_UpdUsr as 'Mxd_UpdUsr'

	from MPOEXPHDR 
	Left Join  MPOEXPDTL on Mxh_PONO = Mxd_PONO and 'X' = 'Y'
	where 
		(@POFm = '' or (Mxh_PONo between @POFm and @POTo)) and 
		(@DateFm = '01/01/1900' or (isnull(Mxh_credat, 
'1900/01/01') between @DateFm and @DateTo + ' 23:59:59'))
		and Mxh_MPOFlg = 'E'


--	Left Join  MPOEXPDTL on 'X' = 'Y' --Mxh_PONO = Mxd_PONO
--	where (@Flag = 'X' or (@Flag <> 'X' and '%' + ltrim(rtrim(Mxh_MpoFlg)) + '%' like @Flag))
	
union all


	select 'D' as 'Opt',  
isnull(Mxh_PONo, 
Mxd_PONo) as 'PONo',  
isnull(Mxh_Seq, 
Mxd_Seq) as 'Seq',  

	--Header
	Mxh_FilNam as 'Mxh_FilNam',  
 Mxh_seq as 'Mxh_seq',  
 Mxh_PONo as 'Mxh_PONo',  
 Mxh_VenNo as 'Mxh_VenNo',  
 Mxh_PODat as 'Mxh_PODat',  
 Mxh_POUsr as 'Mxh_POUsr',  
 Mxh_ConUsr as 'Mxh_ConUsr',  
 Mxh_ConDat as 'Mxh_ConDat',  
 Mxh_CntUsr as 'Mxh_CntUsr',  

	Mxh_Curr as 'Mxh_Curr',  
 Mxh_ImpFty as 'Mxh_ImpFty',  
 Mxh_ShpPlc as 'Mxh_ShpPlc',  
 Mxh_Rmk as 'Mxh_Rmk',  
 Mxh_UpdFlg as 'Mxh_UpdFlg',  
 Mxh_Expt as 'Mxh_Expt',  

	case ltrim(rtrim(isnull(Mxh_MPOFlg, 
''))) when 'A' then 'Approve' when 'R' then 'Reject' when 'E' then 'Wait for Approve' when 'D' then 'Reject (delete)' else '' end as 'Mxh_MPOFlg', 

	Mxh_MPONO as 'Mxh_MPONO',  
 Mxh_CreDat as 'Mxh_CreDat',  

	Mxh_CreUsr as 'Mxh_CreUsr',  
 Mxh_UpdDat as 'Mxh_UpdDat',  
 Mxh_UpdUsr as 'Mxh_UpdUsr',  

	--Detail
	Mxd_FilNam as 'Mxd_FilNam',  
 Mxd_seq as 'Mxd_seq',  
 Mxd_PONo as 'Mxd_PONo',  
 Mxd_POSeq as 'Mxd_POSeq',  
 Mxd_ReqNo as 'Mxd_ReqNo',  
 isnull(Mxd_ItmNo ,  '') as 'Mxd_ItmNo', 
 Mxd_ItmNam as 'Mxd_ItmNam',  
 Mxd_ItmDsc as 'Mxd_ItmDsc',  
 Mxd_ColCde as 'Mxd_ColCde',  

	Mxd_UM as 'Mxd_UM',  
 Mxd_Qty as 'Mxd_Qty',  
 Mxd_UntPrc as 'Mxd_UntPrc',  
 Mxd_PckMth as 'Mxd_PckMth',  
 Mxd_Dept as 'Mxd_Dept',  
 Mxd_PrdNo as 'Mxd_PrdNo',  
 Mxd_Rmk as 'Mxd_Rmk',  
 Mxd_UpdFlg as 'Mxd_UpdFlg',  
 Mxd_Expt as 'Mxd_Expt',  

	case ltrim(rtrim(isnull(Mxd_MPOFlg, 
''))) when 'A' then 'Approve' when 'R' then 'Reject' when 'E' then 'Wait for Approve' when 'D' then 'Reject (delete)' else '' end as 'Mxd_MPOFlg', 

	Mxd_MPONO as 'Mxd_MPONO',  
 Mxd_CreDat as 'Mxd_CreDat',  
 Mxd_CreUsr as 'Mxd_CreUsr',  
 Mxd_UpdDat as 'Mxd_UpdDat',  
 Mxd_UpdUsr as 'Mxd_UpdUsr'

	from MPOEXPHDR
	Right Join MPOEXPDTL on mxh_pono = mxd_pono and 'X' = 'Y'
	where 
		(@POFm = '' or (Mxd_PONo between @POFm and @POTo)) and 
		(@DateFm = '01/01/1900' or (isnull(Mxd_credat, 
'1900/01/01') between @DateFm and @DateTo + ' 23:59:59'))
		and Mxd_MPOFlg = 'E'
	)  a

--	where
--		(@POFm = '' or (PONo between @POFm and @POTo)) and 
--		(@DateFm = '01/01/1900' or (isnull(Mxh_credat,Mxd_Credat) between @DateFm and @DateTo + ' 23:59:59'))

	order by 1,2,3
	--'Opt' desc,isnull(Mxh_PONo,Mxd_PONo),isnull(Mxh_Seq,Mxd_Seq),isnull(mxd_ItmNo,'')



END









GO
GRANT EXECUTE ON [dbo].[sp_select_MPR00001] TO [ERPUSER] AS [dbo]
GO
