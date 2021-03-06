/****** Object:  StoredProcedure [dbo].[sp_insert_TOORDHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_TOORDHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_TOORDHDR]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE   PROCEDURE [dbo].[sp_insert_TOORDHDR]
@toh_cocde nvarchar(6),
@toh_toordno nvarchar(20),
@toh_ordsts nvarchar(20),
@toh_issdat datetime,
@toh_rvsdat datetime,
@toh_verno int,
@toh_saldiv nvarchar(20),
@toh_saltem nvarchar(20),
@toh_salrep nvarchar(30),
@toh_custcde nvarchar(10),
@toh_buyer nvarchar(10),
@toh_year nvarchar(4),
@toh_cus1no nvarchar(6),
@toh_cus2no nvarchar(6),
@toh_refqut nvarchar(20),
@toh_to nvarchar(200),
@toh_cc nvarchar(200),
@toh_fm nvarchar(200),
@toh_rmk nvarchar(400),
@toh_season nvarchar(20),
@usrid nvarchar(30)	

AS

insert into TOORDHDR
(
toh_cocde  ,
 toh_toordno, 
 toh_ordsts  ,
 toh_issdat,
 toh_rvsdat,
toh_verno,
 toh_saldiv , 
 toh_saltem,  
 toh_salrep  ,
 toh_custcde,  
 toh_buyer  ,
 toh_year  ,
 toh_cus1no,  
 toh_cus2no , 
 toh_refqut  ,
 toh_to  ,
 toh_cc  ,
 toh_fm  ,
 toh_rmk , 
 toh_season,  
toh_creusr,
toh_updusr,
toh_credat,
toh_upddat
)
values
(
@toh_cocde , 
 @toh_toordno, 
 @toh_ordsts  ,
 @toh_issdat,
 @toh_rvsdat,
@toh_verno,
 @toh_saldiv , 
 @toh_saltem,  
 @toh_salrep  ,
 @toh_custcde,  
 @toh_buyer  ,
 @toh_year  ,
 @toh_cus1no,  
 @toh_cus2no , 
 @toh_refqut  ,
 @toh_to  ,
 @toh_cc  ,
 @toh_fm  ,
 @toh_rmk , 
 @toh_season,  
@usrid,
@usrid,
getdate(),
getdate()
)






GO
GRANT EXECUTE ON [dbo].[sp_insert_TOORDHDR] TO [ERPUSER] AS [dbo]
GO
