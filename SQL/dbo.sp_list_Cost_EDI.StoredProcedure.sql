/****** Object:  StoredProcedure [dbo].[sp_list_Cost_EDI]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_Cost_EDI]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_Cost_EDI]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







/*
select * from SCORDHDR where soh_ordno = 'US0600001'
select * from SCORDDTL where sod_ordno = 'US0600001'
select * from POORDDTL where pod_scno = 'US0600001'
*/


--sp_list_Cost_EDI '','04/11/2006 00:00:00.00','04/11/2006 23:59:59.00','A','B','HKD'


--sp_list_Cost_EDI '','01/01/2006','01/07/2006','A','B','HKD'

/*
------------------------------------------------------------------------------------------------------------------------------
Modification History
------------------------------------------------------------------------------------------------------------------------------
Modified on	Modified by	Description
------------------------------------------------------------------------------------------------------------------------------
2006-05-22	Lester Wu		Select only updated detail record(s)
2006-07-21	Lester Wu		Add Factory U				
------------------------------------------------------------------------------------------------------------------------------
*/

CREATE        procedure [dbo].[sp_list_Cost_EDI]
@defCocde nvarchar(6),
@UpdDatFm	datetime,
@UpdDatTo	datetime,
@VenFm		varchar(20),
@VenTo		varchar(20),
@CurrCde		varchar(3)

AS

Begin

Declare @EDISEQ as int

select @EDISEQ =  isnull(max(sce_EDISEQ),0) + 1 from SCCSTEDI where convert(varchar(10), sce_EDIDAT , 121)  = convert(varchar(10),getdate(),121)


/* Override Date From and Date To value from Program */
--set UpdDate Fm =select  convert(varchar(10),getdate(),111) + ' ' + '00:00:00'
--set UpdDateTo = select  convert(varchar(10),getdate(),111) + ' ' + '23:59:59'
/* Override Date From and Date To value from Program */

create table #Result_Cost
(
res_cocde		nvarchar(6),
res_cusno		nvarchar(12),
res_cussna		nvarchar(20),
res_scno		nvarchar(20),
res_verno		int,	
res_scseq		int,	
res_jobno		nvarchar(40),
res_dv		nvarchar(6),
res_pv		nvarchar(6),
res_itmno		nvarchar(20),
res_packing	nvarchar(100),
res_colcde		nvarchar(30),
res_qty		int,	
res_untcde		nvarchar(6),
res_untdesc	nvarchar(10),
res_untconvert	numeric(12,4),
res_untcst		numeric(13,4),
res_bomcst		numeric(13,4),
res_pono		nvarchar(40),
res_chndsc		nvarchar(1600) , 
-- Added by Mark Lau 20080826
res_dvno	nvarchar(6),
res_dvftycst	numeric(13,4),
res_dvbomcst	numeric(13,4),	
res_dvfcurcde	nvarchar(6),

res_upddat		datetime,
res_curcde		varchar(3)
)




declare @selrat as numeric(13,11)
declare @buyrat as numeric(13,11)

select 
@selrat  = ysi_selrat ,
@buyrat = ysi_buyrat
from SYSETINF where ysi_typ = '06' and ysi_cde = 'HKD'

--select @selrat , @buyrat

insert into #Result_Cost
select 
soh_cocde , 
soh_cus1no , 
cbi_cussna , 
soh_ordno , 
soh_verno , 
sod_ordseq , 
pod_jobord , 
ibi_venno , 	-- Design Vendor
sod_venno , 	-- Production Vendor
sod_itmno , 
convert(varchar(12),sod_pckunt) + '/' + convert(varchar(12), sod_inrctn) + '/' + convert(varchar(12),sod_mtrctn),
sod_colcde , 
sod_ordqty , 
sod_pckunt , 
ycf_dsc1 , 
ycf_value , 

sod_ftycst , 
sod_bomcst , 

pod_purord , 
isnull(pod_chndsc ,'') as 'pod_chndsc' , 
--added by Mark Lau 20080826
sod_dv	,
sod_dvftycst	,
sod_dvbomcst	,
sod_dvfcurcde	,

sod_upddat,
sod_fcurcde

