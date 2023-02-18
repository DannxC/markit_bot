USE bd_108_bbmcorp

--USE bd_108_bbmcorp
--UPDATE 
--	dbo.cod_ext_0443
--SET
--	ind_sit_0443 = 3
--	,dat_sit_0443 = GETDATE()
--	,usr_sit_0443 = SUSER_NAME()
--FROM
--	dbo.cod_ext_0443
--WHERE
--		tip_0443 = 'Indexador'
--	AND	fte_0443 = 'Markit'
--	AND ind_sit_0443 = 1





/* Declaração de Variáveis */

-- Fonte: mesmo para todos

DECLARE @font VARCHAR(10)											= 'Markit'


-- Tipo: mesmo para todos

DECLARE @tipo VARCHAR(20)											= 'Indexador'


/* Descrição (Indice_Markit) + (freq mult + fre period) (Frequencia_Markit) + Código Interno (Indice_Bahia) */

-- JIBAR03M_1

DECLARE @cod_ext_JIBAR03M_1 VARCHAR(100)							= 'ZAR-JIBAR-SAFEX3M'
DECLARE @descricao_indice_interno_JIBAR03M_1 VARCHAR(100)			= 'JIBAR03M'
DECLARE @cod_instc_indice_interno_JIBAR03M_1 INT       


-- JIBAR03M_2

DECLARE @cod_ext_JIBAR03M_2 VARCHAR(100)							= 'ZAR-JIBAR3M'
DECLARE @descricao_indice_interno_JIBAR03M_2 VARCHAR(100)			= 'JIBAR03M'
DECLARE @cod_instc_indice_interno_JIBAR03M_2 INT    


-- JIBAR03M_3

DECLARE @cod_ext_JIBAR03M_3 VARCHAR(100)							= 'SAFE South Africa Johannesburg JIBAR 3 MONTHS'
DECLARE @descricao_indice_interno_JIBAR03M_3 VARCHAR(100)			= 'JIBAR03M'
DECLARE @cod_instc_indice_interno_JIBAR03M_3 INT    


-- TIIE28D_1

DECLARE @cod_ext_TIIE28D_1 VARCHAR(100)								= 'MXN-TIIE-Banxico28D'
DECLARE @descricao_indice_interno_TIIE28D_1 VARCHAR(100)			= 'TIIE28D'
DECLARE @cod_instc_indice_interno_TIIE28D_1 INT     


-- TIIE28D_2

DECLARE @cod_ext_TIIE28D_2 VARCHAR(100)								= 'MXN-TIIE28D'
DECLARE @descricao_indice_interno_TIIE28D_2 VARCHAR(100)			= 'TIIE28D'
DECLARE @cod_instc_indice_interno_TIIE28D_2 INT     


-- TIIE28D_3

DECLARE @cod_ext_TIIE28D_3 VARCHAR(100)								= 'Mexico Interbank TIIE 28 DAYS'
DECLARE @descricao_indice_interno_TIIE28D_3 VARCHAR(100)			= 'TIIE28D'
DECLARE @cod_instc_indice_interno_TIIE28D_3 INT     


-- US0003M_1

DECLARE @cod_ext_US0003M_1 VARCHAR(100)								= 'USD-LIBOR3M'
DECLARE @descricao_indice_interno_US0003M_1 VARCHAR(100)			= 'US0003M'
DECLARE @cod_instc_indice_interno_US0003M_1 INT		


-- US0003M_2

DECLARE @cod_ext_US0003M_2 VARCHAR(100)								= 'USD-LIBOR-BBA3M'
DECLARE @descricao_indice_interno_US0003M_2 VARCHAR(100)			= 'US0003M'
DECLARE @cod_instc_indice_interno_US0003M_2 INT		


-- US_CPI_1

DECLARE @cod_ext_US_CPI_1 VARCHAR(100)								= 'USA-CPI-U'
DECLARE @descricao_indice_interno_US_CPI_1 VARCHAR(100)				= 'US CPI'
DECLARE @cod_instc_indice_interno_US_CPI_1 INT   


-- US_CPI_2

DECLARE @cod_ext_US_CPI_2 VARCHAR(100)								= 'USA-CPI-U3M'
DECLARE @descricao_indice_interno_US_CPI_2 VARCHAR(100)				= 'US CPI'
DECLARE @cod_instc_indice_interno_US_CPI_2 INT 


-- WIBR3M_1

DECLARE @cod_ext_WIBR3M_1 VARCHAR(100)								= 'PLN-WIBOR3M'
DECLARE @descricao_indice_interno_WIBR3M_1 VARCHAR(100)				= 'WIBR3M'
DECLARE @cod_instc_indice_interno_WIBR3M_1 INT       


