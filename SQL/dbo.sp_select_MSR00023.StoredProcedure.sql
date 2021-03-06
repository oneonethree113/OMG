/****** Object:  StoredProcedure [dbo].[sp_select_MSR00023]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MSR00023]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MSR00023]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/***********************************************************************************************************************************************
Modification History
************************************************************************************************************************************************
Modified by		Modified on		Description
************************************************************************************************************************************************
Lester Wu			2005-04-02		replace ALL with UC-G, exclude MS from UC-G, retrieve company name from database
************************************************************************************************************************************************/


--sp_select_MSR00023 'UCP','','','','','','FD/ET - EASTER','FD/ET - EASTER','2003/01','2003/12','B','SN',0,'mis'

CREATE   PROCEDURE [dbo].[sp_select_MSR00023]

	@cocde	nvarchar(6),

	-- No of Top Vendor ( handle on Report) 
	@TopV	integer,

	-- Vendor No
	@vnFm	nvarchar(6),
	@vnTo	nvarchar(6),

	@venNameFm nvarchar(20),
	@venNameTo nvarchar(20),
	

	--Rang of Category 1
	@clFm	nvarchar(40),
	@clTo	nvarchar(40),

	-- Date Range
	@ymFm	nvarchar(7),
	@ymTo		nvarchar(7),

	-- Booking / Sales
	@bp	nvarchar(1),

	-- Sorting
	@sorting	nvarchar(2),

	
	-- Amount more then
	@Amt	numeric(13,4),

	@User	nvarchar(30)

AS

--------------------------------------------------------------
Declare
	@venOpt	nvarchar(1),
	@catOpt	nvarchar(1),
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
	@yy 	nvarchar(3)

SET @ymFm = right(@ymFm,5)
SET @ymTo = right(@ymTo,5)




SET @catOpt = 'N'
	if @clFm <> '' or @clTo <> ''
	begin 
		Set @catOpt = 'Y'
	end
	Else
	begin
		Set @clFm = '-'
		Set @clTo = '-'
	end

Set @venOpt = 'N'
	If @vnFm <> '' or @vnTo <> ''
	begin
		   Set @venOpt = 'Y'
	end
--@ym01-------------------------------------------------
Set @ym01 = @ymFm
Set @yy = left(@ymFm,3)

	--@ym02-------------------------------------------------
	set @ym02 = '99/99'
	
	If right(@ym01,2) < '99'
	begin
		if right(@ym01,2) < 12
		begin
			   Set @ym02 = @yy + right('00' + ltrim(str(right(@ym01,2)+1,2)),2)
		end
		Else
		begin
			   Set @ym02 = right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/01'
			   Set @yy = right('00'+ltrim(str(left(@ymFm,2)+1,2)),2)+ '/'
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

----------------------------------------------------------
--Lester Wu 2005-04-02, retrieve company name from database----------------------------------------
declare @compName varchar(100)
set @compName = 'UNITED CHINESE GROUP'
if @cocde<>'UC-G'
begin
	select @compName = yco_conam from sycominf where yco_cocde = @cocde
end
---------------------------------------------------------------------------------------------------------------------



Select	
	-- Parameter
	@ym01,@ym02,@ym03,@ym04,@ym05,@ym06,@ym07,@ym08,@ym09,@ym10,@ym11,@ym12,
	@cocde,
	@TopV,
	@vnFm,
	@vnTo,
	@venNameFm,
	@venNameTo,
	@clFm,
	@clTo,
	@ymFm,
	@ymTo,
	@bp,
	@Amt,
--select vpf_yymm from VNPUCINF where vpf_yymm = 
	vbi_venno,
	max(vbi_vensna),
	ym01 = Sum(Case vpf_yymm when @ym01 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end),
	ym02 = Sum(Case vpf_yymm when @ym02 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end),
	ym03 = Sum(Case vpf_yymm when @ym03 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end),
	ym04 = Sum(Case vpf_yymm when @ym04 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end),
	ym05 = Sum(Case vpf_yymm when @ym05 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end),
	ym06 = Sum(Case vpf_yymm when @ym06 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end),
	ym07 = Sum(Case vpf_yymm when @ym07 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end),
	ym08 = Sum(Case vpf_yymm when @ym08 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end),
	ym09 = Sum(Case vpf_yymm when @ym09 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end),
	ym10 = Sum(Case vpf_yymm when @ym10 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end),
	ym11 = Sum(Case vpf_yymm when @ym11 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end),
	ym12 = Sum(Case vpf_yymm when @ym12 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end),
	ymSum = Sum(	
		Case vpf_yymm when @ym01 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym02 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym03 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym04 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym05 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym06 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym07 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym08 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym09 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym10 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym11 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym12 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end)
	,@compName as 'compName'

