/****** Object:  StoredProcedure [dbo].[sp_select_MPO00003_Hdr_update]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MPO00003_Hdr_update]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MPO00003_Hdr_update]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
=========================================================
Program ID	: sp_select_MPO00003_Hdr_update
Description   	: Approve/ Reject MPO Exceptional record(s)
Programmer  	: Lester Wu
Create Date   	:
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     

*/

--sp_help MPOEXPHDR
CREATE  procedure [dbo].[sp_select_MPO00003_Hdr_update]
@cocde		as varchar(6),
@gen		as char(1),
@Mxh_FilNam	as varchar(50),
@Mxh_seq	as int,
@UsrID		as varchar(30)
as
Begin
	declare
		@MPO#		varchar(20),
		@MPOLst		varchar(500),
		@Curr 		varchar(10),
		@Flag 		varchar(6),
		@VenNo		varchar(30)

	declare
		@Mxh_PONo	varchar(20),
		@Mxh_VenNo	varchar(10),
		@Mxh_ImpFty	nvarchar(10),
		@Mxh_ShpPlc	nvarchar(20),
		@Mxh_Curr	varchar(10),
		@Mxh_Rmk	nvarchar(300),
		@Mxh_MPOFlg	char(1),
		@Mxh_MPONO	varchar(20),
		@Mxh_Expt	varchar(255),
		@Mxh_UpdFlg	varchar(3),
		@Mxh_PODat	datetime,
		@Mxh_POUsr	varchar(8),
		@Mxh_ConUsr	varchar(8),
		@Mxh_ConDat	datetime,
		@Mxh_CntUsr	varchar(8)
	
	declare
		@bolShpAll	char(1),
		@bolVenExist	char(1),
		@intGen		int,
		@bolHdrDiff	char(1)	--

	declare 
		@errMsg		varchar(255)

	Declare	
		@Row_Idx		int,
		@Err_Idx			int
		
