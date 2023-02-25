inherited frmCadClientes: TfrmCadClientes
  Caption = 'Cadastro de Clientes'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
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
            FieldName = 'documento'
            Visible = True
          end>
      end
    end
    inherited tabCadastro: TTabSheet
      Caption = 'Cadastro'
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
      'SELECT IdCliente, nome, documento FROM clientes')
    object QryListagemGridIdCliente: TLargeintField
      FieldName = 'IdCliente'
    end
    object QryListagemGridnome: TWideStringField
      FieldName = 'nome'
      Size = 50
    end
    object QryListagemGriddocumento: TWideStringField
      FieldName = 'documento'
      Size = 10
    end
  end
end
