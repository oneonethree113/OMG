/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Item_GetRelItem]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PDA_Item_GetRelItem]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Item_GetRelItem]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
=========================================================
Description   	: sp_select_PDA_Item_GetRelItem
Programmer  	: Mark LAu
Create Date   	: 2008-06-10
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      		Initial  		Description                          
=========================================================     
2008-06-10 		Mark Lau	Get Related Item of Item No. in New Item Number Format
	
*/

CREATE procedure [dbo].[sp_select_PDA_Item_GetRelItem]
@itmno nvarchar(20)
as

declare @Seq	as int
declare @icf_itmno as nvarchar(20)
declare @icf_colcde as nvarchar(50)
declare @cnt as int

set @Seq = 0
set @icf_itmno = ''
set @icf_colcde = ''
set @cnt = 0

Select 
	 0 as 'Seq' , 
	isnull( icf_itmno,'') as 'ItemNo' , 
	isnull( icf_colcde,'') as 'ColorCode' 
into #temp_item
from 
	imcolinf(nolock) 
where 
	icf_itmno like substring(@itmno,1,11) + '%' and icf_itmno <> @itmno
order by icf_itmno, icf_colcde asc

DECLARE item_cursor CURSOR FOR 
select * from #temp_item


OPEN item_cursor

FETCH NEXT FROM item_cursor 
INTO @Seq, @icf_itmno, @icf_colcde

WHILE @@FETCH_STATUS = 0
BEGIN

set @cnt = @cnt + 1
update  #temp_item
set [Seq] = @cnt
where [ItemNo] = @icf_itmno and [ColorCode] = @icf_colcde

FETCH NEXT FROM item_cursor 
INTO @Seq, @icf_itmno, @icf_colcde
END

CLOSE item_cursor
DEALLOCATE item_cursor

select * from #temp_item order by [Seq] asc





GO
GRANT EXECUTE ON [dbo].[sp_select_PDA_Item_GetRelItem] TO [ERPUSER] AS [dbo]
GO
