/****** Object:  StoredProcedure [dbo].[sp_update_SYSALTQC]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SYSALTQC]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SYSALTQC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_update_SYSALTQC] 
	-- Add the parameters for the stored procedure here
	@yst_cocde	nvarchar(6) = ' ',
	@yst_team		nvarchar(50),
	@yst_cus	nvarchar(100),
	@yst_leader		nvarchar(50),
	@yst_prdshp	nvarchar(50),
	@yst_smptst	nvarchar(50),
	@yst_updusr	nvarchar(30),
	@yst_seq BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE SYSALTQC
	SET 
	yst_team	=@yst_team	,
	yst_cus		=@yst_cus	,
	yst_leader	=@yst_leader,
	yst_prdshp	=@yst_prdshp,
	yst_smptst	=@yst_smptst,
	yst_updusr	=@yst_updusr
	where 
	yst_seq		=@yst_seq
END



GO
GRANT EXECUTE ON [dbo].[sp_update_SYSALTQC] TO [ERPUSER] AS [dbo]
GO
