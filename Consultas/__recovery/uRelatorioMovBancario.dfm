inherited frmRelatorioMovBancario: TfrmRelatorioMovBancario
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
    inherited edtCodBanco: TMaskEdit
      Enabled = True
    end
    inherited edtCodCliente: TMaskEdit
      Enabled = True
    end
    inherited edtNumConta: TEdit
      Width = 90
      ExplicitWidth = 90
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
        Width = 60
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
        FieldName = 'saldoInicial'
        Visible = False
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
        Width = 70
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
        Width = 70
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
      DisplayLabel = 'C'#243'd Conta'
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
    object QryRelatoriosaldoInicial: TFloatField
      DisplayLabel = 'Saldo Inicial'
      FieldName = 'saldoInicial'
    end
    object QryRelatoriosaldoAnterior: TFloatField
      DisplayLabel = 'Saldo Anterior'
      FieldName = 'saldoAnterior'
      ReadOnly = True
      DisplayFormat = '#,###0.00'
    end
    object QryRelatoriototalCredito: TLargeintField
      DisplayLabel = 'Total Cr'#233'ditos'
      FieldName = 'totalCredito'
      ReadOnly = True
      DisplayFormat = '#,###0.00'
    end
    object QryRelatoriototalDebito: TLargeintField
      DisplayLabel = 'Total D'#233'bitos'
      FieldName = 'totalDebito'
      ReadOnly = True
      DisplayFormat = '#,###0.00'
    end
    object QryRelatoriosaldoAtual: TLargeintField
      DisplayLabel = 'Saldo Atual'
      FieldName = 'saldoAtual'
      ReadOnly = True
      DisplayFormat = '#,###0.00'
    end
  end
  inherited dtsRelatorio: TDataSource
    Left = 712
  end
end
