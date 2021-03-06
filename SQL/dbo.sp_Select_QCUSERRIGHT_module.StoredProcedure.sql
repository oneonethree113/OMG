/****** Object:  StoredProcedure [dbo].[sp_Select_QCUSERRIGHT_module]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_Select_QCUSERRIGHT_module]
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_QCUSERRIGHT_module]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

drop table  QCRPTHDR

CREATE TABLE [dbo].[QCRPTHDR](
	[qrh_tmprptno] [nvarchar](20) NOT NULL,
	[qrh_rptno] [nvarchar](20) NULL,
	[qrh_rpttyp] [nvarchar](15) NULL,
	[qrh_insptime] [int] NULL,
	[qrh_reqflg] [char](1) NULL,
	[qrh_rptstatus] [nvarchar](20) NULL,
	[qrh_inspresult] [nvarchar](20) NULL,
	[qrh_finalstatus] [nvarchar](50) NULL,
	[qrh_shipapprv] [nvarchar](40) NULL,
	[qrh_retmsg] [nvarchar](200) NULL,
	[qrh_qcno] [nvarchar](20) NULL,
	[qrh_venno] [nvarchar](30) NULL,
	[qrh_venadr] [nvarchar](200) NULL,
	[qrh_cus1no] [nvarchar](6) NULL,
	[qrh_cus2no] [nvarchar](6) NULL,
	[qrh_itmno] [nvarchar](20) NULL,
	[qrh_cusitm] [nvarchar](20) NULL,
	[qrh_postr] [nvarchar](1000) NULL,
	[qrh_cuspostr] [nvarchar](500) NULL,
	[qrh_itmdsc] [nvarchar](800) NULL,
	[qrh_inspdat] [datetime] NULL,
	[qrh_morepo] [nvarchar](1000) NULL,
	[qrh_othvensna] [nvarchar](30) NULL,
	[qrh_othcustomer] [nvarchar](30) NULL,
	[qrh_othitmno] [nvarchar](20) NULL,
	[qrh_othcusitm] [nvarchar](20) NULL,
	[qrh_othpostr] [nvarchar](200) NULL,
	[qrh_othcuspostr] [nvarchar](200) NULL,
	[qrh_mailflg] [char](1) NULL,
	[qrh_mailsender] [nvarchar](500) NULL,
	[qrh_uploadflg] [char](1) NULL,
	[qrh_creusr] [nvarchar](30) NULL,
	[qrh_updusr] [nvarchar](30) NULL,
	[qrh_credat] [datetime] NULL,
	[qrh_upddat] [datetime] NULL,
 CONSTRAINT [PK_QCRPTHDR] PRIMARY KEY CLUSTERED 
(
	[qrh_tmprptno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[QCRPTHDR] ADD  DEFAULT ((0)) FOR [qrh_insptime]
GO

ALTER TABLE [dbo].[QCRPTHDR] ADD  DEFAULT ('N') FOR [qrh_mailflg]
GO

ALTER TABLE [dbo].[QCRPTHDR] ADD  DEFAULT ('N') FOR [qrh_uploadflg]
GO

ALTER TABLE [dbo].[QCRPTHDR] ADD  DEFAULT (getdate()) FOR [qrh_credat]
GO

ALTER TABLE [dbo].[QCRPTHDR] ADD  DEFAULT (getdate()) FOR [qrh_upddat]
GO


---------------

drop table  QCRPTCDE


CREATE TABLE [dbo].[QCRPTCDE](
	[qrc_inspcde] [nvarchar](30) NOT NULL,
	[qrc_cdedsc] [nvarchar](60) NULL,
	[qrc_cdetyp] [nvarchar](10) NULL,
	[qrc_flgimg] [char](1) NULL,
	[qrc_flgdisp] [char](1) NULL,
	[qrc_page] [int] NULL,
	[qrc_categ] [nvarchar](10) NULL,
	[qrc_displayorder] [int] NULL,
	[qrc_resultName] [nvarchar](20) NULL,
	[qrc_resultOpt] [nvarchar](50) NULL,
	[qrc_detailName] [nvarchar](20) NULL,
	[qrc_creusr] [nvarchar](30) NOT NULL,
	[qrc_updusr] [nvarchar](30) NOT NULL,
	[qrc_credat] [datetime] NOT NULL,
	[qrc_upddat] [datetime] NOT NULL,
	[qrc_rptimgdis_order] [int] NULL,
	[qrc_rptimgdis_group] [int] NULL,
	[qrc_resultNameEng] [nvarchar](50) NULL,
	[qrc_resultOptEng] [nvarchar](50) NULL,
 CONSTRAINT [PK_QCRPTCDE] PRIMARY KEY CLUSTERED 
(
	[qrc_inspcde] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[QCRPTCDE] ADD  DEFAULT (getdate()) FOR [qrc_credat]
GO

ALTER TABLE [dbo].[QCRPTCDE] ADD  DEFAULT (getdate()) FOR [qrc_upddat]
GO


------------- 

CREATE TABLE [dbo].[QCEMLHDR](
	[qeh_fr] [nvarchar](50) NOT NULL,
	[qeh_to] [nvarchar](1000) NOT NULL,
	[qeh_cc] [nvarchar](500) NULL,
	[qeh_sub] [nvarchar](300) NOT NULL,
	[qeh_content] [nvarchar](3000) NOT NULL,
	[qeh_tmprptno] [char](30) NOT NULL,
	[qeh_seq] [int] NOT NULL,
	[qeh_mailflg] [char](1) NOT NULL,
	[qeh_validflg] [char](1) NOT NULL,
	[qeh_mailtyp] [char](1) NOT NULL,
	[qeh_creusr] [nvarchar](30) NOT NULL,
	[qeh_updusr] [nvarchar](30) NOT NULL,
	[qeh_credat] [datetime] NOT NULL,
	[qeh_upddat] [datetime] NOT NULL
) ON [PRIMARY]

GO
 
 */

------------------------------------------------------
Create  PROCEDURE [dbo].[sp_Select_QCUSERRIGHT_module] 
@module nvarchar(20),
@usrid nvarchar(30)

AS
declare @cocde  nvarchar(6)
declare @cogrp  nvarchar(6)
set @cocde =''
set @cogrp = 'UCG'

select distinct  a.yug_assrig 
--from syusrprf b , syusrgrp a, syusrfun c
from symusrco b 
left join syusrgrp a on --a.yug_cocde = b.yuc_cocde and 
		a.yug_usrgrp = b.yuc_usrgrp and
		a.yug_cogrp = @cogrp
left join  syusrfun c on --c.yuf_cocde = b.yuc_cocde and  
		a.yug_usrfun = c.yuf_usrfun
where 	--a.yug_usrgrp = b.yuc_usrgrp 
--and 
b.yuc_usrid = @usrid 
and a.yug_cogrp = @cogrp
and yug_usrfun = @module
--and b.yuc_cocde = @cocde
--and a.yug_usrfun = c.yuf_usrfun 
--and c.yuf_cocde = b.yuc_cocde 
--and a.yug_cocde = b.yuc_cocde

---------------


GO
GRANT EXECUTE ON [dbo].[sp_Select_QCUSERRIGHT_module] TO [ERPUSER] AS [dbo]
GO
