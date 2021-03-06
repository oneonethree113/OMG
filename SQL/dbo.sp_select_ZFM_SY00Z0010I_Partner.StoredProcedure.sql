/****** Object:  StoredProcedure [dbo].[sp_select_ZFM_SY00Z0010I_Partner]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_ZFM_SY00Z0010I_Partner]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_ZFM_SY00Z0010I_Partner]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE procedure [dbo].[sp_select_ZFM_SY00Z0010I_Partner]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

@cocde nvarchar(6) 
             

---------------------------------------------- 
 
AS


begin


select cci_cusno as 'KUNNR','WE' as 'PARVW', cci_sapshcusno as 'KTONR' ,'' AS 'KNREF' , '' as 'ACTFLG'  from cucntinf 

 where  cci_cusno like '5%' and cci_cnttyp  in ('B','S','M') --order by cci_cusno , cci_sapshcusno  asc

union

select csc_prmcus as 'KUNNR','WE' as 'PARVW', cci_sapshcusno as 'KTONR'  ,'' AS 'KNREF' , '' as 'ACTFLG'   from  cusubcus
left join cucntinf on csc_seccus = cci_cusno

 where  csc_prmcus like '5%' and cci_cnttyp  in ('B','S','M')

UNION

select csc_prmcus as 'KUNNR','Z1' as 'PARVW', csc_seccus as 'KTONR'  ,'' AS 'KNREF' , '' as 'ACTFLG'   from  cusubcus
 where  csc_prmcus like '5%' 

 order by KUNNR, cci_sapshcusno  asc


end


GO
GRANT EXECUTE ON [dbo].[sp_select_ZFM_SY00Z0010I_Partner] TO [ERPUSER] AS [dbo]
GO
