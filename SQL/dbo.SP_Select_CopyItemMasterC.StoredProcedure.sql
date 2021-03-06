/****** Object:  StoredProcedure [dbo].[SP_Select_CopyItemMasterC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[SP_Select_CopyItemMasterC]
GO
/****** Object:  StoredProcedure [dbo].[SP_Select_CopyItemMasterC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- Don't Delete Company Code !!    
    
/*    
=========================================================    
Program ID : SP_Select_CopyItemMasterC    
Description    : Copy Item Master    
Programmer   : PIC    
Create Date    :     
Last Modified   :     
Table Read(s)  :    
Table Write(s)  :    
=========================================================    
 Modification History                                        
=========================================================    
 Date      Initial   Description                              
=========================================================        
21/03/2003 Allan Yuen    Fix Copy BOM Item Error    
17/07/2003 Allan Yuen Modify for Merge Project    
01/09/2004 Allan Yuen Add copy wasgate %    
01/13/2005 Allan Yuen  Fix Copy Item if formula change    
01/25/2005 Allan Yuen  Adjust Item Cost, Calculated Item Cost, Negotiated Item Cost from decimal point 4 to 2    
03/17/2005 Allan Yuen Add Company Code in IMBASINF    
05/12/2005 Lester Wu  Not copy Image Pth    
05/23/2005 Allan Yuen Add Custom Vendor Code    
07/15/2005 Allan Yuen Add product develop item no, mbcode, mbname    
09/15/2005 Lester Wu  Trim Vendor Item No    
01/23/2006 Allan Yuen Add Factory Price Term    
03/09/2006 Allan Yuen Add Product Type    
21 June 2006 Marco Chan  FtyBOMCst new calculation method with real storage    
31/08/2006 Lester Wu The item copied from an item with product type "Otehr" should not be "Other"  
*/    
    
    
    
CREATE PROCEDURE [dbo].[SP_Select_CopyItemMasterC]     
    
@cocde nvarchar(6),    
@ibi_itmno nvarchar(20),    
@ivi_venitm nvarchar(20),    
@ibi_lnecde nvarchar(10),    
@ibi_catlvl4 nvarchar(20),    
@fyi_fmlopt nvarchar(5),    
@ibi_newitm nvarchar(20),    
@VendorType char(1),    
@UsrID nvarchar(30) = 'SYS-COPY'    
    
    
AS                                                                                                                                                                                                                                                             
  
      
                                                                                                                                                                                                                                                               
  
    
DECLARE  @Colcde nvarchar(2),    
  @Price nvarchar(2),    
  @Packing nvarchar(2),    
  @ibi_itmsts nvarchar(6),    
  @ibi_venno nvarchar(6),    
  @imu_typ  nvarchar(6)    
BEGIN     
    
 --Lester Wu , Trim Vendor Item No    
 SET @ivi_venitm = Ltrim(Rtrim(Replace(Replace(@ivi_venitm,char(10),''),char(13),'')));    
    
 BEGIN      
  DECLARE cur_itmno CURSOR    
  FOR SELECT    
  ibi_itmno, ibi_venno    
  FROM IMBASINF    
  WHERE      
   --ibi_cocde = @cocde and     
   ibi_itmno = @ibi_itmno    
  ORDER BY ibi_itmno    
      
  OPEN cur_itmno    
  FETCH NEXT FROM cur_itmno INTO    
  @ibi_itmno, @ibi_venno    
      
  WHILE @@fetch_status = 0    
  BEGIN    
  --*****************************************************************************    
  --***************************IMBASINF***************************************    
  --*****************************************************************************    
   INSERT INTO IMBASINF    
   (ibi_cocde,  ibi_itmno,  ibi_orgitm,  ibi_lnecde, ibi_prdtyp,    
   ibi_curcde,  ibi_catlvl0,  ibi_catlvl1,  ibi_catlvl2,    
   ibi_catlvl3,  ibi_catlvl4,  ibi_itmsts,  ibi_typ,    
   ibi_engdsc,  ibi_chndsc,  ibi_venno,  ibi_cusven,    
   ibi_imgpth,    
   ibi_hamusa, ibi_hameur, ibi_dtyusa,  ibi_dtyeur,    
   ibi_cosmth, ibi_rmk,  ibi_tirtyp,  ibi_moqctn,    
   ibi_qty,  ibi_moa,  ibi_prvsts,      
--   ibi_latrdat,    
   ibi_wastage,     
--ibi_pditmno, ibi_mbcde,  ibi_mbname, 
   ibi_itmnat,   
	ibi_dsgno,
	ibi_finishing,
	ibi_material,
	ibi_prdsizeTyp,
	ibi_prdsizeUnt,
	ibi_prdsizeVal,
	ibi_moqunttyp,
	ibi_prdicon,
	ibi_prdgrp,
	ibi_imgpthhr,

   ibi_creusr,  ibi_updusr,  ibi_credat,  ibi_upddat)    
    
   SELECT     

   --ibi_cocde, @ibi_newitm, ibi_orgitm, @ibi_lnecde,    
