/****** Object:  StoredProcedure [dbo].[sp_select_IMITMCUSSTY_old]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMITMCUSSTY_old]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMITMCUSSTY_old]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/*  
=========================================================  
Program ID : sp_select_IMITMCUSSTY_old
Description    :   
Programmer   : Frankie Cheung  
Create Date    :   
Last Modified   :   
Table Read(s)  :  
Table Write(s)  :  
=========================================================  
 Modification History                                      
=========================================================  
 Date        Initial    Description                            
=========================================================      
 Select old/reject records from IMITMCUSSTY by itmno, cusno
*/

CREATE PROCEDURE [dbo].[sp_select_IMITMCUSSTY_old]   

@cocde	nvarchar(6), 
@iic_itmno	nvarchar(20),
@iic_cusno	nvarchar(20) 
  
AS  

BEGIN

	select  
		'999' as no,
		iic_sts,
		iic_itmno,
		iic_cusno,
		iic_cusstyno,
		iic_mode,
		isnull(iic_sysmsg,'') as 'iic_sysmsg',
		iic_filnam,
		iic_upload,
		iic_seq,
		iic_creusr,
		iic_updusr,
		iic_credat,
		iic_upddat
	from	
		IMITMCUSSTY
	where 
		iic_itmno = @iic_itmno and
		iic_cusno = @iic_cusno and
		iic_sts = 'O' or iic_sts = 'R' or iic_sts = 'A'
		

END


GO
GRANT EXECUTE ON [dbo].[sp_select_IMITMCUSSTY_old] TO [ERPUSER] AS [dbo]
GO
