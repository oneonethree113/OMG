/****** Object:  StoredProcedure [dbo].[sp_MPOXLS_Hdr]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_MPOXLS_Hdr]
GO
/****** Object:  StoredProcedure [dbo].[sp_MPOXLS_Hdr]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



/*  
=========================================================  
Program ID : sp_MPOXLS_Hdr  
Description    :   
Programmer   : Lester Wu  
Create Date    :  
Last Modified   :   
Table Read(s)  :  
Table Write(s)  :  
=========================================================  
 Modification History                                      
=========================================================  
Date  Author  Description  
=========================================================       
  
*/  
  
--sp_help MPOXLSHDR  
  
CREATE   procedure [dbo].[sp_MPOXLS_Hdr]  
@Mxh_PONo as varchar(20),  
@Mxh_VenNo as varchar(10),              
@Mxh_PODat as datetime,  
@Mxh_POUsr as nvarchar(50),  
@Mxh_ConUsr as nvarchar(50),  
@Mxh_ConDat as datetime,  
@Mxh_CntUsr as nvarchar(50),  
@Mxh_Curr as varchar(10),  
@Mxh_ImpFty as nvarchar(50),  
@Mxh_ShpPlc as nvarchar(50),  
@Mxh_Rmk as nvarchar(300),  
@Mxh_UpdFlg as varchar(3),  
@FileName as nvarchar(50),  
@DUMMY as char(1)  
  
as  
BEGIN  
  
 Declare  
  @tmp_VenNo as varchar(10),              
  @tmp_PODat as datetime,  
  @tmp_POUsr as nvarchar(50),  
  @tmp_ConUsr as nvarchar(50),  
  @tmp_ConDat as datetime,  
  @tmp_CntUsr as nvarchar(50),  
  @tmp_Curr as varchar(10),  
  @tmp_ImpFty as nvarchar(50),  
  @tmp_ShpPlc as nvarchar(50),  
  @tmp_Rmk as nvarchar(300),   
  @changeLog as varchar(200)  
  
 Declare  @errMsg as nvarchar(200),  
  @Flag as char(1),  
  @MPO as varchar(20),  
  @intCount as numeric(9,0),  
  @VenNo as varchar(20),  
  @Curr as varchar(20)  
   
 set @errMsg = ''  
 set @Flag = 'N' --NEW  
 set @MPO = ''   
    
 set @Curr = case @Mxh_curr when '港幣' then 'HKD'  
       when '美元' then 'USD'  
       when '人民幣' then 'RMB'  
       when '新台幣' then 'TWD'  
       else '' end  
  
 --replace(replace(replace(replace(@Mxh_curr,'港幣','HKD'),'美元','USD'),'人民幣','RMB'),'新台幣','TWD')  
 select @MPO = max(isnull(Mxd_MPONo,'')) from MPOXLSDTL where Mxd_PONo = @Mxh_PONo  
