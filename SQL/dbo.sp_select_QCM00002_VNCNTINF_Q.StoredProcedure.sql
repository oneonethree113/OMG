/****** Object:  StoredProcedure [dbo].[sp_select_QCM00002_VNCNTINF_Q]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCM00002_VNCNTINF_Q]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCM00002_VNCNTINF_Q]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_select_QCM00002_VNCNTINF_Q]
	@vci_typ nvarchar(3), 
	@vci_venno nvarchar(6)
AS
BEGIN
	if @vci_typ = 'ALL'
	BEGIN
		SELECT 
			vci_venno, 
			vci_cnttyp, 
			vci_adr = isnull(vci_adr,''),
			vci_cty = isnull(vci_cty, ''), 
			vci_stt = isnull(vci_stt, ''),
			vci_city = isnull(vci_city, ''), 
			vci_town = isnull(vci_town, ''),
			vci_zip = isnull(vci_zip, '')
		FROM 
			VNCNTINF
		WHERE 
			vci_venno = @vci_venno and 
			vci_cnttyp in ('C', 'Q')
			--(vci_cnttyp = 'C' OR vci_cnttyp = 'Q' OR vci_cnttyp = 'M')
	END
	ELSE IF @vci_typ = ''
	BEGIN
		SELECT 
			vci_venno ='', 
			vci_cnttyp ='', 
			vci_adr = '',
			vci_cty = '',
			vci_stt = '',
			vci_city = '',
			vci_town = '',
			vci_zip = ''
		
	
	
	END
	
END

GO
GRANT EXECUTE ON [dbo].[sp_select_QCM00002_VNCNTINF_Q] TO [ERPUSER] AS [dbo]
GO
