/****** Object:  StoredProcedure [dbo].[sp_update_Invoice]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_Invoice]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_Invoice]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO





-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_update_Invoice] AS

update	SHINVHDR 
set	hiv_invsts = 'CLO', hiv_upddat = getdate()
from SHINVHDR, CMPDOC_UCPP
where 
hiv_cocde = 'UCPP' and --cmp_type = 'Invoice' and 
hiv_invno = cmp_docno and 
ltrim(str(month(cmp_txndat))) + '/' + ltrim(str(day(cmp_txndat))) + '/' + ltrim(str(year(cmp_txndat))) = 
ltrim(str(month(getdate()))) + '/' + ltrim(str(day(getdate()))) + '/' + ltrim(str(year(getdate())))


update	SHINVHDR 
set	hiv_invsts = 'CLO', hiv_upddat = getdate()
from SHINVHDR, CMPDOC_UCP
where 
hiv_cocde = 'UCP' and --cmp_type = 'Invoice' and 
hiv_invno = cmp_docno and 
ltrim(str(month(cmp_txndat))) + '/' + ltrim(str(day(cmp_txndat))) + '/' + ltrim(str(year(cmp_txndat))) = 
ltrim(str(month(getdate()))) + '/' + ltrim(str(day(getdate()))) + '/' + ltrim(str(year(getdate())))


update	SHINVHDR 
set	hiv_invsts = 'CLO', hiv_upddat = getdate()
from SHINVHDR, CMPDOC_PG
where 
hiv_cocde = 'PG' and --cmp_type = 'Invoice' and 
hiv_invno = cmp_docno and 
ltrim(str(month(cmp_txndat))) + '/' + ltrim(str(day(cmp_txndat))) + '/' + ltrim(str(year(cmp_txndat))) = 
ltrim(str(month(getdate()))) + '/' + ltrim(str(day(getdate()))) + '/' + ltrim(str(year(getdate())))


update	SHINVHDR 
set	hiv_invsts = 'CLO', hiv_upddat = getdate()
from SHINVHDR, CMPDOC_EW
where 
hiv_cocde = 'EW' and --cmp_type = 'Invoice' and 
hiv_invno = cmp_docno and 
ltrim(str(month(cmp_txndat))) + '/' + ltrim(str(day(cmp_txndat))) + '/' + ltrim(str(year(cmp_txndat))) = 
ltrim(str(month(getdate()))) + '/' + ltrim(str(day(getdate()))) + '/' + ltrim(str(year(getdate())))


update	SHINVHDR 
set	hiv_invsts = 'CLO', hiv_upddat = getdate()
from SHINVHDR, CMPDOC_MS
where 
hiv_cocde = 'MS' and --cmp_type = 'Invoice' and 
hiv_invno = cmp_docno and 
ltrim(str(month(cmp_txndat))) + '/' + ltrim(str(day(cmp_txndat))) + '/' + ltrim(str(year(cmp_txndat))) = 
ltrim(str(month(getdate()))) + '/' + ltrim(str(day(getdate()))) + '/' + ltrim(str(year(getdate())))


update	SAINVHDR 
set	sih_invsts = 'CLO', sih_upddat = getdate()
from SAINVHDR, CMPDOC_UCPP
where 
sih_cocde = 'UCPP' and --cmp_type <> 'Invoice' and 
sih_invno = cmp_docno and 
ltrim(str(month(cmp_txndat))) + '/' + ltrim(str(day(cmp_txndat))) + '/' + ltrim(str(year(cmp_txndat))) = 
ltrim(str(month(getdate()))) + '/' + ltrim(str(day(getdate()))) + '/' + ltrim(str(year(getdate())))


update	SAINVHDR 
set	sih_invsts = 'CLO', sih_upddat = getdate()
from SAINVHDR, CMPDOC_UCP
where 
sih_cocde = 'UCP' and --cmp_type <> 'Invoice' and 
sih_invno = cmp_docno and 
ltrim(str(month(cmp_txndat))) + '/' + ltrim(str(day(cmp_txndat))) + '/' + ltrim(str(year(cmp_txndat))) = 
ltrim(str(month(getdate()))) + '/' + ltrim(str(day(getdate()))) + '/' + ltrim(str(year(getdate())))


update	SAINVHDR 
set	sih_invsts = 'CLO', sih_upddat = getdate()
from SAINVHDR, CMPDOC_PG
where 
sih_cocde = 'PG' and --cmp_type <> 'Invoice' and 
sih_invno = cmp_docno and 
ltrim(str(month(cmp_txndat))) + '/' + ltrim(str(day(cmp_txndat))) + '/' + ltrim(str(year(cmp_txndat))) = 
ltrim(str(month(getdate()))) + '/' + ltrim(str(day(getdate()))) + '/' + ltrim(str(year(getdate())))


update	SAINVHDR 
set	sih_invsts = 'CLO', sih_upddat = getdate()
from SAINVHDR, CMPDOC_EW
where 
sih_cocde = 'EW' and --cmp_type <> 'Invoice' and 
sih_invno = cmp_docno and 
ltrim(str(month(cmp_txndat))) + '/' + ltrim(str(day(cmp_txndat))) + '/' + ltrim(str(year(cmp_txndat))) = 
ltrim(str(month(getdate()))) + '/' + ltrim(str(day(getdate()))) + '/' + ltrim(str(year(getdate())))


update	SAINVHDR 
set	sih_invsts = 'CLO', sih_upddat = getdate()
from SAINVHDR, CMPDOC_MS
where 
sih_cocde = 'MS' and --cmp_type <> 'Invoice' and 
sih_invno = cmp_docno and 
ltrim(str(month(cmp_txndat))) + '/' + ltrim(str(day(cmp_txndat))) + '/' + ltrim(str(year(cmp_txndat))) = 
ltrim(str(month(getdate()))) + '/' + ltrim(str(day(getdate()))) + '/' + ltrim(str(year(getdate())))


update 	SHIPGHDR 
set 	hih_shpsts = 'CLO', hih_upddat = getdate()
where hih_cocde = 'UCPP' and hih_shpsts <> 'CLO' and 
hih_shpno in
(select distinct hiv_shpno from SHINVHDR, CMPDOC_UCPP
where 
hiv_cocde = 'UCPP' and --cmp_type = 'Invoice' and 
hiv_invno = cmp_docno and 
ltrim(str(month(cmp_txndat))) + '/' + ltrim(str(day(cmp_txndat))) + '/' + ltrim(str(year(cmp_txndat))) = 
ltrim(str(month(getdate()))) + '/' + ltrim(str(day(getdate()))) + '/' + ltrim(str(year(getdate())))) and 
(select count(*) from SHINVHDR where hiv_cocde = 'UCPP' and hih_shpno = hiv_shpno) = 
(select count(*) from SHINVHDR where hiv_cocde = 'UCPP' and hih_shpno = hiv_shpno and hiv_invsts = 'CLO')


update 	SHIPGHDR 
set 	hih_shpsts = 'CLO', hih_upddat = getdate()
where hih_cocde = 'UCP' and hih_shpsts <> 'CLO' and 
hih_shpno in
(select distinct hiv_shpno from SHINVHDR, CMPDOC_UCP
where 
hiv_cocde = 'UCP' and --cmp_type = 'Invoice' and 
hiv_invno = cmp_docno and 
ltrim(str(month(cmp_txndat))) + '/' + ltrim(str(day(cmp_txndat))) + '/' + ltrim(str(year(cmp_txndat))) = 
ltrim(str(month(getdate()))) + '/' + ltrim(str(day(getdate()))) + '/' + ltrim(str(year(getdate())))) and 
(select count(*) from SHINVHDR where hiv_cocde = 'UCP' and hih_shpno = hiv_shpno) = 
(select count(*) from SHINVHDR where hiv_cocde = 'UCP' and hih_shpno = hiv_shpno and hiv_invsts = 'CLO')


update 	SHIPGHDR 
set 	hih_shpsts = 'CLO', hih_upddat = getdate()
where hih_cocde = 'PG' and hih_shpsts <> 'CLO' and 
hih_shpno in
(select distinct hiv_shpno from SHINVHDR, CMPDOC_PG
where 
hiv_cocde = 'PG' and --cmp_type = 'Invoice' and 
hiv_invno = cmp_docno and 
ltrim(str(month(cmp_txndat))) + '/' + ltrim(str(day(cmp_txndat))) + '/' + ltrim(str(year(cmp_txndat))) = 
ltrim(str(month(getdate()))) + '/' + ltrim(str(day(getdate()))) + '/' + ltrim(str(year(getdate())))) and 
(select count(*) from SHINVHDR where hiv_cocde = 'PG' and hih_shpno = hiv_shpno) = 
(select count(*) from SHINVHDR where hiv_cocde = 'PG' and hih_shpno = hiv_shpno and hiv_invsts = 'CLO')


update 	SHIPGHDR 
set 	hih_shpsts = 'CLO', hih_upddat = getdate()
where hih_cocde = 'EW' and hih_shpsts <> 'CLO' and 
hih_shpno in
(select distinct hiv_shpno from SHINVHDR, CMPDOC_EW
where 
hiv_cocde = 'EW' and --cmp_type = 'Invoice' and 
hiv_invno = cmp_docno and 
ltrim(str(month(cmp_txndat))) + '/' + ltrim(str(day(cmp_txndat))) + '/' + ltrim(str(year(cmp_txndat))) = 
ltrim(str(month(getdate()))) + '/' + ltrim(str(day(getdate()))) + '/' + ltrim(str(year(getdate())))) and 
(select count(*) from SHINVHDR where hiv_cocde = 'EW' and hih_shpno = hiv_shpno) = 
(select count(*) from SHINVHDR where hiv_cocde = 'EW' and hih_shpno = hiv_shpno and hiv_invsts = 'CLO')


update 	SHIPGHDR 
set 	hih_shpsts = 'CLO', hih_upddat = getdate()
where hih_cocde = 'MS' and hih_shpsts <> 'CLO' and 
hih_shpno in
(select distinct hiv_shpno from SHINVHDR, CMPDOC_MS
where 
hiv_cocde = 'MS' and --cmp_type = 'Invoice' and 
hiv_invno = cmp_docno and 
ltrim(str(month(cmp_txndat))) + '/' + ltrim(str(day(cmp_txndat))) + '/' + ltrim(str(year(cmp_txndat))) = 
ltrim(str(month(getdate()))) + '/' + ltrim(str(day(getdate()))) + '/' + ltrim(str(year(getdate())))) and 
(select count(*) from SHINVHDR where hiv_cocde = 'EW' and hih_shpno = hiv_shpno) = 
(select count(*) from SHINVHDR where hiv_cocde = 'EW' and hih_shpno = hiv_shpno and hiv_invsts = 'CLO')



--Remember call solo sp , sp_update_CUPRCINF_risk_credit_used





GO
GRANT EXECUTE ON [dbo].[sp_update_Invoice] TO [ERPUSER] AS [dbo]
GO
