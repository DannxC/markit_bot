USE bd_106_bbmfront

-- Permissions

GRANT EXECUTE ON  [dbo].[UP_Insere_Importacao_Execucoes_Markit_IRS] TO [BBMI\admintaskscheduler]
GO
-- Extended Properties

EXEC sp_addextendedproperty N'Categoria_Informacao', 'Interna_BD', 'SCHEMA', N'dbo', 'PROCEDURE', N'UP_Insere_Importacao_Execucoes_Markit_IRS', NULL, NULL
EXEC sp_addextendedproperty N'Descricao', 'Insere Importacao Execucoes Markit IRS', 'SCHEMA', N'dbo', 'PROCEDURE', N'UP_Insere_Importacao_Execucoes_Markit_IRS', NULL, NULL
EXEC sp_addextendedproperty N'Leitura_Escrita', 'NA', 'SCHEMA', N'dbo', 'PROCEDURE', N'UP_Insere_Importacao_Execucoes_Markit_IRS', NULL, NULL
EXEC sp_addextendedproperty N'Segregacao_Visao', 'NA', 'SCHEMA', N'dbo', 'PROCEDURE', N'UP_Insere_Importacao_Execucoes_Markit_IRS', NULL, NULL


GRANT EXECUTE ON  [dbo].[UP_Processa_Execucoes_Markit_IRS] TO [BBMI\admintaskscheduler]
GO
-- Extended Properties

EXEC sp_addextendedproperty N'Categoria_Informacao', 'Interna_BD', 'SCHEMA', N'dbo', 'PROCEDURE', N'UP_Processa_Execucoes_Markit_IRS', NULL, NULL
EXEC sp_addextendedproperty N'Descricao', 'Processa Execucoes Markit IRS', 'SCHEMA', N'dbo', 'PROCEDURE', N'UP_Processa_Execucoes_Markit_IRS', NULL, NULL
EXEC sp_addextendedproperty N'Leitura_Escrita', 'NA', 'SCHEMA', N'dbo', 'PROCEDURE', N'UP_Processa_Execucoes_Markit_IRS', NULL, NULL
EXEC sp_addextendedproperty N'Segregacao_Visao', 'NA', 'SCHEMA', N'dbo', 'PROCEDURE', N'UP_Processa_Execucoes_Markit_IRS', NULL, NULL


-- Permissions
GO
GRANT EXECUTE ON  [dbo].[UP_USR_Busca_Execucoes_Markit_IRS] TO [BBMI\BD_SEG_Compliance_Gerente]
GRANT EXECUTE ON  [dbo].[UP_USR_Busca_Execucoes_Markit_IRS] TO [BBMI\BD_SEG_Controle_Diretor]
GRANT EXECUTE ON  [dbo].[UP_USR_Busca_Execucoes_Markit_IRS] TO [BBMI\BD_SEG_Controle_Gerente]
GRANT EXECUTE ON  [dbo].[UP_USR_Busca_Execucoes_Markit_IRS] TO [BBMI\BD_SEG_Controle_Junior]
GRANT EXECUTE ON  [dbo].[UP_USR_Busca_Execucoes_Markit_IRS] TO [BBMI\BD_SEG_Controle_Pleno]
GRANT EXECUTE ON  [dbo].[UP_USR_Busca_Execucoes_Markit_IRS] TO [BBMI\BD_SEG_Controle_Senior]
GRANT EXECUTE ON  [dbo].[UP_USR_Busca_Execucoes_Markit_IRS] TO [BBMI\BD_SEG_Gerencial_Gerente]
GRANT EXECUTE ON  [dbo].[UP_USR_Busca_Execucoes_Markit_IRS] TO [BBMI\BD_SEG_Gerencial_Junior]
GRANT EXECUTE ON  [dbo].[UP_USR_Busca_Execucoes_Markit_IRS] TO [BBMI\BD_SEG_Gerencial_Senior]
GRANT EXECUTE ON  [dbo].[UP_USR_Busca_Execucoes_Markit_IRS] TO [BBMI\BD_SEG_Mesa_Gerente]
GRANT EXECUTE ON  [dbo].[UP_USR_Busca_Execucoes_Markit_IRS] TO [BBMI\BD_SEG_Mesa_Head]
GRANT EXECUTE ON  [dbo].[UP_USR_Busca_Execucoes_Markit_IRS] TO [BBMI\BD_SEG_Mesa_Junior]
GRANT EXECUTE ON  [dbo].[UP_USR_Busca_Execucoes_Markit_IRS] TO [bbmi\BD_SEG_Precos_Junior]
GRANT EXECUTE ON  [dbo].[UP_USR_Busca_Execucoes_Markit_IRS] TO [bbmi\BD_SEG_Risco_Junior]
GRANT EXECUTE ON  [dbo].[UP_USR_Busca_Execucoes_Markit_IRS] TO [BBMI\BD_SEG_TI_Gerente]
GRANT EXECUTE ON  [dbo].[UP_USR_Busca_Execucoes_Markit_IRS] TO [BBMI\BD_SEG_Ti_Senior]
GRANT EXECUTE ON  [dbo].[UP_USR_Busca_Execucoes_Markit_IRS] TO [R_RenanMaldonado]
GO
-- Extended Properties

EXEC sp_addextendedproperty N'Categoria_Informacao', 'Execuções', 'SCHEMA', N'dbo', 'PROCEDURE', N'UP_USR_Busca_Execucoes_Markit', NULL, NULL
EXEC sp_addextendedproperty N'Descricao', 'USR Busca Execucoes Markit IRS', 'SCHEMA', N'dbo', 'PROCEDURE', N'UP_USR_Busca_Execucoes_Markit_IRS', NULL, NULL
EXEC sp_addextendedproperty N'Leitura_Escrita', 'Leitura', 'SCHEMA', N'dbo', 'PROCEDURE', N'UP_USR_Busca_Execucoes_Markit_IRS', NULL, NULL
EXEC sp_addextendedproperty N'Segregacao_Visao', 'Empresa', 'SCHEMA', N'dbo', 'PROCEDURE', N'UP_USR_Busca_Execucoes_Markit_IRS', NULL, NULL

GO	
GRANT SELECT ON dbo.dd_mrkit_temp_0963 TO [BBMI\admintaskscheduler]
GRANT INSERT ON dbo.dd_mrkit_temp_0963 TO [BBMI\admintaskscheduler]