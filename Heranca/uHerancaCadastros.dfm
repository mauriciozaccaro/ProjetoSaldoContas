object frmHerancaCadastros: TfrmHerancaCadastros
  Left = 0
  Top = 0
  Caption = 'frmHerancaCadastros'
  ClientHeight = 382
  ClientWidth = 659
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 659
    Height = 291
    ActivePage = tabListagem
    Align = alClient
    TabOrder = 0
    object tabListagem: TTabSheet
      Caption = 'tabListagem'
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 651
        Height = 72
        Align = alTop
        TabOrder = 0
        object lblIndice: TLabel
          Left = 16
          Top = 16
          Width = 46
          Height = 13
          Caption = 'Pesquisar'
        end
        object mskEdit: TMaskEdit
          Left = 16
          Top = 32
          Width = 273
          Height = 21
          TabOrder = 0
          Text = ''
          TextHint = 'Clique sobre a coluna que deseja pesquisar...'
        end
      end
      object grdListagemGrid: TDBGrid
        Left = 0
        Top = 72
        Width = 651
        Height = 191
        Align = alClient
        DataSource = DtsListagemGrid
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object tabCadastro: TTabSheet
      Caption = 'tabCadastro'
      ImageIndex = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 291
    Width = 659
    Height = 91
    Align = alBottom
    Color = clInactiveCaption
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      659
      91)
    object btnCancelar: TButton
      Left = 207
      Top = 46
      Width = 75
      Height = 25
      Caption = '&CANCELAR'
      TabOrder = 0
    end
    object btnFechar: TButton
      Left = 369
      Top = 46
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&FECHAR'
      TabOrder = 1
    end
    object btnNavigator: TDBNavigator
      Left = 127
      Top = 15
      Width = 236
      Height = 25
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 2
    end
    object btnExcluir: TButton
      Left = 569
      Top = 46
      Width = 75
      Height = 25
      Caption = '&EXCLUIR'
      TabOrder = 3
    end
    object btnGravar: TButton
      Left = 288
      Top = 46
      Width = 75
      Height = 25
      Caption = '&GRAVAR'
      TabOrder = 4
    end
    object btnAlterar: TButton
      Left = 126
      Top = 46
      Width = 75
      Height = 25
      Caption = '&ALTERAR'
      TabOrder = 5
    end
    object btnNovo: TButton
      Left = 45
      Top = 46
      Width = 75
      Height = 25
      Caption = '&NOVO'
      TabOrder = 6
    end
  end
  object QryListagemGrid: TZQuery
    Connection = DtmConexaoPrincipal.ConexaoDB
    Params = <>
    Left = 364
    Top = 32
  end
  object DtsListagemGrid: TDataSource
    DataSet = QryListagemGrid
    Left = 460
    Top = 32
  end
end
