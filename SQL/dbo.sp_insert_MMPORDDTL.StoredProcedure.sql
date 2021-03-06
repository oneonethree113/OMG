/****** Object:  StoredProcedure [dbo].[sp_insert_MMPORDDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_MMPORDDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_MMPORDDTL]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*  
=========================================================  
Program ID :   
Description    :   
Programmer   :   
Create Date    : 2005/08/11  
Last Modified   :   
Table Read(s)  :  
Table Write(s)  :  
=========================================================  
 Modification History                                      
=========================================================  
Date  Author  Description  
=========================================================       
  
*/  
--sp_insert_MMPORDDTL  '','MP0500027'  
  
CREATE PROCEDURE [dbo].[sp_insert_MMPORDDTL]   
  
@Mpd_cocde varchar(6) = '',  
@Mpd_MPONO varchar(20),  
@Mpd_MPOseq int,  
@Mpd_PONo varchar(20),  
@Mpd_POSeq int,  
@Mpd_PODat datetime,  
@Mpd_ShpDat datetime,  
@Mpd_OrgShpDat datetime,  
@Mpd_ReqNo varchar(10),  
@Mpd_VenItm varchar(20),  
@Mpd_ItmNo varchar(20),  
@Mpd_ItmNam varchar(60),  
@Mpd_ItmDsc varchar(30),  
@Mpd_ColCde varchar(14),  
@Mpd_UM varchar(5),  
@Mpd_Qty numeric(9,2),  
@Mpd_ShpQty numeric(9,2),  
@Mpd_UntPrc numeric(9,4),  
@Mpd_MinPrc  numeric(9,4),  
@Mpd_PckMth varchar(8),  
@Mpd_Dept varchar(10),  
@Mpd_PrdNo varchar(100),  
@Mpd_FilNamH varchar(50),  
@Mpd_FilseqH int,  
@Mpd_FilNam varchar(50),  
@Mpd_Filseq int,  
@Mpd_HdrRmk varchar(400),  
@Mpd_Rmk varchar(400),  
@Mpd_CreUsr varchar(30)  
  
AS  
  
--- Get Max Seq Number ----  
declare @maxno as integer  
set @maxno = 0  
set nocount on   
select    
 @maxno = max(isnull(Mpd_MPOseq,0))    
from  
 MPORDDTL  
where  
 Mpd_MPONO = @Mpd_MPONO   
select  @maxno = isnull(@maxno,0)  
select  @maxno = @maxno + 1  
select  @maxno   
set nocount off  
---------------------------  
  
  
if isnull(@Mpd_POSeq,0) <= 0   
begin  
  
select      
 @Mpd_POSeq  = isnull(max(Mpd_POSeq),0) + 1  
from    
 MPORDDTL  (nolock)  
where    
 Mpd_PONO = @Mpd_PONO     
  
end  
  
  
 INSERT INTO  
  MPORDDTL  
  (  
  Mpd_MPONO,  
  Mpd_MPOseq,  
  Mpd_PONo,  
  Mpd_POSeq,  
  Mpd_PODat,  
  Mpd_ShpDat,  
  Mpd_OrgShpDat,  
  Mpd_ReqNo,  
  Mpd_VenItm,  
  Mpd_ItmNo,  
  Mpd_ItmNam,  
  Mpd_ItmDsc,  
  Mpd_ColCde,  
  Mpd_UM,  
  Mpd_Qty,  
  Mpd_ShpQty,  
  Mpd_UntPrc,  
  Mpd_MinPrc,  
  Mpd_PckMth,  
  Mpd_Dept,  
  Mpd_PrdNo,  
  Mpd_FilNamH,  
  Mpd_FilseqH,  
  Mpd_FilNam,  
  Mpd_Filseq,  
  Mpd_HdrRmk,  
  Mpd_Rmk,  
  Mpd_CreDat,  
  Mpd_CreUsr,  
  Mpd_UpdDat,  
  Mpd_UpdUsr  
  )  
 values  
  (  
  @Mpd_MPONO,  
  --@Mpd_MPOseq,  
  @maxno ,  
  @Mpd_PONo,  
  @Mpd_POSeq,  
  @Mpd_PODat,  
  @Mpd_ShpDat,  
  @Mpd_OrgShpDat,  
  @Mpd_ReqNo,  
  @Mpd_VenItm,  
  @Mpd_ItmNo,  
  @Mpd_ItmNam,  
  @Mpd_ItmDsc,  
  @Mpd_ColCde,  
  @Mpd_UM,  
  @Mpd_Qty,  
  @Mpd_ShpQty,  
  @Mpd_UntPrc,  
  @Mpd_MinPrc,  
  @Mpd_PckMth,  
  @Mpd_Dept,  
  @Mpd_PrdNo,  
  @Mpd_FilNamH,  
  @Mpd_FilseqH,  
  @Mpd_FilNam,  
  @Mpd_Filseq,  
  @Mpd_HdrRmk,  
  @Mpd_Rmk,  
  getdate(),  
  @Mpd_CreUsr,  
  getdate(),  
  @Mpd_CreUsr  
  )  
  




GO
GRANT EXECUTE ON [dbo].[sp_insert_MMPORDDTL] TO [ERPUSER] AS [dbo]
GO
