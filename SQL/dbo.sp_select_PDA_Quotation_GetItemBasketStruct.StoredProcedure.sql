/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Quotation_GetItemBasketStruct]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PDA_Quotation_GetItemBasketStruct]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Quotation_GetItemBasketStruct]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO






/*
=========================================================
Description   	: sp_select_PDA_Quotation_GetItemBasket
Programmer  	: Mark Lau
Create Date   	: 2008-06-18
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      Initial  	Description                          
=========================================================    */ 
CREATE procedure [dbo].[sp_select_PDA_Quotation_GetItemBasketStruct]

as

exec sp_select_PDA_Quotation_GetItemBasket '9999999999','',''





GO
GRANT EXECUTE ON [dbo].[sp_select_PDA_Quotation_GetItemBasketStruct] TO [ERPUSER] AS [dbo]
GO
