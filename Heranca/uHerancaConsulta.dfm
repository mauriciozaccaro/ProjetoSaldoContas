object frmHerancaConsulta: TfrmHerancaConsulta
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'frmHerancaConsulta'
  ClientHeight = 282
  ClientWidth = 408
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 408
    Height = 57
    Align = alTop
    Color = clInactiveCaption
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 441
    object lblPesquisa: TLabel
      Left = 6
      Top = 16
      Width = 50
      Height = 13
      Caption = 'Pesquisa..'
    end
    object MaskEdit1: TMaskEdit
      Left = 1
      Top = 35
      Width = 406
      Height = 21
      Align = alBottom
      TabOrder = 0
      Text = 'MaskEdit1'
      ExplicitLeft = 0
      ExplicitTop = 40
      ExplicitWidth = 121
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 241
    Width = 408
    Height = 41
    Align = alBottom
    Color = clInactiveCaption
    ParentBackground = False
    TabOrder = 1
    ExplicitLeft = 56
    ExplicitTop = 224
    ExplicitWidth = 185
    DesignSize = (
      408
      41)
    object btnFechar: TButton
      Left = 319
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight]
      Caption = '&FECHAR'
      TabOrder = 0
      ExplicitLeft = 352
    end
  end
  object grdListagemConsulta: TDBGrid
    Left = 0
    Top = 57
    Width = 408
    Height = 184
    Align = alClient
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
end