--	Lester Wu 2005-10-10
	declare 
		@PODAYS	int ,
		@DlvQty		numeric(9,2)

	select @Mxh_PONo = Mxh_PONo,
		@Mxh_VenNo = Mxh_VenNo,
		@Mxh_ImpFty = Mxh_ImpFty,
		@Mxh_ShpPlc = Mxh_ShpPlc,
		@Mxh_Curr = Mxh_Curr,
		@Mxh_Rmk = Mxh_Rmk,
		@Mxh_MPOFlg = Mxh_MPOFlg,
		@Mxh_MPONO = Mxh_MPONO,
		@Mxh_Expt = Mxh_Expt,
		@Mxh_UpdFlg = Mxh_UpdFlg,
		@Mxh_PODat = Mxh_PODat,
		@Mxh_POUsr = Mxh_POUsr, 
		@Mxh_ConUsr = Mxh_ConUsr,
		@Mxh_ConDat = Mxh_ConDat,
		@Mxh_CntUsr = Mxh_CntUsr
	from 	
		MPOEXPHDR
	where 	
		Mxh_FilNam = @Mxh_FilNam and 
		Mxh_seq = @Mxh_seq	


	set @errMsg = ''

	
	if @gen = 'R' 
	begin
	--Mark Record Reject
		update MPOEXPHDR set Mxh_MpoFlg = @gen , Mxh_UpdDat = getdate(), Mxh_UpdUsr = @UsrID + '_AR'
		where Mxh_FilNam = @Mxh_FilNam  and @Mxh_seq = Mxh_seq 
		
		select 'Reject of ' + @Mxh_PONo + ' ( File Name >  ' + @Mxh_FilNam + ' , Seq > ' + ltrim(rtrim(str(@Mxh_seq))) +  ' ) . Success!'
		return (99)
	end
	else
	begin
		

		set @Curr = case @Mxh_curr when '港幣' then 'HKD' when '美元' then 'USD' when '人民幣' then 'RMB' when '新台幣' then 'TWD'  
				            when 'HKD' then 'HKD' when 'USD' then 'USD' when 'RMB' then 'RMB' when 'TWD' then 'TWD'  else '' end
		
		if upper(@Mxh_UpdFlg) <> 'DEL' 
		begin
			if @Curr = '' 
			begin
				set @Flag = 'E'
				set @errMsg = @errMsg + case when len(@errMsg) > 0 then ' | ' else '' end  + 'Invalid Currency'
			end
			else
			begin
				set @Mxh_curr = @Curr
			end
		
			set @VenNo = ltrim(rtrim(@Mxh_VenNo))
			-- select * from VNBASINF where vbi_prcvenno = '40101'
			select @VenNo=isnull(vbi_venno,@Mxh_VenNo) from VNBASINF where isnull(vbi_prcvenno,'') = @Mxh_VenNo and @Mxh_VenNo <> ''
	
		
			if  ( (select count(1) from VNBASINF where vbi_venno = @VenNo and @VenNo <> '') <= 0 )
			begin
				set @errMsg = @errMsg + case when len(@errMsg) > 0 then ' | ' else '' end  + 'Ven # Not Found'
				set @Flag = 'E'
			end
		
			if @Mxh_ImpFty = '' 
			begin
				set @errMsg = @errMsg + case when len(@errMsg) > 0 then ' | ' else '' end  + 'Custom Fty Empty'
				set @Flag = 'E'		
			end
			else if ((select Count(1) from GRNVENINF where gvi_vensna = @Mxh_ImpFty) <= 0 )
			begin
				set @errMsg = @errMsg + case when len(@errMsg) > 0 then ' | ' else '' end  + 'Custom Fty Invalid'
				set @Flag = 'E'		
			end
		end

		if @Flag = 'E' 
		begin
			Update MPOEXPHDR set Mxh_MPOFlg = 'E' , Mxh_Expt  = @errMsg , Mxh_UpdDat = getdate() , Mxh_UpdUsr = @UsrID + '_AR'
			Where Mxh_FilNam = @Mxh_FilNam and Mxh_seq = @Mxh_seq	
			
			select @Mxh_PONo + ' ( File Name >  ' + @Mxh_FilNam + ' , Seq > ' + ltrim(rtrim(str(@Mxh_seq))) +  ' )  : ' +  @errMsg 
			return (99)
		end

		set @bolShpAll = 'N'
		set @bolVenExist = 'N'
		set @intGen = 0
		set @MPOLst = ''
		set @MPO# = ''
		--Check MPO Generated or not
		select @intGen = count(1) from MPORDDTL where Mpd_PONo = @Mxh_PONo group by Mpd_MPONo
		if @intGen  > 0 
		begin
			select 
				@PODAYS = max(datediff(Day,Mpd_PODat,getdate()))
			from 
				MPORDDTL 
			where 
				Mpd_PONo = @Mxh_PONo 
		end
		------------------------------------------------------------------------------------------------------------------------------------------------------
		if @intGen > 0 and @PODAYS > 21 
		begin
			set @errMsg = 'MPO Gen & PO Days > 21'
			Update MPOEXPHDR set Mxh_MPOFlg = 'E' , Mxh_Expt  = @errMsg , Mxh_UpdDat = getdate() , Mxh_UpdUsr = @UsrID + '_AR'
			Where Mxh_FilNam = @Mxh_FilNam and Mxh_seq = @Mxh_seq	
			
			select @Mxh_PONo + ' ( File Name >  ' + @Mxh_FilNam + ' , Seq > ' + ltrim(rtrim(str(@Mxh_seq))) +  ' )  : ' +  @errMsg 
			return (99)
		end

		------------------------------------------------------------------------------------------------------------------------------------------------------
		begin tran
		--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

			if @intGen > 0 
			begin

				update MPORDHDR
				set Mph_VenNo = @Mxh_VenNo,Mph_ImpFty = @Mxh_ImpFty, Mph_Curr = @Mxh_Curr, Mph_ShpPlc = @Mxh_ShpPlc,
				Mph_UpdUsr = @UsrID + '_AR', Mph_UpdDat = getdate()
				from MPORDDTL
				where Mph_MpoNo = Mpd_MpoNo and Mpd_PONo = @Mxh_PONo and (Mph_VenNo <> @Mxh_VenNo or Mph_ImpFty <> @Mxh_ImpFty or Mph_Curr <> @Mxh_Curr or Mph_ShpPlc <> @Mxh_ShpPlc)
				
				update MPORDDTL
				set Mpd_HdrRmk = @Mxh_Rmk, Mpd_PODat = @Mxh_PODat,Mpd_UpdUsr = @UsrID + '_AR',Mpd_UpdDat = getdate()
				where  Mpd_PONo = @Mxh_PONo

			end

			set @Mxh_MPOFlg = 'N'

			select @Err_Idx = @@error, @Row_Idx = @@RowCount
			if @Err_Idx = 0 and @Row_Idx  >= 1
			begin
				update MPOEXPHDR set Mxh_MpoFlg = @gen , Mxh_UpdUsr = @UsrID + '_AR', Mxh_UpdDat = getdate()
				where Mxh_FilNam = @Mxh_FilNam  and @Mxh_seq = Mxh_seq
			end

			select @Err_Idx = @@error, @Row_Idx = @@RowCount
			if @Err_Idx = 0 and @Row_Idx = 1
			begin
				
				if (select count(1) from MPOXLSHDR where Mxh_MpoFlg = 'G') > 0 
				begin
					update 
						MPOXLSHDR 
					set	
						Mxh_MpoFlg =  case Mxh_MpoFlg 
								when 'G' then 'O'
								when 'E' then 'G'
								end , 
						Mxh_UpdUsr = @UsrID + '_AR', 
						Mxh_UpdDat = getdate() 
					where 
						Mxh_PONo = @Mxh_Pono and 
						Mxh_MpoFlg in ('G','E')

					select @Err_Idx = @@error, @Row_Idx = @@RowCount
				end
				else
				begin
					update 
						MPOXLSHDR 
					set	
						Mxh_MpoFlg =  case Mxh_MpoFlg 
								when 'N' then 'O'
								when 'E' then 'N'
								end , 
						Mxh_UpdUsr = @UsrID + '_AR', 
						Mxh_UpdDat = getdate() 
					where 
						Mxh_PONo = @Mxh_Pono and 
						Mxh_MpoFlg in ('N','E')

					select @Err_Idx = @@error, @Row_Idx = @@RowCount
				end
			end

