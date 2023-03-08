inherited frmRelatorioMovBancario: TfrmRelatorioMovBancario
  Caption = 'frmRelatorioMovBancario'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited btnBuscaBanco: TSpeedButton
      OnClick = btnBuscaBancoClick
    end
    inherited edtCodBanco: TMaskEdit
      Enabled = True
    end
    inherited edtCodCliente: TMaskEdit
      Enabled = True
    end
  end
  inherited Panel2: TPanel
    inherited DBNavigator1: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited grdRelatorio: TDBGrid
    DataSource = dtsRelatorio
    Columns = <
      item
        Expanded = False
        FieldName = 'IdConta'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cliente'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'banco'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'numConta'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'saldoInicial'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'saldoAnterior'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'totalCredito'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'totalDebito'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'saldoAtual'
        Visible = True
      end>
  end
  inherited QryRelatorio: TZQuery
    Active = True
    SQL.Strings = (
      ''
      
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
      'GROUP BY CT.IdConta;'
      ''
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
      FieldName = 'IdConta'
      Required = True
    end
    object QryRelatoriocliente: TWideStringField
      FieldName = 'cliente'
      Required = True
      Size = 50
    end
    object QryRelatoriobanco: TWideStringField
      FieldName = 'banco'
      Required = True
      Size = 50
    end
    object QryRelatorionumConta: TLargeintField
      FieldName = 'numConta'
      Required = True
    end
    object QryRelatoriosaldoInicial: TFloatField
      FieldName = 'saldoInicial'
    end
    object QryRelatoriosaldoAnterior: TFloatField
      FieldName = 'saldoAnterior'
      ReadOnly = True
    end
    object QryRelatoriototalCredito: TLargeintField
      FieldName = 'totalCredito'
      ReadOnly = True
    end
    object QryRelatoriototalDebito: TLargeintField
      FieldName = 'totalDebito'
      ReadOnly = True
    end
    object QryRelatoriosaldoAtual: TLargeintField
      FieldName = 'saldoAtual'
      ReadOnly = True
    end
  end
  inherited dtsRelatorio: TDataSource
    Left = 712
  end
end
