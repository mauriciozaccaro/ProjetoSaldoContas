inherited frmRelatorioMovBancario: TfrmRelatorioMovBancario
  BorderIcons = [biSystemMenu]
  Caption = 'frmRelatorioMovBancario'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited btnBuscaBanco: TSpeedButton
      Top = 30
      ExplicitTop = 30
    end
    inherited Label7: TLabel
      Left = 403
      Top = 15
      Width = 87
      Caption = 'Nr Conta Banc'#225'ria'
      ExplicitLeft = 403
      ExplicitTop = 15
      ExplicitWidth = 87
    end
    inherited dtpInicio: TDateTimePicker
      Date = 44986.000000000000000000
      Time = 44986.000000000000000000
    end
    inherited edtNumConta: TEdit
      Width = 90
      ExplicitWidth = 90
    end
    inherited edtCodConta: TMaskEdit
      Enabled = False
    end
  end
  inherited Panel2: TPanel
    inherited DBNavigator1: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited grdRelatorio: TDBGrid
    Columns = <
      item
        Expanded = False
        FieldName = 'IdConta'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cliente'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'banco'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'numConta'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'saldoAnterior'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'totalCredito'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'totalDebito'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'saldoAtual'
        Width = 80
        Visible = True
      end>
  end
  inherited QryRelatorio: TZQuery
    SQL.Strings = (
      '  /*  SELECT MC.IdConta,'
      '           CL.nome AS cliente,'
      '           BC.nome AS banco,'
      '           CT.numConta,'
      '           CAST(CT.saldoInicial AS FLOAT) AS saldoInicial,'
      '           CASE WHEN '#39'2000-01-01'#39' > (SELECT MIN(ss.dataMov)'
      '                                       FROM movcontas ss'
      
        '                                      WHERE ss.IdConta = MC.IdCo' +
        'nta) THEN ANT.saldoAnterior ELSE CT.saldoInicial END AS saldoAnt' +
        'erior,'
      
        '           SUM(CASE WHEN MC.tipoMov = '#39'C'#39' THEN MC.valor ELSE 0 E' +
        'ND) AS totalCredito,'
      
        '           SUM(CASE WHEN MC.tipoMov = '#39'D'#39' THEN MC.valor ELSE 0 E' +
        'ND) AS totalDebito,'
      
        '           CAST(CASE WHEN '#39'2000-01-01'#39' > (SELECT MIN(ss.dataMov)' +
        '  AS dataMov FROM movcontas ss WHERE ss.IdConta = MC.IdConta)'
      
        '                     THEN ANT.saldoAnterior + SUM(CASE WHEN MC.t' +
        'ipoMov = '#39'C'#39' THEN MC.valor ELSE 0 END) - SUM(CASE WHEN MC.tipoMo' +
        'v = '#39'D'#39' THEN MC.valor ELSE 0 END)'
      
        '                     ELSE CT.saldoInicial + SUM(CASE WHEN MC.tip' +
        'oMov = '#39'C'#39' THEN MC.valor ELSE 0 END) - SUM(CASE WHEN MC.tipoMov ' +
        '= '#39'D'#39' THEN MC.valor ELSE 0 END) END AS FLOAT) AS saldoAtual'
      '      FROM movcontas MC'
      '           INNER JOIN contas CT ON CT.IdConta = MC.IdConta'
      '           INNER JOIN clientes CL ON CL.IdCliente = CT.IdCliente'
      '           INNER JOIN bancos BC ON BC.IdBanco = CT.IdBanco'
      '           LEFT JOIN (SELECT CTT.IdConta,'
      
        '                             (CTT.saldoInicial + COALESCE((SUM(C' +
        'ASE WHEN MCC.tipoMov = '#39'C'#39' THEN MCC.valor ELSE 0 END) -'
      
        '                                                           SUM(C' +
        'ASE WHEN MCC.tipoMov = '#39'D'#39' THEN MCC.valor ELSE 0 END)), 0)) AS s' +
        'aldoAnterior'
      '                        FROM movcontas MCC'
      
        '                             LEFT JOIN contas CTT ON CTT.IdConta' +
        ' = MCC.IdConta'
      '                       WHERE MCC.IdConta = CTT.IdConta'
      '                         AND MCC.dataMov <= '#39'2000-01-01'#39
      
        '                       GROUP BY CTT.IdConta, CTT.saldoInicial) A' +
        'S ANT ON ANT.IdConta = MC.IdConta'
      '     WHERE MC.IdConta = CT.IdConta'
      '       AND CT.IdCliente = CL.IdCliente'
      '       AND CT.IdBanco = BC.IdBanco'
      '       AND CT.IdConta = ANT.IdConta'
      '       AND MC.dataMov BETWEEN '#39'2000-01-01'#39' AND '#39'2030-01-01'#39'  */'
      ''
      ''
      ''
      '    SELECT MC.IdConta,'
      '    CL.nome AS cliente,'
      '    BC.nome AS banco,'
      '    CT.numConta,'
      '    CT.saldoInicial,'
      
        '    CASE WHEN '#39'2022-03-06'#39' >= (SELECT MIN(ss.dataMov)  AS dataMo' +
        'v FROM movcontas ss WHERE ss.IdConta = MC.IdConta)'
      '    THEN ANT.saldoAnterior'
      '    ELSE CT.saldoInicial'
      '    END AS saldoAnterior,'
      
        '    SUM(CASE WHEN MC.tipoMov = '#39'C'#39' THEN MC.valor ELSE 0 END) AS ' +
        'totalCredito,   SUM(CASE WHEN MC.tipoMov = '#39'D'#39' THEN MC.valor ELS' +
        'E 0 END) AS totalDebito,'
      
        '    CASE WHEN '#39'2022-03-06'#39' >= (SELECT MIN(ss.dataMov)  AS dataMo' +
        'v FROM movcontas ss WHERE ss.IdConta = MC.IdConta)'
      
        '    THEN ANT.saldoAnterior + SUM(CASE WHEN MC.tipoMov = '#39'C'#39' THEN' +
        ' MC.valor ELSE 0 END) - SUM(CASE WHEN MC.tipoMov = '#39'D'#39' THEN MC.v' +
        'alor ELSE 0 END)'
      
        '    ELSE CT.saldoInicial + SUM(CASE WHEN MC.tipoMov = '#39'C'#39' THEN M' +
        'C.valor ELSE 0 END) - SUM(CASE WHEN MC.tipoMov = '#39'D'#39' THEN MC.val' +
        'or ELSE 0 END)'
      '    END AS saldoAtual'
      '    FROM movcontas MC'
      '    INNER JOIN contas CT ON CT.IdConta = MC.IdConta'
      '    INNER JOIN clientes CL ON CL.IdCliente = CT.IdCliente'
      '    INNER JOIN bancos BC ON BC.IdBanco = CT.IdBanco'
      
        '    LEFT JOIN (SELECT CTT.IdConta, (CTT.saldoInicial + COALESCE(' +
        '(SUM(CASE WHEN MCC.tipoMov = '#39'C'#39
      
        '    THEN MCC.valor ELSE 0 END)           - SUM(CASE WHEN MCC.tip' +
        'oMov = '#39'D'#39' THEN MCC.valor ELSE 0 END)), 0)) AS saldoAnterior'
      '    FROM movcontas MCC'
      '    LEFT JOIN contas CTT ON CTT.IdConta = MCC.IdConta'
      '    WHERE MCC.IdConta = CTT.IdConta'
      '    AND MCC.dataMov <= (SELECT MIN(ss.dataMov)  AS dataMov'
      '    FROM movcontas ss WHERE ss.IdConta = MCC.IdConta)'
      
        '    GROUP BY CTT.IdConta, CTT.saldoInicial) AS ANT ON ANT.IdCont' +
        'a = MC.IdConta'
      
        '    WHERE MC.IdConta = CT.IdConta   AND CT.IdCliente = CL.IdClie' +
        'nte'
      '    AND CT.IdBanco = BC.IdBanco   AND CT.IdConta = ANT.IdConta'
      '    AND MC.dataMov'
      '    BETWEEN '#39'2022-03-06'#39' AND '#39'2023-03-06'#39' GROUP BY CT.IdConta'
      '    AND CT.IdBanco = 2'
      ''
      '         /*'
      
        'SELECT MC.IdConta, CL.nome AS cliente, BC.nome AS banco, CT.numC' +
        'onta, CT.saldoInicial,  ANT.saldoAnterior,'
      
        '       SUM(CASE WHEN MC.tipoMov = '#39'C'#39' THEN MC.valor ELSE 0 END) ' +
        'AS totalCredito,'
      
        '       SUM(CASE WHEN MC.tipoMov = '#39'D'#39' THEN MC.valor ELSE 0 END) ' +
        'AS totalDebito,'
      
        '      (SUM(CASE WHEN MC.tipoMov = '#39'C'#39' THEN MC.valor ELSE 0 END) ' +
        '- SUM(CASE WHEN MC.tipoMov = '#39'D'#39' THEN MC.valor ELSE 0 END)) AS s' +
        'aldoAtual'
      '  FROM movcontas MC,'
      '       contas CT,'
      '       clientes CL,'
      '       bancos BC,'
      '               '
      
        '             (SELECT CTT.IdConta, COALESCE(CTT.saldoInicial + (S' +
        'UM(CASE WHEN MCC.tipoMov = '#39'C'#39' THEN MCC.valor ELSE 0 END) '
      
        '              - SUM(CASE WHEN MCC.tipoMov = '#39'D'#39' THEN MCC.valor E' +
        'LSE 0 END)), 0) AS saldoAnterior'
      '          FROM movcontas MCC,'
      '               contas CTT,'
      '               clientes CLL,'
      '               bancos BCC'
      '         WHERE MCC.IdConta = CTT.IdConta'
      '           AND CTT.IdCliente = CLL.IdCliente'
      '           AND CTT.IdBanco = BCC.IdBanco'
      '        GROUP BY CTT.IdConta, CTT.saldoInicial) AS ANT'
      '          '
      ' WHERE MC.IdConta = CT.IdConta'
      '   AND CT.IdCliente = CL.IdCliente'
      '   AND CT.IdBanco = BC.IdBanco'
      '   AND CT.IdConta = ANT.IdConta'
      ''
      '           */'
      ''
      '/*'
      'SELECT MC.IdConta,'
      '       CL.nome AS cliente,'
      '       BC.nome AS banco,'
      '       CT.numConta,'
      '       CAST(CT.saldoInicial AS Float) AS saldoInicial,'
      '       ANT.saldoAnterior,'
      '       SUM(CASE'
      '             WHEN MC.tipoMov = '#39'C'#39' THEN'
      '              MC.valor'
      '             ELSE'
      '              0'
      '           END) AS totalCredito,'
      '       SUM(CASE'
      '             WHEN MC.tipoMov = '#39'D'#39' THEN'
      '              MC.valor'
      '             ELSE'
      '              0'
      '           END) AS totalDebito,'
      '       (SUM(CASE'
      '              WHEN MC.tipoMov = '#39'C'#39' THEN'
      '               MC.valor'
      '              ELSE'
      '               0'
      '            END) - SUM(CASE'
      '                          WHEN MC.tipoMov = '#39'D'#39' THEN'
      '                           MC.valor'
      '                          ELSE'
      '                           0'
      '                        END)) AS saldoAtual'
      '  FROM movcontas MC,'
      '       contas CT,'
      '       clientes CL,'
      '       bancos BC,'
      '       (SELECT CTT.IdConta,'
      '               COALESCE(CTT.saldoInicial +'
      '                        (SUM(CASE'
      '                               WHEN MCC.tipoMov = '#39'C'#39' THEN'
      '                                MCC.valor'
      '                               ELSE'
      '                                0'
      '                             END) - SUM(CASE'
      
        '                                           WHEN MCC.tipoMov = '#39'D' +
        #39' THEN'
      '                                            MCC.valor'
      '                                           ELSE'
      '                                            0'
      '                                         END)),'
      '                        0) AS saldoAnterior'
      
        '          FROM movcontas MCC, contas CTT, clientes CLL, bancos B' +
        'CC'
      '         WHERE MCC.IdConta = CTT.IdConta'
      '           AND CTT.IdCliente = CLL.IdCliente'
      '           AND CTT.IdBanco = BCC.IdBanco'
      '           AND MCC.dataMov BETWEEN :dataInicial AND :dataFinal'
      '         GROUP BY CTT.IdConta, CTT.saldoInicial) AS ANT'
      ' WHERE MC.IdConta = CT.IdConta'
      '   AND CT.IdCliente = CL.IdCliente'
      '   AND CT.IdBanco = BC.IdBanco'
      '   AND CT.IdConta = ANT.IdConta'
      '   AND MC.dataMov BETWEEN :dataInicial AND :dataFinal'
      ' GROUP BY CT.IdConta'
      ''
      ' */')
    Left = 656
    Top = 8
    object QryRelatorioIdConta: TLargeintField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'IdConta'
      Required = True
    end
    object QryRelatoriocliente: TWideStringField
      DisplayLabel = 'Cliente'
      FieldName = 'cliente'
      Required = True
      Size = 50
    end
    object QryRelatoriobanco: TWideStringField
      DisplayLabel = 'Banco'
      FieldName = 'banco'
      Required = True
      Size = 50
    end
    object QryRelatorionumConta: TLargeintField
      DisplayLabel = 'Nr Conta'
      FieldName = 'numConta'
      Required = True
    end
    object QryRelatoriosaldoAnterior: TFloatField
      DisplayLabel = 'Saldo Anterior'
      FieldName = 'saldoAnterior'
    end
    object QryRelatoriototalCredito: TFloatField
      DisplayLabel = 'Total Cr'#233'dito'
      FieldName = 'totalCredito'
    end
    object QryRelatoriototalDebito: TFloatField
      DisplayLabel = 'Total D'#233'bito'
      FieldName = 'totalDebito'
    end
    object QryRelatoriosaldoAtual: TFloatField
      DisplayLabel = 'Saldo Final'
      FieldName = 'saldoAtual'
    end
  end
  inherited dtsRelatorio: TDataSource
    Left = 712
  end
end
