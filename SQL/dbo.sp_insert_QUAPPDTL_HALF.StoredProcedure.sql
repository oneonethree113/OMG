/****** Object:  StoredProcedure [dbo].[sp_insert_QUAPPDTL_HALF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_QUAPPDTL_HALF]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_QUAPPDTL_HALF]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_insert_QUAPPDTL_HALF] 

@qxd_tmpqutno nvarchar(50) ,
@qxd_tmpqutseq INT,
@qxd_pricust nvarchar(30) ,
@qxd_seccust nvarchar(30) ,

@qxd_itmno nvarchar(30),

@qxd_um nvarchar(30),
@qxd_inr nvarchar(30),
@qxd_mtr nvarchar(30),
@qxd_prctrm nvarchar(30),
@qxd_trantrm nvarchar(30),
@qxd_ftyprctrm nvarchar(30),

@qxd_creusr nvarchar(30) ,
@qxd_updusr nvarchar(30),

@qxd_flgtmp nvarchar(1)
AS

insert into	QUAPPDTL
(
qxd_tmpqutno,
qxd_tmpqutseq,

qxd_pricust,
qxd_seccust,

qxd_itmno,
qxd_colcde,

qxd_um, 
qxd_inr, 
qxd_mtr, 
qxd_prctrm, 
qxd_trantrm,
qxd_ftyprctrm,

qxd_creusr,
qxd_updusr,
qxd_credat,
qxd_upddat,
qxd_timstp,
qxd_flgtmp,

-- not core info
qxd_txtyp
 
)
values	(
--rtrim because when insert from jsp, many white space at the end, don't know why
rtrim(@qxd_tmpqutno),
@qxd_tmpqutseq,

rtrim(@qxd_pricust),
rtrim(@qxd_seccust),

rtrim(@qxd_itmno),
'N/A;',

rtrim(@qxd_um), 
rtrim(@qxd_inr), 
rtrim(@qxd_mtr), 
rtrim(@qxd_prctrm), 
rtrim(@qxd_trantrm),
rtrim(@qxd_ftyprctrm),

rtrim(@qxd_creusr),
rtrim(@qxd_updusr),
GETDATE(),
GETDATE(),
Default,
rtrim(@qxd_flgtmp),

--not core info
'New'



)



GO
GRANT EXECUTE ON [dbo].[sp_insert_QUAPPDTL_HALF] TO [ERPUSER] AS [dbo]
GO
