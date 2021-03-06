/****** Object:  StoredProcedure [dbo].[sp_update_SYDISPRM]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SYDISPRM]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SYDISPRM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003



/*
Samuel
*/
------------------------------------------------- 
Create  procedure [dbo].[sp_update_SYDISPRM]

                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ydp_cocde	nvarchar(6) = ' ',
@ydp_type	nvarchar(1),
@ydp_cde	nvarchar(6),
@ydp_dsc	nvarchar(200),
@ydp_account	nvarchar(15),
@ydp_sts	char(1),
@ydp_pca	varchar(15),
@ydp_pcb	varchar(15),
@ydp_updusr	nvarchar(30)

---------------------------------------------- 
 
AS


begin
update sydisprm
--set ydp_cocde= @ydp_cocde,
set 
ydp_type=@ydp_type,
ydp_cde = @ydp_cde,
ydp_dsc = @ydp_dsc,
ydp_account_new = @ydp_account,
ydp_sts = @ydp_sts,
ydp_pca = @ydp_pca,
ydp_pcb = @ydp_pcb,
ydp_upddat = getdate(),
ydp_updusr = @ydp_updusr
--------------------------------- 

 where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- ydp_cocde = @ydp_cocde and 
--ydp_cocde = ' ' and 
ydp_type = @ydp_type and 
ydp_cde = @ydp_cde


                                                           
---------------------------------------------------------- 
end




GO
GRANT EXECUTE ON [dbo].[sp_update_SYDISPRM] TO [ERPUSER] AS [dbo]
GO
