/****** Object:  StoredProcedure [dbo].[sp_physical_delete_TODTLSHP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_TODTLSHP]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_TODTLSHP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[sp_physical_delete_TODTLSHP]

@tds_cocde	nvarchar(6),
@tds_toordno	nvarchar(10),
@tds_toordseq	int,
@tds_verno	int,
@tds_shpseq	int


AS

begin

delete from TODTLSHP
where
tds_toordno = @tds_toordno	and
tds_toordseq = @tds_toordseq	and
tds_verno = @tds_verno	and
tds_shpseq = @tds_shpseq	
end



GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_TODTLSHP] TO [ERPUSER] AS [dbo]
GO