--   ' ',  @ibi_newitm, ibi_orgitm, @ibi_lnecde,    
   @cocde,  @ibi_newitm, ibi_orgitm, @ibi_lnecde, --ibi_prdtyp,  
case @VendorType when 'E' then   
   case rtrim(ltrim(ibi_prdtyp)) when '' then '*' else  ibi_prdtyp end   
else ibi_prdtyp end as 'ibi_prdtyp',    
   ibi_curcde,  ibi_catlvl0,  ibi_catlvl1,  ibi_catlvl2,    
   ibi_catlvl3,  @ibi_catlvl4,     
--   (case ibi_itmsts when 'HLD' then ibi_prvsts else  ibi_itmsts end),     
-- AY Change the status to default 'TBC' after copy    
   'TBC',    
   ibi_typ,    
   ibi_engdsc,  ibi_chndsc,  ibi_venno,  ibi_cusven,    
   '', --ibi_imgpth,    
   ibi_hamusa, ibi_hameur, ibi_dtyusa,  ibi_dtyeur,    
   ibi_cosmth, ibi_rmk,  ibi_tirtyp,  ibi_moqctn,    
   ibi_qty,  ibi_moa,  ibi_prvsts,      
   ibi_wastage,     
--ibi_pditmno, ibi_mbcde,  ibi_mbname,    
--   ibi_latrdat,    
--   ibi_creusr,  ibi_updusr,  ibi_credat,  ibi_upddat     
   ibi_itmnat,
	ibi_dsgno,
	ibi_finishing,
	ibi_material,
	ibi_prdsizeTyp,
	ibi_prdsizeUnt,
	ibi_prdsizeVal,
	ibi_moqunttyp,
	ibi_prdicon,
	ibi_prdgrp,
	'',

   @UsrID,  @UsrID,  getdate(),  getdate()    
   FROM IMBASINF    
   WHERE     
    ibi_itmno = @ibi_itmno --AND ibi_cocde = @cocde    
   --Check Status    
   if (Select count(*) From IMCOLINF where     
     --icf_cocde = @cocde and     
     icf_itmno = @ibi_itmno) > 0     
    SET @Colcde = 'Y'    
   else    
    SET @Colcde = 'N'    
   if (Select count(*) From IMPCKINF where     
     --ipi_cocde = @cocde and     
     ipi_itmno = @ibi_itmno) > 0     
    SET @Packing = 'Y'    
   else    
    SET @Packing = 'N'    
   if (Select count(*) From IMMRKUP where     
     --imu_cocde = @cocde and     
     imu_itmno = @ibi_itmno and     
     imu_basprc = 0 and     
     imu_ventyp = 'D') > 0    
    SET @Price = 'N'    
   else    
    SET @Price = 'Y'    
    
   /*    
   IF @Colcde = 'Y' and @Packing = 'Y' and @Price = 'Y'     
    SET @ibi_itmsts = 'CMP'    
   Else    
    SET @ibi_itmsts = 'INC'    
   */    
   SET @ibi_itmsts = 'TBC'    
    
   UPDATE IMBASINF SET ibi_itmsts = @ibi_itmsts    
   WHERE ibi_itmno = @ibi_newitm --AND ibi_cocde = @cocde    
          
       
  --*****************************************************************************    
  --***************************IMBOMASS**************************************    
  --*****************************************************************************    
       
   INSERT INTO IMBOMASS    
   (iba_cocde,  iba_itmno,  iba_assitm,  iba_typ,    
   iba_colcde,  iba_pckunt,  iba_bomqty, iba_inrqty,    
   iba_mtrqty,  iba_curcde,  iba_fmlopt,  iba_bombasprc,    
   iba_creusr,  iba_updusr, iba_credat,  iba_upddat,      
   iba_altitmno, iba_costing, iba_genpo,  iba_untcst,    
   iba_fcurcde, iba_ftycst)    
   SELECT     
   --iba_cocde, @ibi_newitm, iba_assitm, iba_typ,    
   ' ',  @ibi_newitm, iba_assitm,  iba_typ,    
   iba_colcde,  iba_pckunt,  iba_bomqty, iba_inrqty,    
   iba_mtrqty,  iba_curcde,  iba_fmlopt,  iba_bombasprc,    
