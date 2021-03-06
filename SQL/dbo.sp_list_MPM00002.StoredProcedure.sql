/****** Object:  StoredProcedure [dbo].[sp_list_MPM00002]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_MPM00002]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_MPM00002]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*        
=========================================================        
Program ID : sp_list_MPM00002        
Description    : Letter Head, a list of company header to customer factory        
Programmer   : Lester Wu        
ALTER  Date    :         
Last Modified   : 2005-08-18        
Table Read(s)  :        
Table Write(s)  :        
==================================================================================        
 Modification History                                            
==================================================================================        
 Date        Initial    Description                  
==================================================================================        
 18 Oct 2005 Lester Wu  Show Custom UM        
 10 Mar 2006 Lester Wu  Show MPO records with Delivery Qty > Ship Qty        
==================================================================================             
        
        
select * from MPORDHDR        
sp_list_MPM00002 'd','CURR'        
*/        
        
        
        
CREATE  procedure [dbo].[sp_list_MPM00002]        
@cocde varchar(6),        
@type varchar(10),        
@Fty varchar(50) = ''        
as        
Begin        
        
/*        
if @opt = 'IMPFTY'        
begin        
 select distinct isnull(Mph_ImpFty ,'') as 'VenNam'         
 from MPORDHDR (Nolock)        
 left join MPORDDTL (Nolock) on Mph_MpoNo = Mpd_MpoNo        
 where isnull(Mph_ImpFty ,'') <> '' and Mph_MpoSts = 'ACT' and mpd_mpono is not null and isnull(Mph_ImpFty ,'') <> ''        
end        
else         
*/        
if @type = 'MPO'        
begin        
 if @Fty <> ''         
 begin        
  select         
   distinct Mph_MPONo as 'Mph_MPONo' ,        
   Mph_Curr        
  from         
   MPORDHDR        
   Left Join MPORDDTL on Mph_MPONo = Mpd_MPONo        
  where         
   Mph_MpoSts = 'ACT' and         
   ltrim(rtrim(Mph_ImpFty)) = @Fty and        
   -- Lester Wu 2006-03-11, show records with deliver qty only        
   --isnull(Mpd_Qty,0) - isnull(Mpd_ShpQty,0) > 0         
   isnull(Mpd_DQty,0) - isnull(Mpd_ShpQty,0) > 0         
          
  order by        
   Mph_MpoNo        
 end        
end        
else if @type = 'DEST'        
begin        
 select          
  gvi_vensna as 'ShpPlc',        
  gvi_vennam as '_Bill_Chin',        
  gvi_engnam as '_Bill_Eng',        
  gvi_VenAddr as '_Bill_Addr'        
 from         
  GRNVENINF        
 where        
  gvi_type = 'Cust'        
        
        
end        
else if @type = 'LH'  --Letter Head        
begin        
 select          
  cust.gvi_vensna as '_CustFty',        
  inv.gvi_vennam as '_Bill_Chin',        
  inv.gvi_engnam as '_Bill_Eng',        
  cust.gvi_VenAddr as '_Bill_Addr'        
 from         
  GRNVENINF cust        
  LEFT JOIN GRNVENINF inv (NOLOCK) on cust.gvi_invven = inv.gvi_vensna and inv.gvi_type = 'INV'        
 where        
  cust.gvi_type = 'CUST'        
