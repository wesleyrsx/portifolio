/* CRIADO POR: WESLEY RODRIGUES */
/* AGENDA: D0800 */
/* POP: https://banco365.sharepoint.com.mcas.ms/sites/DinfoPJDiemp/SitePages/Carteira-de-Cr%C3%A9dito---Pr%C3%A9vias---Base-Hist%C3%B3rica.aspx */

/* PREVIAS DA CARTEIRA DE CREDITO*/

LIBNAME ARC_AUX '/sasdados/diemp/acompnegcred/acompinfoger/interno/pj/bases/ARC/auxiliar';
LIBNAME BLOCO '/sasdados/diemp/acompnegcred/acompinfoger/interno/pj/bases/PRD/bloco';
LIBNAME ACP '/sasdados/diemp/acompnegcred/acompinfoger/interno/pf/bases/ACP/';
libname externo '/dados/externo';
libname dria "/sasdados/diemp/acompnegcred/acompinfoger/interno/pf/bases/ARC/pnl_prd/msl/dria";
LIBNAME DICRE '/sasdados/diemp/acompnegcred/acompinfoger/interno/pj/bases/ARC/dicre';
libname diemp '/dados/diemp';
LIBNAME MST '/sasdados/diemp/acompnegcred/acompinfoger/interno/pj/bases/MST';
LIBNAME DINFO '/sasdados/diemp/acompnegcred/acompinfoger/interno/pj/bases';
libname db2prd db2 schema=DB2PRD database=BDB2P04 AUTHDOMAIN=DB2I0BED;
LIBNAME SDO '/sasdados/diemp/acompnegcred/acompinfoger/interno/pf/bases/SDO';
LIBNAME HPG POSTGRES SERVER= '172.16.13.157' SCHEMA='arc' DATABASE='diemp' PORT='5432' USER='intranet' PASSWORD='321#@!' readbuff=10000 conopts="UseServerSidePrepare=1;UseDeclareFetch=1;Fetch=10000";
LIBNAME PG POSTGRES SERVER= '172.16.13.160' SCHEMA='arc' DATABASE='diemp' PORT='5432' USER='intranet' PASSWORD='diemp321#@!' readbuff=10000 conopts="UseServerSidePrepare=1;UseDeclareFetch=1;Fetch=10000";


DATA _NULL_;
CALL SYMPUTX ('DT_INI_SMN_ANT1', PUT(INTNX('WEEK', TODAY(), -1, 'B'), YYMMDDN8.));
CALL SYMPUTX ('DT_FIM_SMN_ANT1', PUT(INTNX('WEEK', TODAY(), -1, 'E'), YYMMDDN8.));
CALL SYMPUTX ('DT_INI_SMN_ANT2', PUT(INTNX('WEEK', TODAY(), -2, 'B'), YYMMDDN8.));
CALL SYMPUTX ('DT_FIM_SMN_ANT2', PUT(INTNX('WEEK', TODAY(), -2, 'E'), YYMMDDN8.));
CALL SYMPUTX ('DT_INI_SMN_ANT3', PUT(INTNX('WEEK', TODAY(), -3, 'B'), YYMMDDN8.));
CALL SYMPUTX ('DT_FIM_SMN_ANT3', PUT(INTNX('WEEK', TODAY(), -3, 'E'), YYMMDDN8.));
CALL SYMPUTX ('DT_INI_SMN_ANT4', PUT(INTNX('WEEK', TODAY(), -4, 'B'), YYMMDDN8.));
CALL SYMPUTX ('DT_FIM_SMN_ANT4', PUT(INTNX('WEEK', TODAY(), -4, 'E'), YYMMDDN8.));
;RUN;

%PUT ==== &DT_INI_SMN_ANT1;
%PUT ==== &DT_FIM_SMN_ANT1;
%PUT ==== &DT_INI_SMN_ANT2;
%PUT ==== &DT_FIM_SMN_ANT2;
%PUT ==== &DT_INI_SMN_ANT3;
%PUT ==== &DT_FIM_SMN_ANT3;
%PUT ==== &DT_INI_SMN_ANT4;
%PUT ==== &DT_FIM_SMN_ANT4;


