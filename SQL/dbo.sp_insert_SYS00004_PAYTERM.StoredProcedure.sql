/****** Object:  StoredProcedure [dbo].[sp_insert_SYS00004_PAYTERM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SYS00004_PAYTERM]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SYS00004_PAYTERM]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE procedure [dbo].[sp_insert_SYS00004_PAYTERM]

@cocde	as nvarchar(6),                                                                                                                                                                                                                                                   
@ypt_zterm	as nvarchar(100),
@ypt_ztagg	as numeric(9),
@ypt_text1	as nvarchar(255),
@dummy		char(1)
			

AS

begin

select * from cubasinf

insert into sypayterm
(
ypt_cocde,
ypt_zterm,
ypt_ztagg,
ypt_text1,
ypt_creusr,
ypt_updusr ,
ypt_credat ,
ypt_upddat 
)
values
(
@cocde,
@ypt_zterm,
@ypt_ztagg,
@ypt_text1,
'SAPUSER',
'SAPUSER',
getdate(),
getdate()

)

end


GO
GRANT EXECUTE ON [dbo].[sp_insert_SYS00004_PAYTERM] TO [ERPUSER] AS [dbo]
GO
