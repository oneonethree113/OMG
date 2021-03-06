/****** Object:  StoredProcedure [dbo].[sp_select_SYSOBJECTS]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYSOBJECTS]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYSOBJECTS]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
=========================================================
Program ID	: sp_SELECT
Description   	: 
Programmer  	: Tommy Ho
Create Date   	: 
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      Initial  	Description                          
=========================================================    
05/06/2003 Allan Yuen   Relocate Audit Log Table Location  
*/


CREATE PROCEDURE [dbo].[sp_select_SYSOBJECTS] 

@cocde nvarchar(6) 

AS
select left(name, len(name) - 4) from 
UCPERPDB_AUD..sysobjects 
where xtype = 'U' and right(name, 4) = '_aud' 
order by name







GO
GRANT EXECUTE ON [dbo].[sp_select_SYSOBJECTS] TO [ERPUSER] AS [dbo]
GO
