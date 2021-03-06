/****** Object:  StoredProcedure [dbo].[sp_select_IMM00007]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMM00007]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMM00007]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
sp_select_IMM00007 'UCP','','','','','','1','1','1','1','1','1','1','1','1'
select * from IMEXTITM
where ('YN' like '%' + isnull(Iei_CmpFlg,'') + '%') and
           ('NURO' like '%' + isnull(Iei_Stage,'') + '%') and
           ('AWR' like '%' + isnull(Iei_ApvFlg,'') + '%') 
*/


CREATE procedure [dbo].[sp_select_IMM00007]
@cocde as varchar(6),
@ItemNo as varchar(20),
@VendorFm as varchar(6),
@VendorTo  as varchar(6),
@ProcDatFm as varchar(10),
@ProcDatTo as varchar(10),
@Complete as char(1),
@Incomplete as char(1),
@New as char(1),
@Update as char(1),
@SysReject as char(1),
@Old as char(1),
@Approve as char(1),
@Reject as char(1),
@Wait as char(1)
as
Begin
	
Declare 	@CmpFlg as varchar(2),
	@Stage as varchar(4),
	@ApvFlg as varchar(3)

Set @CmpFlg = ''
Set @Stage = ''
Set @ApvFlg = ''

--Complete Flag
if @Complete = '1'
begin
	Set @CmpFlg = @CmpFlg + 'Y'
end

if @Incomplete = '1'
begin
	Set @CmpFlg = @CmpFlg + 'N'
end

--Stage
if @New = '1' 
begin
	Set @Stage = @Stage + 'N'
end 

if @Update = '1' 
begin
	Set @Stage = @Stage + 'U'
end

if @SysReject = '1'
begin
	Set @Stage = @Stage + 'R'
end

if @Old = '1'
begin
	Set @Stage = @Stage + 'O'
end

-- Approve Flag
if @Approve = '1'
begin
	Set @ApvFlg = @ApvFlg + 'A'
end

if @Reject = '1' 
begin
	Set @ApvFlg = @ApvFlg + 'R'
end

if @Wait = '1' 
begin
	Set @ApvFlg = @ApvFlg + 'W'
end

--select @CmpFlg,@Stage,@ApvFlg


	select 	
		 99 as 'Num',
		Iei_CmpFlg,				Iei_ApvFlg,		
		Iei_Stage,
		isnull(Iei_ItmNo,'') as 'Iei_ItmNo',			isnull(Iei_ItmCol,'') as 'Iei_ItmCol',
		isnull(Iei_VenItm,'') as 'Iei_VenItm',		isnull(Iei_VenCol,'') as 'Iei_VenCol',
		isnull(Iei_Venno,'') as 'Iei_Venno',			isnull(Iei_PdItmNo,'') as 'Iei_PdItmNo',
							isnull(Iei_PrdLne,'') as 'Iei_PrdLne',		
							isnull(Iei_CatLvl,'') as 'Iei_CatLvl',
		isnull(Iei_PrcTrm,'') as 'Iei_PrcTrm',

		isnull(Iei_UntCde,'') as 'Iei_UntCde',		isnull(Iei_Inner,0) as 'Iei_Inner',
		isnull(Iei_Middle,0) as 'Iei_Middle',		isnull(Iei_Master,0) as 'Iei_Master',
		isnull(Iei_CFT,0) as 'Iei_CFT',			isnull(Iei_CBM,0) as 'Iei_CBM',

		isnull(Iei_Curr,'') as 'Iei_Curr',			isnull(Iei_ItmCst,0) as 'Iei_ItmCst',
		isnull(Iei_MrkUp,'') as 'Iei_MrkUp',		isnull(Iei_MrkUp + ' - ' + yfi_fmlopt,'')  as 'Iei_MrkUpStr',	
		isnull(Iei_MrkCurr,'') as 'Iei_MrkCurr',			isnull(Iei_MrkCst,0) as 'Iei_MrkCst',

		isnull(Iei_MOQUM,'') as 'Iei_MOQUM',		isnull(Iei_MOQ,0) as 'Iei_MOQ',


		isnull(Iei_ItmDesc,'') as 'Iei_ItmDesc',		isnull(Iei_ChiDesc,'') as 'Iei_ChiDesc',
		isnull(Iei_PckInst,'') as 'Iei_PckInst',
		isnull(Iei_Except,'') as 'Iei_Except',			isnull(Iei_Rmk,'') as 'Iei_Rmk',

		isnull(Iei_InnerL,0) as 'Iei_InnerL',			isnull(Iei_InnerW,0) as 'Iei_InnerW',
		isnull(Iei_InnerH,0) as 'Iei_InnerH',		ltrim(str(Iei_InnerL,9,2))  + 'X' + ltrim(str(Iei_InnerW,9,2)) + 'X' + ltrim(str(Iei_InnerH,9,2)) as 'Inner',

							isnull(Iei_MasterL,0) as 'Iei_MasterL',
		isnull(Iei_MasterW,0) as 'Iei_MasterW',		isnull(Iei_MasterH,0) as 'Iei_MasterH',
		ltrim(str(Iei_MasterL,9,2)) + 'X' + ltrim(str(Iei_MasterW,9,2)) + 'X' + ltrim(str(Iei_MasterH,9,2)) as 'Master',

		isnull(Iei_FilNam,'') as 'Iei_FilNam',		Iei_Seq,				Iei_FilDat,
							Iei_CreUsr,
		Iei_UpdUsr,				Iei_CreDat,
		Iei_UpdDat,				cast(Iei_TimStp as int) as 'Iei_TimStp',
		UpdFlg='X'
	from 
		IMEXTITM
		LEFT JOIN SYFMLINF on isnull(Iei_MrkUp,'')  = yfi_fmlopt
	where
		(@ItemNo = '' or (@ItemNo <> '' and Iei_ItmNo = @ItemNo )) and
		(@VendorFm = '' or (@VendorFm <> '' and Iei_Venno between @VendorFm and @VendorTo)) and
		(@ProcDatFm = '' or (@ProcDatFm <> '' and convert(varchar(10),Iei_FilDat,101) between @ProcDatFm and @ProcDatTo)) and 
		(@CmpFlg like '%' + isnull(Iei_CmpFlg,'') + '%' ) and
		(@Stage like '%' + isnull(Iei_Stage,'') + '%') and
		(@ApvFlg like '%' + isnull(Iei_ApvFlg,'') + '%' )
	order by 	Iei_ItmNo,Iei_credat
		
		
End







GO
GRANT EXECUTE ON [dbo].[sp_select_IMM00007] TO [ERPUSER] AS [dbo]
GO
