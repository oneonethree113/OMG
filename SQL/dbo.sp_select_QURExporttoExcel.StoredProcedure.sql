/****** Object:  StoredProcedure [dbo].[sp_select_QURExporttoExcel]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QURExporttoExcel]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QURExporttoExcel]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE                        PROCEDURE [dbo].[sp_select_QURExporttoExcel]   
  
@cocde	nvarchar(6),  
@from	nvarchar(20),  
@to	nvarchar(20),  
@sortBy	nvarchar(4)

  
AS  

Declare @_count as int


  
BEGIN  
	SELECT	*
 
	FROM	
	QUOTNDTL dtl 
	 left JOIN   Quprcemt emt
		on	dtl.qud_cocde = emt.qpe_cocde	 	AND  
			dtl.qud_qutno = emt.qpe_qutno 	 and 
			dtl.qud_ITMNO = emt.qpe_itmno 	and
			dtl.qud_qutseq = emt.qpe_qutseq 
 	  left  join 	QUOTNHDR hdr
	on 		emt.qpe_cocde = hdr.quh_cocde	AND  
			emt.qpe_qutno = hdr.quh_qutno 	
 	  left  join IMPRCINF  
		on imu_itmno = qpe_itmno 
		and imu_pckunt = qpe_untcde 
		and imu_inrqty = qpe_inrqty 
		and imu_mtrqty = qpe_mtrqty
		and imu_hkprctrm = qpe_prctrm 
		and imu_trantrm = qpe_trantrm
		and imu_prdven = qud_cusven
 	and		imu_cus1no = qud_cus1no   and
	 				imu_cus2no = qud_cus2no	
		
  	  left   join   IMBASINF imb 
 		 on	imb.ibi_itmno = emt.qpe_itmno    

	left join VNBASINF vnb
		on dtl.qud_venno = vnb.vbi_venno
	
		where	hdr.quh_cocde = @cocde	AND 
			hdr.quh_qutno = @from	 
---		 and imu_pckunt <> ''                     ---??
---		 and imu_hkprctrm <> ''	---??
 
	ORDER BY	hdr.quh_qutno, dtl.qud_qutseq  
    
 
  
END















GO
GRANT EXECUTE ON [dbo].[sp_select_QURExporttoExcel] TO [ERPUSER] AS [dbo]
GO
