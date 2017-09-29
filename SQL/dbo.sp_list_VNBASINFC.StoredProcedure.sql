/****** Object:  StoredProcedure [dbo].[sp_list_VNBASINFC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_VNBASINFC]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_VNBASINFC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 28/07/2003


CREATE procedure [dbo].[sp_list_VNBASINFC]
                                                                                                                                                                                                                                                               
@vbi_cocde nvarchar(6) 

AS Select 

v.vbi_venno,
v.vbi_vensna,
v.vbi_curcde,
s.ysi_buyrat

 from VNBASINF v, SYSETINF s
 where                                                                                                                                                                                                                                                                 
-- v.vbi_cocde = @vbi_cocde and
 v.vbi_vensts <> 'D' AND

-- s.ysi_cocde =  v.vbi_cocde AND
s.ysi_cde = v.vbi_curcde AND
s.ysi_typ = '06'
 
order by v.vbi_venno





GO
GRANT EXECUTE ON [dbo].[sp_list_VNBASINFC] TO [ERPUSER] AS [dbo]
GO
