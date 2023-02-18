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
--		tip_0443 = 'Executing Broker'
--	AND	fte_0443 = 'Markit'
--	AND ind_sit_0443 = 1




/* Declaração de Variáveis */

-- Fonte: mesmo para todos

DECLARE @font VARCHAR(10)											= 'Markit'


-- Tipo: mesmo para todos

DECLARE @tipo VARCHAR(20)											= 'Executing Broker'


/* Código Externo (Nome_Markit) + Código Interno (Nome_Bahia) */

-- JPMC

DECLARE @cod_ext_JPMC VARCHAR(10)									= 'JPMC'
DECLARE @descricao_intermediario_interno_JPMC VARCHAR(100)			= 'JP Off Balcao'
DECLARE @cod_instc_intermediario_interno_JPMC INT       


-- Esse representa um fundo do Bahia
-- BBMI

--DECLARE @cod_ext_BBMI VARCHAR(10)									= 'BBMI'
--DECLARE @descricao_intermediario_interno_BBMI VARCHAR(100)		= 'BBM EXCLUSIVE FUND'
--DECLARE @cod_instc_intermediario_interno_BBMI INT       


-- CITI

DECLARE @cod_ext_CITI VARCHAR(10)									= 'CITI'
DECLARE @descricao_intermediario_interno_CITI VARCHAR(100)			= 'Citi Off Balcao'
DECLARE @cod_instc_intermediario_interno_CITI INT       


-- MS

DECLARE @cod_ext_MS VARCHAR(10)										= 'MS'
DECLARE @descricao_intermediario_interno_MS VARCHAR(100)			= 'Morgan Off Balcao'
DECLARE @cod_instc_intermediario_interno_MS INT       


-- BNPP

DECLARE @cod_ext_BNPP VARCHAR(10)									= 'BNPP'
DECLARE @descricao_intermediario_interno_BNPP VARCHAR(100)			= 'BNP Off Balcao'
DECLARE @cod_instc_intermediario_interno_BNPP INT       


-- GOLD

DECLARE @cod_ext_GOLD VARCHAR(10)									= 'GOLD'

DECLARE @descricao_intermediario_interno_GOLD VARCHAR(100)			= 'Goldman Off Balcao'
DECLARE @cod_instc_intermediario_interno_GOLD INT       


-- BOFA

DECLARE @cod_ext_BOFA VARCHAR(10)									= 'BOFA'
DECLARE @descricao_intermediario_interno_BOFA VARCHAR(100)			= 'Baml Off Balcao'
DECLARE @cod_instc_intermediario_interno_BOFA INT       


-- BARC

DECLARE @cod_ext_BARC VARCHAR(10)									= 'BARC'
DECLARE @descricao_intermediario_interno_BARC VARCHAR(100)			= 'Barclays Off Balcao'
DECLARE @cod_instc_intermediario_interno_BARC INT       


-- JBDH

DECLARE @cod_ext_JBDH VARCHAR(10)									= 'JBDH'
DECLARE @descricao_intermediario_interno_JBDH VARCHAR(100)			= 'JB Drax Off Balcao'
DECLARE @cod_instc_intermediario_interno_JBDH INT       


-- CSFB

DECLARE @cod_ext_CSFB VARCHAR(10)									= 'CSFB'
DECLARE @descricao_intermediario_interno_CSFB VARCHAR(100)			= 'Credit Off Balcao'
DECLARE @cod_instc_intermediario_interno_CSFB INT       



/* Recuperando o cod_instc do intermediario a ser cadastrado na tabela de codigo externo para cada um deles */

-- JPMC

SELECT
	@cod_instc_intermediario_interno_JPMC = cod_instc_0030
FROM
	dbo.itmd_0030
WHERE
		desc_abvd_0030 = @descricao_intermediario_interno_JPMC
	AND tip_itmd_0030 = @tipo
	AND ind_sit_0030 = 1


-- Esse representa um fundo do Bahia
-- BBMI

--SELECT
--	@cod_instc_intermediario_interno_BBMI = cod_instc_0030
--FROM
--	dbo.itmd_0030
--WHERE
--		desc_abvd_0030 = @descricao_intermediario_interno_BBMI
--	AND tip_itmd_0030 = @tipo
--	AND ind_sit_0030 = 1


-- CITI

SELECT
	@cod_instc_intermediario_interno_CITI = cod_instc_0030
FROM
	dbo.itmd_0030
