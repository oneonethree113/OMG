/****** Object:  StoredProcedure [dbo].[sp_select_QCM00002_VNCNTINF_QCFA]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCM00002_VNCNTINF_QCFA]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCM00002_VNCNTINF_QCFA]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_select_QCM00002_VNCNTINF_QCFA]
	@vci_typ nvarchar(3), 
	@vci_venno nvarchar(6)
AS
BEGIN
	if @vci_typ = 'ALL'
	BEGIN
		SELECT 
			vci_venno, 
			vci_cnttyp, 
			vci_cntctp = isnull(vci_cntctp,''),
			vci_cnttil = isnull(vci_cnttil, ''), 
			vci_cntphn = isnull(vci_cntphn, ''),
			vci_cntfax = isnull(vci_cntfax, ''), 
			vci_cnteml = isnull(vci_cnteml, '')
		FROM 
			VNCNTINF
		WHERE 
			vci_venno = @vci_venno and 
			vci_cnttyp in ('QCFA', 'GENL', 'SALE')
			--(vci_cnttyp = 'C' OR vci_cnttyp = 'Q' OR vci_cnttyp = 'M')
	END
	ELSE IF @vci_typ = ''
	BEGIN
		SELECT 
			vci_venno ='', 
			vci_cnttyp ='', 
			vci_cntctp = '',
			vci_cnttil = '',
			vci_cntphn = '',
			vci_cntfax = '',
			vci_cnteml = ''
		
	
	
	END
	
END

GO
GRANT EXECUTE ON [dbo].[sp_select_QCM00002_VNCNTINF_QCFA] TO [ERPUSER] AS [dbo]
GO
