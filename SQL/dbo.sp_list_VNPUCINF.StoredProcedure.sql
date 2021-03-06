/****** Object:  StoredProcedure [dbo].[sp_list_VNPUCINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_VNPUCINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_VNPUCINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 28/07/2003

CREATE procedure [dbo].[sp_list_VNPUCINF]
                                                                                                                                                                                                                                                               
@vpf_cocde 	nvarchar(6),
@vpf_venno	nvarchar(6)

AS
Select 
vpf_yymm = Case left(vpf_yymm,2) when '99' then '19' + vpf_yymm else '20' + vpf_yymm end,
vpf_mtdbok = round(sum(vpf_mtdbok),0),
vpf_mtdpur = round(sum(vpf_mtdpur),0)
--vpf_mpoamt,
--vpf_ypoamt,
--vpf_mosamt,
--vpf_yosamt

from VNPUCINF
where                                                                                                                                                                                                                                                                 
--vpf_cocde = @vpf_cocde and
vpf_venno = @vpf_venno
group by vpf_yymm
order by Case left(vpf_yymm,2) when '99' then '19' + vpf_yymm else '20' + vpf_yymm end desc





GO
GRANT EXECUTE ON [dbo].[sp_list_VNPUCINF] TO [ERPUSER] AS [dbo]
GO
