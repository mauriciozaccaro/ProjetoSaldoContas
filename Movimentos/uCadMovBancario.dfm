inherited frmCadMovBancario: TfrmCadMovBancario
  Tag = 3
  Caption = 'Movimento Banc'#225'rio'
  ClientWidth = 753
  ExplicitWidth = 769
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 753
    ActivePage = tabListagem
    ExplicitWidth = 753
    inherited tabListagem: TTabSheet
      Caption = 'Listagem'
      ExplicitWidth = 745
      inherited Panel2: TPanel
        Width = 745
        ExplicitWidth = 745
      end
      inherited grdListagemGrid: TDBGrid
        Width = 745
        Columns = <
          item
            Expanded = False
            FieldName = 'IdMovContas'
            Width = 50
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
            Width = 180
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
            Width = 150
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
            FieldName = 'valor'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tipoMov'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dataMov'
            Width = 80
            Visible = True
          end>
      end
    end
    inherited tabCadastro: TTabSheet
      ExplicitWidth = 745
      object Label1: TLabel
        Left = 19
        Top = 80
        Width = 73
        Height = 13
        Caption = 'Conta Banc'#225'ria'
      end
      object Label2: TLabel
        Left = 19
        Top = 131
        Width = 33
        Height = 13
        Caption = 'Cliente'
      end
      object Label3: TLabel
        Left = 19
        Top = 187
        Width = 24
        Height = 13
        Caption = 'Valor'
      end
      object btnBuscaBanco: TSpeedButton
        Left = 120
        Top = 95
        Width = 23
        Height = 22
        Glyph.Data = {
          36060000424D3606000000000000360000002800000020000000100000000100
          18000000000000060000120B0000120B00000000000000000000FF00FF314B62
          AC7D7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF777777BDBDBDFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5084B20F6FE1
          325F8CB87E7AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFABABAB9797978B8B8BC1C1C1FF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF32A0FE37A1FF
          106FE2325F8BB67D79FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFB8B8B8BCBCBC9898988A8A8AC0C0C0FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF37A4FE
          379FFF0E6DDE355F89BB7F79FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFBBBBBBBCBCBC9595958B8B8BC2C2C2FF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          37A4FE359EFF0F6FDE35608BA67B7FFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFBBBBBBBABABA9696968C8C8CBABABAFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF38A5FE329DFF156DCE444F5BFF00FF9C6B65AF887BAF887EAA8075FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBCBCBCB9B9B99494947E7E7EFF
          00FF979797AAAAAAABABABA5A5A5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF3BABFFA1CAE7AD8679A98373E0CFB1FFFFDAFFFFDDFCF8CFCCB2
          9FA1746BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBEBEBED1D1D1A8A8A8A3
          A3A3D4D4D4F1F1F1F2F2F2EBEBEBC5C5C59D9D9DFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFC0917DFCE9ACFFFFCCFFFFCFFFFFD0FFFFDEFFFF
          FAE3D3D1996965FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1B1B1DD
          DDDDEBEBEBECECECEDEDEDF2F2F2FDFDFDE3E3E3969696FF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFB08978FAD192FEF4C2FFFFD0FFFFDAFFFFF6FFFF
          FCFFFFFCB69384FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA9A9A9D1
          D1D1E7E7E7EDEDEDF1F1F1FBFBFBFEFEFEFEFEFEB1B1B1FF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFB08978FEDA97EDB478FBEEBBFFFFD3FFFFDCFFFFF4FFFF
          F4FFFFE2E9DDBCA67B73FF00FFFF00FFFF00FFFF00FFFF00FFA9A9A9D5D5D5C1
          C1C1E3E3E3EEEEEEF1F1F1FBFBFBFBFBFBF4F4F4DCDCDCA2A2A2FF00FFFF00FF
          FF00FFFF00FFFF00FFB18A78FFDE99E9A167F4D199FEFCCCFFFFD5FFFFDAFFFF
          DCFFFFD7EFE6C5A97E75FF00FFFF00FFFF00FFFF00FFFF00FFA9A9A9D6D6D6B7
          B7B7D2D2D2EBEBEBEFEFEFF1F1F1F1F1F1EFEFEFE2E2E2A4A4A4FF00FFFF00FF
          FF00FFFF00FFFF00FFAA7F73FAE0A4F0B778EEBA7BF6DDA6FEFBCCFFFFD3FFFF
          D1FFFFD7D9C5A7A3756CFF00FFFF00FFFF00FFFF00FFFF00FFA4A4A4D9D9D9C2
          C2C2C3C3C3D8D8D8EBEBEBEEEEEEEDEDEDEFEFEFCECECE9E9E9EFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFCEB293FFFEDDF4D1A5EEBA7BF2C78FF8E1ABFCF0
          BAFCFACAA3776FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC1C1C1F2
          F2F2D7D7D7C3C3C3CDCDCDDBDBDBE3E3E3E9E9E99F9F9FFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFA1746BE1D4D3FFFEEEF7CC8CF0B473F7C788FCE3
          A5C2A088A5776CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9D9D9DE2
          E2E2F8F8F8CECECEC0C0C0CCCCCCDADADAB7B7B79F9F9FFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF986865BA9587EAD7A4EAD59EE0C097A577
          6CA5776CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF96
          9696B3B3B3D3D3D3D0D0D0C9C9C99F9F9F9F9F9FFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA77E70A98073A4786EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFA2A2A2A3A3A39F9F9FFF00FFFF00FFFF00FFFF00FF}
        NumGlyphs = 2
        OnClick = btnBuscaBancoClick
      end
      object btnBuscaCliente: TSpeedButton
        Left = 120
        Top = 147
        Width = 23
        Height = 22
        Glyph.Data = {
          36060000424D3606000000000000360000002800000020000000100000000100
          18000000000000060000120B0000120B00000000000000000000FF00FF314B62
          AC7D7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF777777BDBDBDFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5084B20F6FE1
          325F8CB87E7AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFABABAB9797978B8B8BC1C1C1FF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF32A0FE37A1FF
          106FE2325F8BB67D79FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFB8B8B8BCBCBC9898988A8A8AC0C0C0FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF37A4FE
          379FFF0E6DDE355F89BB7F79FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFBBBBBBBCBCBC9595958B8B8BC2C2C2FF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          37A4FE359EFF0F6FDE35608BA67B7FFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFBBBBBBBABABA9696968C8C8CBABABAFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF38A5FE329DFF156DCE444F5BFF00FF9C6B65AF887BAF887EAA8075FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBCBCBCB9B9B99494947E7E7EFF
          00FF979797AAAAAAABABABA5A5A5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF3BABFFA1CAE7AD8679A98373E0CFB1FFFFDAFFFFDDFCF8CFCCB2
          9FA1746BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBEBEBED1D1D1A8A8A8A3
          A3A3D4D4D4F1F1F1F2F2F2EBEBEBC5C5C59D9D9DFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFC0917DFCE9ACFFFFCCFFFFCFFFFFD0FFFFDEFFFF
          FAE3D3D1996965FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1B1B1DD
          DDDDEBEBEBECECECEDEDEDF2F2F2FDFDFDE3E3E3969696FF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFB08978FAD192FEF4C2FFFFD0FFFFDAFFFFF6FFFF
          FCFFFFFCB69384FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA9A9A9D1
          D1D1E7E7E7EDEDEDF1F1F1FBFBFBFEFEFEFEFEFEB1B1B1FF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFB08978FEDA97EDB478FBEEBBFFFFD3FFFFDCFFFFF4FFFF
          F4FFFFE2E9DDBCA67B73FF00FFFF00FFFF00FFFF00FFFF00FFA9A9A9D5D5D5C1
          C1C1E3E3E3EEEEEEF1F1F1FBFBFBFBFBFBF4F4F4DCDCDCA2A2A2FF00FFFF00FF
          FF00FFFF00FFFF00FFB18A78FFDE99E9A167F4D199FEFCCCFFFFD5FFFFDAFFFF
          DCFFFFD7EFE6C5A97E75FF00FFFF00FFFF00FFFF00FFFF00FFA9A9A9D6D6D6B7
          B7B7D2D2D2EBEBEBEFEFEFF1F1F1F1F1F1EFEFEFE2E2E2A4A4A4FF00FFFF00FF
          FF00FFFF00FFFF00FFAA7F73FAE0A4F0B778EEBA7BF6DDA6FEFBCCFFFFD3FFFF
          D1FFFFD7D9C5A7A3756CFF00FFFF00FFFF00FFFF00FFFF00FFA4A4A4D9D9D9C2
          C2C2C3C3C3D8D8D8EBEBEBEEEEEEEDEDEDEFEFEFCECECE9E9E9EFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFCEB293FFFEDDF4D1A5EEBA7BF2C78FF8E1ABFCF0
          BAFCFACAA3776FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC1C1C1F2
          F2F2D7D7D7C3C3C3CDCDCDDBDBDBE3E3E3E9E9E99F9F9FFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFA1746BE1D4D3FFFEEEF7CC8CF0B473F7C788FCE3
          A5C2A088A5776CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9D9D9DE2
          E2E2F8F8F8CECECEC0C0C0CCCCCCDADADAB7B7B79F9F9FFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF986865BA9587EAD7A4EAD59EE0C097A577
          6CA5776CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF96
          9696B3B3B3D3D3D3D0D0D0C9C9C99F9F9F9F9F9FFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA77E70A98073A4786EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFA2A2A2A3A3A39F9F9FFF00FFFF00FFFF00FFFF00FF}
        NumGlyphs = 2
        OnClick = btnBuscaClienteClick
      end
      object Label4: TLabel
        Left = 149
        Top = 80
        Width = 29
        Height = 13
        Caption = 'Banco'
      end
      object Label5: TLabel
        Left = 360
        Top = 128
        Width = 31
        Height = 13
        Caption = 'Label5'
      end
      object Label6: TLabel
        Left = 152
        Top = 33
        Width = 78
        Height = 13
        Caption = 'Data Movimento'
      end
      object edtCodigo: TLabeledEdit
        Tag = 1
        Left = 19
        Top = 48
        Width = 62
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        Enabled = False
        NumbersOnly = True
        TabOrder = 0
      end
      object edtBanco: TMaskEdit
        Left = 19
        Top = 96
        Width = 95
        Height = 21
        Enabled = False
        TabOrder = 1
        Text = ''
      end
      object edtCliente: TMaskEdit
        Left = 19
        Top = 148
        Width = 95
        Height = 21
        Enabled = False
        TabOrder = 2
        Text = ''
      end
      object edtValor: TCurrencyEdit
        Tag = 3
        Left = 19
        Top = 206
        Width = 121
        Height = 21
        TabOrder = 3
      end
      object edtNomeCliente: TEdit
        Tag = 2
        Left = 149
        Top = 147
        Width = 291
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 4
      end
      object edtNomeBanco: TEdit
        Tag = 2
        Left = 149
        Top = 96
        Width = 291
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 5
      end
      object edtNumConta: TLabeledEdit
        Tag = 2
        Left = 459
        Top = 96
        Width = 158
        Height = 21
        Color = clBtnFace
        EditLabel.Width = 69
        EditLabel.Height = 13
        EditLabel.Caption = 'N'#250'mero Conta'
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 6
      end
      object rdgCredDeb: TRadioGroup
        Tag = 3
        Left = 165
        Top = 187
        Width = 158
        Height = 43
        Caption = 'Tipo Movimento'
        Columns = 2
        Items.Strings = (
          'Cr'#233'dito'
          'D'#233'bito')
        TabOrder = 7
      end
      object dtpDataMovimento: TDateTimePicker
        Left = 152
        Top = 48
        Width = 113
        Height = 21
        Date = 44991.000000000000000000
        Time = 0.600405173609033200
        TabOrder = 8
      end
    end
  end
  inherited Panel1: TPanel
    Width = 753
    ExplicitWidth = 753
    inherited btnExcluir: TButton
      Anchors = [akLeft]
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
    inherited btnSair: TButton
      Left = 633
      Anchors = [akRight]
      ExplicitLeft = 633
    end
  end
  inherited QryListagemGrid: TZQuery
    Active = True
    SQL.Strings = (
      ''
      'SELECT MC.IdMovContas,'
      '       CL.IdCliente,'
      '       CL.nome AS cliente,'
      '       BC.IdBanco,'
      '       BC.nome AS banco,'
      '       CC.numConta,'
      '       MC.valor,'
      '       MC.tipoMov,'
      '       MC.dataMov'
      '  FROM movContas AS MC,'
      '       contas    AS CC,'
      '       clientes  AS CL,'
      '       bancos    AS BC'
      ' WHERE MC.IdConta = CC.IdConta'
      '   AND CC.IdCliente = CL.IdCliente'
      '   AND CC.IdBanco = BC.IdBanco;'
      '')
    Top = 240
    object QryListagemGridIdMovContas: TLargeintField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'IdMovContas'
    end
    object QryListagemGridIdCliente: TLargeintField
      FieldName = 'IdCliente'
      Visible = False
    end
    object QryListagemGridcliente: TWideStringField
      DisplayLabel = 'Cliente'
      FieldName = 'cliente'
      Required = True
      Size = 50
    end
    object QryListagemGridIdBanco: TLargeintField
      FieldName = 'IdBanco'
      Visible = False
    end
    object QryListagemGridbanco: TWideStringField
      DisplayLabel = 'Banco'
      FieldName = 'banco'
      Required = True
      Size = 50
    end
    object QryListagemGridnumConta: TLargeintField
      DisplayLabel = 'Nr Conta'
      FieldName = 'numConta'
      Required = True
    end
    object QryListagemGridvalor: TFloatField
      DisplayLabel = 'Valor(R$)'
      FieldName = 'valor'
      DisplayFormat = '#,###0.00'
    end
    object QryListagemGridtipoMov: TWideStringField
      DisplayLabel = 'Tipo Movimento'
      FieldName = 'tipoMov'
      Required = True
      Size = 1
    end
    object QryListagemGriddataMov: TWideStringField
      DisplayLabel = 'Data Movimento'
      FieldName = 'dataMov'
      ReadOnly = True
      Size = 10
    end
  end
  inherited DtsListagemGrid: TDataSource
    Left = 436
    Top = 240
  end
end
