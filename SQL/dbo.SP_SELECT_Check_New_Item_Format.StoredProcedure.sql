/****** Object:  StoredProcedure [dbo].[SP_SELECT_Check_New_Item_Format]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[SP_SELECT_Check_New_Item_Format]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_Check_New_Item_Format]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


/*
Created by Mark Lau, 20060913

*/

CREATE  PROCEDURE [dbo].[SP_SELECT_Check_New_Item_Format]
@COCDE NVARCHAR(6),
@ITMNO NVARCHAR(20),
@Checked_ITMNO	NVARCHAR(20) output
AS

Begin
set @Checked_ITMNO = '@@@@@'

--Check whether > 13
if len(@ITMNO) < 11 or charindex('-',@ITMNO) > 0 or charindex('/',@ITMNO) > 0
Begin
set @Checked_ITMNO = @ITMNO
print @ITMNO
end

--Check whether vendor A or B
if upper(substring(@ITMNO, 3, 1))  <> 'A' And upper(substring(@ITMNO, 3, 1)) <>'B' 
Begin
set @Checked_ITMNO = @ITMNO
end




if @Checked_ITMNO = '@@@@@'
Begin

--Check whether is Assortment
If UPPER(substring(@ITMNO, 7, 2)) = 'AS' And Right(@ITMNO, 2) <> '00'
Begin
set @Checked_ITMNO = @ITMNO
End

If UPPER(substring(@ITMNO, 7, 2)) <> 'AS'
Begin

--For Vendor A
if upper(substring(@ITMNO, 3, 1)) = 'A'
begin
If (substring(@ITMNO, 4, 1) >= '0' And substring(@ITMNO, 4, 1) <= '9' ) And (substring(@ITMNO, 5, 1) >= '0' And substring(@ITMNO, 5, 1) <= '9' ) And  (substring(@ITMNO, 6, 1) >= '0' And substring(@ITMNO, 6, 1) <= '9')
Begin
set @Checked_ITMNO = substring(@ITMNO,1,11)
print @Checked_ITMNO
End
end

Else
--For Vendor B
if upper(substring(@ITMNO, 3, 1)) = 'B'
Begin
--For NNN
If (substring(@ITMNO, 4, 1) >= '0' And substring(@ITMNO, 4, 1) <= '9' ) And (substring(@ITMNO, 5, 1) >= '0' And substring(@ITMNO, 5, 1) <= '9' ) And  (substring(@ITMNO, 6, 1) >= '0' And substring(@ITMNO, 6, 1) <= '9')
Begin
set @Checked_ITMNO = substring(@ITMNO,1,11)
print @Checked_ITMNO
End

Else
--For SNN
If (substring(@ITMNO, 4, 1) >= 'A' And substring(@ITMNO, 4, 1) <= 'Z' ) And (substring(@ITMNO, 5, 1) >= '0' And substring(@ITMNO, 5, 1) <= '9' ) And  (substring(@ITMNO, 6, 1) >= '0' And substring(@ITMNO, 6, 1) <= '9')
Begin
set @Checked_ITMNO = substring(@ITMNO,1,11)
print @Checked_ITMNO
End


end


end
               
                
                



End


End


GO
GRANT EXECUTE ON [dbo].[SP_SELECT_Check_New_Item_Format] TO [ERPUSER] AS [dbo]
GO
