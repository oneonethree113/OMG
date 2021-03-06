/****** Object:  StoredProcedure [dbo].[sp_select_MSR00030_sub]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MSR00030_sub]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MSR00030_sub]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_select_MSR00030_sub]

	@cocde	nvarchar(6),

	-- Primary Customer
	@pcFm	nvarchar(6),
	@pcTo	nvarchar(6),

	@ymFm	nvarchar(6),
	@ymTo	nvarchar(6),

	@bs	nvarchar(1)
-----------------------------------------------------------------------------
AS

/*
Set @cocde = 'UCPP'
Set @TopC = 0
Set @pcFm = '10077'
Set @pcTo = '10077'
Set @stFm = ''
Set @stTo = ''
Set @ymFm = '02/01'
Set @ymTo = '02/06'
Set @bs = 'B'
Set @sec = 'Y'
Set @sorting = 'TA'
Set @Amt = 0
*/
Declare
	@Opt1	nvarchar(1),
	@Opt2	nvarchar(1),
	@ym01	nvarchar(5),
	@ym02	nvarchar(5),
	@ym03	nvarchar(5),
	@ym04	nvarchar(5),
	@ym05	nvarchar(5),
	@ym06	nvarchar(5),
	@ym07	nvarchar(5),
	@ym08	nvarchar(5),
	@ym09	nvarchar(5),
	@ym10	nvarchar(5),
	@ym11	nvarchar(5),
	@ym12	nvarchar(5),
	@yy	nvarchar(5)

--------------------------------------------------------


Set @Opt1 = 'Y'
	If @pcFm = '' and @pcTo = ''
	begin
		   Set @Opt1 = 'N'
	end
	
----------------------------------------------------------------------------------------------------------------------------	


set @yy = left(@ymFm,3)

	Set @ym01 = @ymFm

	-- @ym02 --------------------------
	Set @ym02 = '99/99'
	If  right(@ym01,2) <> '99'
	begin
	   If right(@ym01,2) < 12 
	   begin
		   Set @ym02 = @yy + right('00' + ltrim(str(right(@ym01,2)+1,2)),2)
	   end
	   Else
	   begin
		   Set @ym02 = right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/01'
		set @yy =  right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/'
	  end
	end
	
	If @ym02 > @ymTo
	Begin
		   Set @ym02 = '99/99'
	End


	-- @ym03 --------------------------
	Set @ym03 = '99/99'
	If  right(@ym02,2) <> '99'
	begin
	   If right(@ym02,2) < 12 
	   begin
		   Set @ym03 = @yy + right('00' + ltrim(str(right(@ym02,2)+1,2)),2)
	   end
	   Else
	   begin
		   Set @ym03 = right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/01'
		set @yy =  right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/'
	  end
	end

	If @ym03 > @ymTo
	Begin
		   Set @ym03 = '99/99'
	End

	-- @ym04 --------------------------
	Set @ym04 = '99/99'
	If  right(@ym03,2) <> '99'
	begin
	   If right(@ym03,2) < 12 
	   begin
		   Set @ym04 = @yy + right('00' + ltrim(str(right(@ym03,2)+1,2)),2)
	   end
	   Else
	   begin
		   Set @ym04 = right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/01'
		set @yy =  right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/'
	  end
	end

	If @ym04 > @ymTo
	Begin
		   Set @ym04 = '99/99'
	End

	-- @ym05 --------------------------
	Set @ym05 = '99/99'
	If  right(@ym04,2) <> '99'
	begin
	   If right(@ym04,2) < 12 
	   begin
		   Set @ym05 = @yy + right('00' + ltrim(str(right(@ym04,2)+1,2)),2)
	   end
	   Else
	   begin
		   Set @ym05 = right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/01'
		set @yy =  right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/'
	  end
	end

	If @ym05 > @ymTo
	Begin
		   Set @ym05 = '99/99'
	End


	-- @ym06 --------------------------
	Set @ym06 = '99/99'
	If  right(@ym05,2) <> '99'
	begin
	   If right(@ym05,2) < 12 
	   begin
		   Set @ym06 = @yy + right('00' + ltrim(str(right(@ym05,2)+1,2)),2)
	   end
	   Else
	   begin
		   Set @ym06 = right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/01'
		set @yy =  right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/'
	  end
	end


	If @ym06 > @ymTo
	Begin
		   Set @ym06 = '99/99'
	End


	-- @ym07 --------------------------
	Set @ym07 = '99/99'
	If  right(@ym06,2) <> '99'
	begin
	   If right(@ym06,2) < 12 
	   begin
		   Set @ym07 = @yy + right('00' + ltrim(str(right(@ym06,2)+1,2)),2)
	   end
	   Else
	   begin
		   Set @ym07 = right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/01'
		set @yy =  right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/'
	  end
	end
	
	If @ym07 > @ymTo
	Begin
		   Set @ym07 = '99/99'
	End

	-- @ym08 --------------------------
	Set @ym08 = '99/99'
	If  right(@ym07,2) <> '99'
	begin
	   If right(@ym07,2) < 12 
	   begin
		   Set @ym08 = @yy + right('00' + ltrim(str(right(@ym07,2)+1,2)),2)
	   end
	   Else
	   begin
		   Set @ym08 = right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/01'
		set @yy =  right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/'
	  end
	end

	If @ym08 > @ymTo
	Begin
		   Set @ym08 = '99/99'
	End


	-- @ym09 --------------------------
	Set @ym09 = '99/99'
	If  right(@ym08,2) <> '99'
	begin
	   If right(@ym08,2) < 12 
	   begin
		   Set @ym09 = @yy + right('00' + ltrim(str(right(@ym08,2)+1,2)),2)
	   end
	   Else
	   begin
		   Set @ym09 = right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/01'
		set @yy =  right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/'
	  end
	end

	If @ym09 > @ymTo
	Begin
		   Set @ym09 = '99/99'
	End


	-- @ym10 --------------------------
	Set @ym10 = '99/99'
	If  right(@ym09,2) <> '99'
	begin
	   If right(@ym09,2) < 12 
	   begin
		   Set @ym10 = @yy + right('00' + ltrim(str(right(@ym09,2)+1,2)),2)
	   end
	   Else
	   begin
		   Set @ym10 = right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/01'
		set @yy =  right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/'
	  end
	end

	If @ym10 > @ymTo
	Begin
		   Set @ym10 = '99/99'
	End

	-- @ym11 --------------------------
	Set @ym11 = '99/99'
	If  right(@ym10,2) <> '99'
	begin
	   If right(@ym10,2) < 12 
	   begin
		   Set @ym11 = @yy + right('00' + ltrim(str(right(@ym10,2)+1,2)),2)
	   end
	   Else
	   begin
		   Set @ym11 = right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/01'
		set @yy =  right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/'
	  end
	end

	If @ym11 > @ymTo
	Begin
		   Set @ym11 = '99/99'
	End
	

	-- @ym12 --------------------------
	Set @ym12 = '99/99'
	If  right(@ym11,2) <> '99'
	begin
	   If right(@ym11,2) < 12 
	   begin
		   Set @ym12 = @yy + right('00' + ltrim(str(right(@ym11,2)+1,2)),2)
	   end
	   Else
	   begin
		   Set @ym12 = right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/01'
		set @yy =  right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/'
	  end
	end
	
	If @ym12 > @ymTo
	Begin
		   Set @ym12 = '99/99'
	End

