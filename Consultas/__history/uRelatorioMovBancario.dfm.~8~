inherited frmRelatorioMovBancario: TfrmRelatorioMovBancario
  Caption = 'frmRelatorioMovBancario'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    ExplicitLeft = -142
    ExplicitTop = 376
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
        FieldName = 'saldoInicial'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ANTERIOR'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CREDITO'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DEBITO'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALDO'
        Width = 70
        Visible = True
      end>
  end
  inherited QryRelatorio: TZQuery
    Active = True
    SQL.Strings = (
      ''
      
        'SELECT MC.IdConta, CL.nome AS cliente, BC.nome AS banco, CT.numC' +
        'onta, CT.saldoInicial,  ANT.ANTERIOR, '
      
        '       SUM(CASE WHEN MC.tipoMov = '#39'C'#39' THEN MC.valor ELSE 0 END) ' +
        'AS CREDITO,'
      
        '       SUM(CASE WHEN MC.tipoMov = '#39'D'#39' THEN MC.valor ELSE 0 END) ' +
        'AS DEBITO,'
      
        '      (SUM(CASE WHEN MC.tipoMov = '#39'C'#39' THEN MC.valor ELSE 0 END) ' +
        '- SUM(CASE WHEN MC.tipoMov = '#39'D'#39' THEN MC.valor ELSE 0 END)) AS S' +
        'ALDO'
      '  FROM movcontas MC,'
      '       contas CT,'
      '       clientes CL,'
      '       bancos BC,'
      '               '
      
        '             (SELECT CTT.IdConta, COALESCE(CTT.saldoInicial + (S' +
        'UM(CASE WHEN MCC.tipoMov = '#39'C'#39' THEN MCC.valor ELSE 0 END) '
      
        '              - SUM(CASE WHEN MCC.tipoMov = '#39'D'#39' THEN MCC.valor E' +
        'LSE 0 END)), 0) AS ANTERIOR'
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
      'GROUP BY CT.IdConta;')
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
    object QryRelatoriosaldoInicial: TFloatField
      DisplayLabel = 'Saldo Inicial'
      FieldName = 'saldoInicial'
    end
    object QryRelatorioANTERIOR: TFloatField
      DisplayLabel = 'Saldo Anterior'
      FieldName = 'ANTERIOR'
      ReadOnly = True
      DisplayFormat = '#,###0.00'
    end
    object QryRelatorioCREDITO: TLargeintField
      DisplayLabel = 'Cr'#233'dito'
      FieldName = 'CREDITO'
      ReadOnly = True
      DisplayFormat = '#,###0.00'
    end
    object QryRelatorioDEBITO: TLargeintField
      DisplayLabel = 'D'#233'bito'
      FieldName = 'DEBITO'
      ReadOnly = True
      DisplayFormat = '#,###0.00'
    end
    object QryRelatorioSALDO: TLargeintField
      DisplayLabel = 'Saldo Atual'
      FieldName = 'SALDO'
      ReadOnly = True
      DisplayFormat = '#,###0.00'
    end
  end
  inherited dtsRelatorio: TDataSource
    Left = 712
  end
end