-- Added by Mark Lau 20090803
and mxd_credat >= '2009-01-01'
 select @intCount = count(1) from MPOXLSHDR where Mxh_PONo = @Mxh_PONo  
   
 -- 1.  Check Record Exist or Not,   
 -- 2.  Check HK Side Purchase Order Generated or Not,   
 --  i. Error if Generated  
 --  ii. Mark Existing Record to 'Old' if not Generated  
 -- 3.  When Generate HK MPO, Program Should Check the TimeStamp before generate  
 -- 4.  Maintenance a list of ZS's Item No, Name, Description and default Category  
  
 if @Curr = ''   
 begin  
  set @Flag = 'R'  
  set @errMsg = @errMsg + case when len(@errMsg) > 0 then ' | ' else '' end  + 'Invalid Currency'  
 end  
 else  
 begin  
  set @Mxh_curr = @Curr  
 end  
  
 set @VenNo = ltrim(rtrim(@Mxh_VenNo))  
  
 select @VenNo=isnull(vbi_venno,@Mxh_VenNo) from VNBASINF where isnull(vbi_prcvenno,'') = @Mxh_VenNo and @Mxh_VenNo <> ''  
  
 if upper(@Mxh_UpdFlg) <> 'DEL' and ( (select count(1) from VNBASINF where vbi_venno = @VenNo and @VenNo <> '') <= 0 )  
 begin  
  set @errMsg = @errMsg + case when len(@errMsg) > 0 then ' | ' else '' end  + 'Ven # Not Found'  
  set @Flag = 'E'  
 end  
  
 if @Mxh_ImpFty = ''   
 begin  
  set @errMsg = @errMsg + case when len(@errMsg) > 0 then ' | ' else '' end  + 'Custom Fty Empty'  
  set @Flag = 'R'    
 end  
 else if ((select Count(1) from GRNVENINF where gvi_vensna = @Mxh_ImpFty) <= 0 )  
 begin  
  set @errMsg = @errMsg + case when len(@errMsg) > 0 then ' | ' else '' end  + 'Custom Fty Invalid'  
  set @Flag = 'E'    
 end  
  
  
  
  
 if isnull(@MPO,'') <> ''   
 begin  
  --set @Flag = 'E'  
  set @errMsg = @errMsg + case when len(@errMsg) > 0 then ' | ' else '' end  + 'PO Generated (' + @MPO + ')'  
    
  set @tmp_VenNo = ''  
  set @tmp_PODat = '1900/01/01'  
  set @tmp_POUsr = ''  
  set @tmp_ConUsr = ''  
  set @tmp_ConDat = '1900/01/01'  
  set @tmp_CntUsr = ''  
  set @tmp_Curr = ''  
  set @tmp_ImpFty = ''  
  set @tmp_ShpPlc = ''  
  set @tmp_Rmk = ''  
  set @changeLog = ''  
    
  select   
   @changeLog = 'Y' ,   
   @tmp_VenNo = isnull(Mxh_VenNo , '') ,   
   @tmp_PODat = isnull(Mxh_PODat ,  '1900/01/01') ,   
   @tmp_POUsr = isnull(Mxh_POUsr ,  '') ,   
   @tmp_ConUsr = isnull(Mxh_ConUsr ,  '') ,   
   @tmp_ConDat = isnull(Mxh_ConDat ,  '1900/01/01') ,   
   @tmp_CntUsr = isnull(Mxh_CntUsr ,  '') ,   
   @tmp_Curr = isnull(Mxh_Curr ,  '') ,   
   @tmp_ImpFty = isnull(Mxh_ImpFty ,  '') ,   
   @tmp_ShpPlc = isnull(Mxh_ShpPlc ,  '') ,   
   @tmp_Rmk = isnull(Mxh_Rmk ,  '')   
  from  
   MPOXLSHDR  
  where  
   Mxh_PONo = @Mxh_PONo  
  order by   
   Mxh_Credat  
    
  if @changeLog = 'Y'  
  begin  
   set @changeLog = ''  
  
   if @tmp_VenNo <> isnull(@Mxh_VenNo , '')   
   begin  
    set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Ven#'  
   end  
   if @tmp_PODat <> isnull(@Mxh_PODat ,  '1900/01/01')   
   begin  
    set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'PO Date'  
   end   
   if @tmp_POUsr <> isnull(@Mxh_POUsr ,  '')    
   begin  
    set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'PO User'  
   end  
   if @tmp_ConUsr <> isnull(@Mxh_ConUsr ,  '')    
   begin  
    set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Cont.User'  
   end  
   /*  
   if @tmp_ConDat <> isnull(@Mxh_ConDat ,  '1900/01/01')    
   begin  
    set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Confirm Date'  
   end  
   */  
   if @tmp_CntUsr <> isnull(@Mxh_CntUsr ,  '')    
   begin  
    set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Contact User'  
   end  
   if @tmp_Curr <> isnull(@Mxh_Curr ,  '')    
   begin  
    set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Curr.'  
   end  
   if @tmp_ImpFty <> isnull(@Mxh_ImpFty ,  '')    
   begin  
    set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Import Fty'  
   end  
   if @tmp_ShpPlc <> isnull(@Mxh_ShpPlc ,  '')    
   begin  
    set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Ship Place'  
   end  
   if @tmp_Rmk <> isnull(@Mxh_Rmk ,  '')    
   begin  
    set @changeLog = @changeLog + case len(@changeLog) when 0 then '' else ' / ' end + 'Rmk'  
   end  
  
   if @changeLog = ''   
   begin  
    set @Flag = 'O'  
   end  
   else  
   begin  
    set @Flag = 'E'  
    set @changeLog = '[ Change of:- ' + @changeLog + ' ]'  
   end  
  
  end  
  else  
  begin  
   set @Flag = 'N'  
  end  
     
  
  
 end  
 else if @Flag <> 'E' and @Flag <> 'R'  
 begin  
  if upper(@Mxh_UpdFlg) = 'DEL'  
  begin  
   set @Flag = 'D'  
   set @errMsg = 'Existing Record Marked "Old"'     
  
   Update MPOXLSDTL set Mxd_MpoFlg = 'O', Mxd_Expt = Mxd_Expt + case when len(Mxd_Expt) >  0 then ' | ' else '' end + 'Hdr Record Marked Delete', Mxd_UpdUsr = 'XML_UPLOAD' , Mxd_UpdDat = getdate()  
   Where Mxd_PONo = @Mxh_PONo and Mxd_MpoFlg <> 'G'  
  
   Update MPOXLSHDR set Mxh_MPOFlg = 'O', Mxh_Expt = Mxh_Expt + case when len(Mxh_Expt) > 0 then ' | ' else '' end + 'Hdr Record Marked Delete!' , Mxh_UpdUsr = 'XML_UPLOAD' , Mxh_UpdDat = getdate()  
   where Mxh_PONo = @Mxh_PONo and Mxh_MpoFlg <> 'G'  
  end  
  else   
  begin  
   Set @Flag = 'N'  
   set @errMsg = 'Existing Record Marked "Old"'  
  
   Update MPOXLSHDR set Mxh_MPOFlg = 'O', Mxh_UpdUsr = 'XML_UPLOAD' , Mxh_UpdDat = getdate()  
   where Mxh_PONo = @Mxh_PONo and Mxh_MpoFlg <> 'G'  
  end  
 end  
    
  
  
 if @Flag = 'E' or @Flag = 'R'  
 begin  
    
  Update MPOEXPHDR set mxh_mpoflg = 'O' , mxh_upddat = getdate(), mxh_updusr = 'XML UPLOAD'  
  where mxh_MpoFlg = 'E' and mxh_pono = @Mxh_PONo  
      


  insert into MPOEXPHDR (  
   Mxh_FilNam,  
   Mxh_seq,  
   Mxh_PONo,  
   Mxh_VenNo,  
   Mxh_PODat,  
   Mxh_POUsr,  
   Mxh_ConUsr,  
   Mxh_ConDat,  
   Mxh_CntUsr,  
   Mxh_Curr,  
   Mxh_ImpFty,  
   Mxh_ShpPlc,  
   Mxh_Rmk,  
   Mxh_UpdFlg,  
   Mxh_Expt,  
   Mxh_MPOFlg,  
   Mxh_MPONO,  
   Mxh_CreDat,  
   Mxh_CreUsr,  
   Mxh_UpdDat,  
   Mxh_UpdUsr  
     
  )  
  select   
    isnull(@FileName,  ''),
   isnull(max(Mxh_Seq),0) + 1,  
    isnull(@Mxh_PONo,  ''),
    isnull(@Mxh_VenNo,  ''),
    isnull(@Mxh_PODat,  ''),
    isnull(@Mxh_POUsr,  ''),
    isnull(@Mxh_ConUsr,  ''),
    isnull(@Mxh_ConDat,  ''),
    isnull(@Mxh_CntUsr,  ''),
    isnull(@Mxh_Curr,  ''),
   isnull( @Mxh_ImpFty, ''), 
    isnull(@Mxh_ShpPlc,  ''),
   isnull( @Mxh_Rmk,  ''),
    isnull(@Mxh_UpdFlg, ''), 
    isnull(@errMsg + case when len(@errMsg) > 0 then ' ' else '' end +  isnull(@changeLog, '') , ''),
   ltrim(rtrim(@Flag)),  
   '',  
   getdate(),  
   'XML UPLOAD',  
   getdate(),  
   'XML UPLOAD'  
  from   
   MPOEXPHDR  
  where   
   Mxh_FilNam = @FileName  
  
 end  
