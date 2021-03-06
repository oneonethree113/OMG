/****** Object:  StoredProcedure [dbo].[sp_select_IMR00024]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMR00024]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMR00024]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[sp_select_IMR00024]
@cocde varchar(6),
@SCFm varchar(20), 
@SCTo varchar(20), 
@JobFm varchar(20), 
@JobTo varchar(20), 
@Act char(1),
@gsUsrID varchar(30)
as
begin
	declare 
		@optSC char(1), 
		@optJob char(1)

	set @optSC = 'N'
	if @SCFm <> ''
	begin
		set @optSC = 'Y'
	end

	set @optJob = 'N'
	if @JobFm <> ''
	begin
		set @optJob = 'Y'
	end
		
	if @ACT = 'U'
	begin
		select 
			fsa_jobno as 'Job #', 
			fsa_smkno as 'Ship Mark', 
			fsa_act as 'Action', 
			fsa_updusr as 'Update User', 
			fsa_upddat as 'Update Date'
		 from 
			FYJOBATH(nolock)
		where
			(@optSC = 'N' or (@optSC = 'Y' and left(fsa_jobno,9) between @SCFm and @SCTo)) and
			(@optJob = 'N' or (@optJob = 'Y' and fsa_jobno between @JobFm and @JobTo)) 
			--and fsa_act <> ''		
		order by 
			fsa_jobno , 
			fsa_upddat 

	end
	else
	begin
		select 
			fsa_jobno as 'Job #', 
			fsa_smkno as 'Ship Mark', 
			--fsa_act as 'Action', 
			fsa_updusr as 'Update User', 
			fsa_upddat as 'Update Date'
		 from 
			FYJOBATH(nolock)
		where
			(@optSC = 'N' or (@optSC = 'Y' and left(fsa_jobno,9) between @SCFm and @SCTo)) and
			(@optJob = 'N' or (@optJob = 'Y' and fsa_jobno between @JobFm and @JobTo)) 
			and fsa_act <> 'DEL'
		order by 
			fsa_jobno , 
			fsa_smkno 

	end
end





GO
GRANT EXECUTE ON [dbo].[sp_select_IMR00024] TO [ERPUSER] AS [dbo]
GO