PROC SQL;
CREATE TABLE WORK.PREVIAS_SELECIONADAS AS
SELECT * FROM (
	SELECT
		COALESCE(INPUT(SUBSTR(MAX(MEMNAME), 14, 8), 8.),0) AS MEMNAME0 
		,
		COALESCE((	SELECT
		INPUT(SUBSTR(MAX(MEMNAME), 14, 8), 8.) 
	FROM
		DICTIONARY.TABLES
	WHERE
		LIBNAME = 'DICRE' AND
		MEMNAME ? 'OPR_INT_DRIA_' AND
		INPUT(SCAN(MEMNAME, -1, '_'), 8.) BETWEEN &DT_INI_SMN_ANT1 AND &DT_FIM_SMN_ANT1
		),0) AS MEMNAME1,
		CALCULATED MEMNAME1 - CALCULATED MEMNAME0 AS VALOR
	FROM
		DICTIONARY.TABLES
	WHERE
		LIBNAME = 'DRIA' AND
		MEMNAME ? 'PNL_PRD_DRIA_' AND
		INPUT(SCAN(MEMNAME, -1, '_'), 8.) 
	BETWEEN &DT_INI_SMN_ANT1 AND &DT_FIM_SMN_ANT1
	UNION
		SELECT
		COALESCE(INPUT(SUBSTR(MAX(MEMNAME), 14, 8), 8.),0) AS MEMNAME0 
		,
		COALESCE((	SELECT
		INPUT(SUBSTR(MAX(MEMNAME), 14, 8), 8.) 
	FROM
		DICTIONARY.TABLES
	WHERE
		LIBNAME = 'DICRE' AND
		MEMNAME ? 'OPR_INT_DRIA_' AND
		INPUT(SCAN(MEMNAME, -1, '_'), 8.) BETWEEN &DT_INI_SMN_ANT2 AND &DT_FIM_SMN_ANT2
		),0) AS MEMNAME1,
		CALCULATED MEMNAME1 - CALCULATED MEMNAME0 AS VALOR
	FROM
		DICTIONARY.TABLES
	WHERE
		LIBNAME = 'DRIA' AND
		MEMNAME ? 'PNL_PRD_DRIA_' AND
		INPUT(SCAN(MEMNAME, -1, '_'), 8.) BETWEEN &DT_INI_SMN_ANT2 AND &DT_FIM_SMN_ANT2
		UNION
		SELECT
		COALESCE(INPUT(SUBSTR(MAX(MEMNAME), 14, 8), 8.),0) AS MEMNAME0 
		,
		COALESCE((	SELECT
		INPUT(SUBSTR(MAX(MEMNAME), 14, 8), 8.) 
	FROM
		DICTIONARY.TABLES
	WHERE
		LIBNAME = 'DICRE' AND
		MEMNAME ? 'OPR_INT_DRIA_' AND
		INPUT(SCAN(MEMNAME, -1, '_'), 8.) BETWEEN &DT_INI_SMN_ANT3 AND &DT_FIM_SMN_ANT3
		),0) AS MEMNAME1,
		CALCULATED MEMNAME1 - CALCULATED MEMNAME0 AS VALOR
	FROM
		DICTIONARY.TABLES
	WHERE
		LIBNAME = 'DRIA' AND
		MEMNAME ? 'PNL_PRD_DRIA_' AND
		INPUT(SCAN(MEMNAME, -1, '_'), 8.) BETWEEN &DT_INI_SMN_ANT3 AND &DT_FIM_SMN_ANT3
			UNION


		SELECT
		COALESCE(INPUT(SUBSTR(MAX(MEMNAME), 14, 8), 8.),0) AS MEMNAME0 
		,
		COALESCE((	SELECT
		INPUT(SUBSTR(MAX(MEMNAME), 14, 8), 8.) 
	FROM
		DICTIONARY.TABLES
	WHERE
		LIBNAME = 'DICRE' AND
		MEMNAME ? 'OPR_INT_DRIA_' AND
		INPUT(SCAN(MEMNAME, -1, '_'), 8.) BETWEEN &DT_INI_SMN_ANT4 AND &DT_FIM_SMN_ANT4
		),0) AS MEMNAME1,
		CALCULATED MEMNAME1 - CALCULATED MEMNAME0 AS VALOR
	FROM
		DICTIONARY.TABLES
	WHERE
		LIBNAME = 'DRIA' AND
		MEMNAME ? 'PNL_PRD_DRIA_' AND
		INPUT(SCAN(MEMNAME, -1, '_'), 8.) BETWEEN &DT_INI_SMN_ANT4 AND &DT_FIM_SMN_ANT4
	UNION
	SELECT
		COALESCE(INPUT(SUBSTR(MAX(MEMNAME), 14, 8), 8.),0) AS MEMNAME0
	, 
	COALESCE((SELECT
	    INPUT(SUBSTR(MAX(MEMNAME), 14, 8), 8.) AS MEMNAME /* ULTIMA PREVIA DO MES ANTERIOR */

	FROM
	    DICTIONARY.TABLES
	WHERE
	    LIBNAME = UPCASE('DICRE') AND
	    MEMNAME ? UPCASE('OPR_INT_DRIA_') AND
	    SUBSTR(SCAN(MEMNAME, -1, '_'), 1, 6) < PUT(TODAY(), YYMMN6.)),0) AS MEMNAME1,
		CALCULATED MEMNAME1 - CALCULATED MEMNAME0 AS VALOR
	FROM
	    DICTIONARY.TABLES
	WHERE
	    LIBNAME = UPCASE('DRIA') AND
	    MEMNAME ? UPCASE('PNL_PRD_DRIA_') AND
	    SUBSTR(SCAN(MEMNAME, -1, '_'), 1, 6) < PUT(TODAY(), YYMMN6.)

	UNION
		SELECT
		COALESCE(INPUT(SUBSTR(MAX(MEMNAME), 14, 8), 8.),0) AS MEMNAME0 
		,
		COALESCE((	SELECT
		INPUT(SUBSTR(MAX(MEMNAME), 14, 8), 8.) 
	FROM
		DICTIONARY.TABLES
	WHERE
		LIBNAME = 'DICRE' AND
		MEMNAME ? 'OPR_INT_DRIA_' AND
		INPUT(SCAN(MEMNAME, -1, '_'), 8.) 
		),0) AS MEMNAME1,
		CALCULATED MEMNAME1 - CALCULATED MEMNAME0 AS VALOR
	FROM
		DICTIONARY.TABLES
	WHERE
		LIBNAME = 'DRIA' AND
		MEMNAME ? 'PNL_PRD_DRIA_' AND
		INPUT(SCAN(MEMNAME, -1, '_'), 8.) 
		) A
	;
	quit;
