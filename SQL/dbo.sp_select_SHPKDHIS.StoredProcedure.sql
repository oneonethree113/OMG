/****** Object:  StoredProcedure [dbo].[sp_select_SHPKDHIS]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SHPKDHIS]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHPKDHIS]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







/**********************************************************************************************************************************
Modification History
**********************************************************************************************************************************
Modifiy by		Modified on		Description
**********************************************************************************************************************************
***********************************************************************************************************************************/
CREATE          procedure [dbo].[sp_select_SHPKDHIS]
@hip_cus1no  nvarchar(5) ,
@hip_itmno  nvarchar(20) ,

@hip_colcde  nvarchar(30)  ,
@hip_untcde  nvarchar(6)  ,
@hip_inrctn  int   ,
@hip_mtrctn  int  ,
@hip_cft  numeric(11, 4)  ,
@hip_cbm  numeric(11, 4)  ,
@hip_prctrm  nvarchar(6),
@hip_paytrm  nvarchar(6)  


as


select 
* from SHPKDHIS
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
and hip_conftr=
(select 
max(hid_ctnftr) from 
	SHIPGDTL dtl left join SHIPGHDR hdr
		on dtl.hid_shpno = hdr.hih_shpno
where 
hih_cus1no =  	@hip_cus1no and  
hid_itmno =  	@hip_itmno and  
hid_colpck =   	@hip_colcde + ' / ' + @hip_untcde +     ' / ' + cast(@hip_inrctn  as nvarchar(10)) + ' / ' +  cast(@hip_mtrctn  as nvarchar(10)) + ' / ' + cast(@hip_cft  as nvarchar(10)) + ' / ' + cast(@hip_cbm    as nvarchar(10)) + ' / ' +  @hip_prctrm  + ' / ' +  @hip_prctrm  + ' / ' +  @hip_paytrm 
and
hid_upddat =  
	(select max(hid_upddat) 
		from
		SHIPGDTL dtl left join SHIPGHDR hdr
		on dtl.hid_shpno = hdr.hih_shpno
		where 
hih_cus1no =  	@hip_cus1no and  
hid_itmno =  	@hip_itmno and  
hid_colpck =   	@hip_colcde + ' / ' + @hip_untcde +     ' / ' + cast(@hip_inrctn  as nvarchar(10)) + ' / ' +  cast(@hip_mtrctn  as nvarchar(10)) + ' / ' + cast(@hip_cft  as nvarchar(10)) + ' / ' + cast(@hip_cbm    as nvarchar(10)) + ' / ' +  @hip_prctrm  + ' / ' +  @hip_prctrm  + ' / ' +  @hip_paytrm 
)
)


/*
(select 
max(hip_conftr) from SHPKDHIS
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
hip_paytrm =  	@hip_paytrm  and
hip_upddat =  
	(select max(hip_upddat)
		from  SHPKDHIS
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
)
)
*/



---------------------------------------------------------------------------------------------------------------------------------------------------------------------













GO
GRANT EXECUTE ON [dbo].[sp_select_SHPKDHIS] TO [ERPUSER] AS [dbo]
GO
