/****** Object:  StoredProcedure [dbo].[sp_list_shipgdtl_cov]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_shipgdtl_cov]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_shipgdtl_cov]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE    procedure [dbo].[sp_list_shipgdtl_cov]
@hid_cocde	nvarchar(6) 

as
--Set @hid_shpseq = (Select isnull(max(hid_shpseq ),0) + 1 from SHIPGDTL Where hid_cocde = @hid_cocde and hid_shpno = @hid_shpno)


select distinct HID_CTRCFS
 from SHIPGDTL_cov
where hid_cocde=@hid_cocde
order by  HID_CTRCFS

--select  @hid_shpseq as 'NewShpSeq'

---------------------------------------------------------------------------------------------------------------------------------------------------------------------







GO
GRANT EXECUTE ON [dbo].[sp_list_shipgdtl_cov] TO [ERPUSER] AS [dbo]
GO