/*
MEMNAME0 DIRETORIO DRIA
MENNAME1 DIRETORIO DICRE
*/
filename sessoes pipe "ls -l -1 -t /sasdados/diemp/acompnegcred/acompinfoger/interno/pf/bases/ARC/pnl_prd/msl/dria";

data dir_del;
infile sessoes dlm=" " firstobs=2 truncover;
input
Permissions $
Directories
Owner $
Group $
Size
Month $
Day
Hour $
Directory_file $ 50.;
if Directories = 1;
Directory="/sasdados/diemp/acompnegcred/acompinfoger/interno/pf/bases/ARC/pnl_prd/msl/dria/";
run;



PROC SQL;
create table work.del_dria AS
select A.MEMNAME0
FROM
(SELECT
input(substr(Directory_file,14,8), 8.)  as MEMNAME0
FROM WORK.dir_del t1
where Directory_file like "pnl_prd_dria_%.%"
) A	
LEFT JOIN 
	WORK.PREVIAS_SELECIONADAS
 B ON ( B.MEMNAME0 = A.MEMNAME0)
 WHERE B.MEMNAME0 IS MISSING
;
QUIT;

PROC SQL; 
CREATE TABLE WORK.PRV_DEL AS
SELECT DISTINCT MEMNAME0
FROM (
SELECT 
	MEMNAME1 AS MEMNAME0
FROM
	WORK.PREVIAS_SELECIONADAS
WHERE VALOR <> 0
)
UNION
(
SELECT 
	MEMNAME0 
FROM
	WORK.PREVIAS_SELECIONADAS
WHERE VALOR <> 0
)
UNION CORR
SELECT DISTINCT MEMNAME0
FROM
	WORK.DEL_DRIA
;QUIT;

PROC SQL; 
SELECT DISTINCT MEMNAME0 INTO:PREVIAS_DELETAR SEPARATED BY ' '
FROM
	WORK.PRV_DEL 

;QUIT;



%macro date_loop_list(consulta, datas);
	%local i data;

	%let i = 1;
	%let data = %scan(&datas, &i, ' ');

	%do %while (%length(&data) > 0);
		%&consulta(&data);

		%let i = %eval(&i + 1);
		%let data = %scan(&datas, &i, ' ');
	%end;
%mend;

%MACRO PREVIADELTE();
PROC SQL; 
	SELECT DISTINCT
	COUNT(MEMNAME0) AS QT INTO: QT_DEL
FROM
	WORK.PRV_DEL
;QUIT;

%IF &QT_DEL > 0 %THEN %DO;
%MACRO LOOP_DELETAR(DATA);
proc sql;
 drop table DRIA.PNL_PRD_DRIA_&DATA
;
QUIT;
%MEND;
%DATE_LOOP_LIST(LOOP_DELETAR, &PREVIAS_DELETAR);
;
%END;
%ELSE %DO;
%PUT 
###############
NENHUMA TABELA A DELETAR
###############
;
%END;
%MEND;
%PREVIADELTE();


/*Tabelas para criar*/
PROC SQL;
SELECT
	(MEMNAME1)
INTO
	:PREVIAS_SELECIONADAS SEPARATED BY ' '
FROM
	WORK.PREVIAS_SELECIONADAS
WHERE VALOR > 0 and  MEMNAME1 <> 20230831
ORDER BY
	MEMNAME1 DESC
;QUIT;

%macro date_loop_list(consulta, datas);
	%local i data;

	%let i = 1;
	%let data = %scan(&datas, &i, ' ');

	%do %while (%length(&data) > 0);
		%&consulta(&data);

		%let i = %eval(&i + 1);
		%let data = %scan(&datas, &i, ' ');
	%end;
