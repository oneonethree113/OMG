/****** Object:  StoredProcedure [dbo].[sp_list_IMR00005]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_IMR00005]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_IMR00005]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_list_IMR00005]

@cocde as nvarchar(6),
--@stage as nvarchar(30),
--@fromstage as nvarchar(3),
--@tostage as nvarchar(3),
@fromvenno as nvarchar(20),
@tovenno as nvarchar(20),
@fromcredat as nvarchar(10),
@tocredat as nvarchar(10)


as

declare @string as nvarchar(4000)
declare @stage as nvarchar(30)
set @stage = ''

set @string = 
'select a.iid_stage, a.iid_venno, a.iid_prdven, a.iid_credat , a.iid_venitm, a.iid_lnecde, a.iid_engdsc, 
a.iid_untcde, a.iid_conftr,  a.iid_inrqty, a.iid_mtrqty, a.iid_ftyprc, 
---a.iid_sysmsg + '' ('' +a.iid_xlsfil  + '')'' as iid_sysmsg
a.iid_xlsfil  as iid_sysmsg
,''' + 
replace(@stage,'@',' ') + ''',''' + @fromvenno + ''','''  + @tovenno + ''',''' + @fromcredat + ''',''' + @tocredat +  '''

from  (select * from imitmdat (nolock) union select * from imitmdath (nolock)) a

where
--a.iid_cocde = ''' +@cocde + ''' and 
--a.iid_stage in (' + replace(@stage,'@','''') + ') and 
a.iid_venitm >=  ''' + @fromvenno + ''' and a.iid_venitm < = ''' + @tovenno + ''' and
a.iid_credat  >= ''' + @fromcredat + ' 00:00:00' + ''' and a.iid_credat  <= ''' + @tocredat + ' 23:59:59' + '''
order by a.iid_venitm, a.iid_credat'

-- order by a.iid_stage, a.iid_venno,  cast(a.iid_credat as smalldatetime), a.iid_venitm'
---print @string
exec( @string)

--exec( @string)



GO
GRANT EXECUTE ON [dbo].[sp_list_IMR00005] TO [ERPUSER] AS [dbo]
GO
