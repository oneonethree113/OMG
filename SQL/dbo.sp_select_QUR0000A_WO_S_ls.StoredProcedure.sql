/****** Object:  StoredProcedure [dbo].[sp_select_QUR0000A_WO_S_ls]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QUR0000A_WO_S_ls]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QUR0000A_WO_S_ls]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


























/*
 Modification History                                    
=========================================================
22 Jul 2003	Lewis To		Change ignor all system parameter company code
13 Apr 2004	Lester Wu		Add Sort By Quotation Sequence
3rd March 2005	Lester Wu		Retrieve Company Name, Short Name, Address, Phone No, Fax No, Email Address, Logo Path
========================================================= */

--sp_select_QUR0000A_WO_S_ls 'UCPP','1','0','0','1','UQ0400984','UQ0400984','1','1','CUST'

CREATE      procedure [dbo].[sp_select_QUR0000A_WO_S_ls]

                                                                                                                                                                                                                                                       
@cocde	 nvarchar(6),
@printven	nvarchar(1),
@cftr	 nvarchar(1),
@fty	 nvarchar(20),
@showqa   nvarchar(20),
@from	 nvarchar(20),
@to	 nvarchar(20),
@printDI	nvarchar(1),
@printDV	nvarchar(1),
@sortBy		nvarchar(4)	,-- By Customer Item or By Item

--Added by Mark Lau 20060918

@printAlias	nvarchar(1),
@printGroup	nvarchar(1),
@printAll	nvarchar(1),
-- Added by Joe 20100505
@usrid	nvarchar(30),
@doctyp	nvarchar(2)

AS
------------------------------------------------------------------------------------------------------------------------------------------------------
--Lester Wu 2005/03/03 -- Retrieve Company Name, Short Name, Address, Phone No, Fax No, Email Address, Logo Path
------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE
@yco_conam	varchar(100),
@yco_shtnam	varchar(25),
@yco_addr		varchar(200),

@yco_conamc	nvarchar(100),
@yco_shtnamc	nvarchar(25),
@yco_addrc	nvarchar(200),

@yco_phoneno	varchar(50),
@yco_faxno	varchar(50),
@yco_email	varchar(50),

@yco_logoimgpth	varchar(100)



set @yco_conam = ''
set @yco_shtnam = ''
set @yco_addrc = ''

set @yco_conamc = ''
set @yco_shtnamc = ''
set @yco_addrc = ''

set @yco_phoneno = ''
set @yco_faxno = ''
set @yco_email = ''

set @yco_logoimgpth = ''

declare @tmp	nvarchar(20)
set @tmp = ''


select
@yco_conam=yco_conam,
@yco_shtnam=yco_shtnam,
@yco_addr=yco_addr,

@yco_conamc = yco_conamc,
@yco_shtnamc = yco_shtnamc,
@yco_addrc = yco_addrc,

@yco_phoneno= yco_phoneno,
@yco_faxno = yco_faxno,
@yco_email = yco_email,
@yco_logoimgpth = yco_logoimgpth
from 
SYCOMINF(NOLOCK)
where
yco_cocde = @cocde
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------

--Added by Mark Lau 20060918
declare
@newItmNo	nvarchar(20)
set @newItmNo = ''

Begin
	Select	

		
	                'P' as code,   	--1
	                @cocde,		

		cus.cbi_cusnam,	
		hdr.quh_cus1ad, 
		hdr.quh_cus1st, 
		cty.ysi_dsc, 
		hdr.quh_cus1zp,
		hdr.quh_cus1cp,	

		hdr.quh_qutno,	
                                cus.cbi_cusno,	--10
		hdr.quh_rvsdat,	
		hdr.quh_valdat,	
		agt.yai_fulnam,	
		prf.yup_usrnam as 'ysr_dsc',
                              --  rep1.ysr_dsc,	

