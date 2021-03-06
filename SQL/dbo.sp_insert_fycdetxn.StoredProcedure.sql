/****** Object:  StoredProcedure [dbo].[sp_insert_fycdetxn]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_fycdetxn]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_fycdetxn]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_insert_fycdetxn]

@fyohdr nvarchar(10),
@newfty nvarchar(4),
@tmpflg tinyint,
@usrid nvarchar(30)

AS

declare @itmno nvarchar(20)
declare @oldfty nvarchar(4)

select @itmno = foh_ftyitm, @oldfty = foh_ftycde from fyordhdr where foh_fyohdr = @fyohdr

insert into fycdetxn

(
fci_fyohdr,
fci_itmno,
fci_oldfty,
fci_newfty,
fci_tmpflg,
fci_usrid,
fci_credat,
fci_upddat,
fci_lckflg
)

values

(
@fyohdr,
@itmno,
@oldfty, 
@newfty,
@tmpflg,
@usrid,
DEFAULT,
DEFAULT,
DEFAULT
)

update FYORDHDR set foh_ftycde = @newfty, foh_usrid = @usrid, foh_upddat = getdate()  where foh_fyohdr = @fyohdr








GO
GRANT EXECUTE ON [dbo].[sp_insert_fycdetxn] TO [ERPUSER] AS [dbo]
GO
