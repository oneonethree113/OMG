/****** Object:  StoredProcedure [dbo].[sp_select_ExtItemForImage]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_ExtItemForImage]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_ExtItemForImage]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








-- Created by Mark Lau 20070426
-- Get the external items which are changed or created today
CREATE  procedure [dbo].[sp_select_ExtItemForImage]

as  
begin  
  
select 
distinct
a.ibi_itmno as 'ibi_itmno', 
a.ibi_venno as 'ibi_venno', 
ivi_venitm,
vbi_ventyp,
a.ibi_credat as 'ibi_credat',
a.ibi_creusr as 'ibi_creusr',
a.ibi_upddat as 'ibi_upddat',
a.ibi_updusr as 'ibi_updusr',
replace(a.ibi_imgpth,'\\UCHKIMGSRV\guest-share\ucp\itemimg\','\\uchkimgsrv\itemimg\ucp\itemimg\') as 'ibi_imgpth'
from imbasinf a
left join UCPERPDB_AUD..IMBASINF_AUD aud (nolock) on a.ibi_itmno = aud.ibi_itmno
left join imveninf on ivi_itmno = a.ibi_itmno
left join vnbasinf on a.ibi_venno = vbi_venno

where vbi_ventyp = 'E' and 

(
--( convert(nvarchar(10),ibi_credat ,111) = convert(nvarchar(10),getdate(),111) and isnull(ibi_imgpth,'') <> '')
--or
--( ibi_credat > '2007-03-16 14:00' and convert(nvarchar(10),ibi_upddat ,111) = convert(nvarchar(10),getdate(),111) and isnull(ibi_imgpth,'') <> '')
 a.ibi_credat > '2007-03-16 14:00' and isnull(a.ibi_imgpth,'') <> ''
)
and aud.ibi_credat >= getdate() - 7

--or (aud.ibi_credat >= '2010-06-20' and aud.ibi_credat <= '2010-06-30')


order by ibi_credat, ibi_upddat asc


/*ibi_credat >= '2007-03-16 14:00' 
and ibi_credat < '2007-05-10'
and ibi_imgpth <> ''
*/
end

GO
GRANT EXECUTE ON [dbo].[sp_select_ExtItemForImage] TO [ERPUSER] AS [dbo]
GO
