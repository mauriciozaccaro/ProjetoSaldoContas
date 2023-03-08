inherited frmConsultaContaBancaria: TfrmConsultaContaBancaria
  Caption = 'Conta Banc'#225'ria'
  ClientWidth = 499
  ExplicitWidth = 515
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 499
    ExplicitWidth = 499
    inherited MaskEdit1: TMaskEdit
      Width = 497
      ExplicitWidth = 497
    end
  end
  inherited Panel2: TPanel
    Width = 499
    ExplicitWidth = 499
    inherited btnFechar: TButton
      Left = 410
      ExplicitLeft = 410
    end
  end
  inherited grdListagemConsulta: TDBGrid
    Width = 499
    Columns = <
      item
        Expanded = False
        FieldName = 'IdConta'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IdCliente'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'cliente'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IdBanco'
        Visible = False
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
        FieldName = 'situacao'
        Visible = True
      end>
  end
  inherited QryConsulta: TZQuery
    SQL.Strings = (
      ''
      'SELECT CC.IdConta,'
      '       CC.IdCliente,'
      '       CL.nome AS cliente,'
      '       CC.IdBanco,'
      '       BC.nome AS banco,'
      '       CC.numConta,'
      '       CC.situacao'
      '  FROM contas    AS CC,'
      '       clientes  AS CL,'
      '       bancos    AS BC'
      ' WHERE CC.IdCliente = CL.IdCliente'
      '   AND CC.IdBanco = BC.IdBanco;')
    Left = 264
    Top = 1
    object QryConsultaContaBancariaIdConta: TLargeintField
      DisplayLabel = 'C'#243'd. Conta'
      FieldName = 'IdConta'
    end
    object QryConsultaContaBancariaIdCliente: TLargeintField
      FieldName = 'IdCliente'
      Required = True
    end
    object QryConsultaContaBancariacliente: TWideStringField
      DisplayLabel = 'Cliente'
      FieldName = 'cliente'
      Required = True
      Size = 50
    end
    object QryConsultaContaBancariaIdBanco: TLargeintField
      FieldName = 'IdBanco'
      Required = True
    end
    object QryConsultaContaBancariabanco: TWideStringField
      DisplayLabel = 'Banco'
      FieldName = 'banco'
      Required = True
      Size = 50
    end
    object QryConsultaContaBancarianumConta: TLargeintField
      DisplayLabel = 'Nr Conta'
      FieldName = 'numConta'
      Required = True
    end
    object QryConsultaContaBancariasituacao: TWideStringField
      DisplayLabel = 'Ativo'
      FieldName = 'situacao'
      Required = True
      Size = 1
    end
  end
  inherited dtsConsulta: TDataSource
    Left = 336
    Top = 1
  end
end
