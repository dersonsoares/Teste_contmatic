unit uPrincipal.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.DBGrids, Vcl.Mask, RxToolEdit, RxCurrEdit, PedidosController, Pedidos,
  ItensPedido, IProdutosRepository, IPedidosRepository, PedidoRepositoryData;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    btnFechar: TBitBtn;
    btnGravarPedido: TBitBtn;
    btnAddItem: TBitBtn;
    btnEditarItem: TBitBtn;
    btnRemoverItem: TBitBtn;
    GroupBox1: TGroupBox;
    gbxCliente: TGroupBox;
    Label1: TLabel;
    edtNumPedido: TEdit;
    edtNmCliente: TEdit;
    btnNovoPedido: TBitBtn;
    btnAddCliente: TBitBtn;
    mem_Itens: TFDMemTable;
    ds_Itens: TDataSource;
    DBGrid1: TDBGrid;
    mem_Itenscodigo: TIntegerField;
    mem_Itensdescricao: TStringField;
    mem_Itensqtde: TFloatField;
    edtTotal: TCurrencyEdit;
    lblTotal: TLabel;
    mem_ItensvlUnit: TCurrencyField;
    mem_Itensvltotal: TCurrencyField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNovoPedidoClick(Sender: TObject);
    procedure btnAddClienteClick(Sender: TObject);
    procedure btnAddItemClick(Sender: TObject);
    function GetDescricaoProduto(ACodProduto: Integer): String;
    procedure btnRemoverItemClick(Sender: TObject);
    procedure btnEditarItemClick(Sender: TObject);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FController: IPedidoController;
    procedure AtualizarGrid;
    procedure AtualizarTotal;
    procedure CarregarItemParaGrid(AItem: TItensPedido);
    Procedure ControlarStatusBotoes;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses uDMConexao, uSelecionaCliente.View, uSelecionaProduto.View, ObjetosUteis;

{$R *.dfm}

{ TForm1 }

procedure TfrmPrincipal.AtualizarGrid;
var
  Item: TItensPedido;
begin
  mem_Itens.DisableControls;
  try
    mem_Itens.EmptyDataSet;
    for Item in FController.GetItens do
      CarregarItemParaGrid(Item);
  finally
    mem_Itens.EnableControls;
  end;
end;

procedure TfrmPrincipal.AtualizarTotal;
begin
  EdtTotal.Value := FController.GetPedidoAtual.Total;
end;

procedure TfrmPrincipal.btnAddClienteClick(Sender: TObject);
var
  frm: TfrmSelecionarCliente;
begin
  frm := TfrmSelecionarCliente.Create(nil);
  try
    if frm.ShowModal = mrOk then
    begin
      FController.GetPedidoAtual.CodigoCliente := frm.CodigoSelecionado;
      edtNmCliente.Clear;
      edtNmCliente.Text := frm.NomeSelecionado;
    end;
  finally
    frm.Free;
  end;
end;

procedure TfrmPrincipal.btnAddItemClick(Sender: TObject);
var
  frm: TfrmSelecionarProduto;
begin
  frm := TfrmSelecionarProduto.Create(nil);
  try
    if frm.ShowModal = mrOk then
    begin
      FController.AdicionarItem(frm.Codigo, frm.Qtde, frm.Valor);
      AtualizarGrid;
      AtualizarTotal;
    end;
  finally
    frm.Free;
  end;
end;

procedure TfrmPrincipal.btnEditarItemClick(Sender: TObject);
var
  Index: Integer;
  Qtd, Vlr: Double;
begin
  if mem_Itens.IsEmpty then
    Exit;

  Index := mem_Itens.RecNo - 1;
  Qtd := StrToFloatDef(InputBox('Quantidade', 'Informe a nova quantidade:', mem_Itens.FieldByName('qtde').AsString), 1);
  Vlr := StrToFloatDef(InputBox('Valor Unitário', 'Informe o novo valor unitário:', mem_Itens.FieldByName('vlUnit').AsString), 0);

  FController.EditarItem(Index, Qtd, Vlr);
  AtualizarGrid;
  AtualizarTotal;
