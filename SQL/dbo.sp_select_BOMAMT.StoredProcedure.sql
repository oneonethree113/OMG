/****** Object:  StoredProcedure [dbo].[sp_select_BOMAMT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_BOMAMT]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_BOMAMT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
select * from IMBOMASS ass
left join IMBOMASS reg on ass.iba_assitm = reg.iba_itmno
where ass.iba_itmno = '06BT19AS00100'

select * from IMBOMASS ass
left join IMBOMASS reg on ass.iba_assitm = reg.iba_itmno and reg.iba_typ = 'BOM'
where reg.iba_bomqty > 1
and ass.iba_typ = 'ASS'


*/

 /*  
=========================================================  
Program ID :  sp_select_bomamt  
Description    : Calculate Assorted item's BOM price & price   
Programmer   :   
Create Date    : 30 July 2004  
Last Modified   :   
Table Read(s)  : IMBOMASS  
Table Write(s)  :  
=========================================================  
 Modification History                                      
=========================================================  
Date  Author  Description  
=========================================================       
*/  
  
-------------------------------------------------   
CREATE procedure [dbo].[sp_select_BOMAMT]  

@Dummy nvarchar(6),  
@itmno nvarchar(20),  
@mtrqty int,  
@tbomcst numeric(21,11) output ,  
@tbomprc numeric(21,11) output  
  
as  
  
declare  
  
@costflag  char(1),  
@curcde  varchar(4),  
@bombasprc numeric(21,11),  
@imu_selrat numeric(16,11)  ,
@untcst  numeric(21,11),
@fcurcde varchar(4),
@ftycst numeric(21,11)

declare @tUntCst numeric(21,11), @tFtyCst numeric(21,11)

set @tbomcst = 0  
set @tbomprc = 0  
set @tUntCst = 0
set @tFtyCst = 0

/*
select   
	@imu_selrat = ysi_selrat   
from   
	SYSETINF   
where    
	ysi_typ = '06' and  
	ysi_cde = 'HKD'  
*/


DECLARE cur_calbom CURSOR  
FOR    
	select   
		iba_costing,   
		iba_curcde,   
		sum(iba_bomqty*iba_bombasprc) , 
		sum(iba_bomqty*iba_untcst),
		iba_fcurcde,
		sum(iba_bomqty*iba_ftycst)
	from
		imbomass  
	where   
		iba_itmno = @itmno  
	group by   
		iba_costing,   
		iba_curcde ,
		iba_fcurcde
  
OPEN cur_calbom  
FETCH NEXT FROM cur_calbom INTO @costflag, @curcde, @bombasprc  , @untcst, @fcurcde, @ftycst
  
WHILE @@fetch_status = 0  
BEGIN   
  
	if @curcde = 'HKD'
	begin
		set @tUntCst = @tUntCst + (@UntCst * @mtrqty)  
	end
	else
	begin
		select @imu_selrat = yce_selrat from SYCUREX where yce_frmcur = @curcde and yce_tocur = 'HKD'
		set @tUntCst = @tUntCst + ((@UntCst / @imu_selrat) * @mtrqty)
	end

	if @fcurcde = 'HKD'
	begin
		set @tFtyCst = @tFtyCst + (@FtyCst * @mtrqty)  
	end
	else
	begin
		select @imu_selrat = yce_selrat from SYCUREX where yce_frmcur = @fcurcde and yce_tocur = 'HKD'
		set @tFtyCst = @tFtyCst + ((@FtyCst / @imu_selrat) * @mtrqty)  
	end

	IF @costflag = 'Y'   
	--- BOM Cost ---  
	begin  
		if @curcde = 'HKD'   
		begin  
			set @tbomcst = @tbomcst + (@bombasprc * @mtrqty)   
		end  
		else  
		begin  
			select @imu_selrat = yce_selrat from SYCUREX where yce_frmcur = @curcde and yce_tocur = 'HKD'
			set @tbomcst = @tbomcst + ((@bombasprc / @imu_selrat) * @mtrqty)   
		end  
	end  
	else  
     --- BOM Price ---  
	begin  
		if @curcde = 'HKD'   
		begin  
			set @tbomprc = @tbomprc  + (@bombasprc * @mtrqty)   
		end  
		else  
		begin  
			select @imu_selrat = yce_selrat from SYCUREX where yce_frmcur = @curcde and yce_tocur = 'HKD'
			set @tbomprc = @tbomprc + ((@bombasprc / @imu_selrat) * @mtrqty)   
		end  
	end  
  
FETCH NEXT FROM cur_calbom INTO @costflag, @curcde, @bombasprc  , @untcst, @fcurcde, @ftycst
END  
CLOSE cur_calbom  
DEALLOCATE cur_calbom  
  
if ltrim(rtrim(@Dummy)) <> ''  
 SELECT  @tbomcst AS 'BOMCST',  @tbomprc AS 'BOMPRC'  , @tUntCst AS 'UNTCST', @tFtyCst as 'FTYCST'




GO
GRANT EXECUTE ON [dbo].[sp_select_BOMAMT] TO [ERPUSER] AS [dbo]
GO
