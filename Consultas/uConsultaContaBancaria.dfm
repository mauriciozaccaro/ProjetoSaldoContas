inherited frmConsultaContaBancaria: TfrmConsultaContaBancaria
  Caption = 'Conta Banc'#225'ria'
  PixelsPerInch = 96
  TextHeight = 13
  inherited QryConsultaContaBancaria: TZQuery
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
    Left = 40
    object QryConsultaContaBancariaIdConta: TLargeintField
      FieldName = 'IdConta'
    end
    object QryConsultaContaBancariaIdCliente: TLargeintField
      FieldName = 'IdCliente'
      Required = True
    end
    object QryConsultaContaBancariacliente: TWideStringField
      FieldName = 'cliente'
      Required = True
      Size = 50
    end
    object QryConsultaContaBancariaIdBanco: TLargeintField
      FieldName = 'IdBanco'
      Required = True
    end
    object QryConsultaContaBancariabanco: TWideStringField
      FieldName = 'banco'
      Required = True
      Size = 50
    end
    object QryConsultaContaBancarianumConta: TLargeintField
      FieldName = 'numConta'
      Required = True
    end
    object QryConsultaContaBancariasituacao: TWideStringField
      FieldName = 'situacao'
      Required = True
      Size = 1
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
    Active = True
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
