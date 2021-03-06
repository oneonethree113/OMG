/****** Object:  StoredProcedure [dbo].[sp_insert_QUASSINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_QUASSINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_QUASSINF]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








-- Checked by Allan Yuen at 28/07/2003

/*	Author : Tommy Ho	*/

CREATE PROCEDURE [dbo].[sp_insert_QUASSINF] 

@qai_cocde 	nvarchar(6),	@qai_qutno 	nvarchar(20),	
@qai_qutseq 	int,		@qai_itmno 	nvarchar(20),
@qai_assitm 	nvarchar(20),	@qai_assdsc 	nvarchar(800),	
@qai_cusitm	nvarchar(20),	@qai_cusstyno	nvarchar(30), @qai_colcde	nvarchar(30),
@qai_coldsc	nvarchar(300),	

--Added by Mark Lau
@qai_alsitmno	nvarchar(20),	@qai_alscolcde	nvarchar(30),

@qai_cussku           	nvarchar(20),	
@qai_upcean      	nvarchar(15),	@qai_cusrtl	nvarchar(20),	
@qai_untcde 	nvarchar(6),	@qai_inrqty	int,		
@qai_mtrqty	int,	
--Frankie Cheung 2011-02-22 Add Assd IM Period
@qai_imperiod	datetime,
@qai_creusr	nvarchar(30)


AS

insert into [QUASSINF]
(
	qai_cocde ,	qai_qutno ,	qai_qutseq ,
	qai_itmno ,	qai_assitm ,	qai_assdsc ,
	qai_cusitm ,	qai_cusstyno, 	qai_colcde ,	qai_coldsc ,
--Added by Mark Lau
	qai_alsitmno,	qai_alscolcde,
	qai_cussku ,	qai_upcean ,	qai_cusrtl ,		
	qai_untcde ,	qai_inrqty ,	qai_mtrqty ,	
--Frankie Cheung 2011-02-22 Add Assd IM Period
	qai_imperiod,	qai_creusr ,	qai_updusr ,	
	qai_credat ,	qai_upddat 	
)
values
(
	@qai_cocde ,	@qai_qutno ,	@qai_qutseq ,
	@qai_itmno ,	@qai_assitm ,	@qai_assdsc ,
	@qai_cusitm ,	@qai_cusstyno,	@qai_colcde ,	@qai_coldsc ,
--Added by Mark Lau
	@qai_alsitmno,	@qai_alscolcde,
	@qai_cussku ,	@qai_upcean ,	@qai_cusrtl ,
	@qai_untcde ,	@qai_inrqty ,	@qai_mtrqty ,
--Frankie Cheung 2011-02-22 Add Assd IM Period	
	@qai_imperiod,	@qai_creusr ,	@qai_creusr ,	
	getdate() ,	getdate()
)







GO
GRANT EXECUTE ON [dbo].[sp_insert_QUASSINF] TO [ERPUSER] AS [dbo]
GO
