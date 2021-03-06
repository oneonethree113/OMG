/****** Object:  StoredProcedure [dbo].[sp_insert_IMXLS004]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMXLS004]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMXLS004]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




/*
	Program ID	: sp_insert_IMXLS004
	Programmer	: Lester Wu
	Date		: 2007-03-01
*/

--sp_insert_IMXLS004 'UCPP','06A01DA001A01','50154','X1','Customer Alias Item Template.xls','03/01/2007 16:50:04','mis'
/*
 select * from IMCUSALS where ica_apvsts = 'Y'
union all
 select * from IMCUSALS where ica_apvsts = 'N' and ica_flg = ''
order by ica_apvsts desc ,ica_cusno,ica_itmno


*/

CREATE procedure [dbo].[sp_insert_IMXLS004]
@cocde	varchar(6) , 
@ItemNo	varchar(20) , 
@CustNo	varchar(30), 
@CustAls	varchar(30) , 
@ApvSts	char(2),

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

	set @ItemNo = ltrim(rtrim(@ItemNo))
	set @CustNo = ltrim(rtrim(@CustNo))
	set @CustAls = ltrim(rtrim(@CustAls))

	/*
	--1.  No checking of user can access the customer or not
	*/

	--2.  Item Should Exist
	if ((select count(1) from imbasinf where ibi_itmno = @ItemNo) <=  0)
	begin
		set @sysmsg = @sysmsg + case when len(@sysmsg) > 0 then ' / ' else '' end + 'Item # Not Exist'
	End
	
	--3. Customer Should Exist
	if ((select count(1) from cubasinf where cbi_cusno = @custno) <=  0)
	Begin
		set @sysmsg = @sysmsg + case when len(@sysmsg) > 0 then ' / ' else '' end + 'Customer # Not Exist'
	End
	
	if len(@CustAls) <= 0 
	begin
		set @sysmsg = @sysmsg + case when len(@sysmsg) > 0 then ' / ' else '' end + 'Customer Alias Empty'
	end

/*
	if (select count(1) from imcusals where ica_cusalsitm = @CustAls and ica_apvsts = 'Y' and (ica_itmno <> @ItemNo or ica_cusno <> @CustNo)) > 0
	begin
		set @sysmsg = @sysmsg + case when len(@sysmsg) > 0 then ' / ' else '' end + 'Customer Alias in Use'
	end
*/

	if @ApvSts = 'DP' -- Duplicate Item & Customer Pair
	begin
		set @sysmsg = @sysmsg + case when len(@sysmsg) > 0 then ' / ' else '' end + 'Duplicate Item & Customer Pair'
	end

/*	
	if @ApvSts = 'DA' -- Duplicate Alias Item
	begin
		set @sysmsg = @sysmsg + case when len(@sysmsg) > 0 then ' / ' else '' end + 'Duplicate Alias Item'		
	end
*/
	--4. Item # and Customer should be key field
	--5. Customer Alias Cannot duplicate (It is unique for all customers)
	--6. Same Customer Alias for item with different packing

	--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	/*
		-- Y
		-- N
		-- R
	*/

	if len(@sysmsg ) > 0 
	Begin
		insert into IMCUSALS (ica_ItmNo ,ica_cusno, ica_cusalsitm ,ica_apvsts,  ica_sysmsg , ica_filnam , ica_date , ica_credat , ica_creusr , ica_upddat , ica_updusr)
		values (@ItemNo ,@CustNo, @CustAls ,'R', @sysmsg , @FN, @Date , getdate() , @UsrId, getdate(), @UsrId )
	End
	else
	Begin
		
		-- Lester Wu 2007-07-11
		Update   
		  IMCUSALS   
		 set   
		  ica_apvsts = 'X' ,    
		  ica_upddat = getdate(),   
		  ica_updusr = @UsrId  
		 where   
		  ica_cusno = @CustNo and   
		  ica_Itmno = @ItemNo and  
		  ica_apvsts <> 'X'



		insert into IMCUSALS (
			ica_itmno,
			ica_cusno,
			ica_cusalsitm,
			ica_apvsts,
			ica_flg,
			ica_sysmsg,
			ica_filnam,
			ica_date,
			ica_credat,
			ica_creusr,
			ica_upddat,
			ica_updusr
			)
		values
			(
			@ItemNo , 
			@CustNo ,
			@CustAls ,
			'N',  
			'', 
			@sysmsg , 
			@FN, 
			@Date , 
			getdate() , 
			@UsrId, 
			getdate(), 
			@UsrId
			)
	
	End

END



GO
GRANT EXECUTE ON [dbo].[sp_insert_IMXLS004] TO [ERPUSER] AS [dbo]
GO
