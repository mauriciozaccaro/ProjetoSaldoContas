inherited frmConsultaBanco: TfrmConsultaBanco
  Caption = 'Consulta Banco'
  PixelsPerInch = 96
  TextHeight = 13
  inherited grdListagemConsulta: TDBGrid
    Columns = <
      item
        Expanded = False
        FieldName = 'IdBanco'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome'
        Width = 200
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
      'SELECT IdBanco, nome, situacao FROM bancos WHERE situacao = '#39'S'#39)
    object QryConsultaIdBanco: TLargeintField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'IdBanco'
    end
    object QryConsultanome: TWideStringField
      DisplayLabel = 'Banco'
      FieldName = 'nome'
      Required = True
      Size = 50
    end
    object QryConsultasituacao: TWideStringField
      DisplayLabel = 'Ativo'
      FieldName = 'situacao'
      Required = True
      Size = 1
    end
  end
end
