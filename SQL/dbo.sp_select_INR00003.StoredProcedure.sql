/****** Object:  StoredProcedure [dbo].[sp_select_INR00003]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_INR00003]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_INR00003]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO










--sp_select_INR00003 'UCP','0001,0002,0003,0004,0005,0006,0007,0008,0009,1000,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1016,1017,1018,1019,1020,1021,1022,1023,1024,1025,1026,1027,1028,1029,1030,1031,1032,1033,1034,1035,1036,1037,1038,1039,1040,1041,1042,1043,1044,1045,1046,1047,1048,1049,1050,1051,1052,1053,1054,1055,1056,1057,1058,1059,1060,1061,1062,1063,1064,1065,1066,1067,1068,1069,1070,1071,1072,1073,1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1086,1087,1088,1089,1090,1091,1092,1093,1094,1095,1096,1097,1098,1099,1100,1101,1102,1103,1104,1105,1106,1107,1108,1109,1110,1111,1112,1113,1114,1115,1116,1117,1118,1119,1120,1121,1122,1123,1124,1125,1126,1127,1128,1129,1130,1131,1132,1133,1134,1135,1136,1137,1138,1139,1140,1141,1142,1143,1144,1145,1146,1147,1148,1149,1150,1151,1152,1153,1154,1155,1156,1157,1158,1159,1160,1161,1162,1163,1164,1165,1166,1167,1168,1169,1170,1171,1172,1173,1174,1175,1176,1177,1178,1179,1180,1181,1182,1183,1184,1185,1186,1187,1188,1189,1190,1191,119
--2,1193,1194,1195,1196,1197,1198,1199,1200,1201,1202,1203,1204,1205,1206,1207,1208,1209,1210,1211,1212,1213,1214,1215,1216,1217,1218,1219,1220,1221,1222,1223,1224,1225,1226,1227,1228,1229,1230,1231,1232,1233,1234,1235,1236,1237,1238,1239,1240,1241,1242,1243,1244,1245,1246,1247,1248,1249,1250,1251,1252,1253,1254,1255,1256,1257,1258,1259,1260,1261,1262,1263,1264,1265,1266,1267,1268,1269,1270,1271,1272,1273,1274,1275,1276,1277,1278,1279,1280,1281,1282,1283,1284,1285,1286,1287,1288,1289,1290,1291,1292,1293,1294,1295,1296,1297,1298,1299,1300,1301,1302,1303,1304,1305,1306,1307,1308,1309,1310,1311,1312,1313,1314,1315,1316,1317,1318,1319,1320,1321,1322,1323,1324,1325,1326,1327,1328,1329,1330,1331,1332,1333,1334,1335,1336,1337,1338,1339,1340,1341,1342,1343,1344,1345,1346,1347,1348,1349,1350,1351,1352,1353,1354,1355,1356,1357,1358,1359,1360,1361,1362,1363,1364,1365,1366,1367,1368,1369,1370,1371,1372,1373,1374,1375,1376,1377,1378,1379,1381,1382,1383,1384,1385,1386,1387,1388,1389,1390,1391,1392,1393,1394,1395,1396,1397,1
--398,1399,1400,1401,1402,1403,1404,1405,1406,1407,1408,1409,1410,1411,1412,1413,1414,1415,1416,1417,1418,1419,1420,1421,1422,1423,1424,1425,1426,1427,1428,1429,1430,1431,1432,1433,1434,1435,1436,1437,1438,1439,1440,1441,1442,1443,1444,1445,1446,1447,1448,1449,1450,1451,1452,1453,1454,1455,1456,1457,1458,1459,1460,1461,1462,1463,1464,1465,1466,1467,1468,1469,1470,1471,1472,1473,1474,1475,1476,1477,1478,1479,1480,1481,1482,1483,1484,1485,1486,1487,1488,1489,1490,1491,1492,1493,1494,1495,1496,1497,1498,1499,1500,1501,1502,1503,1504,1505,1506,1507,1508,1509,1510,1511,1512,1513,1514,1515,1516,1517,1518,1519,1520,1521,1522,1523,1524,1525,1526,1527,1528,1529,1530,1531,1532,1533,1534,1535,1536,1537,1538,1539,1540,1541,1542,1543,1544,1545,1546,1547,1548,1549,1550,1551,1552,1553,1554,1555,1556,1557,1558,1559,1560,1561,1562,1563,1564,1565,1566,1567,1568,1569,1570,1571,1572,1573,1574,1575,1576,1577,1578,1579,1580,1581,1582,1583,1584,1585,1586,1587,1588,1589,1590,1591,1592,1593,1594,1595,1596,1597,1598,1599,1600,1601,1602
--,1603,1604,1605,1606,1607,1608,1609,1610,1611,1612,1613,1614,1615,1616,1617,1618,1619,1620,1621,1622,1623,1624,1625,1626,1627,1628,1629,1630,1631,1632,1633,1634,1635,1636,1637,1638,1639,1640,1641,1642,1643,1644,1645,1646,1647,1648,9000,9999,A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,T,U,Z','ALL Vendors','','','0','FD','OT','01/01/2003','12/31/2003 23:59:59'



-- Checked by Allan Yuen at 27/03/2003
-- Add ALL COmpany Selection by Lester On 2004/02/27

/*********************************************************************
Modification History
**********************************************************************
Date		Initial		Description
**********************************************************************
16th Feb, 2005	Lester Wu		Add factory 'S','R','W'
**********************************************************************/

