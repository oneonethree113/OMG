/****** Object:  StoredProcedure [dbo].[sp_list_QUOTNDTL_form]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_QUOTNDTL_form]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_QUOTNDTL_form]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE  PROCEDURE [dbo].[sp_list_QUOTNDTL_form] 

@cocde	nvarchar(6),
@qutno	nvarchar(20)

AS

Declare
@qud_qutseq int

select
--ISU Entry
'' as isu_class,		--Class
'' as isu_subclass,	--DPCI - Item # (Sub Class), Subclass:
'' as isu_itmdsc12,	--Item Desc (12 characters)
'' as isu_tssof,		--TSS/AMC Office
'' as isu_tsscontact,	--TSS/AMC Contact
'' as isu_itmft,		--Item Features/Functions
'' as isu_upc01,		--UPC# 1
'' as isu_upc02,		--UPC# 2
'' as isu_upc03,		--UPC# 3
'' as isu_upc04,		--UPC# 4
'' as isu_barcde,		--Barcode


--ISU 
'' as isu_cms,		--CMS#
'' as isu_ftyadr,		--Factory Address
'' as isu_cntyorg,	--Country of Origin
'' as isu_tmkltr,		--Trademark Release Letter
'' as isu_bindrule,	--Binding Ruling #
'' as isu_pcbkd,		--77 Piece Breakdown
'' as isu_env,		--Environmentally Sensitive/Haz Mat
'' as isu_visa,		--VISA Required
'' as isu_spgm,		--Special Program
'' as isu_spgmtrff,	--Special Program Tariff#
'' as isu_knitwoven,	--Knit or woven?
'' as isu_howoven,	--If woven, how ?
'' as isu_consdtl,		--Construction Details	
'' as isu_colPtnFin,	--Color/Pattern/Finish	
'' as isu_license,		--Licenses
'' as isu_careinstr,	--Care Instructions
'' as isu_sellft,		--Selling Features/Decorative Attributes
'' as isu_venleadtime,	--Vendor Prod Lead Time
'' as isu_note01,		--Notes Line 1
'' as isu_note02,		--Notes Line 2
'' as isu_note03,		--Notes Line 3
'' as isu_exwcst,		--EXW Cost	
'' as isu_addcstdsc,	--Add''''l Cost Desc
'' as isu_addcst,		--Additional Cost
'' as isu_domodrpt,	--Domestic Order Point
'' as isu_completeby,	--Completed By
'' as isu_revreason,	--Reason for Revision
'' as isu_adsigndsc,	--Ad/Sign Desc
'' as isu_sellpt,		--Selling Points
'' as isu_packqty,	--Package Qty
'' as isu_odritm,		--Orderable Item
'' as isu_venser,		--Vendor Serviced	
'' as isu_sellitm,		--Sellable Item
'' as isu_poswgt,		--POS Weight Required
'' as isu_soldregrtl,	--Sold only at Reg Retail
'' as isu_stordered,	--Store Ordered
'' as isu_blkact,		--Block Activation
'' as isu_healthitm,	--Health Item
'' as isu_primode,	--Primary Mode
'' as isu_royalty,		--Royalty
'' as isu_royaltyvalue,	--Royalty $:
'' as isu_royaltypercent,	--Royalty %:
'' as isu_royaltyduty,	--Royalty Duty:
'' as isu_prcstgy,	--Price Strategy
'' as isu_servstgy,	--Service Strategy
'' as isu_lbluom,		--Labeling UOM
'' as isu_sizeunt,		--Size Per Unit
'' as isu_brandname,	--Brand Name
'' as isu_posppt,		--POS Prompt:
'' as isu_devtrack,	--Development Track:
'' as isu_srctrack,	--Sourcing Track:
'' as isu_odrptimpno,	--Order Point # (IMPORT):
'' as isu_retpolicy,	--Return Policy:
'' as isu_domven,	--Vendor # (Domestic):
'' as isu_domport,	--Domestic Port:
'' as isu_domper,		--Per (Domestic):
'' as isu_allstore,		--Select All Stores (except E-Commerce)
'' as isu_regdc,		--Select Regional DC's
'' as isu_idccdc,		--Select All IDCs/CDCs
'' as isu_sizemix,		--Size Mix
'' as isu_color01,		--Color(s)1
'' as isu_cat01,		--Category1
'' as isu_grp01,		--Group1
'' as isu_size01,		--Size(s)1
'' as isu_pattern01,	--Pattern(s)1
'' as isu_licence01,	--Licence(s)1
'' as isu_color02,		--Color(s)2
'' as isu_size02,		--Size(s)2
'' as isu_pattern02,	--Pattern(s)2
'' as isu_licence02,	--Licence(s)2
'' as isu_color03,		--Color(s)3
'' as isu_size03,		--Size(s)3
'' as isu_pattern03,	--Pattern(s)3
'' as isu_licence03,	--Licence(s)3
'' as isu_color04,		--Color(s)4
'' as isu_size04,		--Size(s)4
'' as isu_pattern04,	--Pattern(s)4
'' as isu_licence04,	--Licence(s)4
'' as isu_color05,		--Color(s)5
'' as isu_size05,		--Size(s)5
'' as isu_pattern05,	--Pattern(s)5
'' as isu_licence05,	--Licence(s)5	
'' as isu_hanging,	--Hanging
'' as isu_folded,		--Folded   
'' as isu_shoepkg	,	--Shoe Packaging  
'' as isu_pkgpeg,		--Package/Pegged
'' as isu_effdat,		--Effective Date:
'' as isu_shoecde,	--Hanger/Fold/Shoe Code:
'' as isu_reqvalid,	--Request Validation:
'' as isu_eastag,		--EAS Tag:	
'' as isu_pcsperitm,	--# of pcs per Item:
'' as isu_mauitmno,	--Manual Item # Selection:
'' as isu_barcdetyp,	--Barcode Type:
'' as isu_micnam,		--MIC Name/#:
'' as isu_per,		--Per:, A0564-Per
'' as isu_smpapp,	--Sample Approval:
'' as isu_qutacat,	--Quota Category
'' as isu_lcpercent,	--% of Invoice Covered by LC:
'' as isu_tranmode,	--Mode of Transport:
'' as isu_commduty,	--Comm Duty:
'' as isu_antidpgduty,	--Anti-Dumping Duty:
'' as isu_dutyfree,	--Duty Free:
'' as isu_mscgrp,		--MSC/Store Group
'' as isu_ftycontact,	--Factory Contact
'' as isu_tssphone,	--TSS/AMC Phone #
'' as isu_tssfax,		--TSS/AMC Fax #
'' as isu_itmdim,		--Item Dimensions (LxWxH)
'' as isu_transferable,	--Transferable
'' as isu_3pshpReq,	--3rd Party Shipper Required
'' as isu_elgsp,		--Eligible for GSP
'' as isu_elignafta,	--Eligible for NAFTA
'' as isu_cubicft,		--Cubic Feet
'' as isu_exftyprc,	--Ex-factory Price
'' as isu_frtprc,		--Ocean Frt $
'' as isu_glc,		-- Landed Cost (GLC) US$
'' as isu_mfgvensty,	--Mfg/Vendor Style
'' as isu_tgtmtrqty,	--VCP Master (Target.com)

'' as isu_mcstbk01,	--Material Cost Breakdown Details L01
'' as isu_mcstbk02,	--Material Cost Breakdown Details L02
'' as isu_mcstbk03,	--Material Cost Breakdown Details L03
'' as isu_mcstbk04,	--Material Cost Breakdown Details L04
'' as isu_mcstbk05,	--Material Cost Breakdown Details L05
'' as isu_mcstbk06,	--Material Cost Breakdown Details L06


--Quotndtl
qud_cocde,
qud_qutno,
qud_qutseq,
qud_itmno,		--Items
qud_itmtyp,
qud_itmsts,
qud_qutitmsts,
qud_itmdsc,		--Vendor Item Description, Item Desc (22 characters)
qud_alsitmno,
qud_alscolcde,
qud_hstref,
qud_cusitm,
qud_colcde,
qud_cuscol,
qud_coldsc,
qud_pckseq,
qud_untcde,
qud_inrqty,		--SSP Inner
qud_mtrqty,		--VCP Master
qud_cft,
qud_curcde,
qud_cus1sp,
qud_cus2sp,
qud_cus1dp,
case qud_cus2dp
when 0 then qud_cus1dp
else qud_cus2dp		
end as 'qud_cus2dp',	-- FOB Cost
qud_onetim,
qud_discnt,
qud_moq,
qud_moa,
qud_smpunt,
qud_smpqty,
qud_smpprc,
qud_stkqty,
qud_cusqty,
qud_hrmcde,		--H.S. Tariff #
qud_dtyrat,
qud_dept,		--Department
qud_cususd,		--RETAIL
qud_cuscad,
qud_venno,
qud_subcde,
qud_cusven,
qud_cussub,
qud_venitm,
qud_fcurcde,
qud_ftycst,
qud_ftyprc,
qud_basprc,
qud_note,
qud_image,
qud_inrdin,		--Item Dimensions (length), Inner (INCHES) L
qud_inrwin,		--Item Dimensions (width), Inner (INCHES) W
qud_inrhin,		--Item Dimensions (height), Inner (INCHES) H
qud_mtrdin,		--Master (INCHES) L
qud_mtrwin,		--Master (INCHES) W
qud_mtrhin,		--Master (INCHES) H
qud_inrdcm,
qud_inrwcm,
qud_inrhcm,
qud_mtrdcm,
qud_mtrwcm,
qud_mtrhcm,
qud_grswgt,		--Item Dimensions (weight), VCW (LBS)
qud_netwgt,		--SSW (LBS)
qud_cosmth,
qud_tbm,
qud_tbmsts,
qud_prcsec,
qud_grsmgn,
qud_apprve,
qud_pdabpdiff,
qud_pckitr,
qud_prctrm,
qud_moflag,
qud_orgmoq,
qud_orgmoa,
qud_ftyprctrm,
qud_conftr,
qud_contopc,
qud_pcprc,
qud_cusstyno,		--Vendor Style #, Vendor # (Import)
qud_cbm,
qud_upc,
qud_specpck,
qud_ftytmpitm,
qud_ftytmpitmno,
qud_custitmcat,
qud_custitmcatfml,
qud_custitmcatamt,
qud_pmu,
qud_imrmk,
qud_rndsts,
convert(varchar(20), qud_inrdin) + ' x ' + convert(varchar(20), qud_inrwin) + ' x ' + convert(varchar(20),qud_inrhin) as 'qud_itmdim',
substring(sys03.ysi_dsc, 5, len(sys03.ysi_dsc)) 'qud_prctrmdsc',	--Port of Exportation
qud_upddat,	--Date

'' as qud_mtrqtycom,	--VCP Master (Target.com)
'' as qud_grswgtcom,	--VCW (LBS) (Target.com)
'' as qud_mtrdincom,	--Master (INCHES) L (Target.com)
'' as qud_mtrwincom,	--Master (INCHES) W (Target.com)
'' as qud_mtrhincom,	--Master (INCHES) H (Target.com)
'' as qud_inrqtycom,	--SSP Inner (Target.com)
'' as qud_netwgtcom,	--SSW (LBS) (Target.com)
'' as qud_inrdincom,	--Inner (INCHES) L (Target.com)
'' as qud_inrwincom,	--Inner (INCHES) W (Target.com)
'' as qud_inrhincom,	--Inner (INCHES) H (Target.com)



--QUOTNHDR
quh_issdat,
quh_rvsdat,
quh_qutsts,
quh_cus1no,
quh_cus2no,
quh_relatn,
quh_cus1ad,
quh_cus2ad,
quh_cus1st,
quh_cus1cy,
quh_cus1zp,
quh_cus2st,
quh_cus2cy,
quh_cus2zp,
quh_cus1cp,
quh_cus2cp,
quh_salrep,
quh_cusagt,
quh_valdat,
quh_smpprd,
quh_smpfgt,
quh_prctrm,
quh_paytrm,
quh_relcnt,
quh_curcde,
quh_rmk,
quh_conalltopc,
quh_Year,
quh_Season,
quh_Desc,
quh_Year + ' ' + quh_Season + ' '+ quh_Desc as 'quh_program', --Program
--SYCOMINF
yco_shtnam,		--Vendor Name
yco_venid,		--Vendor #
--VNBASINF
case vbi_ventyp
when 'I' then 'Grand China'
when 'J' then 'Grand China'
else vbi_vensna
end as 'vbi_ftynam',	--Factory Name
'Pounds' as qud_untcdedsc,	--Unit of Measure *** Need Further Enhance ***

-- QED 

----Commission (TSS/AMC 5.1 %)--
qed02.qed_percent as 'qed_percent02',
--Commission $--
qed02.qed_amt as 'qed_amt02',

--Duty %--
qed09.qed_percent as 'qed_percent09',

--Duty $--
qed09.qed_amt as 'qed_amt09',

--Transportation Cost $--
qed10.qed_amt as 'qed_amt10',

 --ELC (Estimated Landed Cost)--
qec001.qec_amt as 'qec_amt', 

--FCA Cost ---
qec002.qec_amt as 'qec_FACCst',

--Domestic Cost US$--,--Domestic Cost:
qec003.qec_amt as 'qec_domcst',


'' as ibi_imgpth,	--ITEM PHOTO
'' as vta_program,	



-- PCB Report

'' as pcb_lneno,		--VIT Line Number
'' as pcb_estqty,		--Estimated Quantity
'' as pcb_exrat,		--Exchange Rate
'' as pcb_setdat,		--Set Date
'' as pcb_pricntyorg,	--Primary - Material Country of Origin
'' as pcb_secntyorg,	--Secondary - Material Country of Origin
'' as pcb_trdcntyorg,	--Third Material - Material Country of Origin	
'' as pcb_trimcntyorg,	--Misc Trims - Material Country of Origin
'' as pcb_fhcntyorg,	--Misc Finishes - Material Country of Origin
'' as pcb_rawmttl,	--Raw Materila Total
'' as pcb_op_typ,	--Outer Packaging - Type
'' as pcb_op_cst,	--Outer Packaging - Cost
'' as pcb_op_supp,	--Outer Packaging - Supplier
'' as pcb_op_comment,	--Outer Packaging - Comment
'' as pcb_ip_typ,		--Inner Packaging - Type
'' as pcb_ip_cst,		--Inner Packaging - Cost
'' as pcb_ip_supp,	--Inner Packaging - Supplier
'' as pcb_ip_comment,	--Inner Packaging - Comment
'' as pcb_lbl_typ,	--Hang Tag / Label - Type
'' as pcb_lbl_cst,		--Hang Tag / Label - Cost
'' as pcb_lbl_supp,	--Hang Tag / Label - Supplier
'' as pcb_lbl_comment,	--Hang Tag / Label - Comment
'' as pcb_otr1_typ,	--Other 1 - Type
'' as pcb_otr1_cst,	--Other 1 - Cost
'' as pcb_otr1_supp,	--Other 1 - Supplier
'' as pcb_otr1_comment,	--Other 1 -  Comment
'' as pcb_otr2_typ,	--Other 2 - Type
'' as pcb_otr2_cst,	--Other 2 - Cost
'' as pcb_otr2_supp,	--Other 2 - Supplier
'' as pcb_otr2_comment,	--Other 2 -  Comment
'' as pcb_pkgttl,		--Packaging Total
'' as pcb_mtcstttl,	--Material Cost Total
'' as pcb_mfycst_unt,	--Manufacturing Cost - per sell unit
'' as pcb_mfycst_cmt,	--Manufacturing Cost - Comments
'' as pcb_oh_unt,	--Overhead - per sell unit
'' as pcb_oh_cmt,	--Overhead - Comments
'' as pcb_usell_unt,	--Unsaleables - per sell unit
'' as pcb_usell_cmt,	--Unsaleables - Comments
'' as pcb_qta_cat,	--QUOTA - Enter Category
'' as pcb_qta_unt,	--QUOTA - per sell unit
'' as pcb_qta_cmt,	--QUOTA - Comments
'' as pcb_if_unt,		--Inland Freight - per sell unit
'' as pcb_if_cmt,		--Inland Freight - Comments
'' as pcb_lbrohcsttl,	--LABOR/OVERHEAD COST TOTAL
'' as pcb_wh,		--Warehousing 
'' as pcb_dat,		--Date
'' as pcb_season,	--Season




--VIT report
'Wall Mirrors' as vit_cat,
'salon' as vit_program,
'2' as vit_storecnt,
'1.1' as vit_spspw,
'14500' as vit_totunt,
'$1000' as vit_fca,
'' as vit_domuntcst,
'>$90' as vit_rtlcat,
'12,990' as vit_unrtl,
'Zhongshan' as vit_fcaloc,
'China_Shenzhen_Yantian' as vit_importfob,
'CA-S' as vit_domfob,
'7.8%' as vit_dutyrate,
'1.40' as vit_spduty,
'Grand China' as vit_prifty

--QUL01 Report
/*
'11 Dec 2008' as qul_quodate,
'DY FOB YT LCL(IM Markup22%)' as qul_rmk,
'28HS1990' as qul_FztoryItem,
'Hangtag' as qul_packaging,
round(qud_ftyprc,2) as ffyprcr2,
(qud_ftyprc*1.22) as ftyMp,
(qud_ftyprc*1.22*1.1) as IntSalUp,
'0.3' as pkgcst,
'0.1' as carlbl,
'0.13' as mtltst,
(qud_ftyprc*1.22*1.1 + 0.13) as netcst,
'3.63' as cft,

(qud_ftyprc*1.22*1.1 + 0.13) * 1.005 * 1.03 * 1.03 as fobcst,

'3.270 ' as Flgcst,
((qud_ftyprc*1.22*1.1 + 0.13) * 1.005 * 1.03 * 1.03 + 0.17) as FCC,
'63%' as tgtmkup,
'63%' as tgtFxmkup,
'0.97'  as flgrat,
'TBA' as prdwgt,
'140 mm' as itmdim
*/


