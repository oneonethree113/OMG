/****** Object:  StoredProcedure [dbo].[sp_insert_PDA_Quot]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_PDA_Quot]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_PDA_Quot]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









/*
=========================================================
Description   	: sp_insert_PDA_Quot
Programmer  	: Mark Lau
ALTER  Date   	: 2008-07-09
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      Initial  	Description                          
=========================================================    */ 


CREATE  procedure [dbo].[sp_insert_PDA_Quot]
@qud_cocde nvarchar(6),
@qud_cus1no nvarchar(6),
@qud_cus2no nvarchar(6),
@qud_cus2na nvarchar(20),
@qud_sessid nvarchar(50),
@qud_tmpqutno nvarchar(20),
@qud_seq int,
@qud_itmno nvarchar(20),
@qud_img nvarchar(1),
@qud_del nvarchar(1),
@qud_currel nvarchar(1),
@qud_colcde nvarchar(250),
@qud_pckseq int,
@qud_inrqty int,
@qud_mtrqty int,
@qud_cft numeric(11, 4),
@qud_moq int,
@qud_moa numeric(11, 4),
@qud_untcde nvarchar(6),
@qud_conftr int,
@qud_smpqty int,
@qud_disc numeric(13, 4),
@qud_curcde nvarchar(6),
@qud_cu1pri numeric(13, 4),
@qud_cu2pri numeric(13, 4),
@qud_note nvarchar(255),
@qud_modify nvarchar(1),
@qud_prcsec nvarchar(3),
@qud_grsmgn numeric(13, 4),
@qud_basprc numeric(13, 4),
@qud_smpunt nvarchar(6),
@qud_venitm nvarchar(20),
@qud_aliitm nvarchar(1),
@qud_alsitmno nvarchar(20),
@qud_alscolcde nvarchar(30),
@qud_ventyp nvarchar(1),
@qud_cat nvarchar(50),
@qud_aprsts nvarchar(1),
@qud_qutno nvarchar(20),
@qud_qutseq int,
@qud_qutdat datetime,
@qud_imu_cus1no nvarchar(6),
@qud_imu_cus2no nvarchar(6),
@qud_imu_hkprctrm nvarchar(10),
@qud_imu_ftyprctrm nvarchar(10),
@qud_imu_trantrm nvarchar(10),
@qud_imu_effdat datetime,
@qud_imu_expdat datetime,
@qud_creusr nvarchar(30),
@qud_credat datetime,
@qud_crepda nvarchar(50),
@qud_creip nvarchar(20),
@qud_updusr nvarchar(30),
@qud_upddat datetime,
@qud_updpda nvarchar(50),
@qud_updip nvarchar(20)



as

begin

insert into PDA_Quot
(
qud_cocde,
qud_cus1no,
qud_cus2no,
qud_cus2na,
qud_sessid,
qud_tmpqutno,
qud_seq,
qud_itmno,
qud_img,
qud_del,
qud_currel,
qud_colcde,
qud_pckseq,
qud_inrqty,
qud_mtrqty,
qud_cft,
qud_moq,
qud_moa,
qud_untcde,
qud_conftr,
qud_smpqty,
qud_disc,
qud_curcde,
qud_cu1pri,
qud_cu2pri,
qud_note,
qud_modify,
qud_prcsec,
qud_grsmgn,
qud_basprc,
qud_smpunt,
qud_venitm,
qud_aliitm,
qud_alsitmno,
qud_alscolcde,
qud_ventyp,
qud_cat,
qud_aprsts,
qud_qutno,
qud_qutseq,
qud_qutdat,
qud_imu_cus1no,
qud_imu_cus2no,
qud_imu_hkprctrm,
qud_imu_ftyprctrm,
qud_imu_trantrm,
qud_imu_effdat,
qud_imu_expdat,
qud_creusr,
qud_credat,
qud_crepda,
qud_creip,
qud_updusr,
qud_upddat,
qud_updpda,
qud_updip
)
values
(
@qud_cocde,
@qud_cus1no,
@qud_cus2no,
@qud_cus2na,
@qud_sessid,
@qud_tmpqutno,
@qud_seq,
@qud_itmno,
@qud_img,
@qud_del,
@qud_currel,
@qud_colcde,
@qud_pckseq,
@qud_inrqty,
@qud_mtrqty,
@qud_cft,
@qud_moq,
@qud_moa,
@qud_untcde,
@qud_conftr,
@qud_smpqty,
@qud_disc,
@qud_curcde,
@qud_cu1pri,
@qud_cu2pri,
@qud_note,
@qud_modify,
@qud_prcsec,
@qud_grsmgn,
@qud_basprc,
@qud_smpunt,
@qud_venitm,
@qud_aliitm,
@qud_alsitmno,
@qud_alscolcde,
@qud_ventyp,
@qud_cat,
@qud_aprsts,
@qud_qutno,
@qud_qutseq,
@qud_qutdat,
@qud_imu_cus1no,
@qud_imu_cus2no,
@qud_imu_hkprctrm,
@qud_imu_ftyprctrm,
@qud_imu_trantrm,
@qud_imu_effdat,
@qud_imu_expdat,
@qud_creusr,
@qud_credat,
@qud_crepda,
@qud_creip,
@qud_updusr,
@qud_upddat,
@qud_updpda,
@qud_updip
)



end








GO
GRANT EXECUTE ON [dbo].[sp_insert_PDA_Quot] TO [ERPUSER] AS [dbo]
GO
