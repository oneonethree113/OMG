/****** Object:  StoredProcedure [dbo].[sp_insert_SYSALTQC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SYSALTQC]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SYSALTQC]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_SYSALTQC] 

@yst_cocde	nvarchar(6) = ' ',
@yst_team		nvarchar(50),
@yst_cus	nvarchar(100),
@yst_leader		nvarchar(50),
@yst_prdshp	nvarchar(50),
@yst_smptst	nvarchar(50),
@yst_updusr	nvarchar(30)


AS

declare @cnt int
set @cnt = 0
-- Get latest seq
select @cnt = isnull(max(yst_seq),0) from SYSALTQC 

set @cnt=@cnt+1

INSERT INTO  SYSALTQC

(
yst_team,
yst_cus,
yst_leader,
yst_prdshp,
yst_smptst,

yst_creusr,
yst_updusr,
yst_credat,
yst_upddat,
yst_seq
)

values
(
@yst_team,
@yst_cus,
@yst_leader,
@yst_prdshp,
@yst_smptst,
@yst_updusr,
@yst_updusr,
getdate(),
getdate(),
@cnt
)





GO
GRANT EXECUTE ON [dbo].[sp_insert_SYSALTQC] TO [ERPUSER] AS [dbo]
GO
