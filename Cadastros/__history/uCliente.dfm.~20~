inherited frmCadClientes: TfrmCadClientes
  Caption = 'Cadastro de Clientes'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    ActivePage = tabCadastro
    inherited tabListagem: TTabSheet
      Caption = 'Listagem'
      inherited grdListagemGrid: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'IdCliente'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'numDocumento'
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
      ParentShowHint = False
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
      object edtDescricao: TLabeledEdit
        Left = 19
        Top = 96
        Width = 340
        Height = 21
        Hint = 'Digite seu Nome'
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        TabOrder = 1
      end
      object edtDocumento: TLabeledEdit
        Left = 19
        Top = 144
        Width = 158
        Height = 21
        EditLabel.Width = 54
        EditLabel.Height = 13
        EditLabel.Caption = 'Documento'
        NumbersOnly = True
        TabOrder = 2
      end
      object ckSituacao: TCheckBox
        Left = 190
        Top = 48
        Width = 97
        Height = 17
        Caption = 'Ativo'
        Checked = True
        State = cbChecked
        TabOrder = 3
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
      'SELECT IdCliente,'
      '       nome,'
      '       numDocumento,'
      '       situacao'
      '  FROM clientes')
    object QryListagemGridIdCliente: TLargeintField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'IdCliente'
    end
    object QryListagemGridnome: TWideStringField
      DisplayLabel = 'Nome Cliente'
      FieldName = 'nome'
      Required = True
      Size = 50
    end
    object QryListagemGridnumDocumento: TLargeintField
      DisplayLabel = 'Documento'
      FieldName = 'numDocumento'
      Required = True
    end
    object QryListagemGridsituacao: TWideStringField
      DisplayLabel = 'Ativo'
      FieldName = 'situacao'
      Required = True
      Size = 1
    end
  end
end
