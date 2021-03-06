/****** Object:  StoredProcedure [dbo].[sp_insert_IMXLS003]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMXLS003]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMXLS003]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	Program ID	: sp_insert_IMXLS003
	Programmer	: Lester Wu
	Date		: 2006-07/15
*/

CREATE procedure [dbo].[sp_insert_IMXLS003]
@cocde	varchar(6) , 
@DisItm	varchar(20) , 
@NewItm	varchar(20) , 
@id	int , 
@FN	nvarchar(200) , 
@Date	DateTime , 
@UsrId	varchar(30)
AS
BEGIN
		
	declare @sysmsg as varchar(200)
	
	
	set @sysmsg = ''
	
	--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	-- Checking
	--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	/*
	Access Right Control
	-------------------------------------------------------
	select * from SYUSRPRF
	where yup_flg_cst
	*/

	if @DisItm = @NewItm
	Begin
		set @sysmsg = 'Dis. Item No equals New Item No'
	End
	
	if ((select count(1) from imbasinf where ibi_itmno = @DisItm) <=  0)
	begin
		set @sysmsg = @sysmsg + case when len(@sysmsg) > 0 then ' / ' else '' end + 'Dis. Item Not Exist'
	End
	
	if ((select count(1) from imbasinf where ibi_itmno = @DisItm and ibi_itmsts = 'DIS') >  0)
	Begin
		set @sysmsg = @sysmsg + case when len(@sysmsg) > 0 then ' / ' else '' end + 'Item in DIS status.'
	End

	/*
	if len(@NewItm) > 0 
	Begin
		if (select count(1) from imbasinf where ibi_itmno = @NewItm)
		begin
			set @sysmsg = case len(@sysmsg) > 0 then ' / ' else '' end + 'New Item Not Exist'
		end
	end
	*/
	--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	/*
		-- Y
		-- N
		-- R
	*/

	if ((select count(1) from IMDISITM where idi_disitm = @DisItm and idi_creusr = @UsrId 	and idi_flg   not in ('O','Y') and idi_apvsts <> 'R') > 0 )
	begin
		set @sysmsg = @sysmsg + case when len(@sysmsg) > 0 then ' / ' else '' end + 'Duplicate Item#'
	end
	
	


	
	
	if len(@sysmsg ) > 0 
	Begin
		insert into IMDISITM (idi_disitm , idi_newitm ,idi_apvsts,  idi_sysmsg , idi_filnam , idi_date , idi_credat , idi_creusr , idi_upddat , idi_updusr)
		values (@DisItm , @NewItm ,'R', @sysmsg , @FN, @Date , getdate() , @UsrId, getdate(), @UsrId )
	End
	else
	Begin
		insert into IMDISITM (
			idi_disitm,
			idi_newitm,
			idi_itmsts,
			idi_engdsc,
			idi_chndsc,
			idi_apvsts,
			idi_sysmsg,
			idi_filnam,
			idi_date,
			idi_credat,
			idi_creusr,
			idi_upddat,
			idi_updusr
			)
		select top 1
			@DisItm , 
			@NewItm ,
			ibi_itmsts , 
			ibi_engdsc , 
			ibi_chndsc + case when len(@NewItm) > 0 then char(10) + char(13) + 'refer to (' + @NewItm + ')' else '' end , 
			'N',  
			@sysmsg , 
			@FN, 
			@Date , 
			getdate() , 
			@UsrId, 
			getdate(), 
			@UsrId
		from 
			imbasinf 
		where 
			ibi_itmno = @DisItm
	
	End

END





GO
GRANT EXECUTE ON [dbo].[sp_insert_IMXLS003] TO [ERPUSER] AS [dbo]
GO
