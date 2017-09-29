/****** Object:  StoredProcedure [dbo].[sp_list_QUOTNHDR_CUM00001]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_QUOTNHDR_CUM00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_QUOTNHDR_CUM00001]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_list_QUOTNHDR_CUM00001]
@cocde as varchar(6),
@cusno as varchar(6),
@ctype as char(1)


AS
IF @CTYPE = 'P' 
	BEGIN
--		select quh_cus1no  from quotnhdr where quh_cus1no = @cusno and quh_cocde = @cocde
		select quh_cus1no  from quotnhdr where quh_cus1no = @cusno --and quh_cocde = @cocde
	END
ELSE
	BEGIN
--		select quh_cus2no  from quotnhdr where quh_cus2no =@cusno  and quh_cocde = @cocde
		select quh_cus2no  from quotnhdr where quh_cus2no =@cusno  
	END







GO
GRANT EXECUTE ON [dbo].[sp_list_QUOTNHDR_CUM00001] TO [ERPUSER] AS [dbo]
GO
