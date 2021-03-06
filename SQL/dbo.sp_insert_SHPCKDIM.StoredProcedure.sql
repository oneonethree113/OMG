/****** Object:  StoredProcedure [dbo].[sp_insert_SHPCKDIM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SHPCKDIM]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SHPCKDIM]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






------------------------------------------------- 
CREATE            procedure [dbo].[sp_insert_SHPCKDIM]                                                                                                                                                                                                                                                                
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@hpd_cocde nvarchar (6),
@hpd_shpno nvarchar (20) ,

@hpd_shpseq int,

@hpd_pdseq int,
@hpd_pdnum int,

@hpd_dimtyp nvarchar (20) ,
@hpd_ctnnam nvarchar (1) ,
@hpd_des nvarchar (20) ,


@hpd_ctn int,

@hpd_l_cm numeric(11, 4)  ,
@hpd_w_cm numeric(11, 4)  ,
@hpd_h_cm numeric(11, 4)  ,
@hpd_cbm_cm numeric(11, 4)  ,
@hpd_ttlcbm_cm numeric(11, 4)  ,
@hpd_gw_kg numeric(11, 4)  ,
@hpd_ttlgw_kg numeric(11, 4)  ,
@hpd_nw_kg numeric(11, 4)  ,
@hpd_ttlnw_kg numeric(11, 4)  ,

@hpd_l_in numeric(11, 4)  ,
@hpd_w_in numeric(11, 4)  ,
@hpd_h_in numeric(11, 4)  ,
@hpd_cbm_in numeric(11, 4)  ,
@hpd_ttlcbm_in numeric(11, 4)  ,
@hpd_gw_lb numeric(11, 4)  ,
@hpd_ttlgw_lb numeric(11, 4)  ,
@hpd_nw_lb numeric(11, 4)  ,
@hpd_ttlnw_lb numeric(11, 4)  ,

@hip_cus1no  nvarchar(5) ,
@hip_itmno  nvarchar(20) ,

@hip_colcde  nvarchar(30)  ,
@hip_untcde  nvarchar(6)  ,
@hip_inrctn  int   ,
@hip_mtrctn  int  ,
@hip_cft  numeric(11, 4)  ,
@hip_cbm  numeric(11, 4)  ,
@hip_prctrm  nvarchar(6),
@hip_paytrm  nvarchar(6), 
@ConFtr  int  , -- is cartonfator
@hpd_creusr nvarchar (30)   
                                    
------------------------------------ 
AS
 
insert into  SHPCKDIM
(
hpd_cocde,
hpd_shpno,
hpd_shpseq,
hpd_pdseq,
hpd_pdnum,
hpd_dimtyp,
hpd_ctnnam,
hpd_des,
hpd_ctn,
hpd_l_cm,
hpd_w_cm,
hpd_h_cm,
hpd_cbm_cm,
hpd_ttlcbm_cm,
hpd_gw_kg,
hpd_ttlgw_kg,
hpd_nw_kg,
hpd_ttlnw_kg,
hpd_l_in,
hpd_w_in,
hpd_h_in,
hpd_cbm_in,
hpd_ttlcbm_in,
hpd_gw_lb,
hpd_ttlgw_lb,
hpd_nw_lb,
hpd_ttlnw_lb,
hpd_creusr,
hpd_updusr,
hpd_credat,
hpd_upddat
)

values(
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

@hpd_cocde,
@hpd_shpno,
@hpd_shpseq,
@hpd_pdseq,
@hpd_pdnum,
@hpd_dimtyp,
@hpd_ctnnam,
@hpd_des,
@hpd_ctn,
@hpd_l_cm,
@hpd_w_cm,
@hpd_h_cm,
@hpd_cbm_cm,
@hpd_ttlcbm_cm,
@hpd_gw_kg,
@hpd_ttlgw_kg,
@hpd_nw_kg,
@hpd_ttlnw_kg,
@hpd_l_in,
@hpd_w_in,
@hpd_h_in,
@hpd_cbm_in,
@hpd_ttlcbm_in,
@hpd_gw_lb,
@hpd_ttlgw_lb,
@hpd_nw_lb,
@hpd_ttlnw_lb,
@hpd_creusr,
@hpd_creusr,
getdate(),
getdate()
)     
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------




if ( select count (1) from SHPKDHIS 
where 
hip_cus1no =  	@hip_cus1no and  
hip_itmno =  	@hip_itmno and  
hip_colcde =   	@hip_colcde and   
hip_untcde =   	@hip_untcde and   
hip_inrctn = 	@hip_inrctn and 
hip_mtrctn =  	@hip_mtrctn and  
hip_cft =   	@hip_cft and   
hip_cbm =   	@hip_cbm and   
hip_prctrm = 	@hip_prctrm and 
hip_paytrm =  	@hip_paytrm
  and 
hip_dimtyp =  	@hpd_dimtyp  and 
hip_ctnnam =  	@hpd_ctnnam  and 
hip_des =  	@hpd_des 
and hip_conftr =  	@conftr 
 
) = 0  
begin --insert


insert into SHPKDHIS
(hip_cocde,hip_cus1no,hip_itmno,hip_colcde,hip_untcde,hip_inrctn,hip_mtrctn,hip_cft,hip_cbm, hip_prctrm,hip_paytrm,hip_shpno,hip_shpseq,hip_dimtyp,hip_ctnnam,hip_des,hip_ctn,hip_l_cm,hip_w_cm,hip_h_cm,hip_cbm_cm,hip_ttlcbm_cm,hip_gw_kg,hip_ttlgw_kg,hip_nw_kg,hip_ttlnw_kg,hip_l_in,hip_w_in,
hip_h_in,hip_cbm_in,hip_ttlcbm_in,hip_gw_lb,hip_ttlgw_lb,hip_nw_lb,hip_ttlnw_lb,hip_conFtr,hip_creusr,hip_updusr,hip_credat,hip_upddat)
values
(@hpd_cocde,@hip_cus1no,@hip_itmno,@hip_colcde,@hip_untcde,@hip_inrctn,@hip_mtrctn,@hip_cft,@hip_cbm,@hip_prctrm,@hip_paytrm,@hpd_shpno,@hpd_shpseq,@hpd_dimtyp,@hpd_ctnnam,@hpd_des,@hpd_ctn,@hpd_l_cm,@hpd_w_cm,@hpd_h_cm,@hpd_cbm_cm,@hpd_ttlcbm_cm,@hpd_gw_kg,@hpd_ttlgw_kg,@hpd_nw_kg,@hpd_ttlnw_kg,@hpd_l_in,@hpd_w_in,
@hpd_h_in,@hpd_cbm_in,@hpd_ttlcbm_in,@hpd_gw_lb,@hpd_ttlgw_lb,@hpd_nw_lb,@hpd_ttlnw_lb,@ConFtr,@hpd_creusr,@hpd_creusr,getdate(),getdate())
end 
else
begin --update



update
SHPKDHIS
set 
hip_cocde	=@hpd_cocde,
hip_cus1no	=@hip_cus1no,
hip_itmno	=@hip_itmno,
hip_colcde	=@hip_colcde,
hip_untcde	=@hip_untcde,
hip_inrctn	=@hip_inrctn,
hip_mtrctn	=@hip_mtrctn,
hip_cft	=@hip_cft,
hip_cbm	=@hip_cbm,
hip_prctrm	=@hip_prctrm,
hip_paytrm	=@hip_paytrm,
hip_shpno = @hpd_shpno,
hip_shpseq = @hpd_shpseq,
hip_dimtyp	=@hpd_dimtyp,
hip_ctnnam	=@hpd_ctnnam,
hip_des	=@hpd_des,
hip_ctn	=@hpd_ctn,
hip_l_cm	=@hpd_l_cm,
hip_w_cm	=@hpd_w_cm,
hip_h_cm	=@hpd_h_cm,
hip_cbm_cm	=@hpd_cbm_cm,
hip_ttlcbm_cm	=@hpd_ttlcbm_cm,
hip_gw_kg	=@hpd_gw_kg,
hip_ttlgw_kg	=@hpd_ttlgw_kg,
hip_nw_kg	=@hpd_nw_kg,
hip_ttlnw_kg	=@hpd_ttlnw_kg,
hip_l_in	=@hpd_l_in,
hip_w_in	=@hpd_w_in,
hip_h_in	=@hpd_h_in,
hip_cbm_in	=@hpd_cbm_in,
hip_ttlcbm_in	=@hpd_ttlcbm_in,
hip_gw_lb	=@hpd_gw_lb,
hip_ttlgw_lb	=@hpd_ttlgw_lb,
hip_nw_lb	=@hpd_nw_lb,
hip_ttlnw_lb	=@hpd_ttlnw_lb,
hip_conftr  = @conftr,
hip_creusr	=@hpd_creusr,
hip_updusr	=@hpd_creusr,
hip_credat	=getdate(),
hip_upddat	=getdate()
where 
hip_cus1no =  	@hip_cus1no and  
hip_itmno =  	@hip_itmno and  
hip_colcde =   	@hip_colcde and   
hip_untcde =   	@hip_untcde and   
hip_inrctn = 	@hip_inrctn and 
hip_mtrctn =  	@hip_mtrctn and  
hip_cft =   	@hip_cft and   
hip_cbm =   	@hip_cbm and   
hip_prctrm = 	@hip_prctrm and 
hip_paytrm =  	@hip_paytrm  
and 
hip_dimtyp =  	@hpd_dimtyp  and 
hip_ctnnam =  	@hpd_ctnnam  and 
hip_des =  	@hpd_des  
and hip_conftr =  	@conftr 

end 














GO
GRANT EXECUTE ON [dbo].[sp_insert_SHPCKDIM] TO [ERPUSER] AS [dbo]
GO
