/****** Object:  StoredProcedure [dbo].[sp_select_PKESHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PKESHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PKESHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO















CREATE  procedure [dbo].[sp_select_PKESHDR]
                                                                                                                                                                                                                                                                 
@code nvarchar(10),
@reqno nvarchar(20)


---------------------------------------------- 

 
AS
 

begin


declare @estcount table
(
est_cocde	nvarchar(10),
est_reqno	nvarchar(20),
est_itemno	nvarchar(30),
est_count	int
)

insert into @estcount
select ped_cocde, ped_reqno,ped_itemno, count(*) from PKESDTL (nolock),
PKIMBAIF (nolock)
where ped_cocde = @code and ped_reqno = @reqno
and ped_pkgitem = pib_pgitmno and pib_estflg = 'Y'
group by ped_cocde, ped_reqno,ped_itemno


select peh_cocde,peh_reqno,peh_itemno,peh_assitm,peh_tmpitmno,peh_venno,peh_venitm,peh_colcde,peh_price,
	peh_curcde,peh_creusr,peh_updusr,peh_credat,peh_upddat, case isnull(est_count,0) when '0' then 'N' else 'Y' end as 'est_flag'
from PKESHDR (nolock)
left join @estcount on est_cocde = peh_cocde and est_reqno = peh_reqno and peh_itemno = est_itemno
where peh_cocde = @code and peh_reqno = @reqno 


end


 
 
 
















GO
GRANT EXECUTE ON [dbo].[sp_select_PKESHDR] TO [ERPUSER] AS [dbo]
GO
