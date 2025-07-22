unit uSelecionaProduto.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.StdCtrls, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,uDMConexao;

type
  TfrmSelecionarProduto = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    qry_Produtos: TFDQuery;
    qry_ProdutosCodigo: TIntegerField;
    ds_Produtos: TDataSource;
    qry_ProdutosPrecoVenda: TCurrencyField;
    GroupBox1: TGroupBox;
    edtPesquisa: TEdit;
    BitBtn3: TBitBtn;
    qry_Produtosdescricao: TWideStringField;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FCodigo: Integer;
    FValor: Currency;
    FNome: String;
    FQtde: Currency;
    { Private declarations }
    procedure Filtrar;
  public
    { Public declarations }
    property Codigo : Integer read FCodigo write FCodigo;
    property Nome   : String  read FNome   write FNome;
    property Valor  : Currency read FValor write FValor;
    property Qtde   : Currency read FQtde  write FQtde;
  end;

var
  frmSelecionarProduto: TfrmSelecionarProduto;

implementation

{$R *.dfm}

{ TForm2 }

procedure TfrmSelecionarProduto.BitBtn1Click(Sender: TObject);
var
  InputStr: String;
  Numero: Integer;
begin
  if not qry_Produtos.IsEmpty then
  begin
    Numero := 0;
    repeat
      InputStr := InputBox('Digite Quantidade', 'Quantidade:', '1');
    until TryStrToInt(InputStr, Numero);
    FQtde := Numero;
    FCodigo := qry_ProdutosCodigo.AsInteger;
    FNome   := qry_ProdutosDescricao.AsString;
    FValor  := qry_ProdutosPrecoVenda.AsCurrency;
  end;
end;

procedure TfrmSelecionarProduto.BitBtn3Click(Sender: TObject);
begin
  Filtrar;
end;

procedure TfrmSelecionarProduto.Filtrar;
begin
  qry_Produtos.Filtered:= False;
  if edtPesquisa.Text <> EmptyStr then
    qry_Produtos.Filter := 'Descricao like ''%''' + edtPesquisa.Text + '''%''';
  qry_Produtos.Filtered:= True;
end;

procedure TfrmSelecionarProduto.FormCreate(Sender: TObject);
begin
  qry_Produtos.Connection:= DMConexao.Conexao;
  qry_Produtos.Open;
end;

end.
