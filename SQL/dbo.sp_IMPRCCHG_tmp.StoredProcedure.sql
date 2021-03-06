/****** Object:  StoredProcedure [dbo].[sp_IMPRCCHG_tmp]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_IMPRCCHG_tmp]
GO
/****** Object:  StoredProcedure [dbo].[sp_IMPRCCHG_tmp]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO











/*
=========================================================
Program ID	: 	sp_IMPRCCHG_tmp
Description   	: 	Temporary placement of price change reason
			to be inserted into IMPRCCHG
Programmer  	: 	David Yue
Date Created	:	2012-08-20
=========================================================
 Modification History                                    
=========================================================

=========================================================     
*/


CREATE  PROCEDURE [dbo].[sp_IMPRCCHG_tmp]

@cocde as nvarchar(6),
@itmno as nvarchar(20),
@venno as nvarchar(6),
@prdven as nvarchar(6),
@pckunt as nvarchar(6),
@inrqty as int,
@mtrqty as int,
@cus1no as nvarchar(6),
@cus2no as nvarchar(6),
@ftyprctrm as nvarchar(10),
@hkprctrm as nvarchar(10),
@trantrm as nvarchar(10),
@chgreason as nvarchar(800),
@creusr as nvarchar(30)

AS

set nocount on

insert into IMPRCCHG_tmp
(	ipc_cocde,		ipc_itmno,		ipc_venno,
	ipc_prdven,		ipc_pckunt,		ipc_inrqty,
	ipc_mtrqty,		ipc_cus1no,		ipc_cus2no,
	ipc_ftyprctrm,		ipc_hkprctrm,		ipc_trantrm,
	ipc_chgreason,		ipc_creusr,		ipc_credat
)
values
(	@cocde,			@itmno,			@venno,
	@prdven,		@pckunt,		@inrqty,
	@mtrqty,		@cus1no,		@cus2no,
	@ftyprctrm,		@hkprctrm,		@trantrm,
	@chgreason,		@creusr,		getdate()
)


set nocount off




GO
GRANT EXECUTE ON [dbo].[sp_IMPRCCHG_tmp] TO [ERPUSER] AS [dbo]
GO