%mend;

%MACRO PREVIACRIA();
PROC SQL; 
SELECT DISTINCT
	COUNT(MEMNAME1) AS QT INTO: QT_CRIA
FROM
	WORK.PREVIAS_SELECIONADAS
WHERE VALOR > 0 and  MEMNAME1 <> 20230831
;QUIT;
%IF &QT_CRIA > 0 %THEN %DO;
PROC SQL;
CONNECT TO DB2 (AUTHDOMAIN=DB2SDEMP DATABASE=BDB2P04);

CREATE TABLE WORK.DEPENDENCIAS AS

SELECT *

FROM CONNECTION TO DB2
     (
(
SELECT
A.PREF_DEPE PREFIXO,
A.CD_UOR UOR,
A.NM_DEPE NOME_DEPENDENCIA,
A.PREF_SUPER PREFIXO_SUPER,
A.NM_SUPER NOME_SUPER,
A.PREF_GEREV PREFIXO_GEREV,
A.NM_GEREV NOME_GEREV,
A.PREF_DIRETORIA PREFIXO_DIRETORIA,
A.NM_DIRETORIA NOME_DIRETORIA,
A.PREF_VICE_PRESIDENCIA PREFIXO_VICE_PRESIDENCIA,
A.NM_VICE_PRESIDENCIA NOME_VICE_PRESIDENCIA,
B.NM_EST_UOR SITUACAO,
A.NM_ITEM_AQTT_IOR TIPO,
M.NM_DVS_ESTG_UOR_BB PILAR,
D.TX_RDZ_TIP_AGPT AGRUPAMENTO_FIXO,
F.TX_RDZ_TIP_AGPT AGRUPAMENTO_TRANSITORIO,
G.NM_LGR_UOR_BR LOGRADOURO,
G.TX_CMPT_LGR_BR COMPLEMENTO,
G.NM_BAI_UOR_BR BAIRRO,
G.CD_MUN_UOR CODIGO_MUNICIPIO_BB,
H.CD_MUN_SRF CODIGO_MUNICIPIO_SRF,
H.CD_MUN_IBGE CODIGO_MUNICIPIO_IBGE,
H.CD_MUN_BC CODIGO_MUNICIPIO_BC,
H.CD_MUN_CEF CODIGO_MUNICIPIO_CEF,
G.NM_MUN_UOR NOME_MUNICIPIO,
G.NR_CEP_UOR_BR CEP,
G.SG_UF_UOR UF,
J.TX_EMAI_UOR EMAIL,
K.HR_INC_FCN_EXNO,
K.HR_FIM_FCN_EXNO,
I.NR_LTD LATITUDE,
I.NR_LGTE LONGITUDE,
CURRENT TIMESTAMP TS_ATUALIZACAO
FROM (
    SELECT
    A.CD_DEPE_UOR PREF_DEPE,
    A.CD_UOR,
    A.NM_UOR_RDZ NM_DEPE,
    MAX(CASE WHEN B.CD_TIP_VCL = 1010 THEN C.CD_DEPE_UOR END) PREF_SUPER,
    MAX(CASE WHEN B.CD_TIP_VCL = 1010 THEN C.NM_UOR_RDZ END) NM_SUPER,
    MAX(CASE WHEN B.CD_TIP_VCL = 1020 THEN C.CD_DEPE_UOR END) PREF_GEREV,
    MAX(CASE WHEN B.CD_TIP_VCL = 1020 THEN C.NM_UOR_RDZ END) NM_GEREV,
    MAX(CASE WHEN B.CD_TIP_VCL = 1200 THEN C.CD_DEPE_UOR END) PREF_DIRETORIA,
    MAX(CASE WHEN B.CD_TIP_VCL = 1200 THEN C.NM_UOR_RDZ END) NM_DIRETORIA,
    MAX(CASE WHEN B.CD_TIP_VCL = 1220 THEN C.CD_DEPE_UOR END) PREF_VICE_PRESIDENCIA,
    MAX(CASE WHEN B.CD_TIP_VCL = 1220 THEN C.NM_UOR_RDZ END) NM_VICE_PRESIDENCIA,
    A.CD_ITEM_AQTT_UOR,
    D.NM_ITEM_AQTT_IOR,
    A.CD_EST_UOR
    FROM DB2UOR.UOR A
    INNER JOIN DB2UOR.VCL_UOR B
      ON B.CD_UOR_VCLD = A.CD_UOR
      AND B.CD_TIP_VCL IN (1010, 1020, 1200, 1220) /* super, regional, diretoria e vice presidencia*/
    INNER JOIN DB2UOR.UOR C
      ON C.CD_UOR = B.CD_UOR_VCLR
    INNER JOIN DB2IOR.ITEM_AQTT_IOR D
      ON D.CD_ITEM_AQTT = A.CD_ITEM_AQTT_UOR
    WHERE A.NR_ORD_DEPE_SBDD = 0

    AND A.CD_DEPE_UOR <> 0
    AND A.CD_EST_UOR = 2
   
    GROUP BY A.CD_DEPE_UOR,A.CD_UOR,  A.NM_UOR_RDZ, A.CD_ITEM_AQTT_UOR, D.NM_ITEM_AQTT_IOR, A.CD_EST_UOR
) AS A

/*estado*/
LEFT JOIN DB2UOR.EST_UOR B
  ON B.CD_EST_UOR = A.CD_EST_UOR

/*agrupamento fixo*/
LEFT JOIN DB2MST.AGPT_UOR_BB C
  ON C.CD_UOR_BB = A.CD_UOR
  AND C.CD_NTZ_AGPT_UOR_BB = 17
LEFT JOIN DB2MST.TIP_AGPT_UOR_BB D
  ON D.CD_TIP_AGPT_UOR_BB = C.CD_TIP_AGPT_UOR_BB

/*agrupamento transitorio*/
LEFT JOIN DB2MST.AGPT_UOR_BB E
  ON E.CD_UOR_BB = A.CD_UOR
  AND E.CD_NTZ_AGPT_UOR_BB = 18
LEFT JOIN DB2MST.TIP_AGPT_UOR_BB F
  ON F.CD_TIP_AGPT_UOR_BB = E.CD_TIP_AGPT_UOR_BB

/*endereco*/
LEFT JOIN DB2UOR.END_UOR_BR G
  ON G.CD_UOR = A.CD_UOR

/*municipios*/
LEFT JOIN DB2ARG.MUN H
  ON H.CD_MUN = G.CD_MUN_UOR

/*localizacao*/
LEFT JOIN DB2UOR.LCZC_GEO_UOR I
  ON I.CD_UOR = A.CD_UOR

/*email*/
LEFT JOIN
(
    SELECT CD_UOR , TX_EMAI_UOR FROM DB2UOR.EMAI_UOR  WHERE IN_EMAI_PPL_UOR = 'S'
) J
ON J.CD_UOR = A.CD_UOR

/*horario funcionamento externo em dia util*/
LEFT JOIN
(
    SELECT CD_UOR, HR_INC_FCN_EXNO , HR_FIM_FCN_EXNO
    FROM DB2UOR.HR_FCN_UOR
    WHERE CD_TIP_HR_FCN = 1
) K
ON K.CD_UOR = A.CD_UOR

/*pilar*/

LEFT JOIN DB2MST.UOR_BB L
  ON L.CD_UOR_BB = A.CD_UOR
LEFT JOIN DB2MST.DVS_ESTG_UOR_BB M
  ON M.CD_DVS_ESTG_UOR_BB = L.CD_DVS_ESTG_UOR_BB
)
)
    ;
    DISCONNECT FROM DB2;
