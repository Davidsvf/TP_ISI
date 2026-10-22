/*
 TP01 - Integracao de Sistemas de Informacao
 Base de dados: AcidentesLondresDB (SQL Server)

 ATENCAO:
 Este ficheiro e um modelo inicial. Os nomes e tipos das colunas
 DEVEM coincidir com os campos efetivamente enviados pelos operadores
 Table Output das transformacoes 09 e 10 do Pentaho.

 Para uma copia EXATA da base ja criada no SSMS, usar:
 Database > Tasks > Generate Scripts > Select specific database objects
 (Acidentes e Veiculos) > Advanced > Types of data to script = Schema only.
*/

IF DB_ID(N'AcidentesLondresDB') IS NULL
    CREATE DATABASE AcidentesLondresDB;
GO

USE AcidentesLondresDB;
GO

-- Tabela de acidentes: os restantes campos devem ser ajustados ao CSV integrado.
IF OBJECT_ID(N'dbo.Acidentes', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Acidentes (
        collision_index         VARCHAR(50)  NOT NULL,
        [date]                  DATE         NULL,
        [time]                  VARCHAR(8)   NULL,
        data_hora_acidente      DATETIME2(0) NULL,
        local_authority_ons_district VARCHAR(20) NULL,
        latitude                FLOAT        NULL,
        longitude               FLOAT        NULL,
        accident_severity       INT          NULL,
        number_of_casualties    INT          NULL,
        speed_limit             INT          NULL,
        periodo_dia             NVARCHAR(40) NULL,
        numero_veiculos         INT          NULL,
        temperature_2m          FLOAT        NULL,
        precipitation           FLOAT        NULL,
        wind_speed_10m          FLOAT        NULL,
        weather_code            INT          NULL,
        CONSTRAINT PK_Acidentes PRIMARY KEY (collision_index)
    );
END;
GO

-- Tabela de veiculos: os restantes campos devem ser ajustados ao CSV processado.
IF OBJECT_ID(N'dbo.Veiculos', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Veiculos (
        collision_index          VARCHAR(50) NOT NULL,
        vehicle_reference        INT         NOT NULL,
        vehicle_type             INT         NULL,
        sex_of_driver            INT         NULL,
        age_of_driver            INT         NULL,
        faixa_etaria             NVARCHAR(40) NULL,
        categoria_veiculo        NVARCHAR(80) NULL,
        CONSTRAINT PK_Veiculos PRIMARY KEY (collision_index, vehicle_reference),
        CONSTRAINT FK_Veiculos_Acidentes FOREIGN KEY (collision_index)
            REFERENCES dbo.Acidentes(collision_index)
    );
END;
GO

-- Verificar se as tabelas existem e consultar o numero de registos.
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'dbo' AND TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

SELECT 'Acidentes' AS Tabela, COUNT(*) AS TotalRegistos FROM dbo.Acidentes
UNION ALL
SELECT 'Veiculos', COUNT(*) FROM dbo.Veiculos;
GO
