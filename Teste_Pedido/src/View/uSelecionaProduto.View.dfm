object frmSelecionarProduto: TfrmSelecionarProduto
  Left = 0
  Top = 0
  Caption = 'Selecionar Produtos'
  ClientHeight = 367
  ClientWidth = 596
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 596
    Height = 285
    Align = alClient
    DataSource = ds_Produtos
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
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Caption = 'Produto'
        Width = 398
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PrecoVenda'
        Title.Caption = 'Pre'#231'o'
        Width = 109
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 326
    Width = 596
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 436
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Selecionar'
      ModalResult = 1
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 513
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Fechar'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 596
    Height = 41
    Align = alTop
    Caption = 'Pesquisar Produto'
    TabOrder = 2
    object edtPesquisa: TEdit
      Left = 4
      Top = 14
      Width = 505
      Height = 21
      TabOrder = 0
    end
    object BitBtn3: TBitBtn
      Left = 515
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Pesquisar'
      ModalResult = 2
      TabOrder = 1
      OnClick = BitBtn3Click
    end
  end
  object qry_Produtos: TFDQuery
    Connection = DMConexao.Conexao
    SQL.Strings = (
      'Select Codigo,'
      '           Cast(Descricao as varchar(200)) as Descricao,'
      '           PrecoVenda'
      'from Produtos')
    Left = 336
    Top = 88
    object qry_ProdutosCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object qry_ProdutosPrecoVenda: TCurrencyField
      FieldName = 'PrecoVenda'
    end
    object qry_Produtosdescricao: TWideStringField
      FieldName = 'descricao'
      Size = 200
    end
  end
  object ds_Produtos: TDataSource
    DataSet = qry_Produtos
    Left = 336
    Top = 136
  end
end