From 	VNPUCINF, VNBASINF
Where	-- 2004/02/16
	--vpf_cocde = @cocde and 
	--Lester Wu 2005-04-02, replace ALL with UC-G, exclude MS company from UC-G
--	(@cocde='ALL' or vpf_cocde=@cocde) and
	((@cocde='UC-G' and vpf_cocde<>'MS') or vpf_cocde=@cocde) and
	---------------------------------
	--vbi_cocde = vpf_cocde 
 	vbi_venno = vpf_venno
--and	vbi_cocde = @cocde      
and	((@venOpt = 'Y' and vbi_venno between @vnFm and @vnTo) or @venOpt = 'N')
and	((@catOpt = 'Y'  and vbi_venno in
(select distinct(vcr_venno)
 from VNCATREL 
where --vcr_cocde = @cocde and    --2004/01/05  rem by Lester Wu, since there is not company code in VNCATREL
((@venOpt = 'Y' and vcr_venno between @vnFm and @vnTo) or @venOpt = 'N') 
and ((@catOpt = 'Y' and vcr_catlvl1 between left(@clFm, patindex('%-%', @clFm) - 1) and  left(@clTo, patindex('%-%', @clTo) - 1)) or @catOpt = 'N'))) or @catOpt = 'N')
group by	vbi_venno

having 	Sum(	Case vpf_yymm when @ym01 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym02 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym03 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym04 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym05 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym06 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym07 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym08 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym09 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym10 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym11 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end +
		Case vpf_yymm when @ym12 then Case @bp when 'P' then round(vpf_mtdpur,0) else round(vpf_mtdbok,0) end else 0 end)
		> @Amt

order by	
	
	Case @sorting when 'TA' then --when 0 then 0 else
	Sum(	Case vpf_yymm when @ym01 then Case @bp when 'P' then vpf_mtdpur else vpf_mtdbok end else 0 end +
		Case vpf_yymm when @ym02 then Case @bp when 'P' then vpf_mtdpur else vpf_mtdbok end else 0 end +
		Case vpf_yymm when @ym03 then Case @bp when 'P' then vpf_mtdpur else vpf_mtdbok end else 0 end +
		Case vpf_yymm when @ym04 then Case @bp when 'P' then vpf_mtdpur else vpf_mtdbok end else 0 end +
		Case vpf_yymm when @ym05 then Case @bp when 'P' then vpf_mtdpur else vpf_mtdbok end else 0 end +
		Case vpf_yymm when @ym06 then Case @bp when 'P' then vpf_mtdpur else vpf_mtdbok end else 0 end +
		Case vpf_yymm when @ym07 then Case @bp when 'P' then vpf_mtdpur else vpf_mtdbok end else 0 end +
		Case vpf_yymm when @ym08 then Case @bp when 'P' then vpf_mtdpur else vpf_mtdbok end else 0 end +
		Case vpf_yymm when @ym09 then Case @bp when 'P' then vpf_mtdpur else vpf_mtdbok end else 0 end +
		Case vpf_yymm when @ym10 then Case @bp when 'P' then vpf_mtdpur else vpf_mtdbok end else 0 end +
		Case vpf_yymm when @ym11 then Case @bp when 'P' then vpf_mtdpur else vpf_mtdbok end else 0 end +
		Case vpf_yymm when @ym12 then Case @bp when 'P' then vpf_mtdpur else vpf_mtdbok end else 0 end)
		else 0 end desc,	
	Case @sorting when 'SN' then max(vbi_vensna)  else '' end,
	vbi_venno










GO
GRANT EXECUTE ON [dbo].[sp_select_MSR00023] TO [ERPUSER] AS [dbo]
GO