end        
else if @type = 'DROPDOWN'        
begin        
 create table #tmp_cty(        
  _type varchar(6),        
  _value nvarchar(50),        
  -- Lester Wu 2006-03-20        
  _index int        
 )        
 insert into #tmp_cty values ('_Cty','台灣',1)        
 insert into #tmp_cty values ('_Cty','日本',2)        
 insert into #tmp_cty values ('_Cty','香港',3)        
 insert into #tmp_cty values ('_Cty','美國',4)        
 insert into #tmp_cty values ('_Cty','中國',5)        
 insert into #tmp_cty values ('_Cty','英國',6)        
 insert into #tmp_cty values ('_Cty','德國',7)        
 insert into #tmp_cty values ('_Cty','新加坡',8)        
 insert into #tmp_cty values ('_Cty','印尼',9)        

        
 insert into #tmp_cty values ('_UM','KG',1)        
 insert into #tmp_cty values ('_UM','包',2)        
 insert into #tmp_cty values ('_UM','袋',3)        
 insert into #tmp_cty values ('_UM','件',4)        
 insert into #tmp_cty values ('_UM','盒',5)        
 insert into #tmp_cty values ('_UM','箱',6)        
 insert into #tmp_cty values ('_UM','桶',7)        
 insert into #tmp_cty values ('_UM','卷',8)        
 insert into #tmp_cty values ('_UM','罐',9)        
 insert into #tmp_cty values ('_UM','紮',10)        
 insert into #tmp_cty values ('_UM','瓶',11)      
 insert into #tmp_cty values ('_UM','千克',12)      
 insert into #tmp_cty values ('_UM','散',13)      
 insert into #tmp_cty values ('_UM','套',14)      

        
 insert into #tmp_cty values ('_CAR','3 噸車',1)        
 insert into #tmp_cty values ('_CAR','5 噸車',2)        
 insert into #tmp_cty values ('_CAR','8 噸車',3)        
 insert into #tmp_cty values ('_CAR','10 噸車',4)        
 insert into #tmp_cty values ('_CAR','20'' 櫃',5)        
 insert into #tmp_cty values ('_CAR','40'' 櫃',6)        
 insert into #tmp_cty values ('_CAR','40'' HQ',7)        
 insert into #tmp_cty values ('_CAR','45'' 櫃',8)        
 insert into #tmp_cty values ('_CAR','速遞',9)        
 insert into #tmp_cty values ('_CAR','內地交收',10)        
      
        
 insert into #tmp_cty values ('_UM2','M',1)        
 insert into #tmp_cty values ('_UM2','KG',2)        
 insert into #tmp_cty values ('_UM2','包',3)        
 insert into #tmp_cty values ('_UM2','袋',4)        
 insert into #tmp_cty values ('_UM2','件',5)        
 insert into #tmp_cty values ('_UM2','盒',6)        
 insert into #tmp_cty values ('_UM2','箱',7)        
 insert into #tmp_cty values ('_UM2','桶',8)        
 insert into #tmp_cty values ('_UM2','卷',9)        
 insert into #tmp_cty values ('_UM2','罐',10)        
 insert into #tmp_cty values ('_UM2','紮',11)        
 insert into #tmp_cty values ('_UM2','瓶',12)        
 insert into #tmp_cty values ('_UM2','套',13)      
        
       
 select _type,_value from #tmp_cty order by _type, _index,_value        
         
 drop table #tmp_cty        
end        
else if @type = 'CUSTCAT'         
begin        
 --select distinct Zil_CatCde1 from ZSITMLST        
 select  ymc_catcde + ' - ' +  ymc_catdsc  as 'CustCat'        
 from SYMCATCDE         
 where ymc_type = 1        
 order by ymc_catcde        
        
end        
else if @type = 'ITEM'        
begin        
 select          
  Zil_ItmNo,        
  Zil_ItmNam,        
  Zil_ItmDesc,         
  isnull( ymc_catcde + ' - ' +  ymc_catdsc,'' )  as 'CustCat' ,         
  Zil_CustUM         
 from ZSITMLST         
 left join SYMCATCDE on zil_CatCde2 = ymc_catcde and ymc_type = 1        
 where @Fty <> ''        
 and Zil_ItmNo = @Fty        
 --and ymc_catcde is not null        
         
end        
else if @type = 'CURR'        
begin        
 create table #_Curr(        
  _val varchar(6),        
  _exchange  numeric(16,11)        
 )        
 insert into #_Curr values ('HKD',1)        
 insert into #_Curr values ('USD',1)        
-- insert into #_Curr values ('TWD',1)        
-- insert into #_Curr values ('RMB',1)        
        
 update #_Curr        
 set _exchange = ysi_selrat        
 from SYSETINF         
 where ysi_typ = '06' and ysi_cde = 'HKD'        
 and _val = 'HKD'        
        
 --select 1.0 / 0.12903225806        
        
        
 select * from #_Curr order by _val        
 drop table #_Curr        
        
end        
        
end        
        
        
        
        
        
        
      
      
    
  




GO
GRANT EXECUTE ON [dbo].[sp_list_MPM00002] TO [ERPUSER] AS [dbo]
GO
