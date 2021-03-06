/****** Object:  StoredProcedure [dbo].[sp_update_PKORDHDR]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_PKORDHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_PKORDHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  procedure [dbo].[sp_update_PKORDHDR]
                                                                                                                                                                                                                                                                 
@cocde nvarchar(6),
@ordno nvarchar(20),
@deldate datetime ,
@dremark nvarchar(1000),
@iremark nvarchar(1000),
@shpstr datetime,
@shpend datetime,
@fty nvarchar(20),
@address nvarchar(300),
@ttlamt numeric(13,4),

@State nvarchar(50),
@cntry nvarchar(50),
@zip nvarchar(50),

@cntper nvarchar(20),
@tel nvarchar(20),

@address_fty nvarchar(300),
@State_fty nvarchar(50),
@cntry_fty nvarchar(50),
@zip_fty nvarchar(50),
@cntper_fty nvarchar(20),
@tel_fty nvarchar(20),


@Delamt numeric(13,4),
@TtlDelamt numeric(13,4),
@repflg nvarchar(10),
@user nvarchar(30)


---------------------------------------------- 

 
AS
 

begin

update PKORDHDR set 

poh_dvydat = @deldate,
poh_dremark = @dremark , 
poh_iremark = @iremark , 
poh_updusr = @user ,
poh_upddat = getdate(),
poh_revdat = getdate(),
poh_shpstr = @shpstr,
poh_shpend = @shpend,
poh_fty = @fty,
poh_address = @address,
poh_ttlamt = @ttlamt,

poh_state = @state,
poh_cntry= @cntry,
poh_zip= @zip,

poh_ctnper = @cntper,
poh_tel = @tel,


poh_address_fty = @address_fty,
poh_state_fty = @state_fty,
poh_cntry_fty= @cntry_fty,
poh_zip_fty= @zip_fty,
poh_cntper_fty = @cntper_fty,
poh_tel_fty = @tel_fty,

poh_Delamt = @Delamt,
poh_TtlDelamt = @TtlDelamt,
poh_reprtflg = @repflg

where poh_ordno = @ordno and poh_cocde = @cocde 

end






GO
GRANT EXECUTE ON [dbo].[sp_update_PKORDHDR] TO [ERPUSER] AS [dbo]
GO
