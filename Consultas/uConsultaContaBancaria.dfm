inherited frmConsultaContaBancaria: TfrmConsultaContaBancaria
  Caption = 'Conta Banc'#225'ria'
  PixelsPerInch = 96
  TextHeight = 13
  inherited grdListagemConsulta: TDBGrid
    DataSource = dtsConsultaContaBancaria
    Columns = <
      item
        Expanded = False
        FieldName = 'IdConta'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'banco'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'numConta'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'situacao'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cliente'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'IdCliente'
        Visible = False
      end>
  end
  inherited QryConsultaContaBancaria: TZQuery
    SQL.Strings = (
      ''
      'SELECT CC.IdConta,'
      '       CL.IdCliente,'
      '       CL.nome AS cliente,'
      '       BC.nome AS banco,'
      '       CC.numConta,'
      '       CC.situacao'
      '  FROM contas    AS CC,'
      '       clientes  AS CL,'
      '       bancos    AS BC'
      ' WHERE CC.IdCliente = CL.IdCliente'
      '   AND CC.IdBanco = BC.IdBanco;')
    Left = 40
    object QryConsultaContaBancariaIdConta: TLargeintField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'IdConta'
    end
    object QryConsultaContaBancariacliente: TWideStringField
      DisplayLabel = 'Cliente'
      FieldName = 'cliente'
      Required = True
      Size = 50
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
    object QryConsultaContaBancariasituacao: TWideMemoField
      DisplayLabel = 'Ativo'
      FieldName = 'situacao'
      ReadOnly = True
      BlobType = ftWideString
    end
    object QryConsultaContaBancariaIdCliente: TLargeintField
      FieldName = 'IdCliente'
    end
  end
  inherited dtsConsultaContaBancaria: TDataSource
    Left = 264
  end
end
