/****** Object:  StoredProcedure [dbo].[sp_list_IMR00021]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_IMR00021]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_IMR00021]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*
Author		: Lester Wu 
Date		: 2006-10-11
Description		: 

*/

-- sp_list_IMR00021 'UCPP','02A005-AS3625,372409050c2,02A005-001241,01B06ZT070ADV','BOM','BOTH'

CREATE  procedure [dbo].[sp_list_IMR00021]
@cocde	varchar(6),
@itmList	varchar(600),
@itmType	char(3),
@resultType varchar(4)
as
begin
	create table #_ITMLST(_itm varchar(30))
	declare	@itmRemain varchar(1000), @itmPart varchar(30)


	-- Check Update Items
	set @itmRemain = ltrim(rtrim(@itmList))
	while charindex(',',@itmRemain) > 0 
	begin
		set @itmPart = ltrim(rtrim(left(@itmRemain, charindex(',', @itmRemain) - 1)))
		set @itmRemain = ltrim(rtrim(right(@itmRemain,len(@itmRemain) - charindex(',', @itmRemain))))
		if len(@itmPart) > 0 
		begin
			insert into #_ITMLST (_itm) values (@itmPart)
		end
	end
	if len(@itmRemain) > 0
	begin
		insert into #_ITMLST (_itm) values (@itmRemain)
	end
	

	-- Added by Mark Lau 20090519
	-- Assortment Item
	if @itmType = 'ASS' 
	begin
		select distinct @itmType , @resultType, ass.iba_itmno as 'assortment',ass.iba_assitm as 'regular',ass.iba_colcde as 'Color' ,  isnull(reg.iba_assitm,'') as 'bom', 'ASS' as 'Type' , isnull(ibi_engdsc,'') as 'ibi_engdsc'
		from IMBOMASS org (NOLOCK)
		left join IMBOMASS ass (nolock) on org.iba_itmno = ass.iba_itmno and ass.iba_typ = 'ASS'
		left join IMBOMASS reg (nolock) on ass.iba_assitm = reg.iba_itmno and reg.iba_typ = 'BOM'
		left join IMBASINF (nolock) on ass.iba_itmno = ibi_itmno
		where org.iba_typ = 'ASS'
		and org.iba_itmno in (select _itm from #_ITMLST)
		and ass.iba_itmno is not null
		order by [assortment],[regular],[bom]
	end		
	
	
	-- Assorted Item
	if @itmType = 'REG' 
	begin
		select distinct @itmType , @resultType, ass.iba_itmno as 'assortment',ass.iba_assitm as 'regular',ass.iba_colcde as 'Color' ,  isnull(reg.iba_assitm,'') as 'bom', 'ASS' as 'Type' , isnull(ibi_engdsc,'') as 'ibi_engdsc'
		from IMBOMASS org (NOLOCK)
		left join IMBOMASS ass (nolock) on org.iba_itmno = ass.iba_itmno and ass.iba_typ = 'ASS'
		left join IMBOMASS reg (nolock) on ass.iba_assitm = reg.iba_itmno and reg.iba_typ = 'BOM'
		left join IMBASINF (nolock) on ass.iba_itmno = ibi_itmno
		where org.iba_typ = 'ASS'
		and org.iba_assitm in (select _itm from #_ITMLST)
		and ass.iba_itmno is not null
		--order by [assortment],[regular],[bom]
		
		-- David Yue 2012-11-05 Expand Search Parameters to include History Tables --
		union
		select distinct @itmType , @resultType, assh.iba_itmno as 'assortment',assh.iba_assitm as 'regular',assh.iba_colcde as 'Color' ,  isnull(regh.iba_assitm,'') as 'bom', 'ASS' as 'Type' , isnull(ibi_engdsc,'') as 'ibi_engdsc'
		from IMBOMASSH orgh (NOLOCK)
		left join IMBOMASSH assh (nolock) on orgh.iba_itmno = assh.iba_itmno and assh.iba_typ = 'ASS'
		left join IMBOMASSH regh (nolock) on assh.iba_assitm = regh.iba_itmno and regh.iba_typ = 'BOM'
		left join IMBASINFH (nolock) on assh.iba_itmno = ibi_itmno
		where orgh.iba_typ = 'ASS'
		and orgh.iba_assitm in (select _itm from #_ITMLST)
		and assh.iba_itmno is not null
		order by [assortment],[regular],[bom]
	end
	if @itmType = 'BOM'
	begin
		if @resultType = 'REG' 
		begin
			select distinct @itmType , @resultType, '' as 'assortment',reg.iba_itmno as 'regular',''  as 'Color', reg.iba_assitm as 'bom' , 'REG' as 'Type' , isnull(ibi_engdsc,'') as 'ibi_engdsc'
			from IMBOMASS org (NOLOCK)
			left join IMBOMASS reg (nolock) on org.iba_itmno = reg.iba_itmno and reg.iba_typ = 'BOM'
			left join IMBASINF (nolock) on reg.iba_itmno = ibi_itmno
			where org.iba_typ = 'BOM'
			and org.iba_assitm in (select _itm from #_ITMLST)
			and reg.iba_itmno is not null
			--order by [assortment],[regular],[bom]
			
			-- David Yue 2012-11-05 Expand Search Parameters to include History Tables --
			union
			select distinct @itmType , @resultType, '' as 'assortment',regh.iba_itmno as 'regular',''  as 'Color', regh.iba_assitm as 'bom' , 'REG' as 'Type' , isnull(ibi_engdsc,'') as 'ibi_engdsc'
			from IMBOMASSH orgh (NOLOCK)
			left join IMBOMASSH regh (nolock) on orgh.iba_itmno = regh.iba_itmno and regh.iba_typ = 'BOM'
			left join IMBASINFHh (nolock) on regh.iba_itmno = ibi_itmno
			where orgh.iba_typ = 'BOM'
			and orgh.iba_assitm in (select _itm from #_ITMLST)
			and regh.iba_itmno is not null
			order by [assortment],[regular],[bom]
		end
		if @resultType = 'ASS' 
		begin
			select distinct @itmType , @resultType, isnull(ass.iba_itmno,'') as 'assortment', isnull(ass.iba_assitm,'') as 'regular', isnull(ass.iba_colcde,'') as 'Color',  isnull(reg.iba_assitm,'') as 'bom', 'ASS' as 'Type' , isnull(ibi_engdsc,'') as 'ibi_engdsc'
			from IMBOMASS orgreg  (NOLOCK)
			left join IMBOMASS org  (NOLOCK) on orgreg.iba_itmno = org.iba_assitm and org.iba_typ = 'ASS'
			left join IMBOMASS ass (nolock) on org.iba_itmno = ass.iba_itmno and ass.iba_typ = 'ASS'
			left join IMBOMASS reg (nolock) on ass.iba_assitm = reg.iba_itmno and reg.iba_typ = 'BOM'
			left join IMBASINF (nolock) on ass.iba_itmno = ibi_itmno
			where orgreg.iba_typ = 'BOM'
			and orgreg.iba_assitm in  (select _itm from #_ITMLST)
			and org.iba_itmno is not null		
			--order by [assortment],[regular],[bom]

			-- David Yue 2012-11-05 Expand Search Parameters to include History Tables --
			union
			select distinct @itmType , @resultType, isnull(assh.iba_itmno,'') as 'assortment', isnull(assh.iba_assitm,'') as 'regular', isnull(assh.iba_colcde,'') as 'Color',  isnull(regh.iba_assitm,'') as 'bom', 'ASS' as 'Type' , isnull(ibi_engdsc,'') as 'ibi_engdsc'
			from IMBOMASSH orgregh  (NOLOCK)
			left join IMBOMASSH orgh  (NOLOCK) on orgregh.iba_itmno = orgh.iba_assitm and orgh.iba_typ = 'ASS'
			left join IMBOMASSH assh (nolock) on orgh.iba_itmno = assh.iba_itmno and assh.iba_typ = 'ASS'
			left join IMBOMASSH regh (nolock) on assh.iba_assitm = regh.iba_itmno and regh.iba_typ = 'BOM'
			left join IMBASINFH (nolock) on assh.iba_itmno = ibi_itmno
			where orgregh.iba_typ = 'BOM'
			and orgregh.iba_assitm in  (select _itm from #_ITMLST)
			and orgh.iba_itmno is not null		
			order by [assortment],[regular],[bom]
		end
		if @resultType = 'BOTH'
		begin
			select @itmType , @resultType, '' as 'assortment',reg.iba_itmno as 'regular',''  as 'Color', reg.iba_assitm as 'bom' , 'REG' as 'Type' , isnull(ibi_engdsc,'') as 'ibi_engdsc'
			from IMBOMASS org (NOLOCK)
			left join IMBOMASS reg (nolock) on org.iba_itmno = reg.iba_itmno and reg.iba_typ = 'BOM'
			left join IMBASINF (nolock) on reg.iba_itmno = ibi_itmno
			where org.iba_typ = 'BOM'
			and org.iba_assitm in (select _itm from #_ITMLST)
			and reg.iba_itmno is not null
			union
			select @itmType , @resultType, isnull(ass.iba_itmno,'') as 'assortment', isnull(ass.iba_assitm,'') as 'regular', isnull(ass.iba_colcde,'') as 'Color',  isnull(reg.iba_assitm,'') as 'bom', 'ASS' as 'Type' , isnull(ibi_engdsc,'') as 'ibi_engdsc'
			from IMBOMASS orgreg  (NOLOCK)
			left join IMBOMASS org  (NOLOCK) on orgreg.iba_itmno = org.iba_assitm and org.iba_typ = 'ASS'
			left join IMBOMASS ass (nolock) on org.iba_itmno = ass.iba_itmno and ass.iba_typ = 'ASS'
			left join IMBOMASS reg (nolock) on ass.iba_assitm = reg.iba_itmno and reg.iba_typ = 'BOM'
			left join IMBASINF (nolock) on ass.iba_itmno = ibi_itmno
			where orgreg.iba_typ = 'BOM'
			and orgreg.iba_assitm in  (select _itm from #_ITMLST)
			and org.iba_itmno is not null		
			--order by [Type],[assortment],[regular],[bom]

			-- David Yue 2012-11-05 Expand Search Parameters to include History Tables --
			union
			select @itmType , @resultType, '' as 'assortment',regh.iba_itmno as 'regular',''  as 'Color', regh.iba_assitm as 'bom' , 'REG' as 'Type' , isnull(ibi_engdsc,'') as 'ibi_engdsc'
			from IMBOMASSH orgh (NOLOCK)
			left join IMBOMASSH regh (nolock) on orgh.iba_itmno = regh.iba_itmno and regh.iba_typ = 'BOM'
			left join IMBASINFH (nolock) on regh.iba_itmno = ibi_itmno
			where orgh.iba_typ = 'BOM'
			and orgh.iba_assitm in (select _itm from #_ITMLST)
			and regh.iba_itmno is not null
			union
			select @itmType , @resultType, isnull(assh.iba_itmno,'') as 'assortment', isnull(assh.iba_assitm,'') as 'regular', isnull(assh.iba_colcde,'') as 'Color',  isnull(regh.iba_assitm,'') as 'bom', 'ASS' as 'Type' , isnull(ibi_engdsc,'') as 'ibi_engdsc'
			from IMBOMASSH orgregh  (NOLOCK)
			left join IMBOMASSH orgh  (NOLOCK) on orgregh.iba_itmno = orgh.iba_assitm and orgh.iba_typ = 'ASS'
			left join IMBOMASSH assh (nolock) on orgh.iba_itmno = assh.iba_itmno and assh.iba_typ = 'ASS'
			left join IMBOMASSH regh (nolock) on assh.iba_assitm = regh.iba_itmno and regh.iba_typ = 'BOM'
			left join IMBASINFH (nolock) on assh.iba_itmno = ibi_itmno
			where orgregh.iba_typ = 'BOM'
			and orgregh.iba_assitm in  (select _itm from #_ITMLST)
			and orgh.iba_itmno is not null		
			order by [Type],[assortment],[regular],[bom]
		end
	end
end






GO
GRANT EXECUTE ON [dbo].[sp_list_IMR00021] TO [ERPUSER] AS [dbo]
GO