-- WIBR3M_2

DECLARE @cod_ext_WIBR3M_2 VARCHAR(100)								= 'PLN-WIBOR-WIBO3M'
DECLARE @descricao_indice_interno_WIBR3M_2 VARCHAR(100)				= 'WIBR3M'
DECLARE @cod_instc_indice_interno_WIBR3M_2 INT       


-- WIBR6M_1

DECLARE @cod_ext_WIBR6M_1 VARCHAR(100)								= 'PLN-WIBOR-WIBO6M'
DECLARE @descricao_indice_interno_WIBR6M_1 VARCHAR(100)				= 'WIBR6M'
DECLARE @cod_instc_indice_interno_WIBR6M_1 INT       


-- WIBR6M_2

DECLARE @cod_ext_WIBR6M_2 VARCHAR(100)								= 'PLN-WIBOR6M'
DECLARE @descricao_indice_interno_WIBR6M_2 VARCHAR(100)				= 'WIBR6M'
DECLARE @cod_instc_indice_interno_WIBR6M_2 INT       


-- WIBR6M_3

DECLARE @cod_ext_WIBR6M_3 VARCHAR(100)								= 'GPW Benchmark WIBOR PLN 6M'
DECLARE @descricao_indice_interno_WIBR6M_3 VARCHAR(100)				= 'WIBR6M'
DECLARE @cod_instc_indice_interno_WIBR6M_3 INT       


-- CDOR03_1

DECLARE @cod_ext_CDOR03_1 VARCHAR(100)								= 'CAD-BA-CDOR3M'
DECLARE @descricao_indice_interno_CDOR03_1 VARCHAR(100)				= 'CDOR03'
DECLARE @cod_instc_indice_interno_CDOR03_1 INT       


-- CDOR03_2

DECLARE @cod_ext_CDOR03_2 VARCHAR(100)								= 'CAD-CDOR3M'
DECLARE @descricao_indice_interno_CDOR03_2 VARCHAR(100)				= 'CDOR03'
DECLARE @cod_instc_indice_interno_CDOR03_2 INT       



-- SOFR_1

DECLARE @cod_ext_SOFR_1 VARCHAR(100)								= 'USD-SOFR-OIS Compound'
DECLARE @descricao_indice_interno_SOFR_1 VARCHAR(100)				= 'SOFR'
DECLARE @cod_instc_indice_interno_SOFR_1 INT       


-- SOFR_2

DECLARE @cod_ext_SOFR_2 VARCHAR(100)								= 'USD-SOFR-COMPOUND'
DECLARE @descricao_indice_interno_SOFR_2 VARCHAR(100)				= 'SOFR'
DECLARE @cod_instc_indice_interno_SOFR_2 INT       


-- CAONREPO_1

DECLARE @cod_ext_CAONREPO_1 VARCHAR(100)							= 'CAD-CORRA-OIS Compound'
DECLARE @descricao_indice_interno_CAONREPO_1 VARCHAR(100)			= 'CAONREPO'
DECLARE @cod_instc_indice_interno_CAONREPO_1 INT       


-- CAONREPO_2

DECLARE @cod_ext_CAONREPO_2 VARCHAR(100)							= 'CAD-CORRA-OIS-COMPOUND'
DECLARE @descricao_indice_interno_CAONREPO_2 VARCHAR(100)			= 'CAONREPO'
DECLARE @cod_instc_indice_interno_CAONREPO_2 INT    


-- PRIB06M_1

DECLARE @cod_ext_PRIB06M_1 VARCHAR(100)								= 'CZK-PRIBOR6M'
DECLARE @descricao_indice_interno_PRIB06M_1 VARCHAR(100)			= 'PRIB06M'
DECLARE @cod_instc_indice_interno_PRIB06M_1 INT       


-- PRIB06M_2

DECLARE @cod_ext_PRIB06M_2 VARCHAR(100)								= 'CZK-PRIBOR-PRBO6M'
DECLARE @descricao_indice_interno_PRIB06M_2 VARCHAR(100)			= 'PRIB06M'
DECLARE @cod_instc_indice_interno_PRIB06M_2 INT       


-- ESTRON_1

DECLARE @cod_ext_ESTRON_1 VARCHAR(100)								= 'EUR-EuroSTR-COMPOUND'
DECLARE @descricao_indice_interno_ESTRON_1 VARCHAR(100)				= 'ESTRON'
DECLARE @cod_instc_indice_interno_ESTRON_1 INT       


-- ESTRON_2