QUIT;


%MACRO LOOP_OPR_INT_DRIA(DATA);
PROC SQL;
CREATE TABLE DRIA.PNL_PRD_DRIA_&DATA AS 
SELECT 
	(T1.DT_CCL_CTB) AS DT,
	YEAR(T1.DT_CCL_CTB)AS ANO,
	MONTH(T1.DT_CCL_CTB)AS MES,
	YEAR(T1.DT_CCL_CTB)*100 + MONTH(T1.DT_CCL_CTB) AS ANOMES, 
	COALESCE(T2.ID_BL, 0) AS ID_BL,
	COALESCE(T2.NM_BL, 'VERIFICAR') AS NM_BL,
	INPUT(CAT(T1.CD_PRD, T1.CD_MDLD), 8. ) AS ID_FML,
	T1.CD_PRD AS ID_PRD,
	T1.CD_PRD, 
	T1.CD_MDLD, 
	INPUT(CAT(T1.CD_PRD, T1.CD_MDLD), 8.) AS ID_MDLD, 
	'' AS PILAR, /*Tipo Carteira*/
	COALESCE(T4.NM_GST_CLI, 'DEMAIS') AS NM_DRTA,
	t1.NM_SGM_CLI as SGM,
	(CASE 
		WHEN T1.CD_PRF_DEPE_GST_PRD = 8596 THEN 'DIRAG'
		WHEN T1.CD_PRF_DEPE_GST_PRD = 9951 THEN 'DISEM'
		WHEN T1.CD_PRF_DEPE_GST_PRD = 9958 THEN 'UCE'
		WHEN T1.CD_PRF_DEPE_GST_PRD = 8593 THEN 'DIGOV'
		WHEN T1.CD_PRF_DEPE_GST_PRD = 8595 THEN 'UCR'
		WHEN T1.CD_PRF_DEPE_GST_PRD = 8558 THEN 'DISEC'
		WHEN T1.CD_PRF_DEPE_GST_PRD = 9880 THEN 'DIMEP'
		WHEN T1.CD_PRF_DEPE_GST_PRD = 9973 THEN 'DIEMP'
		ELSE 'DEMAIS' 
	END) AS GST_PRD,
	'I' AS TIP_CTRA,
	T10.RISCO_9 AS RSCO_OPR, 
	T1.CD_RSCO_CRD_CLI AS RSCO_CLI, 
