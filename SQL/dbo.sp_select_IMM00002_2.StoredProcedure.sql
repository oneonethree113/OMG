/****** Object:  StoredProcedure [dbo].[sp_select_IMM00002_2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMM00002_2]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMM00002_2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/*
sp_IMINSDAT
sp_IMUPDDAT


select * from IMASSDAT where iad_venitm like '%903' or iad_venitm like '%997'

sp_helptext sp_select_IMM00002_2 'UCP','04A760AS09903','07/06/2007 16:50:46','EXCEL TEST - LW.xls','mis'
*/

CREATE PROCEDURE [dbo].[sp_select_IMM00002_2]  
  
@iad_cocde nvarchar(6),  
@iad_venitm nvarchar(20),  
@iad_chkdat datetime,  
@iad_xlsfil nvarchar(30),  
@iad_creusr nvarchar(30)  
  
AS  
  
select   
iad_venitm as 'Vendor Item',   
iad_acsno as 'Assorted Vendor Item' ,   
iad_colcde as 'Color Code',  
--Frankie Cheung 20110223 Add Assd Period
iad_period_bef as 'Assd Period (Before)',
iad_period as 'Assd Period (After)',
-----------------------------------------
iad_untcde as 'UM',  
iad_inrqty as 'Inner Qty',  
iad_mtrqty as 'Master Qty'  
from IMASSDAT, IMITMDAT  
where   
--iad_cocde = @iad_cocde and 
iad_venitm = @iad_venitm and   
iad_chkdat = @iad_chkdat and iad_xlsfil = @iad_xlsfil and iad_stage = 'W' and  
iad_cocde = iid_cocde and iad_venitm = iid_venitm and  
iad_chkdat = iid_chkdat and iad_xlsfil = iid_xlsfil and iid_stage = 'W'  








GO
GRANT EXECUTE ON [dbo].[sp_select_IMM00002_2] TO [ERPUSER] AS [dbo]
GO