CREATE  PROCEDURE [dbo].[sp_select_INR00003]
@cocde		nvarchar(6),
@vendor		varchar(4000),
@Vendor_label	nvarchar(4000),
@SCFm	nvarchar(40),
@SCTo	nvarchar(40),
@CatL		nvarchar(1),
@CatFm	nvarchar(20),
@CatTo	nvarchar(20),
@dateFm	datetime,
@dateTo	datetime

As 

--if @cocde = 'UCP' set @vendor = '0005,0007,0006,0009'
--if @cocde = 'UCPP' set @vendor = 'A,B,C,D,E,F,G,H,J,K,L,M,N,P,T,U,Z'
--2005/02/16 Lester Wu Add 'S,R,W' Factory
--if (@cocde = 'UCPP'  OR @cocde = 'PG') and @vendor = 'A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,T,U,Z' set @Vendor_label = 'Internal & Joint-Venture Vendor'                               
if (@cocde = 'UCPP'  OR @cocde = 'PG') and @vendor = 'A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,U,W,Z' set @Vendor_label = 'Internal & Joint-Venture Vendor'

create table #tmp_INR00003 (tmp_venno	nvarchar(6)) on [PRIMARY]
Declare	@vendor_part	nvarchar(10),
@vendor_remain	varchar(4000)
Set @vendor_remain = @vendor
While charindex(',', @vendor_remain) <> 0
begin
	Set @vendor_part = ltrim(left(@vendor_remain, charindex(',',@vendor_remain) - 1))
	Set @vendor_remain = right(@vendor_remain, len(@vendor_remain) - charindex(',', @vendor_remain))
	insert into #tmp_INR00003 values (@vendor_part)
end
insert into #tmp_INR00003 values (ltrim(@vendor_remain))



Declare 
@SCFmC	nvarchar(4),
@SCToC	nvarchar(4)

set @SCFmC  = ''
set @SCToC  = ''

If @SCFm <> ''
begin
	Set @SCFmC = left(@SCFm, charindex(' - ', @SCFm))
end
If @SCTo <> ''
begin
	Set @SCToC = left(@SCTo, charindex(' - ', @SCTo) )
end
--Frankie Cheung 20091006---
/*
declare @CURAT	numeric(15,11)

select @CURAT = isnull(ysi_selrat,0) from SYSETINF where 
		--ysi_cocde = @cocde and 
		ysi_cde= 'HKD'
*/
-----------------------------


Select	
-- Rem By Lester Wu on 2004/02/27 
--'cocde' = @Cocde,
--	'vendor' = @vendor,
--	'vendor_label' = replace(replace(@vendor_label, '(', '/'),')', '/'),
--	'SCFm' = @SCFm,
--	'SCTo' = @SCTo,
------------------------------
	'dateFrom' = 
			Case	
				when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') <= @dateFm then @dateFm
				when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') >   @dateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01')
				when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') <=  @dateFm then @dateFm
				when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') >    @dateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16')end,

	'DateTo' = 	
			Case	
				when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  > @dateTo then @dateTo
				when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  <= @dateTo then convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')
				when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  <= @dateTo then convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1
				when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  > @dateTo then @dateTo end,

--	'USAAMT' = sum(case hid_untsel when 'HKD' then isnull(hid_shpqty * hid_selprc * @CURAT,0) else isnull(hid_shpqty * hid_selprc,0) end),
	--Frankie Cheung 20091006
	'USAAMT' = sum(case soh_curexrat when 0 then 0 else isnull(hid_shpqty * hid_selprc / soh_curexrat,0) end),

	'USD' = sum(case hid_untsel when 'USD' then isnull(hid_shpqty * hid_selprc,0) ELSE 0 end),
	'HKD' = sum(case hid_untsel when 'HKD' then isnull(hid_shpqty * hid_selprc,0) ELSE 0 end)
	,hih_cocde
-- Lester Wu 2004/02/27
into #tmp_inr00003_result
-----------------------------
From	
--	SHIPGDTL, SCORDDTL, SHINVHDR, IMBASINF, #tmp_INR00003
--	SHIPGDTL, SCORDDTL, SHINVHDR, v_imbasinf_rpt, #tmp_INR00003
	SHIPGHDR,
	SHINVHDR,
	SHIPGDTL,
	SCORDDTL,
	v_imbasinf_rpt,
	#tmp_INR00003,
	SCORDHDR