/*	COALESCE(T14.ENCARTEIRAMENTO, t1.NM_TIP_CTRA) AS SGM_FATM,*/
	'' AS SGM_FATM,
	'' AS IN_ECN_VERDE,


	0 AS IN_DFNC,


	COUNT(DISTINCT T1.NR_UNCO_CTR_OPR) FORMAT=COMMAX19. AS QTDE_OPR,
	COUNT(DISTINCT T1.CD_CLI) FORMAT=COMMAX19. AS QTDE_CLI, 
	SUM(T1.VL_BASE_CLC_PVS) FORMAT=COMMAX19.2 AS VL_SDO, 
	SUM(T1.VL_CLCD_PVS) FORMAT=COMMAX19.2 AS VL_PVS, 
	SUM(T1.INAD15) FORMAT=COMMAX19.2 AS INAD15, 
	SUM(T1.INAD15) FORMAT=COMMAX19.2 AS INAD15_59, 
	SUM(T1.INAD30) FORMAT=COMMAX19.2 AS INAD30, 
	SUM(T1.INAD60) FORMAT=COMMAX19.2 AS INAD60, 
	SUM(T1.INAD90) FORMAT=COMMAX19.2 AS INAD90,
	IFC(T13.MCI IS MISSING ,'NAO', 'SIM') AS FLCD, 
	CASE WHEN PROVENTISTA = 1 THEN 'SIM' ELSE 'NAO' END AS PROVENTISTA, 
	T9.CD_LNCD, 
	T9.NM_LNCD,
	CASE WHEN T9.CD_LNCD IN ( 2787, 2880, 2888, 2891, 2977, 3101, 5932, 5936) THEN 'NAO CORRENTISTA'	
	ELSE 'CORRENTISTA' END AS TIP_CLI,
	t1.UF_CTRA


FROM
	DICRE.OPR_INT_DRIA_&DATA t1
LEFT JOIN 
	DIEMP.BLOCODIEMP T2 ON
		T1.CD_PRD = T2.CD_PRD
        AND T1.CD_MDLD = T2.CD_MDLD
LEFT JOIN
    MST.BASE_PREFIXOS T3 ON
        T1.CD_PRF_DEPE_CTRA = T3.PREF_AG
LEFT JOIN
    DINFO.GST_CTRA_CLI T4 ON
        T3.PREF_DIRETORIA = T4.PRF_GST_CLI  
LEFT JOIN
    DB2PRD.MDLD_PRD T5 ON
        T1.CD_PRD = T5.CD_PRD
        AND T1.CD_MDLD = T5.CD_MDLD
LEFT JOIN 
	DB2PRD.PRD T7 ON 
		T1.CD_PRD = T7.CD_PRD
LEFT JOIN
	SDO.SDO_CTR_HIST T9 ON (
		INPUT(T1.NR_CTR_OPR, 17.)  = T9.NR_CTR_OPR	
	AND T9.CD_CLI  = T1.CD_CLI )
							
LEFT JOIN 
	ARC_AUX.NIVEIS_RISCO T10 ON 
	T1.CD_RSCO_ATBD = T10.RISCO
LEFT JOIN
	BLOCO.VW_FPM T11 ON
		T1.CD_PRD = T11.CD_PRD
		AND T1.CD_MDLD = T11.CD_MDLD
LEFT JOIN 
	WORK.DEPENDENCIAS T12 ON
	 ( T12.PREFIXO = T1.CD_PRF_DEPE_CTRA)
LEFT JOIN
	ACP.ACP_ANOT_CADL_MRT T13 ON 
	(T1.CD_CLI = T13.MCI)
/*left join */
/*		EXTERNO.CARTEIRAS_CATEGORIZACAO T14 on ( t1.CD_TIP_CTRA = t14.CD_TIP_CTRA )	 */
WHERE 
	t1.CD_PRF_GST_PRD = 9973
	AND	
	( t1.CD_TIP_PSS = 1 OR t1.SG_SIS_OGM_OPR = 'CDC' )	 

