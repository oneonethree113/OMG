/****** Object:  StoredProcedure [dbo].[sp_list_VNCSEINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_VNCSEINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_VNCSEINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 28/07/2003


CREATE procedure [dbo].[sp_list_VNCSEINF]
                                                                                                                                                                                                                                                               
@vcs_cocde 	nvarchar(6) ,
@vcs_venno 	nvarchar(6),
@vcs_csetyp	nvarchar(2)
AS
Select 

'   ' as status,
vcs_csenam,
vcs_accno,
vcs_accnam,
vcs_cseadr,
vcs_csestt,
vcs_csecty + ' - ' + ysi_dsc as 'vcs_csecty',
vcs_csezip,
vcs_csectp,
vcs_csetil,
vcs_csephn,
vcs_csefax,
vcs_cseeml,
vcs_csermk,


vcs_csedef,
vcs_creusr,
vcs_csetyp,
vcs_cseseq


from VNCSEINF

left join SYSETINF
	on ysi_typ = '02'  
	--and    vcs_cocde=ysi_cocde 
	and  vcs_csecty = ysi_cde
where                                                                                                                                                                                                                                                                 
--vcs_cocde 	= @vcs_cocde and
vcs_venno 	= @vcs_venno and
vcs_csetyp	= @vcs_csetyp







GO
GRANT EXECUTE ON [dbo].[sp_list_VNCSEINF] TO [ERPUSER] AS [dbo]
GO