---		Details Group by Item & Packing
		

		--Added by Mark Lau 20060917
		--Added by Mark Lau 20080516, Add CDTVX
		case when @printGroup = '1' and @Sortby <> 'SEQ' then
		case when len(dtl.qud_itmno) < 11 or charindex('-',dtl.qud_itmno) > 0 or charindex('/',dtl.qud_itmno) >0 or (Upper(substring(dtl.qud_itmno,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(dtl.qud_itmno,7,2) = 'AS' then dtl.qud_itmno
	
		else 
		case when upper(substring(dtl.qud_itmno, 3, 1)) = 'A' or upper(substring(dtl.qud_itmno, 3, 1)) = 'C'  or upper(substring(dtl.qud_itmno, 3, 1)) = 'D' or upper(substring(dtl.qud_itmno, 3, 1)) = 'T' or upper(substring(dtl.qud_itmno, 3, 1)) = 'X' or upper(substring(dtl.qud_itmno, 3, 1)) = 'V' then substring(dtl.qud_itmno,1,11)--and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)
			else 
			case when upper(substring(dtl.qud_itmno, 3, 1)) = 'B' and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)
				else 
				case when upper(substring(dtl.qud_itmno, 3, 1)) = 'B' and (upper(substring(dtl.qud_itmno, 4, 1)) >= 'A' And upper(substring(dtl.qud_itmno, 4, 1)) <= 'Z' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)
					else dtl.qud_itmno
				 end
			end
		end
		end
		else
		dtl.qud_itmno
		end as 'dtl.qud_itmno',
					
		--isnull(dtl.qud_alsitmno,'') as 'dtl.qud_alsitmno',
		dtl.qud_alsitmno,
--		dtl.qud_itmno ,

---		No Item to be displayed if  'To be midified' is checked 
                                dtl.qud_tbm,	
		dtl.qud_cusitm,	
		dtl.qud_itmdsc,	-- 18
		dtl.qud_curcde,	

--                              if   @cftr =  '0' then orignal else convert to PC 
                               @cftr as 'cftr',	-- 20
		--Edited by Mark Lau 20070614
		case when dtl.qud_contopc = 'Y' then dtl.qud_pcprc else dtl.qud_cus1dp end as 'dtl.qud_cus1dp' ,		
		--Edited by Mark Lau 20070614
		case when dtl.qud_contopc = 'Y' then 'PC' else dum.ysi_dsc end as 'dum.ysi_dsc' ,	

                                ftr.ycf_oper,	
                                ftr.ycf_value,	
		--edited by Mark Lau 20070623
		case when dtl.qud_contopc = 'Y' then dtl.qud_inrqty * dtl.qud_conftr else  dtl.qud_inrqty end as 'dtl.qud_inrqty' ,	
		case when dtl.qud_contopc = 'Y' then dtl.qud_mtrqty * dtl.qud_conftr else dtl.qud_mtrqty end as 'dtl.qud_mtrqty' ,	
		dtl.qud_cft,	
		dtl.qud_pckitr,	
                               @showqa,	
		--Lester Wu 2004/11/18 retun only the selected MOQ/MOA value
		case dtl.qud_moflag when 'Q' then dtl.qud_moq when '' then dtl.qud_moq else 0 end as 'dtl.qud_moq',
		case dtl.qud_moflag when 'A' then dtl.qud_moa when '' then dtl.qud_moa else 0 end as 'dtl.qud_moa',
		--dtl.qud_moq,	-- 30
		--dtl.qud_moa,	
                                --dtl.qud_colcde,	

		--Added by Mark Lau 20060917
		--Added by Mark Lau 20080516, Add CDTVX
		case when @printGroup = '1' and @Sortby <> 'SEQ'  then
		case when len(dtl.qud_itmno) < 11 or charindex('-',dtl.qud_itmno) > 0 or charindex('/',dtl.qud_itmno) >0 or (Upper(substring(dtl.qud_itmno,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(dtl.qud_itmno,7,2) = 'AS' then dtl.qud_colcde
	
		else 
		case when upper(substring(dtl.qud_itmno, 3, 1)) = 'A' or upper(substring(dtl.qud_itmno, 3, 1)) = 'C'  or upper(substring(dtl.qud_itmno, 3, 1)) = 'D' or upper(substring(dtl.qud_itmno, 3, 1)) = 'T' or upper(substring(dtl.qud_itmno, 3, 1)) = 'X' or upper(substring(dtl.qud_itmno, 3, 1)) = 'V'  then + '(' + substring(dtl.qud_itmno,12, len(dtl.qud_itmno) - 11) +  ') ' + dtl.qud_colcde   --and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)
			else 
			case when upper(substring(dtl.qud_itmno, 3, 1)) = 'B' and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then  '(' +  substring(dtl.qud_itmno,12,len(dtl.qud_itmno) - 11) + ') ' + dtl.qud_colcde
				else 
				case when upper(substring(dtl.qud_itmno, 3, 1)) = 'B' and (upper(substring(dtl.qud_itmno, 4, 1)) >= 'A' And upper(substring(dtl.qud_itmno, 4, 1)) <= 'Z' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then  '(' + substring(dtl.qud_itmno,12,len(dtl.qud_itmno) - 11) + ') ' +  dtl.qud_colcde
					else dtl.qud_colcde 
				 end
			end
		end
		end
		else
		dtl.qud_colcde
		end as 'dtl.qud_colcde',




                                dtl.qud_coldsc,	
	                dtl.qud_cusqty,	

---		For Internal User Only:
---       		If @fty = 0(Yes), then no printing on vensa, venno, venitm & ftyprc
		@fty,		
		 ven.vbi_vensna,	
		 dtl.qud_venno,	
		 dtl.qud_venitm,	-- 38

		case  dtl.qud_tbm when 'Y' then
		replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(cast(dtl.qud_ftyprc as nvarchar(17)),'.', 'D'), '0','K'), '9', 'H'),  '8', 'R') , '7', 'E'), '6', 'T'), '5', 'N'), '4', 'I'), '3', 'P'), '2', 'C'), '1', 'U')+replace(replace(dtl.qud_fcurcde,'HKD','2'),'USD','1')+ ' (' + ltrim(str(qud_qutseq)) + ')'
		else
		replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(cast(dtl.qud_ftyprc as nvarchar(17)),'.', 'D'), '0','K'), '9', 'H'),  '8', 'R') , '7', 'E'), '6', 'T'), '5', 'N'), '4', 'I'), '3', 'P'), '2', 'C'), '1', 'U')+replace(replace(dtl.qud_fcurcde,'HKD','2'),'USD','1')
		end,		--39		
	--assortatment
	inf.qai_assitm,
	inf.qai_assdsc,
	inf.qai_coldsc,
	inf.qai_cussku,
	inf.qai_upcean,
	inf.qai_cusrtl,
	ltrim(inf.qai_untcde),
	--2004/04/13 Lester Wu dtl.qud_qutseq,
	case @sortBy when 'SEQ' then dtl.qud_qutseq else 0 end as 'qudseq',
	inf.qai_cusitm,
	inf.qai_colcde,
	ltrim(str(inf.qai_inrqty,10,0)),
	ltrim(str(inf.qai_mtrqty,10,0)),
	rtrim(dtl.qud_note),
	rtrim(dtl.qud_note),
	imm.ibi_imgpth,
	prc.ysi_dsc,
	pay.ysi_dsc,
	prd.yst_trmdsc,
	fgt.yst_trmdsc,
	--2004/04/13 Lester Wu Case @sortBy When 'CUST' then dtl.qud_cusitm else dtl.qud_itmno end + STR(dtl.qud_inrqty,10,0) + STR(dtl.qud_mtrqty,10, 0) + STR(dtl.qud_cft,10, 2) + dum.ysi_dsc + STR(dtl.qud_cus1dp,13,4),  --59