WHERE
		desc_abvd_0030 = @descricao_intermediario_interno_CITI
	AND tip_itmd_0030 = @tipo
	AND ind_sit_0030 = 1


-- MS

SELECT
	@cod_instc_intermediario_interno_MS	= cod_instc_0030
FROM
	dbo.itmd_0030
WHERE
		desc_abvd_0030 = @descricao_intermediario_interno_MS
	AND tip_itmd_0030 = @tipo
	AND ind_sit_0030 = 1


-- BNPP

SELECT
	@cod_instc_intermediario_interno_BNPP = cod_instc_0030
FROM
	dbo.itmd_0030
WHERE
		desc_abvd_0030 = @descricao_intermediario_interno_BNPP
	AND tip_itmd_0030 = @tipo
	AND ind_sit_0030 = 1


-- GOLD

SELECT
	@cod_instc_intermediario_interno_GOLD = cod_instc_0030
FROM
	dbo.itmd_0030
WHERE
		desc_abvd_0030 = @descricao_intermediario_interno_GOLD
	AND tip_itmd_0030 = @tipo
	AND ind_sit_0030 = 1


-- BOFA

SELECT
	@cod_instc_intermediario_interno_BOFA = cod_instc_0030
FROM
	dbo.itmd_0030
WHERE
		desc_abvd_0030 = @descricao_intermediario_interno_BOFA
	AND tip_itmd_0030 = @tipo
	AND ind_sit_0030 = 1


-- BARC

SELECT
	@cod_instc_intermediario_interno_BARC	= cod_instc_0030
FROM
	dbo.itmd_0030
WHERE
		desc_abvd_0030 = @descricao_intermediario_interno_BARC
	AND tip_itmd_0030 = @tipo
	AND ind_sit_0030 = 1


-- JBDH

SELECT
	@cod_instc_intermediario_interno_JBDH	= cod_instc_0030
FROM
	dbo.itmd_0030
WHERE
		desc_abvd_0030 = @descricao_intermediario_interno_JBDH
	AND tip_itmd_0030 = @tipo
	AND ind_sit_0030 = 1


-- CSFB

SELECT
	@cod_instc_intermediario_interno_CSFB	= cod_instc_0030
FROM
	dbo.itmd_0030
WHERE
		desc_abvd_0030 = @descricao_intermediario_interno_CSFB
	AND tip_itmd_0030 = @tipo
	AND ind_sit_0030 = 1



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
	-- JPMC
	(   
		@cod_ext_JPMC,        
        @tipo,        
        @font,        
        @cod_instc_intermediario_interno_JPMC,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- Esse representa um fundo do Bahia
	-- BBMI
	--,(   
	--	@cod_ext_BBMI,        
    --    @tipo,        
    --    @font,        
    --    @cod_instc_intermediario_interno_BBMI,   
	--
    --    1,         
    --    GETDATE(), 
    --    SUSER_NAME()         
	--)
	-- CITI
	,(   
		@cod_ext_CITI,        
        @tipo,        
        @font,        
        @cod_instc_intermediario_interno_CITI,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- MS
	,(   
		@cod_ext_MS,        
        @tipo,        
        @font,        
        @cod_instc_intermediario_interno_MS,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- BNPP
	,(   
		@cod_ext_BNPP,        
        @tipo,        
        @font,        
        @cod_instc_intermediario_interno_BNPP,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- GOLD
	,(   
		@cod_ext_GOLD,        
        @tipo,        
        @font,        
        @cod_instc_intermediario_interno_GOLD,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- BOFA
	,(   
		@cod_ext_BOFA,        
        @tipo,        
        @font,        
        @cod_instc_intermediario_interno_BOFA,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- BARC
	,(   
		@cod_ext_BARC,        
        @tipo,        
        @font,        
        @cod_instc_intermediario_interno_BARC,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- JBDH
	,(   
		@cod_ext_JBDH,        
        @tipo,        
        @font,        
        @cod_instc_intermediario_interno_JBDH,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)
	-- CSFB
	,(   
		@cod_ext_CSFB,        
        @tipo,        
        @font,        
        @cod_instc_intermediario_interno_CSFB,   

        1,         
        GETDATE(), 
        SUSER_NAME()         
	)


--SELECT
--	*
--FROM
--	dbo.cod_ext_0443
--WHERE
--		tip_0443 = 'Executing Broker'
--  AND	fte_0443 = 'Markit'
--	AND ind_sit_0443 = 1