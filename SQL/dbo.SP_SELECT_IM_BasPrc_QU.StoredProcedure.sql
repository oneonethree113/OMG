/****** Object:  StoredProcedure [dbo].[SP_SELECT_IM_BasPrc_QU]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[SP_SELECT_IM_BasPrc_QU]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_IM_BasPrc_QU]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE  PROCEDURE [dbo].[SP_SELECT_IM_BasPrc_QU]
@qud_cocde 	nvarchar(6),
@qud_curcde	nvarchar(6),
@qud_itmno	nvarchar(20),
@qud_untcde	nvarchar(6),
@qud_mtrqty	int,
@qud_inrqty	int,
@qud_basprc	numeric(13,4),
@qud_cus1no	nvarchar(6),
@qud_cus2no	nvarchar(6),
@qud_prctrm	nvarchar(10),
@qud_ftyprctrm	nvarchar(10),
@qud_trantrm	nvarchar(10),
@qud_effdat	datetime,
@qud_expdat	datetime


AS

declare @CurrencyRate numeric(16,11)

set @CurrencyRate = 0

declare @imu_basprc	numeric(13,4)

set @imu_basprc = 0

begin

/*Select @CurrencyRate= ysi_selrat from SYSETINF where ysi_typ = '06' and ysi_cde = 'HKD' 

select	@imu_basprc = CASE @qud_curcde when 'HKD' then
				isnull(imu_basprc, 0) / @CurrencyRate
			else
				isnull(imu_basprc, 0)
			end */

select	@CurrencyRate = yce_selrat from SYCUREX where yce_iseff = 'Y' and yce_tocur = 'USD' and yce_frmcur = @qud_curcde
 
select	@imu_basprc = isnull(imu_basprc, 0) / @CurrencyRate
from 	IMVENINF
left join 	IMPRCINF on	imu_itmno = @qud_itmno				and 
			imu_typ = 'REG'					and
			ivi_venno = imu_prdven				and 
			(imu_status = 'ACT' or imu_status = '')			and
			imu_pckunt = @qud_untcde				and
			imu_inrqty = @qud_inrqty				and
			imu_mtrqty = @qud_mtrqty				and
			imu_cus1no = @qud_cus1no				and
			imu_cus2no = @qud_cus2no
where	ivi_itmno = @qud_itmno	and
	ivi_def = 'Y'

select case when str(@qud_basprc,13,3) <> str(@imu_basprc,13,3) then 'Y' else 'N' end as 'qud_pdabpdiff'	


END



GO
GRANT EXECUTE ON [dbo].[SP_SELECT_IM_BasPrc_QU] TO [ERPUSER] AS [dbo]
GO
