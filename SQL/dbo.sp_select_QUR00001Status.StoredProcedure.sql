/****** Object:  StoredProcedure [dbo].[sp_select_QUR00001Status]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QUR00001Status]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QUR00001Status]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE procedure [dbo].[sp_select_QUR00001Status]

@cocde	 nvarchar(6),
@from	 nvarchar(20),
@to	 nvarchar(20)

AS

SELECT quh_qutno  FROM QUOTNHDR 
where quh_qutno >= @from and  quh_qutno <=  @to
and quh_cocde = @cocde 
and 
(
(quh_qutsts = 'H' or quh_qutsts = 'E' or quh_qutsts = 'I' or quh_qutsts = 'W')
or

--Sub Query Added by Mark Lau 20060922, it aims to check the quotation whether has OLD ITEM
quh_qutno in (
select distinct(qud_qutno) from quotndtl
left join imbasinf on qud_itmno = ibi_itmno
where ibi_itmsts = 'OLD'
)
)


GO
GRANT EXECUTE ON [dbo].[sp_select_QUR00001Status] TO [ERPUSER] AS [dbo]
GO
