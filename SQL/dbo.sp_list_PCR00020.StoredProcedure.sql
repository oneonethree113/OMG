/****** Object:  StoredProcedure [dbo].[sp_list_PCR00020]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_PCR00020]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_PCR00020]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*	@INPUTCOCDE
*	UCP     --> UCP
*	UCPP   --> UCPP
*	ELLI     --> ELLIWELL
*	@INPUTTYPE
*	INV      --> INVOICE
*	DPS      --> DEPOSIT
*	ADJ      --> ADJUST
*	DEP      --> ADJUST DEPRECIATION
*
*
*/
--sp_list_PCR00020 '','12/01/2003','UCPP','INV'
--select convert(char(10),getdate(),101)
create  procedure [dbo].[sp_list_PCR00020]
@COCDE		nvarchar(6),
@INPUTDATE	nvarchar(10),
@INPUTCOCDE	nvarchar(6),
@INPUTTYPE	nvarchar(10)
as 
BEGIN
declare	@optCOCDE	nvarchar(6),
	@optTYPE		nvarchar(10)


if @INPUTCOCDE=''
set @optCOCDE = 'UCP'
else
set @optCOCDE = @INPUTCOCDE

if @INPUTTYPE=''
set @optTYPE='INV'
else
set @optTYPE = @INPUTTYPE


create table #TMPPCM00003(
tmp_TYPE		nvarchar(10) null,
tmp_STR		nvarchar(2000) null
) on [PRIMARY]




--XXXXXXXXXXXXXXXXXXXXX
--insert INVOICE DATA into temp table 
if @optTYPE = 'INV' 
begin

--****
insert into #TMPPCM00003 
--****
select distinct @optTYPE,'""Invoice"",""'+ bid_docno +'"",""'+ 
   ltrim(str(month(bid_issdat)))+'/'+ltrim(str(day(bid_issdat)))+'/'+ltrim(str(year(bid_issdat)))+'"",""'+ 
   bid_cusno+'"",""'+ bid_doctyp+'"",""'+ 
   bid_paytrm +'"",""'+ bid_prctrm+'"",""'+
   (case bid_curcde when 'HKD' then '' else bid_curcde end) +'"",""'+  
   ''+'"",""""' as 'Invoice'
from       BAINVDTL 
where      --ltrim(str(month(bid_txndat)))+'/'+ltrim(str(day(bid_txndat)))+'/'+ltrim(str(year(bid_txndat))) = convert(char(10),@INPUTDATE,101) and
convert(char(10),bid_txndat,101)=convert(char(10),@INPUTDATE,101) and
--   ltrim(str(month(getdate())))+'/'+ltrim(str(day(getdate())))+'/'+ltrim(str(year(getdate()))) and 
   bid_cocde = @INPUTCOCDE and bid_seqno = 1

/*--**********--
union all
select ''
union all
--**********--*/

--****
insert into #TMPPCM00003 
--****
select     distinct @optTYPE,'""Invoice"",""' + bid_cusno +'"",""'+ bid_docno +'"",""'+ 
   left(ltrim(str(bid_pstno))+'0000',5)+'"",""Account (G/L)"",""' + bid_account + '"",""'+ 
   bid_desc +'"",""'+ ltrim(str(bid_amount,13,2))+'""' as 'Invoice'
from       BAINVDTL 
where      --ltrim(str(month(bid_txndat)))+'/'+ltrim(str(day(bid_txndat)))+'/'+ltrim(str(year(bid_txndat))) =  convert(char(10),@INPUTDATE,101) and
convert(char(10),bid_txndat,101)=convert(char(10),@INPUTDATE,101) and
--   ltrim(str(month(getdate())))+'/'+ltrim(str(day(getdate())))+'/'+ltrim(str(year(getdate()))) and 
   bid_cocde = @INPUTCOCDE and bid_seqno = 1
end


--XXXXXXXXXXXXXXXXXXXXX
--insert DEPOSIT DATA into temp table
if @optTYPE = 'DPS' 
begin


--****
insert into #TMPPCM00003 
--****
select       distinct @optTYPE,'""Invoice"",""'+ bid_docno +'"",""'+ 
   ltrim(str(month(bid_issdat)))+'/'+ltrim(str(day(bid_issdat)))+'/'+ltrim(str(year(bid_issdat)))+'"",""'+ 
   bid_cusno+'"",""'+ bid_doctyp+'"",""'+ 
   bid_paytrm +'"",""'+ bid_prctrm+'"",""'+
   (case bid_curcde when 'HKD' then '' else bid_curcde end) +'"",""'+  
   ''+'"",""""' as 'Invoice'