DECLARE @cod_ext_ESTRON_2 VARCHAR(100)								= 'EUR-EuroSTR-OIS Compound'
DECLARE @descricao_indice_interno_ESTRON_2 VARCHAR(100)				= 'ESTRON'
DECLARE @cod_instc_indice_interno_ESTRON_2 INT     


-- FED_1

DECLARE @cod_ext_FED_1 VARCHAR(100)									= 'USD-Federal Funds-OIS Compound'
DECLARE @descricao_indice_interno_FED_1 VARCHAR(100)				= 'FED'
DECLARE @cod_instc_indice_interno_FED_1 INT       


-- FED_2

DECLARE @cod_ext_FED_2 VARCHAR(100)									= 'USD-Federal Funds-H.15-OIS-COMPOUND'
DECLARE @descricao_indice_interno_FED_2 VARCHAR(100)				= 'FED'
DECLARE @cod_instc_indice_interno_FED_2 INT       





/* Recuperando o cod_instc do INDICE a ser cadastrado na tabela de codigo externo para cada um deles */

-- JIBAR03M_1

SELECT
	@cod_instc_indice_interno_JIBAR03M_1 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_JIBAR03M_1
	AND ind_sit_0174 = 1


-- JIBAR03M_2

SELECT
	@cod_instc_indice_interno_JIBAR03M_2 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_JIBAR03M_2
	AND ind_sit_0174 = 1


-- JIBAR03M_3

SELECT
	@cod_instc_indice_interno_JIBAR03M_3 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_JIBAR03M_3
	AND ind_sit_0174 = 1


-- TIIE28D_1

SELECT
	@cod_instc_indice_interno_TIIE28D_1 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_TIIE28D_1
	AND ind_sit_0174 = 1


-- TIIE28D_2

SELECT
	@cod_instc_indice_interno_TIIE28D_2 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_TIIE28D_2
	AND ind_sit_0174 = 1


-- TIIE28D_3

SELECT
	@cod_instc_indice_interno_TIIE28D_3 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_TIIE28D_3
	AND ind_sit_0174 = 1


-- US000

--SELECT
--	@cod_instc_indice_interno_US000 = cod_instc_0174
--FROM
--	dbo.indx_0174
--WHERE
--		desc_abvd_0174 = @descricao_indice_interno_US000
--	AND ind_sit_0174 = 1


-- US0003M_1

SELECT
	@cod_instc_indice_interno_US0003M_1 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_US0003M_1
	AND ind_sit_0174 = 1


-- US0003M_2

SELECT
	@cod_instc_indice_interno_US0003M_2 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_US0003M_2
	AND ind_sit_0174 = 1


-- US_CPI_1

SELECT
	@cod_instc_indice_interno_US_CPI_1 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_US_CPI_1
	AND ind_sit_0174 = 1


-- US_CPI_2

SELECT
	@cod_instc_indice_interno_US_CPI_2 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_US_CPI_2
	AND ind_sit_0174 = 1


-- WIBR3M_1

SELECT
	@cod_instc_indice_interno_WIBR3M_1 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_WIBR3M_1
	AND ind_sit_0174 = 1


-- WIBR3M_2

SELECT
	@cod_instc_indice_interno_WIBR3M_2 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_WIBR3M_2
	AND ind_sit_0174 = 1


-- WIBR6M_1

SELECT
	@cod_instc_indice_interno_WIBR6M_1 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_WIBR6M_1
	AND ind_sit_0174 = 1


-- WIBR6M_2

SELECT
	@cod_instc_indice_interno_WIBR6M_2 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_WIBR6M_2
	AND ind_sit_0174 = 1


-- WIBR6M_3

SELECT
	@cod_instc_indice_interno_WIBR6M_3 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_WIBR6M_3
	AND ind_sit_0174 = 1


-- CDOR03_1

SELECT
	@cod_instc_indice_interno_CDOR03_1 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_CDOR03_1
	AND ind_sit_0174 = 1


-- CDOR03_2

SELECT
	@cod_instc_indice_interno_CDOR03_2 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_CDOR03_2
	AND ind_sit_0174 = 1



-- SOFR_1

SELECT
	@cod_instc_indice_interno_SOFR_1 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_SOFR_1
	AND ind_sit_0174 = 1


-- SOFR_2

SELECT
	@cod_instc_indice_interno_SOFR_2 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_SOFR_2
	AND ind_sit_0174 = 1


-- CAONREPO_1

SELECT
	@cod_instc_indice_interno_CAONREPO_1 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_CAONREPO_1
	AND ind_sit_0174 = 1


-- CAONREPO_2

