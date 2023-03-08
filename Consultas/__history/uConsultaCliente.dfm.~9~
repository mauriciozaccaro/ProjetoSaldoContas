inherited frmConsultaCliente: TfrmConsultaCliente
  Caption = 'Consulta Cliente'
  PixelsPerInch = 96
  TextHeight = 13
  inherited grdListagemConsulta: TDBGrid
    Columns = <
      item
        Expanded = False
        FieldName = 'IdCliente'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'numDocumento'
        Width = 80
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
      'SELECT IdCliente,'
      '       nome,'
      '       numDocumento,'
      '       situacao'
      '  FROM clientes'
      'WHERE situacao = '#39'S'#39)
    object QryConsultaIdCliente: TLargeintField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'IdCliente'
    end
    object QryConsultanome: TWideStringField
      DisplayLabel = 'Nome Cliente'
      FieldName = 'nome'
      Required = True
      Size = 50
    end
    object QryConsultanumDocumento: TLargeintField
      DisplayLabel = 'Nr Documento'
      FieldName = 'numDocumento'
      Required = True
    end
    object QryConsultasituacao: TWideStringField
      DisplayLabel = 'Ativo'
      FieldName = 'situacao'
      Required = True
      Size = 1
    end
  end
end
