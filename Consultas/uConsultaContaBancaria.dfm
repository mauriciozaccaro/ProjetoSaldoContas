inherited frmConsultaContaBancaria: TfrmConsultaContaBancaria
  Caption = 'Conta Banc'#225'ria'
  PixelsPerInch = 96
  TextHeight = 13
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
    Left = 128
  end
  object QryConsultaCliente: TZQuery
    Connection = DtmConexaoPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT IdCliente,'
      '       nome,'
      '       numDocumento,'
      '       situacao'
      '  FROM clientes'
      'WHERE situacao = '#39'S'#39)
    Params = <>
    Left = 112
    object QryConsultaClienteIdCliente: TLargeintField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'IdCliente'
    end
    object QryConsultaClientenome: TWideStringField
      DisplayLabel = 'Nome Cliente'
      FieldName = 'nome'
      Required = True
      Size = 50
    end
    object QryConsultaClientenumDocumento: TLargeintField
      DisplayLabel = 'Nr Documento'
      FieldName = 'numDocumento'
      Required = True
    end
    object QryConsultaClientesituacao: TWideStringField
      DisplayLabel = 'Ativo'
      FieldName = 'situacao'
      Required = True
      Size = 1
    end
  end
  object dtsConsultaCliente: TDataSource
    DataSet = QryConsultaCliente
    Left = 216
  end
  object QryConsultaBanco: TZQuery
    Connection = DtmConexaoPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT IdBanco, nome, situacao FROM bancos WHERE situacao = '#39'S'#39)
    Params = <>
    Left = 296
    object QryConsultaBancoIdBanco: TLargeintField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'IdBanco'
    end
    object QryConsultaBanconome: TWideStringField
      DisplayLabel = 'Banco'
      FieldName = 'nome'
      Required = True
      Size = 50
    end
    object QryConsultaBancosituacao: TWideStringField
      DisplayLabel = 'Ativo'
      FieldName = 'situacao'
      Required = True
      Size = 1
    end
  end
  object dtsConsultaBanco: TDataSource
    DataSet = QryConsultaBanco
    Left = 360
  end
end
