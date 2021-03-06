/****** Object:  StoredProcedure [dbo].[sp_select_BJ_rpt_BJEXESUM ]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_BJ_rpt_BJEXESUM ]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_BJ_rpt_BJEXESUM ]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  procedure [dbo].[sp_select_BJ_rpt_BJEXESUM ]                                                                                                                                                                                                                                                                
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
AS
    SET NOCOUNT ON
begin
select * from BJEXESUM 
 where bes_credat > Cast(Replace(cast(DateAdd(Day, Datediff(Day,0, GetDate() -1), 0) as nvarchar(30)),'12:00AM','14:59') as datetime)
order by bes_pgid,bes_credat  
end

GO
GRANT EXECUTE ON [dbo].[sp_select_BJ_rpt_BJEXESUM ] TO [ERPUSER] AS [dbo]
GO