--------------------------------------------------------------------------------------------------------------------------------------------

Select	

	cbs_cusno,
	ymSum = Sum(	
		Case cbs_yymm when @ym01 then Case @bs when 'S' then cbs_mtdsal else cbs_mtdbok end else 0 end +
		Case cbs_yymm when @ym02 then Case @bs when 'S' then cbs_mtdsal else cbs_mtdbok end else 0 end +
		Case cbs_yymm when @ym03 then Case @bs when 'S' then cbs_mtdsal else cbs_mtdbok end else 0 end +
		Case cbs_yymm when @ym04 then Case @bs when 'S' then cbs_mtdsal else cbs_mtdbok end else 0 end +
		Case cbs_yymm when @ym05 then Case @bs when 'S' then cbs_mtdsal else cbs_mtdbok end else 0 end +
		Case cbs_yymm when @ym06 then Case @bs when 'S' then cbs_mtdsal else cbs_mtdbok end else 0 end +
		Case cbs_yymm when @ym07 then Case @bs when 'S' then cbs_mtdsal else cbs_mtdbok end else 0 end +
		Case cbs_yymm when @ym08 then Case @bs when 'S' then cbs_mtdsal else cbs_mtdbok end else 0 end +
		Case cbs_yymm when @ym09 then Case @bs when 'S' then cbs_mtdsal else cbs_mtdbok end else 0 end +
		Case cbs_yymm when @ym10 then Case @bs when 'S' then cbs_mtdsal else cbs_mtdbok end else 0 end +
		Case cbs_yymm when @ym11 then Case @bs when 'S' then cbs_mtdsal else cbs_mtdbok end else 0 end +
		Case cbs_yymm when @ym12 then Case @bs when 'S' then cbs_mtdsal else cbs_mtdbok end else 0 end)

From 	CUBOKSAL
Where	cbs_cocde = @cocde
and	((@Opt1 = 'Y' and cbs_cusno between @pcFm and @pcTo) or @Opt1 = 'N')
group by	cbs_cusno


GO
GRANT EXECUTE ON [dbo].[sp_select_MSR00030_sub] TO [ERPUSER] AS [dbo]
GO