SELECT
	@cod_instc_indice_interno_CAONREPO_2 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_CAONREPO_2
	AND ind_sit_0174 = 1


-- PRIB06M_1

SELECT
	@cod_instc_indice_interno_PRIB06M_1 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_PRIB06M_1
	AND ind_sit_0174 = 1


-- PRIB06M_2

SELECT
	@cod_instc_indice_interno_PRIB06M_2 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_PRIB06M_2
	AND ind_sit_0174 = 1


-- ESTRON_1

SELECT
	@cod_instc_indice_interno_ESTRON_1 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_ESTRON_1
	AND ind_sit_0174 = 1


-- ESTRON_2

SELECT
	@cod_instc_indice_interno_ESTRON_2 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_ESTRON_2
	AND ind_sit_0174 = 1


-- FED_1

SELECT
	@cod_instc_indice_interno_FED_1 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_FED_1
	AND ind_sit_0174 = 1


-- FED_2

SELECT
	@cod_instc_indice_interno_FED_2 = cod_instc_0174
FROM
	dbo.indx_0174
WHERE
		desc_abvd_0174 = @descricao_indice_interno_FED_2
	AND ind_sit_0174 = 1





/* Inserção de novos cadastramentos na tabela de Código Externo */

INSERT INTO
    dbo.cod_ext_0443
    (
        cod_ext_0443,
        tip_0443,
        fte_0443,
        cod_instc_int_0443,

        ind_sit_0443,
        dat_cdm_0443,
        usr_cdm_0443
    )
VALUES 
	-- JIBAR03M_1
	(   
		@cod_ext_JIBAR03M_1,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_JIBAR03M_1,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- JIBAR03M_2
	,(   
		@cod_ext_JIBAR03M_2,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_JIBAR03M_2,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- JIBAR03M_3
	,(   
		@cod_ext_JIBAR03M_3,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_JIBAR03M_3,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- TIIE28D_1
	,(   
		@cod_ext_TIIE28D_1,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_TIIE28D_1,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- TIIE28D_2
	,(   
		@cod_ext_TIIE28D_2,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_TIIE28D_2,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- TIIE28D_3
	,(   
		@cod_ext_TIIE28D_3,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_TIIE28D_3,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- US0003M_1
	,(   
		@cod_ext_US0003M_1,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_US0003M_1,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- US0003M_2
	,(   
		@cod_ext_US0003M_2,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_US0003M_2,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- US_CPI_1
	,(   
		@cod_ext_US_CPI_1,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_US_CPI_1,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- US_CPI_2
	,(   
		@cod_ext_US_CPI_2,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_US_CPI_2,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- WIBR3M_1
	,(   
		@cod_ext_WIBR3M_1,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_WIBR3M_1,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- WIBR3M_2
	,(   
		@cod_ext_WIBR3M_2,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_WIBR3M_2,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- WIBR6M_1
	,(   
		@cod_ext_WIBR6M_1,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_WIBR6M_1,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- WIBR6M_2
	,(   
		@cod_ext_WIBR6M_2,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_WIBR6M_2,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- WIBR6M_3
	,(   
		@cod_ext_WIBR6M_3,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_WIBR6M_3,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- CDOR03_1
	,(   
		@cod_ext_CDOR03_1,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_CDOR03_1,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- CDOR03_2
	,(   
		@cod_ext_CDOR03_2,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_CDOR03_2,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)

	-- SOFR_1
	,(   
		@cod_ext_SOFR_1,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_SOFR_1,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- SOFR_2
	,(   
		@cod_ext_SOFR_2,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_SOFR_2,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- CAONREPO_1
	,(   
		@cod_ext_CAONREPO_1,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_CAONREPO_1,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- CAONREPO_2
	,(   
		@cod_ext_CAONREPO_2,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_CAONREPO_2,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- PRIB06M_1
	,(   
		@cod_ext_PRIB06M_1,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_PRIB06M_1,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- PRIB06M_2
	,(   
		@cod_ext_PRIB06M_2,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_PRIB06M_2,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- ESTRON_1
	,(   
		@cod_ext_ESTRON_1,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_ESTRON_1,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- ESTRON_2
	,(   
		@cod_ext_ESTRON_2,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_ESTRON_2,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- FED_1
	,(   
		@cod_ext_FED_1,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_FED_1,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- FED_2
	,(   
		@cod_ext_FED_2,        
        @tipo,        
        @font,        
        @cod_instc_indice_interno_FED_2,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)




--SELECT
--	*
--FROM
--	dbo.cod_ext_0443
--WHERE
--		tip_0443 = 'Indexador'
--  AND	fte_0443 = 'Markit'
--	AND ind_sit_0443 = 1