/****** Object:  StoredProcedure [dbo].[sp_update_TOORDHDR_TOM00003]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_TOORDHDR_TOM00003]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_TOORDHDR_TOM00003]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[sp_update_TOORDHDR_TOM00003] 


@toh_cocde		nvarchar(6),
@toh_toordnoFrom	nvarchar(20),
@toh_toordnoTo		nvarchar(20),
@status		nvarchar(20),
@user			nvarchar(30)
AS



declare @toh_toordno nvarchar(30),
	 @count int,
	 @tod_cus1no nvarchar(6),
	@tod_cus2no nvarchar(6),
	@tod_ftyitmno nvarchar(20),
	@tod_ftytmpitmno nvarchar(20),
	@tod_venno nvarchar(6),
	@tod_venitm nvarchar(30),
	@tod_pckunt nvarchar(10),
	@tod_projqty bigint,
	@tod_toordno nvarchar(20),
	@tod_toordseq int,
	@tod_qutno nvarchar(20),
	@tod_qutseq int,
	@tod_verno int,
	@tod_cocde nvarchar(6),
	@current_qty int,
	@msg nvarchar(1000)

set @msg =''
if @status = 'REL'
begin 

Declare cur_check_prcingkey cursor
for
select 
toh_toordno from TOORDHDR (nolock) 
where toh_cocde = @toh_cocde and 
toh_toordno >= @toh_toordnoFrom and
toh_toordno <= @toh_toordnoTo and 
len(rtrim(toh_toordno)) = len(rtrim(@toh_toordnoFrom)) and 
 toh_ordsts = 'OPE'

Open cur_check_prcingkey
Fetch next from cur_check_prcingkey into
@toh_toordno

While @@fetch_status = 0
Begin
           if @toh_toordno <> ''
           begin
		UPDATE	TOORDHDR
		SET	toh_ordsts = @status,
			toh_upddat = getdate(),
			toh_updusr = @user,
			toh_rvsdat = getdate()
			
		where toh_toordno = @toh_toordno

		set @msg = isnull(@msg,'') + ' - ' + @toh_toordno + ' successfully release'
           end

		Declare cur_toorddtl cursor
		for 
		select tod_cocde,tod_cus1no,tod_cus2no,tod_ftyitmno,tod_ftytmpitmno,tod_venno,tod_venitm,tod_pckunt,tod_projqty,tod_toordno,tod_toordseq,tod_qutno,tod_qutseq,tod_verno from TOORDDTL (nolock)
		where tod_cocde = @toh_cocde and tod_toordno = @toh_toordno and tod_latest ='Y'
	
		Open cur_toorddtl 
		fetch next from cur_toorddtl into
		@tod_cocde,@tod_cus1no,@tod_cus2no,@tod_ftyitmno,@tod_ftytmpitmno,@tod_venno,@tod_venitm,@tod_pckunt,@tod_projqty,@tod_toordno,@tod_toordseq,@tod_qutno,@tod_qutseq,@tod_verno
	
		While @@fetch_status = 0
		Begin
			-- Add for gen sap checking logic
			update TOORDDTL set tod_gensapflag = 'Y' where  tod_cocde = @toh_cocde and tod_toordno = @toh_toordno and tod_latest ='Y' and tod_gensapdate = '1900/01/01' and tod_prdven >= 'A' and tod_prdven <= 'Z'	

			select @count = count(*) from dbo.TOITMSUM
			where tis_cus1no = @tod_cus1no and
			tis_cus2no = @tod_cus2no and
			tis_itmno = @tod_ftyitmno and
			tis_tmpitmno = @tod_ftytmpitmno and
			tis_venno = @tod_venno and
			tis_ventimno = @tod_venitm

				if @count = 0
				begin	
					insert into dbo.TOITMSUM
					(tis_cocde, tis_cus1no, tis_cus2no,
					 tis_year, tis_itmtyp, tis_assitm, tis_itmno, 
					 tis_tmpitmno, tis_venno, tis_ventimno, tis_pckunt,
					 tis_toqty, tis_soqty, tis_osqty, tis_creusr, tis_updusr, 
					 tis_credat, tis_upddat)
					 values
					 (@tod_cocde,@tod_cus1no,@tod_cus2no,
					  '','','',@tod_ftyitmno,
					  @tod_ftytmpitmno,@tod_venno,@tod_venitm,@tod_pckunt,
					  0,0,0,
					  @user,@user,getdate(),getdate())
				
				end
				/*else
				begin
					select @current_qty = tid_toqty from dbo.TOITMDTL
					where 
					tid_cus1no = @tod_cus1no and
					tid_cus2no = @tod_cus2no and
					tid_itmno = @tod_ftyitmno and
					tid_tmpitmno = @tod_ftytmpitmno and
					tid_venno = @tod_venno and
					tid_venitmno = @tod_venitm
					
					
					Update TOITMSUM SET
					tis_toqty = tis_toqty + @tod_projqty - @current_qty 
					
					Where
					tis_cus1no = @tod_cus1no and
					tis_cus2no = @tod_cus2no and
					tis_itmno = @tod_ftyitmno and
					tis_tmpitmno = @tod_ftytmpitmno and
					tis_venno = @tod_venno and
					tis_ventimno = @tod_venitm 
				end*/
			

			select @count = count(*) from TOITMDTL
			where 
			tid_toordno = @tod_toordno and
			tid_toordseq = @tod_toordseq
			
				if @count = 0
				begin	
					insert into dbo.TOITMDTL
					(tid_cocde, tid_cus1no, tid_cus2no,
					 tid_year, tid_itmtyp, tid_assitm, tid_itmno,
					 tid_tmpitmno, tid_venno, tid_venitmno, tid_pckunt, 
					 tid_toqty, tid_soqty,tid_osqty, tid_toordno, tid_toordseq,tid_verno, tid_ordno,
					 tid_ordseq, tid_creusr, tid_updusr, tid_credat, tid_upddat)
					 values
					 (@tod_cocde,@tod_cus1no,@tod_cus2no,
					  '','','',@tod_ftyitmno,
					  @tod_ftytmpitmno,@tod_venno,@tod_venitm,@tod_pckunt,
					  @tod_projqty,0,@tod_projqty,@tod_toordno,@tod_toordseq,@tod_verno,@tod_qutno,
					  @tod_qutseq , @user,@user,getdate(),getdate())

				--Full + Update
					Update TOITMSUM SET
					tis_toqty = tis_toqty + @tod_projqty,
					tis_osqty = tis_toqty + @tod_projqty - tis_soqty,
					tis_updusr = @user,
					tis_upddat = getdate()
					
					Where
					tis_cus1no = @tod_cus1no and
					tis_cus2no = @tod_cus2no and
					tis_itmno = @tod_ftyitmno and
					tis_tmpitmno = @tod_ftytmpitmno and
					tis_venno = @tod_venno and
					tis_ventimno = @tod_venitm
				end
				else
				begin

					select @current_qty = tid_toqty from dbo.TOITMDTL
					where 
					tid_cus1no = @tod_cus1no and
					tid_cus2no = @tod_cus2no and
					tid_itmno = @tod_ftyitmno and
					tid_tmpitmno = @tod_ftytmpitmno and
					tid_venno = @tod_venno and
					tid_venitmno = @tod_venitm and 
					tid_toordno = @tod_toordno and 
					tid_toordseq = @tod_toordseq
				
					Update TOITMDTL SET
					tid_verno = tid_verno + 1,
					tid_toqty = @tod_projqty,
					tid_osqty = @tod_projqty - tid_soqty,
					tid_updusr = @user,
					tid_upddat = getdate()
					Where
					tid_toordno = @tod_toordno and
					tid_toordseq = @tod_toordseq

				-- + - Update
					Update TOITMSUM SET
					tis_toqty = tis_toqty + @tod_projqty - @current_qty,
					tis_osqty = tis_toqty + @tod_projqty - @current_qty - tis_soqty,
					tis_updusr = @user,
					tis_upddat = getdate()
					
					Where
					tis_cus1no = @tod_cus1no and
					tis_cus2no = @tod_cus2no and
					tis_itmno = @tod_ftyitmno and
					tis_tmpitmno = @tod_ftytmpitmno and
					tis_venno = @tod_venno and
					tis_ventimno = @tod_venitm
				end
			
			
			

			 Fetch next from cur_toorddtl into
          			 @tod_cocde,@tod_cus1no,@tod_cus2no,@tod_ftyitmno,@tod_ftytmpitmno,@tod_venno,@tod_venitm,@tod_pckunt,@tod_projqty,@tod_toordno,@tod_toordseq,@tod_qutno,@tod_qutseq,@tod_verno
		End
		Close cur_toorddtl
		Deallocate cur_toorddtl
			
           Fetch next from cur_check_prcingkey into
           @toh_toordno
