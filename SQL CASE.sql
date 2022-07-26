SELECT DISTINCT PCV_FILIAL AS FILIAL,
                PCV_ENVEL ENVELOPE,
                PCV_STATUS STATUS_ENVELOPE,
                PCV_TPOPER AS TIPO_OPERACAO,
                PCV_PLACA PLACA,
                PCV_TPFROT TP_FROTA,
                PCV_TPVEIC TP_VEICULO,
                PCV_CDMOTO COD_MOTORISTA,
                PCV_NMMOTO NM_MOTORISTA,
                PCW_VIAGEM CD_VIAGEM,
                PCW_CARGA CARGA,
                PCW_TOTFRE TOTAL_FRETE,
                PCW_PESCAR PESO_CARGA,
                TO_CHAR(TO_DATE(PCW_DTVIAG, 'YYYYMMDD'), 'DD/MM/YYYY') AS DT_VIAGEM,
                 TO_CHAR(TO_DATE(PCW_RETVIA, 'YYYYMMDD'), 'DD/MM/YYYY') AS RETORNO,
                PCW_STATUS STATUS_VIAGEM,
                PCX_SEQ SEQ_TRECHO,
                PCX_STATUS STATUS_TRECHO,
                PCX_VIAGEM VIAGEM,
                PCX_TPVIAG TP_VIAGEM,
                PCX_TRECHO TRECHO,
                PCX_TPTREC TP_TRECHO,
                PCX_ORIGEM ORIGEM,
                CC2.CC2_EST AS UF_ORIGEM,
                PCX_DESTIN DESTINO,
                CC2DEST.CC2_EST AS UF_DEST,
                PCX_PESTRE PESO_TRECHO,
                PCX_VALFRE VLR_FRETE,
                TO_CHAR(TO_DATE(PCX_DTSAID, 'YYYYMMDD'), 'DD/MM/YYYY') AS DT_SAIDA,
                PCX_HRSAID HR_SAIDA,
                TO_CHAR(TO_DATE(PCX_DTCHEG, 'YYYYMMDD'), 'DD/MM/YYYY') AS DT_CHEGADA,
                PCX_HRCHEG HR_CHEGADA,
                PCX_KMORIG KM_ORIGEM,
                PCX_KMCHEG KM_CHEGADA,
                PCX_KMCHEG - PCX_KMORIG as KM_TOTAL,
                PCX_DIAMOT DIARIA,
                TO_CHAR(TO_DATE(PCX_DTFECH, 'YYYYMMDD'), 'DD/MM/YYYY') AS DT_FECHAMENTO,
                (PCX_VALFRE + PCX_DIAMOT) TOTAL_FRETE,
                TQN.TQN_CODCOM AS COMBUSTIVEL,
                
                CASE
                  WHEN (TQN_CODCOM IN ('S10')) THEN
                   ('S10')
                  ELSE
                   ' '
                END AS S10,
                
                CASE
                  WHEN (TQN_CODCOM IN ('S50')) THEN
                   ('S50')
                  ELSE
                   ' '
                END AS S50,
                
                CASE
                  WHEN (TQN_CODCOM IN ('ARL')) THEN
                   ('ARL')
                  ELSE
                   ' '
                END AS ARL,
                CASE
                  WHEN (TQN_CODCOM IN ('S10')) THEN
                   (TQN_VALTOT / TQN_QUANT)
                  ELSE
                   0
                END AS S10_REAIS,
                
                CASE
                  WHEN (TQN_CODCOM IN ('S50')) THEN
                   (TQN_VALTOT / TQN_QUANT)
                  ELSE
                   0
                END AS S50_REAIS,
                
                CASE
                  WHEN (TQN_CODCOM IN ('ARL')) THEN
                   (TQN_VALTOT / TQN_QUANT)
                  ELSE
                   0
                END AS ARL_REAIS,
                TQN_QUANT QUANTIDADE,
                TQN_VALTOT TOTAL,
                PCV_CNTINI,
                PCV_CNTFIM,
                PCV_CNTTOT,
                TO_CHAR(TO_DATE(PCV_DTINCL, 'RRRRMMDD'), 'DD/MM/RRRR') AS DT_INCLUI,
                PCV_INCLUS USER_INCLUI,
                TO_CHAR(TO_DATE(PCV_DTFECH, 'YYYYMMDD'), 'DD/MM/YYYY') AS DT_FECHAMENTO,
                PCV_FECHAM USER_FECHA,
                PCV_REABRE USER_REABER,
                TO_CHAR(TO_DATE(PCV_DTREAB, 'YYYYMMDD'), 'DD/MM/YYYY') AS DT_REABER
  FROM TMPROD.PCV010 PCV
  JOIN TMPROD.PCX010 PCX
    ON PCV.PCV_FILIAL = PCX.PCX_FILIAL
   AND PCV.PCV_ENVEL = PCX.PCX_ENVEL
  JOIN TMPROD.PCW010 PCW
    ON PCV.PCV_FILIAL = PCW.PCW_FILIAL
   AND PCV.PCV_ENVEL = PCW.PCW_ENVEL
  JOIN TMPROD.TQN010 TQN
    ON PCV.PCV_ENVEL = TQN.TQN_XENVEL
  JOIN TMPROD.CC2010 CC2
    ON CC2.CC2_MUN = PCX.PCX_ORIGEM
  JOIN TMPROD.CC2010 CC2DEST
    ON CC2DEST.CC2_MUN = PCX.PCX_DESTIN
 WHERE PCV.D_E_L_E_T_ = ' '
   AND PCX.D_E_L_E_T_ = ' '
   AND PCW.D_E_L_E_T_ = ' '
   AND TQN.D_E_L_E_T_ = ' '
   AND PCW_RETVIA > '00000001'
   AND PCV_DTREAB > '00000001'