Where	

		hih_cocde = hid_cocde 
	and	hih_shpno = hid_shpno
	and	hid_cocde = sod_cocde 
	and 	hid_ordno = sod_ordno 
	and 	hid_ordseq = sod_ordseq 
	and 	hid_cocde = hiv_cocde 
	and 	hid_shpno = hiv_shpno 
	and 	hid_invno = hiv_invno
	and	hid_itmno = sod_itmno
--	and 	left(hid_colcde,10) = left(sod_colcde,10)
	and	sod_itmno = ibi_itmno
	--Frankie Cheung 20091006
	and	sod_ordno = soh_ordno

/*
		hid_cocde = sod_cocde 
	and 	hid_ordno = sod_ordno 

	and 	hid_ordseq = sod_ordseq 
	and 	hid_cocde = hiv_cocde 
	and 	hid_shpno = hiv_shpno 
	and 	hid_invno = hiv_invno
	--and	hid_cocde = ibi_cocde and hid_itmno = ibi_itmno
	and	hid_itmno = sod_itmno

	and 	hid_colcde = sod_colcde 
	and	sod_itmno = ibi_itmno
*/
--	and 	hiv_invdat between convert(datetime,  @dateFm, 121) and convert(datetime, @dateTo, 121) 

	and 	hiv_invdat >= convert(datetime,  @dateFm, 121) and hiv_invdat  <=  convert(datetime, @dateTo, 121) 
	--and	hid_cocde= @cocde 
	--and	(@cocde='ALL' or hih_cocde=@cocde)
	and 	hid_venno = tmp_venno

/*
	hid_cocde = sod_cocde 
and 	hid_ordno = sod_ordno 
and 	hid_ordseq = sod_ordseq 

and 	hid_cocde = hiv_cocde 
and 	hid_shpno = hiv_shpno 
and 	hid_invno = hiv_invno
and	hid_itmno = ibi_itmno

and	hid_itmno = sod_itmno
and	hid_colcde = sod_colcde
and 	hiv_invdat between convert(datetime,  @dateFm, 121) and convert(datetime, @dateTo, 121) 
and	hid_cocde= @cocde 
and 	hid_venno = tmp_venno
*/

and 	((@SCTo <> '' and  sod_subcde Between @SCFmC and @SCToC ) or @SCTo = '')
and	((@CatFm <> '' and ibi_catlvl0 between @CatFm and @CatTo and @CatL = '0') or
	(@CatFm <> '' and ibi_catlvl1 between @CatFm and @CatTo and @CatL = '1') or
	(@CatFm <> '' and ibi_catlvl2 between @CatFm and @CatTo and @CatL = '2') or
	(@CatFm <> '' and ibi_catlvl3 between @CatFm and @CatTo and @CatL = '3') or
	(@CatFm <> '' and ibi_catlvl4 between @CatFm and @CatTo and @CatL = '4') or @CatFm = '')

group by 
	-- Lester Wu 2004/02/27
	hih_cocde,
	-----------------------
	Case	
		when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') <= @dateFm then @dateFm
		when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') >   @dateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01')
		when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') <=  @dateFm then @dateFm
		when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') >    @dateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16')end,

	Case	
		when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  > @dateTo then @dateTo
		when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  <= @dateTo then convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')
		when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  <= @dateTo then convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1
		when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  > @dateTo then @dateTo end


order by 
	Case	
		when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') <= @dateFm then @dateFm
		when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') >   @dateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01')
		when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') <=  @dateFm then @dateFm
		when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') >    @dateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16')end,

	Case	
		when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  > @dateTo then @dateTo
		when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  <= @dateTo then convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')
		when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  <= @dateTo then convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1
		when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  > @dateTo then @dateTo end
-- Lester Wu 2004/02/27

if @Cocde<>'ALL'
begin 
delete from #tmp_inr00003_result where hih_cocde <>@cocde
end
select 	--cocde,vendor,vendor_label,SCFm,SCTo,
	'cocde' = @Cocde,
	'vendor' = @vendor,
	'vendor_label' = replace(replace(@vendor_label, '(', '/'),')', '/'),
	'SCFm' = @SCFm,
	'SCTo' = @SCTo,
	dateFrom,DateTo,
	sum(round(USAAMT,2)) as 'USAAMT',sum(round(USD,2))as 'USD',sum(round(HKD,2))as 'HKD'
from #tmp_inr00003_result 
group by dateFrom,DateTo
-------------------------------






GO
GRANT EXECUTE ON [dbo].[sp_select_INR00003] TO [ERPUSER] AS [dbo]
GO
