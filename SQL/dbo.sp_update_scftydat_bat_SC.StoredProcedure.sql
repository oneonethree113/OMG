/****** Object:  StoredProcedure [dbo].[sp_update_scftydat_bat_SC]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_scftydat_bat_SC]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_scftydat_bat_SC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO














CREATE   procedure [dbo].[sp_update_scftydat_bat_SC]

@cocde	nvarchar(6),
@lotno		nvarchar(255),
@filename	nvarchar(255),
@jobord	nvarchar(30),
@zi01		numeric(13,4),
@zi01_curr	nvarchar(6),
@ftycv		nvarchar(6),
@ftypv		nvarchar(6),
@usrid		nvarchar(30)
AS

declare @scno as nvarchar(20)
declare @scseq as int
declare @pono as nvarchar(20)
declare @poseq as int
declare @scbomcst as numeric(13,4)
declare @scftyprc as numeric(13,4)
declare @scftycst as numeric(13,4)
declare @currdt as datetime
declare @scpv as nvarchar(10)
declare @sccv as nvarchar(10)
declare @updpo as nvarchar(1)
declare @chgfty as nvarchar(1)
declare @itmno as nvarchar(30)

set @scno = ''
set @scseq = 0
set @pono = ''
set @poseq = 0
set @currdt = getdate()
set @scpv = ''
set @sccv = ''
set @updpo = 'N'
set @chgfty = 'N'
set @scftycst = 0
set @itmno = ''

begin

select 
@scseq = isnull(sod_ordseq,0) ,
@scno = isnull(sod_ordno,''),
@pono = isnull(pod_purord,''),
@poseq =  isnull(pod_purseq,0),
@scbomcst = cast(round(isnull(sod_bomcst,0) ,2,1) as numeric(11,2)),
@scftycst =  cast(round(isnull(sod_ftycst,0) ,2,1) as numeric(11,2)),--isnull(sod_ftycst,0),
@scftyprc =  cast(round(isnull(sod_ftyprc,0) ,2,1) as numeric(11,2)),--isnull(sod_ftyprc,0),
@scpv =  isnull(sod_venno,''),
@sccv =  isnull(sod_cusven,''),
@itmno = isnull(sod_itmno,'')
from scorddtl (nolock)
left join poorddtl (nolock) on sod_ordno = pod_scno and sod_ordseq = pod_scline
where pod_jobord = @jobord

/*
if ( @ftycv = '3041' and @sccv = 'A' ) or ( @ftycv = '3041'  and @sccv = 'B' ) or ( @ftycv = '3041'  and @sccv = 'U' )
begin
	set @ftycv = @sccv
end
else if  ( @ftycv = '3051' and @sccv = 'C' ) or ( @ftycv = '3051'  and @sccv = 'D' )
begin
	set @ftycv = @sccv
end
else
begin
	select  @ftycv = ysi_cde from sysetinf 
	where ysi_typ = '23'
	and ysi_sapcde = @ftycv
end 
*/

if  ( @scpv <> @ftypv )  or ( @sccv <> @ftycv ) 
begin
set @chgfty = 'Y'
end

if  @chgfty = 'N'
begin
set @updpo = 'Y'
end