from QUOTNDTL (nolock)
left join QUOTNHDR (nolock) on quh_cocde = qud_cocde and quh_qutno = qud_qutno
left join SYCOMINF (nolock) on yco_cocde = qud_cocde
left join VNBASINF (nolock) on vbi_venno = qud_venno
left join SYSETINF sys03 (nolock) on sys03.ysi_cde = qud_prctrm and ysi_typ = '03'
left join QUELCDTL qed02 (nolock) on qed02.qed_qutno = qud_qutno and qed02.qed_qutseq = qud_qutseq and qed02.qed_grpcde = '001' and qed02.qed_cecde = '02'
left join QUELCDTL qed09 (nolock) on qed09.qed_qutno = qud_qutno and qed09.qed_qutseq = qud_qutseq and qed09.qed_grpcde = '001' and qed09.qed_cecde = '09'
left join QUELCDTL qed10 (nolock) on qed10.qed_qutno = qud_qutno and qed10.qed_qutseq = qud_qutseq and qed10.qed_grpcde = '001' and qed10.qed_cecde = '10'
left join QUELC qec001 (nolock) on qec001.qec_qutno = qud_qutno and qec001.qec_qutseq = qud_qutseq and qec001.qec_grpcde = '001'
left join QUELC qec002 (nolock) on qec002.qec_qutno = qud_qutno and qec002.qec_qutseq = qud_qutseq and qec002.qec_grpcde = '002'
left join QUELC qec003 (nolock) on qec003.qec_qutno = qud_qutno and qec003.qec_qutseq = qud_qutseq and qec003.qec_grpcde = '003'






where qud_cocde = @cocde
and qud_qutno = @qutno
order by 	qud_qutseq



GO
GRANT EXECUTE ON [dbo].[sp_list_QUOTNDTL_form] TO [ERPUSER] AS [dbo]
GO
