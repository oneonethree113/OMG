/****** Object:  StoredProcedure [dbo].[sp_select_BOMASS]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_BOMASS]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_BOMASS]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_select_BOMASS] 
@grdtype nvarchar(3),
@act	nvarchar(3),
@iba_cocde  	nvarchar(6),
@iba_itmno  	nvarchar(20)
AS
if @act ='ASS'
begin
	if  @grdtype='OLD'
	begin
		select imu_itmno, count(distinct imu_conftr) as 'imu_conftr' into #temp1 from IMPRCINF group by imu_itmno
		SELECT iba_itmno as ' ITEM #',
			iba_assitm as 'Assorted Item',
			iba_colcde as 'Color Code',
			iba_pckunt as 'UM' ,
			imu_conftr as 'Conversion Factor To PCs',
			iba_inrqty as 'Inner Qty',
			iba_mtrqty as 'Master Qty',
			case when year(iba_period) = 1900 then '' else
			ltrim(str(year(iba_period))) + '-' + right('0' +  ltrim(str( month(iba_period))),2) end as 'Period'
			from 
				IMBOMASS left join #temp1 on iba_itmno=imu_itmno 
			where 
				iba_itmno = @iba_itmno
		drop table #temp1
		end
	else 
	begin
		select iad_venitm as ' ITEM #',
			iad_acsno as 'Assorted Item',
			iad_colcde as 'Color Code',
			iad_untcde as 'UM',
			iad_conftr as 'Conversion Factor To PCs',
			iad_inrqty as 'Inner Qty',
			iad_mtrqty as 'Master Qty',

			case when year(iad_period) = 1900 then '' else ltrim(str(year(iad_period))) + '-' + right('0' +  ltrim(str( month(iad_period))),2) end as 'Period'

		 from IMASSDAT where 
			iad_venitm = @iba_itmno
	end

end
else
begin
	if  @grdtype='OLD'
	begin

		SELECT iba_itmno as ' ITEM #',
			iba_assitm as 'Accessory #',
			ISNULL(ibi_engdsc,'N/A') as 'Accessory Description',
			iba_colcde as 'Color Code',		
			iba_pckunt as 'UM' ,
			iba_bomqty as 'Quantity',
			case when year(iba_period) = 1900 then '' else
			ltrim(str(year(iba_period))) + '-' + right('0' +  ltrim(str( month(iba_period))),2) end as 'Period'	
		from IMBOMASS
			left join IMBASINF on ibi_itmno = iba_assitm
		where 
			iba_itmno = @iba_itmno
	end
	else 
	begin
	create table #temp(
		ibd_venitmT nvarchar(20),
		ibd_acsnoT nvarchar(20),
		seqT int
	)
	insert into #temp(
		ibd_venitmT ,
		ibd_acsnoT ,
		seqT 
	)select ibd_venitm,ibd_acsno,max(ibd_recseq) from IMBOMDAT group by ibd_venitm,ibd_acsno

		select ibd_venitm as ' ITEM #',
			ibd_acsno as 'Accessory #',
			ibd_itmdsc as 'Accessory Description',
			ibd_colcde as 'Color Code',
			ibd_untcde as 'UM',
			ibd_qty as 'Quantity',
			case when year(ibd_period) = 1900 then '' else ltrim(str(year(ibd_period))) + '-' + right('0' +  ltrim(str( month(ibd_period))),2) end as 'Period'
		from IMBOMDAT left join #temp on ibd_venitm=ibd_venitmT and  ibd_acsno=ibd_acsnoT
		where ibd_venitm = @iba_itmno and ibd_recseq=seqT
		drop table #temp
	end
end



GO
GRANT EXECUTE ON [dbo].[sp_select_BOMASS] TO [ERPUSER] AS [dbo]
GO
