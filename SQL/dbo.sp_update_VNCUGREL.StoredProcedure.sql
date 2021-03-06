/****** Object:  StoredProcedure [dbo].[sp_update_VNCUGREL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_VNCUGREL]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_VNCUGREL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_update_VNCUGREL]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

@vcr_cocde nvarchar(6),
@vcr_venno nvarchar(6),
@vcr_cugrpcde nvarchar(20),
@vcr_flg_ext char(1),
@icf_mrkup decimal(10,5),
@vcr_updusr nvarchar(30)


                                   
----------------------------------- 
AS




update  VNCUGREL set vcr_flg_ext = @vcr_flg_ext , vcr_updusr = @vcr_updusr , vcr_upddat = getdate()
where vcr_venno = @vcr_venno and vcr_cugrpcde = @vcr_cugrpcde



if 
(select count (*) from IMCGCFML where  icf_venno = @vcr_venno and icf_cugrpcde = @vcr_cugrpcde ) > 0 
begin
update  IMCGCFML  set icf_flg_ext = @vcr_flg_ext ,
icf_mrkup =@icf_mrkup, 
icf_updusr = @vcr_updusr , icf_upddat = getdate()
where icf_venno = @vcr_venno and icf_cugrpcde = @vcr_cugrpcde
end 
else
begin
insert into IMCGCFML  
(icf_cocde, icf_venno, icf_cugrpcde, icf_flg_int, icf_flg_ext,icf_mrkup, icf_creusr, icf_updusr, icf_credat, icf_upddat, icf_timstp
)
values
(' ',@vcr_venno,@vcr_cugrpcde,'N',@vcr_flg_ext,@icf_mrkup,@vcr_updusr,@vcr_updusr,getdate(),getdate(),null
)

end 






GO
GRANT EXECUTE ON [dbo].[sp_update_VNCUGREL] TO [ERPUSER] AS [dbo]
GO