/*			select @Err_Idx = @@error, @Row_Idx = @@RowCount
			if @Err_Idx = 0 and @Row_Idx >= 1
			begin
				insert into MPOXLSHDR (Mxh_PONo, Mxh_VenNo, Mxh_ImpFty, Mxh_ShpPlc, Mxh_Curr, Mxh_Rmk, Mxh_MPOFlg, Mxh_MPONO, Mxh_Expt, Mxh_UpdFlg, Mxh_PODat,Mxh_POUsr, Mxh_ConUsr, Mxh_ConDat, Mxh_CntUsr,Mxh_CreUsr,Mxh_CreDat,Mxh_UpdUsr,Mxh_UpdDat)
				values (@Mxh_PONo, @Mxh_VenNo, @Mxh_ImpFty, @Mxh_ShpPlc, @Mxh_Curr, @Mxh_Rmk, @Mxh_MPOFlg, @Mxh_MPONO, @Mxh_Expt, @Mxh_UpdFlg, @Mxh_PODat,@Mxh_POUsr, @Mxh_ConUsr, @Mxh_ConDat, @Mxh_CntUsr,@UsrID + '_AR',getdate(),@UsrID + '_AR',getdate())
			end
			select @Err_Idx = @@error, @Row_Idx = @@RowCount
*/
			--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx			
		if @Err_Idx = 0 
		begin
			commit tran
			Select 'Approval of ' +  @Mxh_PONo + ' ( File Name >  ' + @Mxh_FilNam + ' , Seq > ' + ltrim(rtrim(str(@Mxh_seq))) +  ' ) . Success!'
			return (99)
		end
		else
		begin
			rollback tran
			return (@Err_Idx)
		end
	end
End






GO
GRANT EXECUTE ON [dbo].[sp_select_MPO00003_Hdr_update] TO [ERPUSER] AS [dbo]
GO
