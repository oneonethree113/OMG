/****** Object:  StoredProcedure [dbo].[sp_list_VNCNTINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_VNCNTINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_VNCNTINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     procedure [dbo].[sp_list_VNCNTINF]

@vci_cocde 	nvarchar(6) ,
@vci_venno  	nvarchar(6) ,
@vci_cnttyp	nvarchar(6),
@vci_ADR_PER	nvarchar(3)
                                              
AS

begin

if @vci_ADR_PER = 'ADR' 
begin

	if @vci_cnttyp = 'Q' 
		begin
			select 
		
			'   ' as 'Status',
		 	isnull(vci_cnttyp,'') as 'vci_cnttyp',
			vci_adr,
			isnull(vci_town,'') as 'vci_town',
			isnull(vci_city,'') as 'vci_city',
			vci_stt,
			vci_cty + ' - ' + ysi_dsc as 'vci_cty',
			vci_zip,
			vci_creusr,
			vci_seq,
			-- Added by Mark Lau 20081027
			isnull(vci_chnadr,'') as 'vci_chnadr',	
			isnull(vci_adrdtl,'') as 'vci_adrdtl'
			from VNCNTINF (nolock)
			left join SYSETINF (nolock)
			on ysi_typ = '02'  
			--and vci_cocde=ysi_cocde 
			and vci_cty = ysi_cde
		
			where                                  
			--vci_cocde 	= @vci_cocde and                                                                                                                                                                                                                         
			vci_venno 	= @vci_venno and
			(vci_cnttyp='U' or vci_cnttyp='Q') and
			vci_cty		<> ''
		
			order by vci_adr

		end
	else  if @vci_cnttyp = 'M' 
		begin

			select 
		
			'   ' as 'Status',
		 	isnull(vci_cnttyp,'') as 'vci_cnttyp',
			vci_adr,
		
			isnull(vci_town,'') as 'vci_town',
			isnull(vci_city,'') as 'vci_city',
			vci_stt,
			vci_cty + ' - ' + ysi_dsc as 'vci_cty',
			vci_zip,
			vci_creusr,
			vci_seq,
			-- Added by Mark Lau 20081027
			isnull(vci_chnadr,'') as 'vci_chnadr',	
			isnull(vci_adrdtl,'') as 'vci_adrdtl'
			from VNCNTINF (nolock)
			left join SYSETINF (nolock)
			on ysi_typ = '02'  
			--and vci_cocde=ysi_cocde 
			and vci_cty = ysi_cde
		
			where                                  
			--vci_cocde 	= @vci_cocde and                                                                                                                                                                                                                         
			vci_venno 	= @vci_venno and
			vci_cnttyp	= @vci_cnttyp and
			vci_cty		<> ''
		
			order by vci_adr
		end
	else  if @vci_cnttyp = 'C' 
		begin

			select 
		
			'   ' as 'Status',
		 	isnull(vci_cnttyp,'') as 'vci_cnttyp',
			vci_adr,
			isnull(vci_town,'') as 'vci_town',
			isnull(vci_city,'') as 'vci_city',
			vci_stt,
			vci_cty  as 'vci_cty',
			vci_zip,
			vci_creusr,
			vci_seq,
			-- Added by Mark Lau 20081027
			isnull(vci_chnadr,'') as 'vci_chnadr',	
			isnull(vci_adrdtl,'') as 'vci_adrdtl'
			from VNCNTINF (nolock)
--			left join SYSETINF (nolock)
	--		on ysi_typ = '02'  
			--and vci_cocde=ysi_cocde 
			--and vci_cty = ysi_cde
		
			where                                  
			--vci_cocde 	= @vci_cocde and                                                                                                                                                                                                                         
			vci_venno 	= @vci_venno and
			vci_cnttyp	= @vci_cnttyp --and
			--vci_cty		<> ''
		
			order by vci_adr

		end
	else
		begin
			select 
			'   ' as 'Status',
		 	isnull(vci_cnttyp,'') as 'vci_cnttyp',
			vci_adr,
			isnull(vci_town,'') as 'vci_town',
			isnull(vci_city,'') as 'vci_city',
			vci_stt,
			vci_cty + ' - ' + ysi_dsc as 'vci_cty',
			vci_zip,
			vci_creusr,
			vci_seq,
			-- Added by Mark Lau 20081027
			isnull(vci_chnadr,'') as 'vci_chnadr',	
			isnull(vci_adrdtl,'') as 'vci_adrdtl'
	 		from VNCNTINF (nolock)
			left join SYSETINF (nolock)	on ysi_typ = '02'  	and vci_cty = ysi_cde
			where                                  
			--vci_cocde 	= @vci_cocde and                                                                                                                                                                                                                         
			vci_venno 	= @vci_venno and
			vci_cnttyp	= @vci_cnttyp and
			vci_cty		<> ''
			order by vci_adr
		end
end

if @vci_ADR_PER = 'PER' 
begin
	select 
	'   ' as 'Status',
	vci_cnttyp,
	vci_cntctp,
	vci_cnttil,
	vci_cntphn,
	vci_cntfax,
	vci_cnteml,
	vci_cntdef,
	vci_creusr,
	vci_seq
	from VNCNTINF (nolock)
	where                                  
	--vci_cocde 	= @vci_cocde and                                                                                                                                                                                                                         
	vci_venno 	= @vci_venno and
	vci_cntctp	<> ''

	order by vci_cnttyp, vci_cntdef desc, vci_cntctp
end

end





GO
GRANT EXECUTE ON [dbo].[sp_list_VNCNTINF] TO [ERPUSER] AS [dbo]
GO
