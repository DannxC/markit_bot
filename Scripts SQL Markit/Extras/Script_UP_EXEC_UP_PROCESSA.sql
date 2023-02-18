use bd_106_bbmfront

update bd_106_bbmfront..dd_mrkit_temp_0963
set ind_sit_0963 = 1
where cod_instc_ipc_0963 = 9

EXEC [UP_Processa_Execucoes_Markit_IRS] 9



--SELECT DISTINCT
--	descErro
--FROM
--	##Problemas_Validacao_Markit
--WHERE
--	descErro <> ''

SELECT * FROM bd_106_bbmfront.dbo.ctrl_ipc
select * from bd_106_bbmfront..dd_mrkit_temp_0963


DECLARE @QtdDiferentesDatas INT
SELECT 
	@QtdDiferentesDatas = COUNT(distinct header_Trade_Date_0963) 
FROM
	dbo.dd_mrkit_temp_0963 AS temp
WHERE
		temp.ind_sit_0963			= 1
	AND temp.cod_instc_ipc_0963		= 8
GROUP BY
	header_Trade_Date_0963



select distinct
	*
from 
	bd_106_bbmfront..dd_mrkit_temp_0963
where 
	ind_sit_0963 = 1 --and cod_instc_ipc_0963 = 22

select distinct
	*
from 
	bd_106_bbmfront..dd_mrkit_0964 
where 
	ind_sit_0964 = 1 --and cod_instc_ipc_0963 = 22