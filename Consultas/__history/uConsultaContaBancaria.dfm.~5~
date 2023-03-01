inherited frmConsultaContaBancaria: TfrmConsultaContaBancaria
  Caption = 'Conta Banc'#225'ria'
  OnClose = FormClose
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
      end>
  end
  inherited QryConsultaContaBancaria: TZQuery
    SQL.Strings = (
      ''
      'SELECT CC.IdConta,'
      '       CL.nome AS cliente,'
      '       BC.nome AS banco,'
      '       CC.numConta,'
      '      CASE CC.situacao'
      '          WHEN '#39'S'#39' THEN '#39'Sim'#39
      '          WHEN '#39'N'#39' THEN '#39'N'#227'o'#39
      '          ELSE '#39'inv'#225'lido'#39
      '       END AS situacao'
      '  FROM contas    AS CC,'
      '       clientes  AS CL,'
      '       bancos    AS BC'
      ' WHERE CC.IdCliente = CL.IdCliente'
      '   AND CC.IdBanco = BC.IdBanco;')
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
      BlobType = ftWideMemo
    end
  end
end