--   iba_creusr,  iba_updusr, iba_credat,  iba_upddat,     
   @UsrID,  @UsrID,  getdate(),  getdate(),    
   iba_altitmno, iba_costing, iba_genpo,  iba_untcst,    
   iba_fcurcde, iba_ftycst    
   FROM IMBOMASS    
   WHERE iba_itmno = @ibi_itmno --AND iba_cocde = @cocde       
    
      
  --*****************************************************************************    
  --***************************IMCOLINF***************************************    
  --*****************************************************************************    
    
       
   INSERT INTO IMCOLINF    
   (icf_cocde,  icf_itmno,  icf_colcde,  icf_colseq,    
   icf_vencol,  icf_coldsc,  icf_typ,  icf_ucpcde,    
   icf_eancde,      
   icf_creusr,  icf_updusr,  icf_credat,  icf_upddat,      
   icf_asscol,  icf_swatchpath, icf_imgpath, icf_venno,    
   icf_lnecde)    
   SELECT     
   --icf_cocde, @ibi_newitm, icf_colcde,  icf_colseq,    
   ' ',  @ibi_newitm, icf_colcde,  icf_colseq,    
   icf_vencol,  icf_coldsc,  icf_typ,  icf_ucpcde,    
   icf_eancde,      
   --icf_creusr, icf_updusr,  icf_credat,  icf_upddat,      
   @UsrID,   @UsrID,  getdate(),  getdate(),    
   icf_asscol,  icf_swatchpath, icf_imgpath, icf_venno,    
   icf_lnecde    
   FROM IMCOLINF    
   WHERE icf_itmno = @ibi_itmno --AND icf_cocde = @cocde      
       
      
  --*****************************************************************************    
  --***************************IMCTYINF***************************************    
  --*****************************************************************************    
         
   INSERT INTO IMCTYINF    
   (ici_cocde,  ici_itmno,  ici_ctyseq,  ici_ctycde,    
   ici_cusno,  ici_valdat,  ici_rmk,  ici_creusr,    
   ici_updusr,  ici_credat,  ici_upddat)    
   SELECT     
   --ici_cocde, @ibi_newitm, ici_ctyseq, ici_ctycde,    
   ' ',  @ibi_newitm, ici_ctyseq,  ici_ctycde,    
   ici_cusno,  ici_valdat,  ici_rmk,      