-- else  
-- begin  
    
  Update MPOXLSHDR set Mxh_Latest = 'N', Mxh_UpdUsr = 'XML_UPLOAD' , Mxh_UpdDat = getdate()  
  where Mxh_PONo = @Mxh_PONo and Mxh_Latest = 'Y'  
  
  insert into MPOXLSHDR (  
   Mxh_FilNam,  
   Mxh_seq,  
   Mxh_PONo,  
   Mxh_VenNo,  
   Mxh_PODat,  
   Mxh_POUsr,  
   Mxh_ConUsr,  
   Mxh_ConDat,  
   Mxh_CntUsr,  
   Mxh_Curr,  
   Mxh_ImpFty,  
   Mxh_ShpPlc,  
   Mxh_Rmk,  
   Mxh_UpdFlg,  
   Mxh_Expt,  
   Mxh_MPOFlg,  
   Mxh_MPONO,  
   Mxh_CreDat,  
   Mxh_CreUsr,  
   Mxh_UpdDat,  
   Mxh_UpdUsr  
     
  )  
  select   
   @FileName,  
   isnull(max(Mxh_Seq),0) + 1,  
   isnull(@Mxh_PONo, ''),
   isnull(@VenNo,    ''),
   --@Mxh_VenNo,  ''),
   isnull(@Mxh_PODat,''),  
   isnull(@Mxh_POUsr,  ''),
   isnull(@Mxh_ConUsr,  ''),
   isnull(@Mxh_ConDat,  ''),
   isnull(@Mxh_CntUsr,  ''),
   isnull(@Mxh_Curr,  ''),
   isnull(@Mxh_ImpFty, ''), 
   isnull(@Mxh_ShpPlc,  ''),
   isnull(@Mxh_Rmk,  ''),
   isnull(@Mxh_UpdFlg, ''), 
   isnull(@errMsg + case when len(@errMsg) > 0 then ' ' else '' end + isnull( @changeLog, '') , ''),
   ltrim(rtrim(@Flag)),  
   '',  
   getdate(),  
   'XML UPLOAD',  
   getdate(),  
   'XML UPLOAD'  
  from   
   MPOXLSHDR  
  where   
   Mxh_FilNam = @FileName  
-- end  
END



GO
GRANT EXECUTE ON [dbo].[sp_MPOXLS_Hdr] TO [ERPUSER] AS [dbo]
GO