from       BAINVDTL 
where     -- ltrim(str(month(bid_txndat)))+'/'+ltrim(str(day(bid_txndat)))+'/'+ltrim(str(year(bid_txndat))) =  convert(char(10),@INPUTDATE,101) and
convert(char(10),bid_txndat,101)=convert(char(10),@INPUTDATE,101) and
--   ltrim(str(month(getdate())))+'/'+ltrim(str(day(getdate())))+'/'+ltrim(str(year(getdate()))) and 
   bid_cocde = @INPUTCOCDE and bid_seqno = 1 and bid_account = '3070000'

--****
insert into #TMPPCM00003 
--****
select     distinct @optTYPE,'""Invoice"",""' + bid_cusno +'"",""'+ bid_docno +'"",""'+ 
   left(ltrim(str(bid_pstno))+'0000',5)+'"",""Account (G/L)"",""' + bid_account + '"",""'+ 
   bid_desc +'"",""'+ ltrim(str(bid_amount,13,2))+'""' as 'Invoice'
from       BAINVDTL
where     -- ltrim(str(month(bid_txndat)))+'/'+ltrim(str(day(bid_txndat)))+'/'+ltrim(str(year(bid_txndat))) =  convert(char(10),@INPUTDATE,101) and
convert(char(10),bid_txndat,101)=convert(char(10),@INPUTDATE,101) and
--   ltrim(str(month(getdate())))+'/'+ltrim(str(day(getdate())))+'/'+ltrim(str(year(getdate()))) and 
   bid_cocde = @INPUTCOCDE and bid_seqno = 1 and bid_account = '3070000'

end



--XXXXXXXXXXXXXXXXXXXXX
--insert ADJUST DATA into temp table
if @optTYPE = 'ADJ'
begin


--****
insert into #TMPPCM00003 
--****
select       @optTYPE,'""' + ltrim(str(month(bid_issdat)))+'/'+ltrim(str(day(bid_issdat)))+'/'+ltrim(str(year(bid_issdat))) +'"",""' +
   bid_docno + '"",""'+ 'Customer' +'"",""'+ bid_cusno + '"",""'+ 
   bid_desc +'"",""'+ (case bid_curcde when 'HKD' then '' else bid_curcde end) + '"",""'+ '' +'"",""'+
   str(bid_amount) +'"",""'+ 'G/L Account' +'"",""'+
   bid_account +'"",""'+ '' +'""'
from       BAINVDTL 
where      --ltrim(str(month(bid_txndat)))+'/'+ltrim(str(day(bid_txndat)))+'/'+ltrim(str(year(bid_txndat))) =  convert(char(10),@INPUTDATE,101) and
convert(char(10),bid_txndat,101)=convert(char(10),@INPUTDATE,101) and
--   ltrim(str(month(getdate())))+'/'+ltrim(str(day(getdate())))+'/'+ltrim(str(year(getdate()))) and 
   bid_cocde = @INPUTCOCDE and bid_seqno > 1 and bid_amount <> 0

end


--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
--insert ADJUST DEPRECIATION DATA into temp table
if @optTYPE = 'DEP'  
begin


--****
insert into #TMPPCM00003 
--****
select       @optTYPE,'""'+ltrim(str(month(bid_issdat)))+'/'+ltrim(str(day(bid_issdat)))+'/'+ltrim(str(year(bid_issdat))) + '"",""' +
   bid_docno + '"",""'+ 'Customer' + '"",""' + bid_cusno + '"",""'+
   bid_desc + '"",""'+ (case bid_curcde when 'HKD' then '' else bid_curcde end) + '"",""'+ '' + '"",""' +
   str(bid_amount) + '"",""' + 'G/L Account' + '"",""'+
   bid_account + '"",""'+ '' + '""'
from       BAINVDTL 
where      --ltrim(str(month(bid_txndat)))+'/'+ltrim(str(day(bid_txndat)))+'/'+ltrim(str(year(bid_txndat))) =  convert(char(10),@INPUTDATE,101) and
convert(char(10),bid_txndat,101)=convert(char(10),@INPUTDATE,101) and
--   ltrim(str(month(getdate())))+'/'+ltrim(str(day(getdate())))+'/'+ltrim(str(year(getdate()))) and 
   bid_cocde = @INPUTCOCDE and bid_seqno > 1 and bid_amount <> 0 and bid_account = '3070000'

end

select 
@INPUTDATE,
@INPUTCOCDE,
@INPUTTYPE,
tmp_TYPE,
tmp_STR
from #TMPPCM00003
order by tmp_TYPE


END

--drop table #TMPPCM00003
--select *from #TMPPCM00003





GO
GRANT EXECUTE ON [dbo].[sp_list_PCR00020] TO [ERPUSER] AS [dbo]
GO