--   ici_creusr,  ici_updusr,  ici_credat,  ici_upddat    
   @UsrID,   @UsrID,  getdate(),  getdate()    
   FROM IMCTYINF    
   WHERE ici_itmno = @ibi_itmno --AND ici_cocde = @cocde       
       
      
  --*****************************************************************************    
  --***************************IMMATBKD***************************************    
  --*****************************************************************************    
       
   INSERT INTO IMMATBKD    
   (ibm_cocde, ibm_itmno, ibm_matseq, ibm_mat,
    ibm_curcde, ibm_cst, ibm_cstper, ibm_wgtper,
    ibm_creusr, ibm_updusr, ibm_credat, ibm_upddat)    
       
   SELECT     
   ' ',  @ibi_newitm, ibm_matseq, ibm_mat,
   ibm_curcde, ibm_cst, ibm_cstper, ibm_wgtper,
   @UsrID,   @UsrID,  getdate(),  getdate()    
   FROM IMMATBKD    
   WHERE ibm_itmno = @ibi_itmno --AND ibm_cocde = @cocde    
       
      
  --*****************************************************************************    
  --***************************IMMRKUP***************************************    
  --*****************************************************************************    
   -- Checking the Item Type First --    
   select @imu_typ = imu_typ FROM IMMRKUP WHERE imu_itmno = @ibi_itmno --AND imu_cocde = @cocde     
   ----------------------------------------    
   if @imu_typ = 'BOM'     
      begin    
    INSERT INTO IMMRKUP    
    (imu_cocde, imu_itmno, imu_typ,  imu_ventyp,    
    imu_venno, imu_prdven, imu_pckseq, imu_pckunt,     
    imu_inrqty, imu_mtrqty, imu_cft,  imu_curcde,     
    imu_prctrm, imu_relatn, imu_fmlopt, imu_ftycst,     
    imu_ftyprc, imu_calftyprc, imu_bcurcde, imu_basprc,     
    imu_negprc, imu_alsbasprc, imu_itmprc, imu_bomprc,    
    imu_creusr, imu_updusr, imu_credat, imu_upddat,     
    imu_bomcst, imu_ttlcst, imu_ftyprctrm, imu_ftybomcst,
    imu_conftr
-- Frankie Cheung 20100419 Add Cost Change date
    ,imu_cstchgdat	

) 
    SELECT     
    --imu_cocde, @ibi_newitm, imu_typ,  imu_ventyp,    
    ' ',  @ibi_newitm, imu_typ,  imu_ventyp,    
    imu_venno, imu_prdven, imu_pckseq, imu_pckunt,     
    imu_inrqty, imu_mtrqty, imu_cft,  imu_curcde,     
--    imu_prctrm, imu_relatn,  (CASE @cocde WHEN 'UCPP' THEN @fyi_fmlopt ELSE imu_fmlopt END), imu_ftycst,     
    imu_prctrm, imu_relatn,  (CASE @VendorType WHEN 'I' THEN @fyi_fmlopt WHEN 'J' THEN @fyi_fmlopt  ELSE imu_fmlopt END), imu_ftycst,     
--    imu_ftyprc, imu_calftyprc, imu_bcurcde, imu_basprc,     
    round(imu_ftyprc,2), imu_calftyprc, imu_bcurcde, imu_basprc,    
    imu_negprc, imu_alsbasprc, imu_itmprc, imu_bomprc,    
--    imu_creusr, imu_updusr, imu_credat, imu_upddat,    
    @UsrID,   @UsrID,  getdate(),  getdate(),     
    imu_bomcst, imu_ttlcst,  imu_ftyprctrm, imu_ftybomcst,
    imu_conftr