from 
SCORDHDR(NOLOCK)
LEFT JOIN SCORDDTL on SOH_ORDNO = SOD_ORDNO and SOH_COCDE = SOD_COCDE
LEFT JOIN POORDDTL on SOD_COCDE = POD_COCDE and SOD_ORDNO = POD_SCNO and SOD_ORDSEQ = POD_SCLINE
LEFT JOIN IMBASINF on SOD_ITMNO = IBI_ITMNO
LEFT JOIN CUBASINF on SOH_CUS1NO = CBI_CUSNO
LEFT JOIN SYCONFTR on SOD_PCKUNT = YCF_CODE1

where 
 sod_upddat between @UpdDatFm and @UpdDatTo	--Lester Wu 2006-05-22

/*
soh_ordno in (
	select 
		distinct sod_ordno 
	from 
		SCORDDTL(NOLOCK)
	where 
		sod_upddat between @UpdDatFm and @UpdDatTo
)
*/
and soh_ordsts in ('REL')
and 	(
	--ibi_venno between @VenFm and @VenTo 
	ibi_venno in ('A','B','U')	-- 2006-07-21	Lester Wu		Add Factory U	
	or 
	--sod_venno between @VenFm and @VenTo 
	sod_venno in ('A','B','U')	-- 2006-07-21	Lester Wu		Add Factory U	
	)




if @CurrCde = 'HKD' 
begin

update #Result_Cost set res_untcst = res_untcst / @buyrat, res_bomcst = res_bomcst / @buyrat
where res_curcde = 'USD'

end
else
begin

update #Result_Cost set res_untcst = res_untcst * @buyrat, res_bomcst = res_bomcst * @buyrat
where res_curcde = 'HKD'

end

/*88888888888888888888888888888888888888888888888888888888*/
-- Keep Image of Upload COST EDI INFORMATION
-- Lester Wu 2006-05-22
/*88888888888888888888888888888888888888888888888888888888*/
insert into SCCSTEDI
(
sce_EDIDAT , sce_EDISEQ , 
sce_UpdDatFm , sce_UpdDatTo , sce_VenFm , sce_VenTo , sce_CurrCde , 
--
sce_cocde , sce_cusno , sce_cussna , 
sce_scno , sce_verno , sce_scseq , sce_jobno , sce_dv , sce_pv , 
sce_itmno	, sce_packing , sce_colcde , sce_qty , sce_untcde , 
sce_untdesc , sce_untconvert , sce_untcst , sce_bomcst , sce_pono , sce_chndsc , 
-- Added by Mark Lau 20080826
sce_dvno	,sce_dvftycst	,sce_dvbomcst	,	sce_dvfcurcde	,

sce_upddat
)
select	getdate() , 
	@EDISEQ , 	
	@UpdDatFm , 
	@UpdDatTo , 
	@VenFm , 
	@VenTo , 
	@CurrCde , 
	--
	res_cocde , 
	res_cusno , 
	res_cussna , 
	res_scno , 
	res_verno , 
	res_scseq , 
	res_jobno , 
	res_dv , 
	res_pv , 
	res_itmno , 
	res_packing , 
	res_colcde , 
	res_qty , 
	res_untcde , 
	res_untdesc , 
	res_untconvert , 
	res_untcst , 
	res_bomcst , 
	res_pono , 
	res_chndsc , 
	--Added by Mark Lau 20080826
	res_dvno	,
	res_dvftycst	,
	res_dvbomcst	,	
	res_dvfcurcde	,

	convert(varchar(23),res_upddat, 121) 
	
from 
	#Result_Cost
order by 
	res_cocde,res_scno,res_scseq	
/*88888888888888888888888888888888888888888888888888888888*/


--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
select 
	res_cocde , 
	res_cusno , 
	res_cussna , 
	res_scno , 
	res_verno , 
	res_scseq , 
	res_jobno , 
	res_dv , 
	res_pv , 
	res_itmno , 
	res_packing , 
	res_colcde , 
	res_qty , 
	res_untcde , 
	res_untdesc , 
	res_untconvert , 
	res_untcst , 
	res_bomcst , 
	res_pono , 
	res_chndsc , 
	--Added by Mark Lau 20080826
	res_dvno	,
	res_dvftycst	,
	res_dvbomcst	,	
	res_dvfcurcde	,

	convert(varchar(23),res_upddat, 121) as res_upddat
from 
	#Result_Cost
order by 
	res_cocde,res_scno,res_scseq
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
end


GO
GRANT EXECUTE ON [dbo].[sp_list_Cost_EDI] TO [ERPUSER] AS [dbo]
GO