--	Case @sortBy When 'SEQ' then right('0000'+ltrim(str(dtl.qud_qutseq)),4) + '@'  When 'CUST' then dtl.qud_cusitm else dtl.qud_itmno end + STR(dtl.qud_inrqty,10,0) + STR(dtl.qud_mtrqty,10, 0) + STR(dtl.qud_cft,10, 2) + dum.ysi_dsc + STR(dtl.qud_cus1dp,13,4),  --59
	-- 2004/05/20 Lester Wu
	Case @sortBy When 'SEQ' then right('0000'+ltrim(str(dtl.qud_qutseq)),4) + '@'  When 'CUST' then dtl.qud_cusitm + '_' + dtl.qud_itmno  else 

		--Added by Mark Lau 20060917
		--Added by Mark Lau 20080516, Add CDTVX
		case when @printGroup = '1' and @Sortby <> 'SEQ' then
		case when len(dtl.qud_itmno) < 11 or charindex('-',dtl.qud_itmno) > 0 or charindex('/',dtl.qud_itmno) >0 or (Upper(substring(dtl.qud_itmno,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(dtl.qud_itmno,7,2) = 'AS' then dtl.qud_itmno
	
		else 
		case when upper(substring(dtl.qud_itmno, 3, 1)) = 'A' or upper(substring(dtl.qud_itmno, 3, 1)) = 'C'  or upper(substring(dtl.qud_itmno, 3, 1)) = 'D' or upper(substring(dtl.qud_itmno, 3, 1)) = 'T' or upper(substring(dtl.qud_itmno, 3, 1)) = 'X' or upper(substring(dtl.qud_itmno, 3, 1)) = 'V'  then substring(dtl.qud_itmno,1,11)--and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)
			else 
			case when upper(substring(dtl.qud_itmno, 3, 1)) = 'B' and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)
				else 
				case when upper(substring(dtl.qud_itmno, 3, 1)) = 'B' and (upper(substring(dtl.qud_itmno, 4, 1)) >= 'A' And upper(substring(dtl.qud_itmno, 4, 1)) <= 'Z' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)
					else dtl.qud_itmno
				 end
			end
		end
		end
		else
		dtl.qud_itmno
		end  + '_' + --as 'dtl.qud_itmno',
		
		--Added by Mark Lau 20060917
		--Added by Mark Lau 20080516, Add CDTVX
		case when @printGroup = '1' and @Sortby <> 'SEQ'  then
		case when len(dtl.qud_itmno) < 11 or charindex('-',dtl.qud_itmno) > 0 or charindex('/',dtl.qud_itmno) >0 or (Upper(substring(dtl.qud_itmno,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(dtl.qud_itmno,7,2) = 'AS' then ''
	
		else 
		case when upper(substring(dtl.qud_itmno, 3, 1)) = 'A' or upper(substring(dtl.qud_itmno, 3, 1)) = 'C'  or upper(substring(dtl.qud_itmno, 3, 1)) = 'D' or upper(substring(dtl.qud_itmno, 3, 1)) = 'T' or upper(substring(dtl.qud_itmno, 3, 1)) = 'X' or upper(substring(dtl.qud_itmno, 3, 1)) = 'V'  then + '(' + substring(dtl.qud_itmno,12, len(dtl.qud_itmno) - 11) +  ') ' + ''   --and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)
			else 
			case when upper(substring(dtl.qud_itmno, 3, 1)) = 'B' and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then  '(' +  substring(dtl.qud_itmno,12,len(dtl.qud_itmno) - 11) + ') ' + ''
				else 
				case when upper(substring(dtl.qud_itmno, 3, 1)) = 'B' and (upper(substring(dtl.qud_itmno, 4, 1)) >= 'A' And upper(substring(dtl.qud_itmno, 4, 1)) <= 'Z' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then  '(' + substring(dtl.qud_itmno,12,len(dtl.qud_itmno) - 11) + ') ' +  ''
					else ''
				 end
			end
		end
		end
		else
		''
		end 


 + '_' + dtl.qud_cusitm  + '_' +  dtl.qud_alsitmno end + STR(dtl.qud_inrqty,10,0) + STR(dtl.qud_mtrqty,10, 0) + STR(dtl.qud_cft,10, 2) + dum.ysi_dsc + STR(dtl.qud_cus1dp,13,4) ,  --59
	-------------------
	ltrim(replace(cast(imm.ibi_lnecde as nvarchar(10)), '/' ,'_')),
	imm.ibi_itmno,	--60
	imm.ibi_venno,	--61
	ltrim(replace(cast( imc.icf_colcde  as nvarchar(30)),'-','_')), --62
	ltrim(replace(cast( imo.ivi_venitm as nvarchar(20)),'/','_')),  --63                              
	@printven,
	
	-- Sorting string
	-- 2004/04/13 Lester Wu Case @sortBy When 'CUST' then dtl.qud_cusitm else dtl.qud_itmno end,
	Case @sortBy When 'SEQ' then '' When 'CUST' then dtl.qud_cusitm else dtl.qud_itmno end  ,
	----------------------------------------------------------------------------------------------------
	imm.ibi_itmsts,
--Kenny Add on 07-10-2002
--Kenny Add on 07-10-2002
	case 	when dtl.qud_prctrm = '' then isnull(prc.ysi_dsc,'') 
		else
		 isnull(prcd.ysi_dsc,'')
		end  as 'PriceTerm'

---	Sub-report for Color Code & Color Description
	,isnull(vbi_ventyp,'') as 'vbi_ventyp',
	--2005/03/03 Lester Wu -- Retrieve Company Name , Short Name , Address, Phone, Fax, Email
	@yco_conam,
	@yco_shtnam,
	@yco_addr,
	@yco_conamc,
	@yco_shtnamc,
	@yco_addrc,
	@yco_phoneno,
	@yco_faxno,
	@yco_email,
	@yco_logoimgpth
	--
	,@printAlias
	,@PrintGroup
	,@PrintAll
	,--Added by Mark Lau 20061005
		--Added by Mark Lau 20080516, Add CDTVX
		case when @printGroup = '1' and @Sortby <> 'SEQ'  then
		case when len(dtl.qud_itmno) < 11 or charindex('-',dtl.qud_itmno) > 0 or charindex('/',dtl.qud_itmno) >0 or (Upper(substring(dtl.qud_itmno,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(dtl.qud_itmno,7,2) = 'AS' then ''
	
		else 
		case when upper(substring(dtl.qud_itmno, 3, 1)) = 'A' or upper(substring(dtl.qud_itmno, 3, 1)) = 'C'  or upper(substring(dtl.qud_itmno, 3, 1)) = 'D' or upper(substring(dtl.qud_itmno, 3, 1)) = 'T' or upper(substring(dtl.qud_itmno, 3, 1)) = 'X' or upper(substring(dtl.qud_itmno, 3, 1)) = 'V'  then + '(' + substring(dtl.qud_itmno,12, len(dtl.qud_itmno) - 11) +  ') ' + ''   --and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)
			else 
			case when upper(substring(dtl.qud_itmno, 3, 1)) = 'B' and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then  '(' +  substring(dtl.qud_itmno,12,len(dtl.qud_itmno) - 11) + ') ' + ''
				else 
				case when upper(substring(dtl.qud_itmno, 3, 1)) = 'B' and (upper(substring(dtl.qud_itmno, 4, 1)) >= 'A' And upper(substring(dtl.qud_itmno, 4, 1)) <= 'Z' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then  '(' + substring(dtl.qud_itmno,12,len(dtl.qud_itmno) - 11) + ') ' +  ''
					else '' 
				 end
			end
		end
		end
		else
		''
		end as 'ColSeq'

From 	
QUOTNHDR hdr
left join QUOTNDTL dtl on hdr.quh_cocde = dtl.qud_cocde and hdr.quh_qutno = dtl.qud_qutno
left join CUBASINF cus on hdr.quh_cus1no = cus.cbi_cusno
left join SYSETINF cty on hdr.quh_cus1cy = cty.ysi_cde and cty.ysi_typ = '02'
left join SYSETINF prc on hdr.quh_prctrm = prc.ysi_cde and prc.ysi_typ = '03'
left join SYSETINF prcd on dtl.qud_prctrm = prcd.ysi_cde and prcd.ysi_typ = '03'
left join SYSETINF pay on hdr.quh_paytrm = pay.ysi_cde and pay.ysi_typ = '04'
left join SYSETINF dum on dtl.qud_untcde = dum.ysi_cde and dum.ysi_typ = '05'
left join SYAGTINF agt on hdr.quh_cusagt = agt.yai_agtcde
left join SYUSRPRF prf on hdr.quh_srname = prf.yup_usrid
left join SYSMPTRM prd on hdr.quh_smpprd = prd.yst_trmcde
left join SYSMPTRM fgt on hdr.quh_smpprd = fgt.yst_trmcde
left join SYCONFTR ftr on dtl.qud_untcde = ftr.ycf_code1 and ftr.ycf_code2 = 'PC'
left join QUASSINF inf on hdr.quh_cocde = inf.qai_cocde and dtl.qud_qutno = inf.qai_qutno and dtl.qud_qutseq = inf.qai_qutseq
left join VNBASINF ven on dtl.qud_venno = ven.vbi_venno and ven.vbi_vensts <> (case @printDV  when '0' then 'D' else '' end)
left join IMBASINF imm on dtl.qud_itmno = imm.ibi_itmno and imm.ibi_itmsts <> (case @printDI when '0' then 'DIS' else '' end) and imm.ibi_itmsts <> (case @printDI when '0' then 'TBC' else '' end)
left join IMCOLINF imc on dtl.qud_colcde = imc.icf_colcde and dtl.qud_itmno = imc.icf_itmno
left join IMVENINF imo on dtl.qud_itmno = imo.ivi_itmno and dtl.qud_venno = imo.ivi_venno 
WHERE 	
hdr.quh_cocde = @cocde and hdr.quh_qutno >= @from and hdr.quh_qutno <= @to
and	cus.cbi_cusno is not null
and	ven.vbi_venno is not null
and	imm.ibi_itmno is not null
and 	(	
		exists
		(	
			select 1 from syusrright
			where yur_usrid = @usrid  and yur_doctyp = @doctyp and yur_lvl = 0
		)
		or cus.cbi_saltem in 
		(	
			select yur_para from syusrright
			where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 1
		)
		or hdr.quh_cus1no in 
		(
			select yur_para from syusrright
			where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 2
		)
	)
order by 1, 9, 60, 19, ColSeq
-----------------------------------------------------------------------------------------------
	 
End



GO
GRANT EXECUTE ON [dbo].[sp_select_QUR0000A_WO_S_ls] TO [ERPUSER] AS [dbo]
GO