-- Frankie Cheung 20100419 Add Cost Change date
    ,imu_cstchgdat	
    FROM IMMRKUP    
    WHERE     
     imu_itmno = @ibi_itmno AND     
     --imu_cocde = @cocde AND     

    imu_venno in (SELECT     
       ibi_venno     
           FROM     
       IMBASINF     
           WHERE     
       --ibi_cocde = @cocde and     
       ibi_itmno = imu_itmno)     
    --Kenny Corrected on 19-11-2002    
    -- Allan Yuen Remark this option (BOM Item Don't have Production Vendor)    
    --and imu_prdven in (SELECT ibi_venno FROM IMBASINF WHERE ibi_cocde = @cocde and ibi_itmno = imu_itmno)     
    -- ------------------------------------------    
 --   imu_ventyp = 'D' OR imu_venno IN (SELECT imu_venno FROM  IMMRKUP    
  --  WHERE imu_itmno = @ibi_itmno AND imu_cocde = @cocde AND imu_ventyp = 'D')    
      end    
   else    
      begin    
    INSERT INTO IMMRKUP    
    (imu_cocde, imu_itmno, imu_typ,  imu_ventyp,    
    imu_venno, imu_prdven, imu_pckseq, imu_pckunt,     
    imu_inrqty, imu_mtrqty, imu_cft,  imu_curcde,     
    imu_prctrm, imu_relatn,  imu_fmlopt, imu_ftycst,     
    imu_ftyprc, imu_calftyprc, imu_bcurcde, imu_basprc,     
    imu_negprc, imu_alsbasprc, imu_itmprc, imu_bomprc,    
    imu_creusr, imu_updusr, imu_credat, imu_upddat,    
    imu_bomcst, imu_ttlcst,  imu_ftyprctrm, imu_ftybomcst,
    imu_conftr
-- Frankie Cheung 20100419 Add Cost Change Date
    ,imu_cstchgdat
)
    SELECT     
    --imu_cocde, @ibi_newitm, imu_typ,  imu_ventyp,    
    ' ',  @ibi_newitm, imu_typ,  imu_ventyp,    
    imu_venno, imu_prdven, imu_pckseq, imu_pckunt,     
    imu_inrqty, imu_mtrqty, imu_cft,  imu_curcde,     
--    imu_prctrm, imu_relatn,  (CASE @cocde WHEN 'UCPP' THEN @fyi_fmlopt ELSE imu_fmlopt END), imu_ftycst,     
    imu_prctrm, imu_relatn,  (CASE @VendorType WHEN 'I' THEN @fyi_fmlopt WHEN 'J' THEN @fyi_fmlopt  ELSE imu_fmlopt END), imu_ftycst,     
--    imu_ftyprc, imu_calftyprc, imu_bcurcde, imu_basprc,     
    round(imu_ftyprc,2), round(imu_calftyprc,2), imu_bcurcde, imu_basprc,     
--    imu_negprc,  imu_alsbasprc, imu_itmprc, imu_bomprc,    
    round(imu_negprc,2),  imu_alsbasprc, imu_itmprc, imu_bomprc,    
--    imu_creusr, imu_updusr, imu_credat, imu_upddat,    
    @UsrID,  @UsrID,  getdate(),  getdate(),    
--    imu_bomcst, imu_ttlcst     
    round(imu_bomcst,2), round(imu_ttlcst,2), imu_ftyprctrm, imu_ftybomcst,
    imu_conftr
-- Frankie Cheung 20100419 Add Cost Change Date
    ,imu_cstchgdat
    FROM IMMRKUP    
    WHERE     
     imu_itmno = @ibi_itmno and    
     --AND imu_cocde = @cocde AND     
     imu_venno in (SELECT     
        ibi_venno     
            FROM     
        IMBASINF     
            WHERE     
        --ibi_cocde = @cocde and     
        ibi_itmno = imu_itmno    
            )     
    --Kenny Corrected on 19-11-2002    
    and imu_prdven in (SELECT     
        ibi_venno     
         FROM     
        IMBASINF     
         WHERE     
        --ibi_cocde = @cocde and     
        ibi_itmno = imu_itmno    
        )     
    --imu_ventyp = 'D' OR imu_venno IN (SELECT imu_venno FROM  IMMRKUP    
    --WHERE imu_itmno = @ibi_itmno AND imu_cocde = @cocde AND imu_ventyp = 'D')    
      end    
   IF @cocde = 'UCPP'    
   BEGIN    
    declare @sql nvarchar(2000),    
    @s nvarchar(200)    
     
    select     
     @s = yfi_fml     
    from     
     syfmlinf     
    where     
     --yfi_cocde = @cocde and    
     yfi_cocde = ' ' and     
     yfi_fmlopt = @fyi_fmlopt    
        
    
    --- Update Item Price ---    
    set @sql = 'DECLARE @n numeric(13,4),    
    @r numeric(13,4);    
    select @n = 1' + @s + ';    
--    UPDATE i SET i.imu_basprc = i.imu_ftyprc * s.ysi_selrat * @n     
    UPDATE i SET i.imu_itmprc = i.imu_ttlcst * s.ysi_selrat * @n     
    FROM IMMRKUP i, SYSETINF s    
    WHERE i.imu_itmno = ''' + @ibi_newitm + ''' AND     
    --i.imu_cocde = ''' + @cocde + ''' AND    
    --s.ysi_cocde = i.imu_cocde AND    
    s.ysi_cocde = '' '' AND    
    s.ysi_typ = ''06'' AND     
    s.ysi_cde = imu_curcde;    
    '    
    exec (@sql)    
    
    
    --- Update Basic Price Price ---    
    set @sql = 'UPDATE i set i.imu_basprc = i.imu_itmprc + i.imu_bomprc    
    FROM IMMRKUP i, SYSETINF s    
    WHERE i.imu_itmno = ''' + @ibi_newitm + ''' AND     
    --i.imu_cocde = ''' + @cocde + ''' AND    
    --s.ysi_cocde = i.imu_cocde AND    
    s.ysi_cocde = '' '' AND    
    s.ysi_typ = ''06'' AND     
    s.ysi_cde = imu_curcde;    
    '    
    exec (@sql)    
    
    
   --*****************************************************************************     
       
   DECLARE @imu_venno nvarchar(6),    
    @imu_degvenno nvarchar(6),    
    @ymf_fmlopt nvarchar(5),    
    @imu_basprc numeric(13,4),    
    @imu_fmlopt nvarchar(5),    
    @imu_pckunt nvarchar(6),    
    @imu_inrqty int,    
    @imu_mtrqty int,    
    @imu_cft numeric(11,4),    
    @imu_ftyprc numeric(13,4)    
        
    DECLARE cur_degven CURSOR    
    FOR SELECT     
     distinct     
      imu_venno,    
      imu_basprc,    
      imu_fmlopt,    
      imu_pckunt,    
      imu_inrqty,    
    
      imu_mtrqty,    
      imu_cft,    
      imu_ftyprc    
        FROM     
     IMMRKUP    
        WHERE     
      imu_itmno = @ibi_newitm AND     
      --imu_cocde = @cocde AND    
      imu_ventyp = 'D'    
        
    OPEN cur_degven    
    FETCH NEXT FROM cur_degven INTO    
    @imu_degvenno,    
    @imu_basprc,    
    @imu_fmlopt,    
    @imu_pckunt,    
    @imu_inrqty,    
    @imu_mtrqty,    
    @imu_cft,    
    @imu_ftyprc    
        
    WHILE @@fetch_status = 0    
    BEGIN     
           
     DECLARE cur_immrkup CURSOR    
     FOR     
      SELECT    
       imu_venno    
      FROM     
       IMMRKUP    
      WHERE     
       imu_itmno = @ibi_newitm AND     
       --imu_cocde = @cocde AND    
       imu_ventyp = 'P' AND     
       imu_venno = @imu_degvenno    
            
     OPEN cur_immrkup    
     FETCH NEXT FROM cur_immrkup INTO    
     @imu_venno    
         
     WHILE @@fetch_status = 0    
     BEGIN     
      IF @cocde = 'UCPP'    
      BEGIN    
       SELECT     
        @ymf_fmlopt = ymf_fmlopt     
       FROM     
        SYMRKFML     
       WHERE    
        --ymf_cocde = @cocde AND    
        ymf_cocde = ' ' AND    
        ymf_prdvenno = @imu_venno AND    
        ymf_degvenno = @imu_degvenno AND    
        ymf_mkpopt = @imu_fmlopt    
      END    
      ELSE    
      BEGIN    
       SELECT     
        @ymf_fmlopt = yvf_fmlopt    
       FROM     
        SYVENFML     
       WHERE    
        --yvf_cocde = @cocde AND    
        yvf_cocde = ' ' AND    
        yvf_venno = @imu_venno    
      END     
          
      IF @@rowcount > 0    
      BEGIN    
       select     
        @s = yfi_fml     
       from     
        syfmlinf     
       where     
        --yfi_cocde = @cocde and    
        yfi_cocde = ' ' and    
        yfi_fmlopt = @ymf_fmlopt    
      END    
     
      IF @@rowcount = 0     
      BEGIN    
       SET @s = '*0'    
       SET @ymf_fmlopt = 'PDV'    
    
       --IF @imu_venno = @imu_degvenno     
        
      END    
        
               
      set @sql = 'DECLARE @n numeric(13,4),    
      @r numeric(13,4);    
      select @n = 1' + @s + ';    
      UPDATE i SET i.imu_basprc = ' + STR(@imu_basprc,13,4) + ','    
    
      IF @imu_venno = @imu_degvenno     
      BEGIN    
       set @sql = @sql + 'i.imu_calftyprc = round(' + str(@imu_ftyprc,13,4) + ',2) ,'    
      END    
      ELSE    
      BEGIN    
       set @sql = @sql + 'i.imu_calftyprc = round((' + str(@imu_basprc,13,4) + ' * s.ysi_selrat * @n),2),'    
      END    
          
      set @sql = @sql + 'i.imu_fmlopt = ''' + @ymf_fmlopt + '''     
      FROM IMMRKUP i, SYSETINF s     
      WHERE     
      i.imu_itmno = ''' + @ibi_newitm + ''' AND    
      --i.imu_cocde = ''' + @cocde + ''' AND    
      --s.ysi_cocde = i.imu_cocde AND    
      s.ysi_cocde = '' '' AND    

      imu_pckunt = ''' + @imu_pckunt  + ''' AND    
      imu_inrqty = ' + str(@imu_inrqty) + ' AND    
      imu_mtrqty = ' + str(@imu_mtrqty) + ' AND    
      imu_cft = ' + str(@imu_cft,11,4) + ' AND    
      imu_venno = ''' + @imu_venno + ''' AND    
      imu_ventyp = ''P'' AND    
      s.ysi_typ = ''06'' AND    
      s.ysi_cde = imu_bcurcde;    
      '    
        
    
      exec (@sql)    
         
      FETCH NEXT FROM cur_immrkup INTO    
      @imu_venno    
     END    
        
     CLOSE cur_immrkup    
     DEALLOCATE cur_immrkup    
        
     FETCH NEXT FROM cur_degven INTO    
     @imu_degvenno,    
     @imu_basprc,    
     @imu_fmlopt,    
     @imu_pckunt,    
     @imu_inrqty,    
     @imu_mtrqty,    
     @imu_cft,    
     @imu_ftyprc    
    END    
       
    CLOSE cur_degven    
    DEALLOCATE cur_degven     
   END    
  --*****************************************************************************     
       
  --*****************************************************************************    
  --***************************IMPCKINF***************************************    
  --*****************************************************************************    
       
   INSERT INTO IMPCKINF    
   (ipi_cocde,  ipi_itmno,  ipi_pckseq,  ipi_pckunt,    
   ipi_mtrqty,  ipi_inrqty,  ipi_inrhin,  ipi_inrwin,    
   ipi_inrdin,  ipi_inrhcm,  ipi_inrwcm, ipi_inrdcm,    
   ipi_mtrhin,  ipi_mtrwin, ipi_mtrdin,  ipi_mtrhcm,    
   ipi_mtrwcm, ipi_mtrdcm, ipi_cft,  ipi_cbm,    
   ipi_grswgt,  ipi_netwgt,  ipi_pckitr,      
   ipi_creusr,  ipi_updusr,  ipi_credat,  ipi_upddat,
   ipi_conftr, ipi_cusno
-- Frankie Cheung 20100419
   ,ipi_qutdat 

)   
   SELECT     
--   ipi_cocde,  @ibi_newitm, ipi_pckseq,  ipi_pckunt,    
   ' ',  @ibi_newitm, ipi_pckseq,  ipi_pckunt,    
   ipi_mtrqty,  ipi_inrqty,  ipi_inrhin,  ipi_inrwin,    
   ipi_inrdin,  ipi_inrhcm,  ipi_inrwcm, ipi_inrdcm,    
   ipi_mtrhin,  ipi_mtrwin, ipi_mtrdin,  ipi_mtrhcm,    
   ipi_mtrwcm, ipi_mtrdcm, ipi_cft,  ipi_cbm,    
   ipi_grswgt,  ipi_netwgt,  ipi_pckitr,      
--   ipi_creusr,  ipi_updusr,  ipi_credat,  ipi_upddat    
   @UsrID,  @UsrID,  getdate(),  getdate(),
   ipi_conftr, ipi_cusno   
-- Frankie Cheung 20100419
   ,ipi_qutdat 
   FROM     
    IMPCKINF    
   WHERE     
    ipi_itmno = @ibi_itmno     
    --AND ipi_cocde = @cocde    
       
       
  --*****************************************************************************    
  --***************************IMSALBKG*************************************    
  --*****************************************************************************    
   /*    
   INSERT INTO IMSALBKG     (isb_cocde, isb_itmno, isb_yymm, isb_mtdbok,    
   isb_mtdsal, isb_mtdpur, isb_creusr, isb_updusr,    
   isb_credat, isb_upddat)    
   SELECT     
   isb_cocde, @ibi_newitm, isb_yymm, isb_mtdbok,    
   isb_mtdsal, isb_mtdpur, isb_creusr, isb_updusr,    
   isb_credat, isb_upddat    
   FROM IMSALBKG    
   WHERE isb_itmno = @ibi_itmno AND isb_cocde = @cocde    
   */    
      
  --*****************************************************************************    
  --***************************IMVENINF***************************************    
  --*****************************************************************************    
       
   INSERT INTO IMVENINF    
   (ivi_cocde,  ivi_itmno,  ivi_venitm,  ivi_venno,    
   ivi_def,  ivi_subcde,  ivi_creusr,  ivi_updusr,    
   ivi_credat,  ivi_upddat)    
   SELECT     
    ivi_cocde,  @ibi_newitm, @ivi_venitm, ivi_venno,    
    'Y',  ivi_subcde,      
--    ivi_creusr,  ivi_updusr,  ivi_credat,  ivi_upddat    
    @UsrID,  @UsrID,  getdate(),  getdate()    
   FROM     
    IMVENINF    
   WHERE     
    ivi_itmno = @ibi_itmno     
    --AND ivi_cocde = @cocde     
    AND ivi_venno = @ibi_venno    
       
      
  --*****************************************************************************    
  --***************************IMVENPCK***************************************    
  --*****************************************************************************    
       
   INSERT INTO IMVENPCK    
   (ivp_cocde,  ivp_itmno,  ivp_pckseq, ivp_venno,    
   ivp_relatn,  ivp_creusr,  ivp_updusr, ivp_credat,    
   ivp_upddat)     
   SELECT     
   --ivp_cocde, @ibi_newitm, ivp_pckseq, ivp_venno,    
   ' ',  @ibi_newitm, ivp_pckseq, ivp_venno,    
   ivp_relatn,      
--   ivp_creusr,  ivp_updusr, ivp_credat,  ivp_upddat    
   @UsrID,  @UsrID,  getdate(),  getdate()    
   FROM IMVENPCK    
   WHERE     
    ivp_itmno = @ibi_itmno     
    --AND ivp_cocde = @cocde    
      
    
   FETCH NEXT FROM cur_itmno INTO    
   @ibi_itmno, @ibi_venno    
  END    
     
  CLOSE cur_itmno    
  DEALLOCATE cur_itmno    
     
 END    
END    
    
    
    
    
    
  
  










GO
GRANT EXECUTE ON [dbo].[SP_Select_CopyItemMasterC] TO [ERPUSER] AS [dbo]
GO