End
Close cur_check_prcingkey
Deallocate cur_check_prcingkey


/**UPDATE	TOORDHDR
SET		toh_ordsts = @status,
		toh_upddat = getdate(),
		toh_updusr = @user,
		toh_verno = toh_verno + 1
		where
		toh_cocde = @toh_cocde and
		toh_toordno >= @toh_toordnoFrom and
		toh_toordno <= @toh_toordnoTo and
		len(rtrim(toh_toordno)) = len(rtrim(@toh_toordnoFrom))
		and toh_ordsts = 'REL' */
		 
end
else
begin
--update to ope
Declare cur_check_prcingkey cursor
for
select 
toh_toordno from TOORDHDR (nolock) 
where toh_cocde = @toh_cocde and 
toh_toordno >= @toh_toordnoFrom and
toh_toordno <= @toh_toordnoTo and 
len(rtrim(toh_toordno)) = len(rtrim(@toh_toordnoFrom)) and 
 toh_ordsts = 'REL'

Open cur_check_prcingkey
Fetch next from cur_check_prcingkey into
@toh_toordno

While @@fetch_status = 0
Begin
           if @toh_toordno <> ''
           begin
		UPDATE	TOORDHDR
		SET	toh_ordsts = @status,
			toh_upddat = getdate(),
			toh_updusr = @user,
			toh_verno = toh_verno + 1,
			toh_rvsdat = getdate()
		where toh_toordno = @toh_toordno

		set @msg = isnull(@msg,'') + ' - ' + @toh_toordno + ' successfully unrelease'
           end
 Fetch next from cur_check_prcingkey into
           @toh_toordno
End
Close cur_check_prcingkey
Deallocate cur_check_prcingkey
end

select @msg

GO
GRANT EXECUTE ON [dbo].[sp_update_TOORDHDR_TOM00003] TO [ERPUSER] AS [dbo]
GO
