object frmSelecionarCliente: TfrmSelecionarCliente
  Left = 0
  Top = 0
  Caption = 'Selecionar Clientes...'
  ClientHeight = 294
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 253
    Width = 527
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitLeft = 312
    ExplicitTop = 240
    ExplicitWidth = 185
    object BitBtn1: TBitBtn
      Left = 374
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Selecionar'
      ModalResult = 1
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 449
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Fechar'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 527
    Height = 253
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 312
    ExplicitTop = 240
    ExplicitWidth = 185
    ExplicitHeight = 41
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 525
      Height = 251
      Align = alClient
      DataSource = ds_Clientes
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Codigo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Nome'
          Width = 425
          Visible = True
        end>
    end
  end
  object qry_Clientes: TFDQuery
    SQL.Strings = (
      'Select Codigo,'
      '           Cast(Nome as Varchar(500)) as Nome'
      'from Clientes')
    Left = 336
    Top = 88
    object qry_ClientesCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object qry_ClientesNome: TWideStringField
      FieldName = 'Nome'
      Size = 500
    end
  end
  object ds_Clientes: TDataSource
    DataSet = qry_Clientes
    Left = 336
    Top = 136
  end
end
