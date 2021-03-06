/****** Object:  StoredProcedure [dbo].[sp_list_CUGRPINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_CUGRPINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_CUGRPINF]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/*
=========================================================
Program ID	: 	sp_list_CUGRPINF
Description   	: 	Display Customer Group
Programmer  	: 	David Yue
Date Created	:	2012-12-31
=========================================================
 Modification History                                   
=========================================================
2012-12-28	David Yue	SP Created
=========================================================     
*/

CREATE PROCEDURE [dbo].[sp_list_CUGRPINF]   
  
@cocde nvarchar(6),
@mode nvarchar(3)
  
AS  
  
if @mode = 'A'
begin
	select	cgi_cugrpcde,
		cgi_cugrpdsc,
		case cgi_flg_int when 'Y' then case cgi_flg_ext when 'N' then 'INT' else 'ALL' end
			else case cgi_flg_ext when 'Y' then 'EXT' else 'N/A' end end as 'cgi_grptyp'
	from	CUGRPINF
	order by cgi_flg_int, cgi_cugrpcde
end
else if @mode = 'E'
begin
	select	cgi_cugrpcde,
		cgi_cugrpdsc,
		'EXT' as 'cgi_grptyp'
	from	CUGRPINF
	where	cgi_flg_ext = 'Y'
	order by cgi_cugrpcde
end
else if @mode = 'I'
begin
	select	cgi_cugrpcde,
		cgi_cugrpdsc,
		'INT' as 'cgi_grptyp'
	from	CUGRPINF
	where	cgi_flg_int = 'Y'
	order by cgi_cugrpcde
end





GO
GRANT EXECUTE ON [dbo].[sp_list_CUGRPINF] TO [ERPUSER] AS [dbo]
GO