end;

procedure TfrmPrincipal.btnGravarPedidoClick(Sender: TObject);
begin
   try
    FController.SalvarPedido;
    ShowMessage('Pedido salvo com sucesso!');
    Close;
  except
    on E: Exception do
      ShowMessage('Erro ao salvar: ' + E.Message);
  end;
end;

procedure TfrmPrincipal.btnNovoPedidoClick(Sender: TObject);
begin
  FController.NovoPedido;
  btnNovoPedido.Enabled := False;
  edtNumPedido.Text := IntToStr(FController.GetPedidoAtual.Numero);
  ControlarStatusBotoes;
  AtualizarTotal;
end;

procedure TfrmPrincipal.btnRemoverItemClick(Sender: TObject);
var
  Index: Integer;
begin
  if mem_Itens.IsEmpty then
    Exit;

  if MessageDlg('Deseja realmente excluir este item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Index := mem_Itens.RecNo - 1;
    FController.RemoverItem(Index);
    AtualizarGrid;
    AtualizarTotal;
  end;
end;

procedure TfrmPrincipal.CarregarItemParaGrid(AItem: TItensPedido);
begin
  mem_Itens.Append;
  mem_Itens.FieldByName('Codigo').AsInteger := AItem.CodigoProduto;
  mem_Itens.FieldByName('Descricao').AsString := GetDescricaoProduto(AItem.CodigoProduto);
  mem_Itens.FieldByName('qtde').AsFloat := AItem.Quantidade;
  mem_Itens.FieldByName('vlUnit').AsFloat := AItem.ValorUnitario;
  mem_Itens.FieldByName('VlTotal').AsFloat := AItem.ValorTotal;
  mem_Itens.Post;
end;

procedure TfrmPrincipal.ControlarStatusBotoes;
begin
  btnAddItem.Enabled := not btnNovoPedido.Enabled;
  btnEditarItem.Enabled := btnAddItem.Enabled;
  btnRemoverItem.Enabled := btnAddItem.Enabled;
  btnGravarPedido.Enabled := btnAddItem.Enabled;
  gbxCliente.Enabled := btnAddItem.Enabled;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  DMConexao := TDMConexao.Create(Application);
  FController := TPedidoController.Create(TPedidoRepositoryData.Create(DMConexao.Conexao));
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F3) then
  begin
    if btnAddItem.Enabled then
      btnAddItemClick(Self);
  end
  else if (Key = VK_F4) then
  begin
    if btnEditarItem.Enabled then
      btnEditarItemClick(Self);
  end
  else if (Key = VK_F5) then
  begin
    if btnRemoverItem.Enabled then
      btnRemoverItemClick(Self);
  end
  else if (Key = VK_F10) then
  begin
    if btnNovoPedido.Enabled then
      btnNovoPedidoClick(Self);
  end
  else if (Key = VK_F12) then
  begin
    if btnGravarPedido.Enabled then
      btnGravarPedidoClick(Self);
  end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  mem_Itens.Close;
  mem_Itens.Open;
  btnNovoPedido.SetFocus;
  ControlarStatusBotoes;
end;

function TfrmPrincipal.GetDescricaoProduto(ACodProduto: Integer): String;
var
  DataSet: TFDQuery;
begin
  Result:= EmptyStr;
  try
    CreateDataset(DataSet, DMConexao.Conexao);
    DataSet.SQL.Clear;
    DataSet.SQL.Add('Select Descricao from Produtos where Codigo = :Codigo');
    DataSet.Params.ParamByName('Codigo').Value := ACodProduto;
    DataSet.Open;

    if not DataSet.IsEmpty then
      Result:= DataSet.FieldByName('Descricao').AsString;
  finally
    FreeDataset(DataSet);
  end;
end;

end.
