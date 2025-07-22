unit ClienteRepositoryData;

interface

uses
  System.Generics.Collections, FireDAC.Comp.Client, Clientes,
  IClientesRepository, ObjetosUteis;

type
  TClientesRepositoryData = class(TInterfacedObject, IClienteRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    function GetClienteId(const ACodigo: Integer): TClientes;
    function GetTodos: TObjectList<TClientes>;
    procedure Adicionar(ACliente: TClientes);
    procedure Editar(ACliente: TClientes);
    procedure Deletar(const ACodigo: Integer);
  end;

implementation

uses
  System.SysUtils;

{ ClienteRepositoryData }

constructor TClientesRepositoryData.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TClientesRepositoryData.GetTodos: TObjectList<TClientes>;
var
  DataSet: TFDQuery;
  Cliente: TClientes;
begin
  Result := TObjectList<TClientes>.Create;
  CreateDataset(DataSet, FConnection);
  try
    DataSet.SQL.Text := 'SELECT Codigo, Nome, Cidade, UF FROM Clientes ORDER BY Nome';
    DataSet.Open;
    while not DataSet.Eof do
    begin
      Cliente := TClientes.Create;
      Cliente.Codigo := DataSet.FieldByName('Codigo').AsInteger;
      Cliente.Nome := DataSet.FieldByName('Nome').AsString;
      Cliente.Cidade := DataSet.FieldByName('Cidade').AsString;
      Cliente.UF := DataSet.FieldByName('UF').AsString;
      Result.Add(Cliente);

      DataSet.Next;
    end;
  finally
    FreeDataset(DataSet);
  end;
end;

function TClientesRepositoryData.GetClienteId(const ACodigo: Integer): TClientes;
var
  DataSet: TFDQuery;
begin
  Result := nil;
  CreateDataset(DataSet, FConnection);
  try
    DataSet.SQL.Text := 'SELECT Codigo, Nome, Cidade, UF FROM Clientes WHERE Codigo = :Codigo';
    DataSet.ParamByName('Codigo').AsInteger := ACodigo;
    DataSet.Open;
    if not DataSet.IsEmpty then
    begin
      Result := TClientes.Create;
      Result.Codigo := DataSet.FieldByName('Codigo').AsInteger;
      Result.Nome := DataSet.FieldByName('Nome').AsString;
      Result.Cidade := DataSet.FieldByName('Cidade').AsString;
      Result.UF := DataSet.FieldByName('UF').AsString;
    end;
  finally
    FreeDataset(DataSet);
  end;
end;

procedure TClientesRepositoryData.Adicionar(ACliente: TClientes);
var
  DataSet: TFDQuery;
begin
  CreateDataset(DataSet, FConnection);
  try
    DataSet.SQL.Text := 'INSERT INTO Clientes (Codigo, Nome, Cidade, UF) VALUES (:Codigo, :Nome, :Cidade, :UF)';
    DataSet.ParamByName('Codigo').AsInteger := ACliente.Codigo;
    DataSet.ParamByName('Nome').AsString := ACliente.Nome;
    DataSet.ParamByName('Cidade').AsString := ACliente.Cidade;
    DataSet.ParamByName('UF').AsString := ACliente.UF;
    DataSet.ExecSQL;
  finally
    FreeDataset(DataSet);
  end;
end;

procedure TClientesRepositoryData.Editar(ACliente: TClientes);
var
  DataSet: TFDQuery;
begin
  CreateDataset(DataSet, FConnection);
  try
    DataSet.SQL.Text := 'UPDATE Clientes SET Nome = :Nome, Cidade = :Cidade, UF = :UF WHERE Codigo = :Codigo';
    DataSet.ParamByName('Codigo').AsInteger := ACliente.Codigo;
    DataSet.ParamByName('Nome').AsString := ACliente.Nome;
    DataSet.ParamByName('Cidade').AsString := ACliente.Cidade;
    DataSet.ParamByName('UF').AsString := ACliente.UF;
    DataSet.ExecSQL;
  finally
    FreeDataset(DataSet);
  end;
end;

procedure TClientesRepositoryData.Deletar(const ACodigo: Integer);
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := FConnection;
    Q.SQL.Text := 'DELETE FROM Clientes WHERE Codigo = :Codigo';
    Q.ParamByName('Codigo').AsInteger := ACodigo;
    Q.ExecSQL;
  finally
    Q.Free;
  end;
end;

end.
