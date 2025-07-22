unit ProdutoRepositoryData;

interface

uses
  System.Generics.Collections, FireDAC.Comp.Client, Produtos, ObjetosUteis,
  IProdutosRepository;

type
  TProdutoRepositorySQLite = class(TInterfacedObject, IProdutoRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    function GetProdutoId(const ACodigo: Integer): TProdutos;
    function GetTodos: TObjectList<TProdutos>;
    procedure Adicionar(AProduto: TProdutos);
    procedure Editar(AProduto: TProdutos);
    procedure Deletar(const ACodigo: Integer);
  end;

implementation

uses
  System.SysUtils;

{ ProdutoRepositoryData }

constructor TProdutoRepositorySQLite.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TProdutoRepositorySQLite.GetTodos: TObjectList<TProdutos>;
var
  DataSet: TFDQuery;
  Produto: TProdutos;
begin
  Result := TObjectList<TProdutos>.Create;
  CreateDataset(DataSet, FConnection);
  try
    DataSet.Connection := FConnection;
    DataSet.SQL.Text := 'SELECT Codigo, Descricao, PrecoVenda FROM Produtos ORDER BY Descricao';
    DataSet.Open;
    while not DataSet.Eof do
    begin
      Produto := TProdutos.Create;
      Produto.Codigo := DataSet.FieldByName('Codigo').AsInteger;
      Produto.Descricao := DataSet.FieldByName('Descricao').AsString;
      Produto.Preco := DataSet.FieldByName('PrecoVenda').AsFloat;
      Result.Add(Produto);
      DataSet.Next;
    end;
  finally
    FreeDataset(DataSet);
  end;
end;

function TProdutoRepositorySQLite.GetProdutoId(const ACodigo: Integer): TProdutos;
var
  DataSet: TFDQuery;
begin
  Result := nil;
  CreateDataset(DataSet, FConnection);
  try
    DataSet.Connection := FConnection;
    DataSet.SQL.Text := 'SELECT Codigo, Descricao, PrecoVenda FROM Produtos WHERE Codigo = :Codigo';
    DataSet.ParamByName('Codigo').AsInteger := ACodigo;
    DataSet.Open;
    if not DataSet.IsEmpty then
    begin
      Result := TProdutos.Create;
      Result.Codigo := DataSet.FieldByName('Codigo').AsInteger;
      Result.Descricao := DataSet.FieldByName('Descricao').AsString;
      Result.Preco := DataSet.FieldByName('PrecoVenda').AsFloat;
    end;
  finally
    DataSet.Free;
  end;
end;

procedure TProdutoRepositorySQLite.Adicionar(AProduto: TProdutos);
var
  DataSet: TFDQuery;
begin
  CreateDataset(DataSet, FConnection);
  try
    DataSet.Connection := FConnection;
    DataSet.SQL.Text := 'INSERT INTO Produtos (Codigo, Descricao, PrecoVenda) VALUES (:Codigo, :Descricao, :PrecoVenda)';
    DataSet.ParamByName('Codigo').AsInteger := AProduto.Codigo;
    DataSet.ParamByName('Descricao').AsString := AProduto.Descricao;
    DataSet.ParamByName('PrecoVenda').AsFloat := AProduto.Preco;
    DataSet.ExecSQL;
  finally
    DataSet.Free;
  end;
end;

procedure TProdutoRepositorySQLite.Editar(AProduto: TProdutos);
var
  DataSet: TFDQuery;
begin
  CreateDataset(DataSet, FConnection);
  try
    DataSet.Connection := FConnection;
    DataSet.SQL.Text := 'UPDATE Produtos SET Descricao = :Descricao, PrecoVenda = :PrecoVenda WHERE Codigo = :Codigo';
    DataSet.ParamByName('Codigo').AsInteger := AProduto.Codigo;
    DataSet.ParamByName('Descricao').AsString := AProduto.Descricao;
    DataSet.ParamByName('PrecoVenda').AsFloat := AProduto.Preco;
    DataSet.ExecSQL;
  finally
    DataSet.Free;
  end;
end;

procedure TProdutoRepositorySQLite.Deletar(const ACodigo: Integer);
var
  DataSet: TFDQuery;
begin
  CreateDataset(DataSet, FConnection);
  try
    DataSet.Connection := FConnection;
    DataSet.SQL.Text := 'DELETE FROM Produtos WHERE Codigo = :Codigo';
    DataSet.ParamByName('Codigo').AsInteger := ACodigo;
    DataSet.ExecSQL;
  finally
    DataSet.Free;
  end;
end;

end.
