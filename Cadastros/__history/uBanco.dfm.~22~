inherited frmCadBancos: TfrmCadBancos
  Caption = 'Cadastro de Banco'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    inherited tabListagem: TTabSheet
      Caption = 'Listagem'
      inherited grdListagemGrid: TDBGrid
        ReadOnly = True
        Columns = <
          item
            Expanded = False
            FieldName = 'IdBanco'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'situacao'
            Visible = True
          end>
      end
    end
    inherited tabCadastro: TTabSheet
      object edtCodigo: TLabeledEdit
        Left = 19
        Top = 48
        Width = 62
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        TabOrder = 0
      end
      object ckSituacao: TCheckBox
        Left = 190
        Top = 48
        Width = 97
        Height = 17
        Caption = 'Ativo'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object edtDescricao: TLabeledEdit
        Tag = 2
        Left = 19
        Top = 96
        Width = 178
        Height = 21
        EditLabel.Width = 29
        EditLabel.Height = 13
        EditLabel.Caption = 'Banco'
        TabOrder = 1
      end
    end
  end
  inherited Panel1: TPanel
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagemGrid: TZQuery
    SQL.Strings = (
      'SELECT IdBanco,'
      '       nome,'
      '       situacao'
      '  FROM bancos')
    object QryListagemGridIdBanco: TLargeintField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'IdBanco'
    end
    object QryListagemGridnome: TWideStringField
      DisplayLabel = 'Banco'
      FieldName = 'nome'
      Required = True
      Size = 50
    end
    object QryListagemGridsituacao: TWideStringField
      DisplayLabel = 'Ativo'
      FieldName = 'situacao'
      Required = True
      Size = 1
    end
  end
end
