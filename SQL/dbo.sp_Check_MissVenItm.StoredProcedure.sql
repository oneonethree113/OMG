/****** Object:  StoredProcedure [dbo].[sp_Check_MissVenItm]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_Check_MissVenItm]
GO
/****** Object:  StoredProcedure [dbo].[sp_Check_MissVenItm]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 27/07/2003


CREATE PROCEDURE [dbo].[sp_Check_MissVenItm] 

@cocde nvarchar(6),
@typ nvarchar(2)

AS

If @typ = 'IM' 
Begin
	Select 	ivi_venno + ' - ' + isnull(vbi_vensna,'') as 'Vendor',
		ibi_itmno as 'Item #',	ibi_itmsts as 'Status',
		imu_pckunt as 'UM',	imu_inrqty as 'Inner',
		imu_mtrqty as 'Master',	imu_cft as 'CFT',
		imu_basprc as 'Basic Price'
	From IMBASINF

--	left join IMVENINF on ivi_cocde = ibi_cocde and ivi_itmno = ibi_itmno
--	left join IMMRKUP on imu_cocde = ibi_cocde and imu_itmno = ibi_itmno and imu_venno = ivi_venno 
--	left join VNBASINF on vbi_Cocde = ibi_cocde and vbi_venno = ivi_venno
	left join IMVENINF on ivi_itmno = ibi_itmno
	left join IMMRKUP on imu_itmno = ibi_itmno and imu_venno = ivi_venno 
	left join VNBASINF on vbi_venno = ivi_venno
	Where 
--	ibi_cocde = @cocde and
	(ivi_venitm is null or ivi_venitm = '') and
	imu_itmno is not Null
	Order by ivi_venno, ibi_itmno
End
Else If @typ = 'SC'
Begin
	Select 	sod_ordno as 'SC #',
		sod_venno + ' - ' + isnull(vbi_vensna,'') as 'Vendor',
		sod_itmno as 'Item #',	
		sod_pckunt as 'UM',	sod_inrctn as 'Inner',
		sod_mtrctn as 'Master',	sod_cft as 'CFT',
		sod_credat as 'CreateDate',	sod_upddat as 'UpdateDate',
		sod_creusr as 'CreateUser',	sod_updusr as 'UpdateUser'
	From SCORDDTL
--	left join VNBASINF on vbi_Cocde = sod_cocde and vbi_venno = sod_venno
	left join VNBASINF on vbi_venno = sod_venno
	Where 
	sod_cocde = @cocde and
	(sod_venitm is null or sod_venitm = '') 
	Order by sod_ordno , sod_itmno ,sod_venno
End
Else If @typ = 'PO'
Begin
	Select 	pod_purord as 'PO #',
		poh_venno + ' - ' + isnull(vbi_vensna,'') as 'Vendor',
		pod_itmno as 'Item #',	
		pod_untcde as 'UM',	pod_inrctn as 'Inner',
		pod_mtrctn as 'Master',	pod_cubcft as 'CFT',
		pod_credat as 'CreateDate',	pod_upddat as 'UpdateDate',
		pod_creusr as 'CreateUser',	pod_updusr as 'UpdateUser'
	From POORDHDR
--	left join VNBASINF on vbi_Cocde = poh_cocde and vbi_venno = poh_venno
	left join VNBASINF on vbi_venno = poh_venno
	,POORDDTL
	Where 
	poh_purord = pod_purord and
	pod_cocde = @cocde and
	(pod_venitm is null or pod_venitm = '') 
	Order by pod_purord , pod_itmno , poh_venno
End




GO
GRANT EXECUTE ON [dbo].[sp_Check_MissVenItm] TO [ERPUSER] AS [dbo]
GO