if ( @scno<> '' ) and ( @scseq <> 0 ) and  ( @pono<> '' ) and ( @poseq <> 0 ) 
	begin
	
	if (select count(*) from imveninf where ivi_itmno = @itmno and ivi_venno = @ftypv ) = 9 
		begin

			insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after, sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
			values(@cocde,@lotno,@filename,@jobord ,'09',@scpv,@ftypv,'S','',@usrid,@currdt,@usrid,@currdt)

			if ( select count(*) from SCFDBHDR 
			where sbh_cocde = @cocde and
			sbh_lotno = @lotno and sbh_filename = @filename and
			sbh_jobord = @jobord) = 0 
				begin
				
				insert into SCFDBHDR(sbh_cocde,sbh_lotno,sbh_filename,sbh_jobord,sbh_ordno,sbh_ordseq,sbh_purord,sbh_purseq,sbh_creusr,sbh_credat,sbh_updusr,sbh_upddat)
				values(@cocde,@lotno,@filename,@jobord ,@scno,@scseq,@pono,@poseq,@usrid,@currdt,@usrid,@currdt)
				
				end		
			
		end
	else
		begin

	
		-- Update PV Price
		update scorddtl
		set 
		sod_updusr = @usrid,
		sod_upddat = @currdt,
		sod_ftycst = @zi01  - @scbomcst,
		sod_ftyprc = @zi01,
		sod_updpo = @updpo,
		sod_chgfty = @chgfty,
		sod_venno = @ftypv,
		sod_cusven = @ftycv,
		sod_tradeven = @ftycv,
		sod_examven = @ftycv
		--sod_ftyprc = sod_ftycst + sod_bomcst
		where
		sod_ordno = @scno
		and sod_ordseq = @scseq
		
			if (  @@rowcount > 0 )
			begin
			
				-- SC FTY CST 
				--if ( @scftycst <> @zi01- @scbomcst )
				--begin
					insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after, sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
					values(@cocde,@lotno,@filename,@jobord ,'01',cast(@scftycst as nvarchar(255)),cast(round(@zi01- @scbomcst,2,1) as nvarchar(255)),'S','',@usrid,@currdt,@usrid,@currdt)
				--end
				-- SC FTY PRC
				--if ( @scftyprc <> @zi01  )
				--begin
					insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after,sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
					values(@cocde,@lotno,@filename,@jobord ,'02',cast((@scftyprc) as nvarchar(255) ),cast(round(@zi01,2,1 ) as nvarchar(255)),'S','',@usrid,@currdt,@usrid,@currdt)
				--end
				
				-- SC CV
				--if (@sccv <> @ftycv  )
				--begin
					insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after, sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
					values(@cocde,@lotno,@filename,@jobord ,'05',cast(@sccv as nvarchar(255)),cast(@ftycv as nvarchar(255)),'S','',@usrid,@currdt,@usrid,@currdt)
				--end
	
				-- SC PV
				--if (@scpv <> @ftypv)
				--begin
					insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after, sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
					values(@cocde,@lotno,@filename,@jobord ,'06',cast(@scpv as nvarchar(255)),cast(@ftypv as nvarchar(255)),'S','',@usrid,@currdt,@usrid,@currdt)
				--end
	
				 
	
	
				if ( select count(*) from SCFDBHDR 
				where sbh_cocde = @cocde and
				sbh_lotno = @lotno and sbh_filename = @filename and
				sbh_jobord = @jobord) = 0 
					begin
					
					insert into SCFDBHDR(sbh_cocde,sbh_lotno,sbh_filename,sbh_jobord,sbh_ordno,sbh_ordseq,sbh_purord,sbh_purseq,sbh_creusr,sbh_credat,sbh_updusr,sbh_upddat)
					values(@cocde,@lotno,@filename,@jobord ,@scno,@scseq,@pono,@poseq,@usrid,@currdt,@usrid,@currdt)
					
					end
		
			end
	
		end
	end 
else
	begin
	-- SC no. not found
	if ( @scno = '' ) or ( @scseq = 0 )
		begin
		insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after, sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
		values(@cocde,@lotno,@filename,@jobord ,'','','','F','SC Details not found',@usrid,@currdt,@usrid,@currdt)
		end
	else if ( @pono = '' ) or ( @poseq = 0 )
		begin
		insert into SCFDBDTL (sbd_cocde,sbd_lotno,sbd_filename,sbd_jobord,sbd_chgtyp,sbd_before,sbd_after, sbd_flg,sbd_rmk,sbd_creusr,sbd_credat,sbd_updusr,sbd_upddat)
		values(@cocde,@lotno,@filename,@jobord ,'','','','F','PO Details not found',@usrid,@currdt,@usrid,@currdt)
		end	
	end

	if ( select count(*) from SCFDBHDR 
	where sbh_cocde = @cocde and
	sbh_lotno = @lotno and sbh_filename = @filename and
	sbh_jobord = @jobord) = 0 
		begin
		
		insert into SCFDBHDR(sbh_cocde,sbh_lotno,sbh_filename,sbh_jobord,sbh_ordno,sbh_ordseq,sbh_purord,sbh_purseq,sbh_creusr,sbh_credat,sbh_updusr,sbh_upddat)
		values(@cocde,@lotno,@filename,@jobord ,@scno,@scseq,@pono,@poseq,@usrid,@currdt,@usrid,@currdt)
		
		end

end

GO
GRANT EXECUTE ON [dbo].[sp_update_scftydat_bat_SC] TO [ERPUSER] AS [dbo]
GO