GROUP BY 
	T1.DT_CCL_CTB, 
	CALCULATED ANO,
	CALCULATED MES,
	CALCULATED ANOMES,
	CALCULATED ID_BL,
	CALCULATED NM_BL,
	CALCULATED ID_FML,
	T1.CD_PRD ,
	T1.CD_PRD, 
	T1.CD_MDLD, 
	CALCULATED ID_MDLD,
	CALCULATED PILAR, 
	CALCULATED NM_DRTA,
	t1.NM_SGM_CLI,
	T1.CD_PRF_DEPE_GST_PRD , 
	CALCULATED TIP_CTRA,
	T10.RISCO_9, 
	T1.CD_RSCO_CRD_CLI, 
	CALCULATED SGM_FATM,
	CALCULATED IN_ECN_VERDE,
	CALCULATED IN_DFNC,
	CALCULATED FLCD, 
	CALCULATED PROVENTISTA, 
	T9.CD_LNCD, 
	T9.NM_LNCD,
	CALCULATED TIP_CLI,
	t1.UF_CTRA
;
QUIT;
%MEND;
%DATE_LOOP_LIST(LOOP_OPR_INT_DRIA, &PREVIAS_SELECIONADAS);
%END;
%ELSE %DO;
%PUT 
###############
NENHUMA TABELA A CRIAR
###############
;
%END;
%MEND;
%PREVIACRIA();


PROC SQL;
drop table PG.dria_ctra_pf_total
;
QUIT;

DATA PG.dria_ctra_pf_total (BULKLOAD=YES);
SET DRIA.PNL_PRD_DRIA_:
;RUN;

PROC SQL;
CREATE TABLE DATAS_NAS_DUAS AS
	SELECT 
	A.DT
FROM 
	PG.DRIA_CTRA_PF_TOTAL A, PG.DRIA_CTRA_PJ_TOTAL B WHERE ( A.DT = B.DT )
GROUP BY
	A.DT
;
QUIT;

PROC SQL;
SELECT DISTINCT CAT("'",PUT(DT, YYMMDDD10.),"'") INTO:DT_PF SEPARATED BY " , " 
FROM 
	PG.DRIA_CTRA_PF_TOTAL A, PG.DRIA_CTRA_PJ_TOTAL B WHERE ( A.DT = B.DT )
;
QUIT;


PROC SQL;
CONNECT TO POSTGRES AS PG(database=diemp user=intranet password='diemp321#@!' server='172.16.13.160' port=5432);
EXECUTE(drop table arc.test_data ; ) by PG;
/*EXECUTE(*/
/*create table arc.test_data as */
/*select*/
/*	dt,*/
/*	sum(vl_sdo) as vl_sdo*/
/*from */
/*	arc.dria_ctra_pf_total*/
/*where */
/*	dt in ( &dt_pf )*/
/*group by*/
/*	dt;*/
/*) by pg;*/

QUIT;

