object frmPDV: TfrmPDV
  Left = 685
  Top = 147
  AutoSize = True
  BorderStyle = bsDialog
  Caption = 'Form Padr'#227'o'
  ClientHeight = 768
  ClientWidth = 1269
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    1269
    768)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl2: TLabel
    Left = 847
    Top = 67
    Width = 155
    Height = 56
    Anchors = [akTop]
    Caption = 'VENDA'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -40
    Font.Name = 'Arial Black'
    Font.Style = []
    ParentFont = False
  end
  object lbl9: TLabel
    Left = 1079
    Top = 67
    Width = 81
    Height = 56
    Anchors = [akTop]
    Caption = '001'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -40
    Font.Name = 'Arial Black'
    Font.Style = []
    ParentFont = False
    ExplicitLeft = 1077
  end
  object lbl11: TLabel
    Left = 1062
    Top = 5
    Width = 81
    Height = 56
    Anchors = [akTop]
    Caption = '001'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -40
    Font.Name = 'Arial Black'
    Font.Style = []
    ParentFont = False
    ExplicitLeft = 1063
  end
  object lbl12: TLabel
    Left = 865
    Top = 5
    Width = 166
    Height = 56
    Anchors = [akTop]
    Caption = 'CAIXA -'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -40
    Font.Name = 'Arial Black'
    Font.Style = []
    ParentFont = False
  end
  object lbl13: TLabel
    Left = 1073
    Top = 13
    Width = 81
    Height = 56
    Anchors = [akTop]
    Caption = '001'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -40
    Font.Name = 'Arial Black'
    Font.Style = []
    ParentFont = False
    ExplicitLeft = 1081
  end
  object lbl14: TLabel
    Left = 870
    Top = 13
    Width = 166
    Height = 56
    Anchors = [akTop]
    Caption = 'CAIXA -'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -40
    Font.Name = 'Arial Black'
    Font.Style = []
    ParentFont = False
    ExplicitLeft = 881
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 1269
    Height = 183
    Align = alTop
    AutoSize = True
    Color = clHotLight
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      1269
      183)
    object lbl1: TLabel
      Left = 969
      Top = 1
      Width = 166
      Height = 56
      Anchors = [akTop]
      Caption = 'CAIXA -'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -40
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
    end
    object lblCaixa: TLabel
      Left = 1165
      Top = 1
      Width = 81
      Height = 56
      Anchors = [akTop]
      Caption = '001'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -40
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
    end
    object lbl8: TLabel
      Left = 277
      Top = 31
      Width = 123
      Height = 38
      Anchors = [akTop]
      Caption = 'VENDA -'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -27
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
    end
    object lblVenda: TLabel
      Left = 417
      Top = 31
      Width = 54
      Height = 38
      Anchors = [akTop]
      Caption = '000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -27
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
    end
    object lbl10: TLabel
      Left = 299
      Top = 63
      Width = 101
      Height = 38
      Anchors = [akTop]
      Caption = 'DATA -'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -27
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
    end
    object lblData: TLabel
      Left = 417
      Top = 63
      Width = 124
      Height = 38
      Anchors = [akTop]
      Caption = '00/00/00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -27
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
    end
    object lbl16: TLabel
      Left = 250
      Top = 1
      Width = 150
      Height = 38
      Anchors = [akTop]
      Caption = 'CLIENTE -'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -27
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
    end
    object lblCod_Cli: TLabel
      Left = 417
      Top = 1
      Width = 54
      Height = 38
      Anchors = [akTop]
      Caption = '000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -27
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
    end
    object lbl28: TLabel
      Left = 662
      Top = 94
      Width = 328
      Height = 28
      Anchors = [akTop]
      Caption = 'C'#243'digo de barra * Quantidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -20
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
    end
    object pnl2: TPanel
      Left = 8
      Top = 5
      Width = 190
      Height = 177
      Caption = 'Imagem'
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
    end
    object edtConsulta: TEdit
      Left = 662
      Top = 128
      Width = 587
      Height = 48
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnKeyPress = edtConsultaKeyPress
    end
  end
  object pnl3: TPanel
    Left = 0
    Top = 183
    Width = 642
    Height = 472
    Align = alLeft
    AutoSize = True
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 1
    object pnlGrid: TPanel
      Left = 5
      Top = 5
      Width = 632
      Height = 462
      Align = alClient
      BorderWidth = 5
      Color = clHotLight
      ParentBackground = False
      TabOrder = 0
      object grddbgrd: TDBGrid
        Left = 6
        Top = 6
        Width = 620
        Height = 450
        Align = alClient
        DataSource = dm.dtsItem_Venda
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgColumnResize, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnCellClick = grddbgrdCellClick
        OnDblClick = grddbgrdDblClick
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'ID_ITEM'
            Title.Alignment = taCenter
            Title.Caption = 'Item'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 77
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESC_PROD'
            Title.Alignment = taCenter
            Title.Caption = 'Descri'#231#227'o'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 239
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'QTDE'
            Title.Alignment = taCenter
            Title.Caption = 'Qtde'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VAL_PROD'
            Title.Alignment = taCenter
            Title.Caption = 'Valor Unit'#225'rio'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 115
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TOTAL_PROD'
            Title.Alignment = taCenter
            Title.Caption = 'SubTotal'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 102
            Visible = True
          end>
      end
    end
  end
  object pnl4: TPanel
    Left = 642
    Top = 183
    Width = 627
    Height = 472
    Align = alClient
    AutoSize = True
    BevelOuter = bvNone
    BorderWidth = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -47
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object lbl3: TLabel
      Left = 20
      Top = 374
      Width = 587
      Height = 28
      Align = alTop
      Caption = 'Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 56
    end
    object lbl4: TLabel
      Left = 20
      Top = 20
      Width = 587
      Height = 28
      Align = alTop
      Caption = 'Status'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 70
    end
    object lbl5: TLabel
      Left = 20
      Top = 104
      Width = 587
      Height = 28
      Align = alTop
      Caption = 'Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 84
    end
    object lbl6: TLabel
      Left = 20
      Top = 281
      Width = 587
      Height = 28
      Align = alTop
      Caption = 'SubTotal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 96
    end
    object lbl7: TLabel
      Left = 20
      Top = 188
      Width = 587
      Height = 28
      Align = alTop
      Caption = 'Valor Unit'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 153
    end
    object edtStatus: TEdit
      Left = 20
      Top = 48
      Width = 587
      Height = 56
      Margins.Left = 5
      Margins.Right = 5
      Align = alTop
      Alignment = taCenter
      Color = clHotLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -40
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = 'Caixa Livre'
    end
    object edtProduto: TEdit
      Left = 20
      Top = 132
      Width = 587
      Height = 56
      Margins.Left = 5
      Margins.Right = 5
      Align = alTop
      Alignment = taCenter
      Color = clHotLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -40
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtValor_Unitario: TEdit
      Left = 20
      Top = 216
      Width = 587
      Height = 65
      Margins.Left = 5
      Margins.Right = 5
      Align = alTop
      Alignment = taRightJustify
      Color = clHotLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -47
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object edtSub_total: TEdit
      Left = 20
      Top = 309
      Width = 587
      Height = 65
      Margins.Left = 5
      Margins.Right = 5
      Align = alTop
      Alignment = taRightJustify
      Color = clHotLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -47
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object edtTotal: TEdit
      Left = 20
      Top = 402
      Width = 587
      Height = 65
      Margins.Left = 5
      Margins.Right = 5
      Alignment = taRightJustify
      Color = clHotLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -47
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
  end
  object pnl5: TPanel
    Left = 0
    Top = 655
    Width = 1269
    Height = 113
    Align = alBottom
    AutoSize = True
    BorderWidth = 15
    Color = clHotLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    object lbl15: TLabel
      Left = 973
      Top = 74
      Width = 123
      Height = 23
      Caption = 'ESC - FECHAR'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl17: TLabel
      Left = 26
      Top = 16
      Width = 239
      Height = 23
      Caption = 'F1 - CONSULTAR ESTOQUE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl18: TLabel
      Left = 26
      Top = 45
      Width = 170
      Height = 23
      Caption = 'F2 - INICIAR VENDA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl19: TLabel
      Left = 26
      Top = 74
      Width = 198
      Height = 23
      Caption = 'F3 - FINALIZAR VENDA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl20: TLabel
      Left = 342
      Top = 16
      Width = 242
      Height = 23
      Caption = 'F4 - ALTERAR QUANTIDADE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl21: TLabel
      Left = 342
      Top = 45
      Width = 217
      Height = 23
      Caption = 'F5 - GERAR OR'#199'AMENTO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl22: TLabel
      Left = 342
      Top = 74
      Width = 199
      Height = 23
      Caption = 'F6 - CANCELAR VENDA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl23: TLabel
      Left = 679
      Top = 16
      Width = 196
      Height = 23
      Caption = 'DEL - CANCELAR ITEM'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl24: TLabel
      Left = 679
      Top = 45
      Width = 202
      Height = 23
      Caption = 'F8 - INCLUIR PRODUTO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl25: TLabel
      Left = 679
      Top = 74
      Width = 201
      Height = 23
      Caption = 'F9 - PROCURAR VENDA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl26: TLabel
      Left = 973
      Top = 16
      Width = 150
      Height = 23
      Caption = 'F10 - GERAR NFE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl27: TLabel
      Left = 973
      Top = 45
      Width = 287
      Height = 23
      Caption = 'F11 - ALTERAR VENDA GRAVADA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end