/****** Object:  StoredProcedure [dbo].[sp_insert_SAPZPCKINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SAPZPCKINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SAPZPCKINF]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--select zpi_zmatnr,zpi_matnr,zpi_itmdsc,zpi_um2,zpi_inrqty2,zpi_mtrqty2,zpi_cft2,* from SAPZPCKINF  
  
CREATE procedure [dbo].[sp_insert_SAPZPCKINF]   
@RunNO  varchar(20),  
@FileName varchar(255),  
@zpi_matnr varchar(18) ,  
@zpi_zmatnr varchar(18),  
@zpi_plant varchar(4),  
@zpi_itmdsc varchar(40),  
@zpi_lngdsc varchar(255),  
@zpi_typ varchar(1),  
@zpi_vol numeric(13,4),  
@zpi_untvol varchar(3),  
@zpi_len numeric(13,4),  
@zpi_width numeric(13,4),  
@zpi_height numeric(13,4),  
@zpi_untdim varchar(3),  
@zpi_nw numeric(13,4),  
@zpi_gw numeric(13,4),  
@zpi_untwgt varchar(3),  
@zpi_mtrqty numeric(13,4),  
@zpi_untqty varchar(3),  
@zpi_sts varchar(1),  
@zpi_tspcst numeric(13,4),  
@zpi_pckcst numeric(13,4),  
@zpi_cdat datetime,  
@zpi_cusr varchar(12),  
@zpi_udat datetime,  
@zpi_uusr varchar(12),  
@zpi_um2 varchar(20),  
@zpi_inrqty2 varchar(20),  
@zpi_mtrqty2 varchar(20),  
@zpi_cft2 varchar(20),  
@zpi_ZAEHL int,   
@zpi_MSEHT varchar (20) ,  
@zpi_MSEHL varchar (50) ,  
@zpi_cusno varchar(20),
@dummy char(1) = 'X'  
as  
begin  
  
 delete from SAPZPCKINF where zpi_matnr = @zpi_matnr and zpi_zmatnr = @zpi_zmatnr  
  
 insert into SAPZPCKINF (  
  zpi_runno,  
  zpi_filnam,  
  zpi_matnr ,   
  zpi_zmatnr ,   
  zpi_plant ,   
  zpi_itmdsc ,   
  zpi_lngdsc ,   
  zpi_typ ,   
  zpi_vol ,   
  zpi_untvol ,   
  zpi_len ,   
  zpi_width ,   
  zpi_height ,   
  zpi_untdim ,   
  zpi_nw ,   
  zpi_gw ,   
  zpi_untwgt ,   
  zpi_mtrqty ,   
  zpi_untqty ,   
  zpi_sts ,   
  zpi_tspcst ,   
  zpi_pckcst ,   
  zpi_cdat ,   
  zpi_cusr ,   
  zpi_udat ,   
  zpi_uusr ,   
  zpi_um2 ,   
  zpi_inrqty2 ,   
  zpi_mtrqty2 ,   
  zpi_cft2 ,   
  zpi_ZAEHL ,  
  zpi_MSEHT ,  
  zpi_MSEHL ,  
  zpi_cusno,
  zpi_credat ,   
  zpi_creusr ,   
  zpi_upddat ,   
  zpi_updusr  
 )  
 values(  
  @runno,  
  @FileName,  
  @zpi_matnr ,   
  @zpi_zmatnr ,   
  @zpi_plant ,   
  @zpi_itmdsc ,   
  @zpi_lngdsc ,   
  @zpi_typ ,   
  @zpi_vol ,   
  @zpi_untvol ,   
  @zpi_len ,   
  @zpi_width ,   
  @zpi_height ,   
  @zpi_untdim ,   
  @zpi_nw ,   
  @zpi_gw ,   
  @zpi_untwgt ,   
  @zpi_mtrqty ,   
  @zpi_untqty ,   
  @zpi_sts ,   
  @zpi_tspcst ,   
  @zpi_pckcst ,   
  @zpi_cdat ,   
  @zpi_cusr ,   
  @zpi_udat ,   
  @zpi_uusr ,   
  @zpi_um2 ,   
  @zpi_inrqty2 ,   
  @zpi_mtrqty2 ,   
  @zpi_cft2 ,   
  @zpi_ZAEHL ,  
  @zpi_MSEHT ,  
  @zpi_MSEHL ,  
  @zpi_cusno,
  getdate() ,   
  'SAPPCKUPL' ,   
  getdate(),   
  'SAPPCKUPL'  
 )  
end  
  




GO
GRANT EXECUTE ON [dbo].[sp_insert_SAPZPCKINF] TO [ERPUSER] AS [dbo]
GO
