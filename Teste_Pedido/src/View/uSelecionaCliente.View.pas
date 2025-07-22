unit uSelecionaCliente.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, uDMConexao;

type
  TfrmSelecionarCliente = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    qry_Clientes: TFDQuery;
    ds_Clientes: TDataSource;
    qry_ClientesCodigo: TIntegerField;
    qry_ClientesNome: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    FNomeSelecionado: string;
    FCodigoSelecionado: Integer;
    { Private declarations }

  public
    { Public declarations }
    property CodigoSelecionado: Integer read FCodigoSelecionado;
    property NomeSelecionado: string read FNomeSelecionado;
  end;

var
  frmSelecionarCliente: TfrmSelecionarCliente;

implementation

{$R *.dfm}

{ TForm2 }

procedure TfrmSelecionarCliente.BitBtn1Click(Sender: TObject);
begin
  FCodigoSelecionado := qry_Clientes.FieldByName('Codigo').AsInteger;
  FNomeSelecionado := qry_Clientes.FieldByName('Nome').AsString;
end;

procedure TfrmSelecionarCliente.FormCreate(Sender: TObject);
begin
  qry_Clientes.Connection:= DMConexao.Conexao;
  qry_Clientes.Open;
end;

end.
