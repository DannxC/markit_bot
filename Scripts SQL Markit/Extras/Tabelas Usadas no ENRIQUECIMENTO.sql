select * from bd_108_bbmcorp..indx_0174				-- tab de indices (externos)

select * from bd_108_bbmcorp..cod_ext_0443			-- tab de contrapartes (externo)

select * from bd_108_bbmcorp..itmd_0030				-- códigos INTERNOS do bahia

select * from bd_108_bbmcorp..v_moe_0042			-- tab de código de MOEDAS




select * from bd_108_bbmcorp..itfc_0115				-- tab das interfaces						minha: 'Importacao_Markit'
select * from bd_108_bbmcorp..func_sgn_0026			-- tab da funcao de segurança				minha: 'ITFC_IPC_DD_MRKIT' (cadastrei manualmente)			167
select * from bd_108_bbmcorp..usr_func_sgn_0028		-- tab de usuarios que sao permitidos pela funcao de segurança.				( a priori eu copiei os mesmos usuarios q sao permitidos no MUFG)

select * from bd_108_bbmcorp..agdm_trf_0162			-- tab de agendamento de tarefas			minha: tipo: 'Robo_Markit' + tarefa: 'Importacao_Dados_Markit'

