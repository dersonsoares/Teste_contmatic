object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Pedidos'
  ClientHeight = 418
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 49
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 633
      Height = 47
      Align = alClient
      Alignment = taCenter
      Caption = 'Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 121
      ExplicitHeight = 42
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 635
    Height = 67
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 4
      Top = 3
      Width = 149
      Height = 46
      Caption = 'C'#243'digo'
      Enabled = False
      TabOrder = 0
      object edtNumPedido: TEdit
        Left = 4
        Top = 14
        Width = 139
        Height = 27
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 377
    Width = 635
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnFechar: TBitBtn
      Left = 528
      Top = 6
      Width = 99
      Height = 25
      Caption = 'Fechar'
      TabOrder = 0
    end
    object btnGravarPedido: TBitBtn
      Left = 423
      Top = 6
      Width = 99
      Height = 25
      Caption = 'Gravar (F12)'
      TabOrder = 1
      OnClick = btnGravarPedidoClick
    end
    object btnNovoPedido: TBitBtn
      Left = 318
      Top = 6
      Width = 99
      Height = 25
      Caption = 'Novo (F10)'
      TabOrder = 2
      OnClick = btnNovoPedidoClick
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 116
    Width = 153
    Height = 261
    Align = alLeft
    BevelOuter = bvLowered
    TabOrder = 3
    object btnAddItem: TBitBtn
      Left = 8
      Top = 6
      Width = 136
      Height = 25
      Caption = 'Adicionar (F3)'
      TabOrder = 0
      OnClick = btnAddItemClick
    end
    object btnEditarItem: TBitBtn
      Left = 7
      Top = 32
      Width = 136
      Height = 25
      Caption = 'Editar (F4)'
      TabOrder = 1
      OnClick = btnEditarItemClick
    end
    object btnRemoverItem: TBitBtn
      Left = 8
      Top = 58
      Width = 136
      Height = 25
      Caption = 'Remover (F5)'
      TabOrder = 2
      OnClick = btnRemoverItemClick
    end
  end
  object Panel5: TPanel
    Left = 153
    Top = 116
    Width = 482
    Height = 261
    Align = alClient
    TabOrder = 4
    object Panel6: TPanel
      Left = 1
      Top = 219
      Width = 480
      Height = 41
      Align = alBottom
      BevelOuter = bvLowered
      TabOrder = 0
      object lblTotal: TLabel
        Left = 269
        Top = 14
        Width = 43
        Height = 19
        Caption = 'Total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtTotal: TCurrencyEdit
        Left = 320
        Top = 11
        Width = 154
        Height = 27
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Value = 1500.000000000000000000
      end
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 480
      Height = 218
      Align = alClient
      DataSource = ds_Itens
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'codigo'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Title.Caption = 'Produto'
          Width = 185
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'qtde'
          Title.Caption = 'Quantidade'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vlUnit'
          Title.Caption = 'Vl. Unit'#225'rio'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vltotal'
          Title.Caption = 'Vl. Total'
          Visible = True
        end>
    end
  end
  object gbxCliente: TGroupBox
    Left = 156
    Top = 52
    Width = 472
    Height = 46
    Caption = 'Cliente'
    TabOrder = 5
    object edtNmCliente: TEdit
      Left = 5
      Top = 14
      Width = 420
      Height = 27
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object btnAddCliente: TBitBtn
      Left = 428
      Top = 14
      Width = 41
      Height = 27
      Caption = '+'
      TabOrder = 1
      OnClick = btnAddClienteClick
    end
  end
  object mem_Itens: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 505
    Top = 244
    object mem_Itenscodigo: TIntegerField
      FieldName = 'codigo'
    end
    object mem_Itensdescricao: TStringField
      FieldName = 'descricao'
      Size = 255
    end
    object mem_Itensqtde: TFloatField
      FieldName = 'qtde'
    end
    object mem_ItensvlUnit: TCurrencyField
      FieldName = 'vlUnit'
    end
    object mem_Itensvltotal: TCurrencyField
      FieldName = 'vltotal'
    end
  end
  object ds_Itens: TDataSource
    DataSet = mem_Itens
    Left = 505
    Top = 292
  end
end