PROC SQL;
CONNECT TO POSTGRES AS PG(database=diemp user=intranet password='diemp321#@!' server='172.16.13.160' port=5432);
EXECUTE(truncate table arc.msl_ctra_total;) BY PG;
EXECUTE(
insert into arc.msl_ctra_total
(anomes, ano, mes, cd_prd, nm_prd, cd_mdld, nm_mdld, tip_ctra, rsco_opr, rsco_cli, sgm_fatm, cd_prf_depe_gst, nm_gst, id_mdld, id_bl, nm_bl, id_fml, nm_fml, sgm, prf_drta, nm_drta, pilar, in_ecn_verde, in_dfnc, qtd_cli, qtd_opr, vl_sdo, vl_pvs, inad15, inad15_59, inad30, inad60, inad90, flcd, proventista, cd_lncd, nm_lncd, tip_cli, tip_pss, nm_pss, uf)
select anomes, ano, mes, cd_prd, nm_prd, cd_mdld, nm_mdld, case when cd_prd = 599 then 'A' else tip_ctra end as tip_ctra, rsco_opr, rsco_cli, sgm_fatm, cd_prf_depe_gst, nm_gst, id_mdld, case when id_bl in ( 2 , 4 , 200 ) then 0 else id_bl end as id_bl, initcap(case when nm_bl in ( 'GIRO', 'RECEBIVEIS' , 'ADT' ) then 'DEMAIS' else nm_bl end) as nm_bl, id_fml, nm_fml, sgm, prf_drta, nm_drta, pilar, in_ecn_verde, 0 as in_dfnc,  qtd_cli, qtd_opr, vl_sdo, vl_pvs, inad15, inad15_59, inad30, inad60, inad90, flcd, proventista, cd_lncd, nm_lncd, case when cd_lncd in ( 2787, 2880, 2888, 2891, 2977, 3101, 5932, 5936) then 'NAO CORRENTISTA' else 'CORRENTISTA' end as tip_cli, 1 as tip_pss, 'Pessoa Física' as nm_pss, uf_ctra as uf from arc.msl_ctra_pf_total
where anomes >= 202202 
union 
/*select *, null as flcd, null as proventista, null as cd_lncd, null as nm_lncd, null as nao_correntista, 2 as tip_pss from arc.ctra_msl_pj_total*/
select anomes, ano, mes, cd_prd, nm_prd, cd_mdld, nm_mdld, case when cd_prd = 599 then 'A' else tip_ctra end as tip_ctra, rsco_opr, rsco_cli, sgm_fatm, prf_gst, nm_gst, id_mdld, case when cd_prd = 599 then 7 else id_bl end as id_bl, initcap(case when cd_prd = 599 then 'Fiança' else nm_bl end) as nm_bl, id_fml, nm_fml, sgm, prf_drta, nm_drta, pilar, in_ecn_verde, in_dfnc, qtd_cli, qtd_opr, vl_sdo, vl_pvs, inad15, inad15_59, inad30, inad60, inad90, null as flcd, null as proventista, null as cd_lncd, null as nm_lncd, null as nao_correntista, 2 as tip_pss, 'Pessoa Jurídica' as nm_pss, uf_age as uf
FROM arc.ctra_msl_pj_total where anomes >= 202202 
;) BY PG;
EXECUTE(truncate table arc.dria_ctra_total;) BY PG;
EXECUTE(
insert into arc.dria_ctra_total
(dt, ano, mes, anomes, id_bl, nm_bl, id_fml, id_prd, cd_prd, cd_mdld, id_mdld, pilar, nm_drta, sgm, gst_prd, tip_ctra, rsco_opr, rsco_cli, sgm_fatm, in_ecn_verde, in_dfnc, qtde_opr, qtde_mci, vl_sdo, vl_pvs, inad15, inad15_59, inad30, inad60, inad90, flcd, proventista, cd_lncd, nm_lncd, tip_cli , tip_pss, nm_pss, uf)
select dt, ano, mes, anomes, case when id_bl in ( 2 , 4 , 200 ) then 0 else id_bl end as id_bl, initcap(case when nm_bl in ( 'GIRO', 'RECEBIVEIS' , 'ADT' ) then 'DEMAIS' else nm_bl end) as nm_bl, id_fml, id_prd, cd_prd, cd_mdld, id_mdld, pilar, nm_drta, sgm, gst_prd, case when cd_prd = 599 then 'A' else tip_ctra end as tip_ctra, rsco_opr, rsco_cli, sgm_fatm, in_ecn_verde, in_dfnc, qtde_opr, qtde_cli as qtde_mci, vl_sdo, vl_pvs, inad15, inad15_59, inad30, inad60, inad90, flcd, proventista, cd_lncd, nm_lncd, tip_cli, 1 as tip_pss, 'Pessoa Física' as nm_pss, uf_ctra as uf from arc.dria_ctra_pf_total
union
select dt, ano, mes, anomes, case when cd_prd = 599 then 7 else id_bl end as id_bl, initcap(case when cd_prd = 599 then 'Fiança' else nm_bl end) as nm_bl,   id_fml, id_prd, cd_prd, cd_mdld, id_mdld, pilar, nm_drta, sgm, gst_prd, case when cd_prd = 599 then 'A' else tip_ctra end as tip_ctra, rsco_opr, rsco_cli, sgm_fatm, in_ecn_verde, in_dfnc, qtde_opr, qtde_mci, vl_sdo, vl_pvs, inad15, inad15_59, inad30, inad60, inad90, null as flcd, null as proventista, null as cd_lncd, null as nm_lncd, null as tip_cli , 2 as tip_pss, 'Pessoa Jurídica' as nm_pss, uf_age as uf  from arc.ctra_dria_pj_total
where 
	dt in ( &dt_pf )
;) BY PG;
EXECUTE( drop table if exists arc.filtro;) BY PG;
EXECUTE(
create table arc.filtro as
select distinct cd_prd, nm_prd, cd_mdld, nm_mdld, case when cd_prd = 599 then 'A' else tip_ctra end as tip_ctra, rsco_opr, rsco_cli, sgm_fatm, cd_prf_depe_gst, nm_gst, id_mdld, id_bl, nm_bl, sgm, prf_drta, nm_drta, pilar, in_ecn_verde, in_dfnc, flcd, proventista, cd_lncd, nm_lncd, tip_cli, tip_pss, nm_pss
from arc.msl_ctra_total;
) BY PG;

QUIT;


PROC DATASETS LIBRARY=WORK KILL; RUN;

x chown -R &sysuserid.:sas14xfs /dados/sasdados/diemp/acompnegcred/acompinfoger/interno/pf/bases/ARC/pnl_prd/msl/dria;
x chmod 777 "/dados/sasdados/diemp/acompnegcred/acompinfoger/interno/pf/bases/ARC/pnl_prd/msl/dria/"*;

/*
PROC SQL;
CONNECT TO POSTGRES AS PG(database=diemp user=intranet password='diemp321#@!' server='172.16.13.160' port=5432);

EXECUTE(
delete from arc.dria_ctra_total
where dt = '2023-12-08'
;) BY PG;
QUIT;


