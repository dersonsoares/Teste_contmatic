unit PedidoRepositoryData;

interface

uses
  System.Generics.Collections, FireDAC.Comp.Client, Pedidos, ItensPedido, ObjetosUteis,
  IPedidosRepository;

type
  TPedidoRepositoryData = class(TInterfacedObject, IPedidoRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    function GetPedidoId(const ANumero: Integer): TPedidos;
    function GetTodos: TObjectList<TPedidos>;
    procedure Adicionar(APedido: TPedidos);
    procedure Editar(APedido: TPedidos);
    procedure Deletar(const ANumero: Integer);

    function GetNextNumeroPedido: Integer;
  end;

implementation

uses
  System.SysUtils;

{ TPedidoRepositoryData }

constructor TPedidoRepositoryData.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TPedidoRepositoryData.GetNextNumeroPedido: Integer;
var
  DataSet: TFDQuery;
begin
  CreateDataSet(DataSet, FConnection);
  try
    DataSet.Connection := FConnection;
    DataSet.SQL.Text := 'SELECT IFNULL(MAX(Numero), 0) + 1 AS NextNum FROM Pedidos';
    DataSet.Open;
    Result := DataSet.FieldByName('NextNum').AsInteger;
  finally
    FreeDataSet(DataSet);
  end;
end;

procedure TPedidoRepositoryData.Adicionar(APedido: TPedidos);
var
  DataSet: TFDQuery;
  Item: TItensPedido;
begin
  FConnection.StartTransaction;
  try
    if APedido.Numero = 0 then
      APedido.Numero := GetNextNumeroPedido;

    CreateDataSet(DataSet, FConnection);
    try
      DataSet.Connection := FConnection;
      DataSet.SQL.Text := 'INSERT INTO Pedidos (Numero, DataEmissao, CodigoCliente, ValorTotal) ' +
                    'VALUES (:Numero, :DataEmissao, :CodigoCliente, :ValorTotal)';
      DataSet.ParamByName('Numero').AsInteger := APedido.Numero;
      DataSet.ParamByName('DataEmissao').AsDateTime := APedido.DataEmissao;
      DataSet.ParamByName('CodigoCliente').AsInteger := APedido.CodigoCliente;
      DataSet.ParamByName('ValorTotal').AsFloat := APedido.Total;
      DataSet.ExecSQL;
    finally
      FreeDataSet(DataSet);
    end;

    // Inserir os itens
    for Item in APedido.Itens do
    begin
      CreateDataSet(DataSet, FConnection);
      try
        DataSet.Connection := FConnection;
        DataSet.SQL.Text := 'INSERT INTO PedidoItens (NumeroPedido, CodigoProduto, Quantidade, ValorUnitario, ValorTotal) ' +
                      'VALUES (:NumeroPedido, :CodigoProduto, :Quantidade, :ValorUnitario, :ValorTotal)';
        DataSet.ParamByName('NumeroPedido').AsInteger := APedido.Numero;
        DataSet.ParamByName('CodigoProduto').AsInteger := Item.CodigoProduto;
        DataSet.ParamByName('Quantidade').AsFloat := Item.Quantidade;
        DataSet.ParamByName('ValorUnitario').AsFloat := Item.ValorUnitario;
        DataSet.ParamByName('ValorTotal').AsFloat := Item.ValorTotal;
        DataSet.ExecSQL;
      finally
        FreeDataSet(DataSet);
      end;
    end;

    FConnection.Commit;
  except
    on E: Exception do
    begin
      FConnection.Rollback;
      raise Exception.Create('Erro ao salvar pedido: ' + E.Message);
    end;
  end;
end;

procedure TPedidoRepositoryData.Editar(APedido: TPedidos);
var
  DataSet: TFDQuery;
  Item: TItensPedido;
begin
  FConnection.StartTransaction;
  try
    // Atualiza dados do pedido
    CreateDataSet(DataSet, FConnection);
    try
      DataSet.Connection := FConnection;
      DataSet.SQL.Text := 'UPDATE Pedidos SET DataEmissao = :DataEmissao, CodigoCliente = :CodigoCliente, ValorTotal = :ValorTotal ' +
                    'WHERE Numero = :Numero';
      DataSet.ParamByName('Numero').AsInteger := APedido.Numero;
      DataSet.ParamByName('DataEmissao').AsDateTime := APedido.DataEmissao;
      DataSet.ParamByName('CodigoCliente').AsInteger := APedido.CodigoCliente;
      DataSet.ParamByName('ValorTotal').AsFloat := APedido.Total;
      DataSet.ExecSQL;
    finally
      FreeDataSet(DataSet);
    end;

    // Remove itens antigos e insere os novos
    CreateDataSet(DataSet, FConnection);
    try
      DataSet.Connection := FConnection;
      DataSet.SQL.Text := 'DELETE FROM PedidoItens WHERE NumeroPedido = :NumeroPedido';
      DataSet.ParamByName('NumeroPedido').AsInteger := APedido.Numero;
      DataSet.ExecSQL;
    finally
      FreeDataSet(DataSet);
    end;

    for Item in APedido.Itens do
    begin
      CreateDataSet(DataSet, FConnection);
      try
        DataSet.Connection := FConnection;
        DataSet.SQL.Text := 'INSERT INTO PedidoItens (NumeroPedido, CodigoProduto, Quantidade, ValorUnitario, ValorTotal) ' +
                      'VALUES (:NumeroPedido, :CodigoProduto, :Quantidade, :ValorUnitario, :ValorTotal)';
        DataSet.ParamByName('NumeroPedido').AsInteger := APedido.Numero;
        DataSet.ParamByName('CodigoProduto').AsInteger := Item.CodigoProduto;
        DataSet.ParamByName('Quantidade').AsFloat := Item.Quantidade;
        DataSet.ParamByName('ValorUnitario').AsFloat := Item.ValorUnitario;
        DataSet.ParamByName('ValorTotal').AsFloat := Item.ValorTotal;
        DataSet.ExecSQL;
      finally
        FreeDataSet(DataSet);
      end;
    end;

    FConnection.Commit;
  except
    on E: Exception do
    begin
      FConnection.Rollback;
      raise Exception.Create('Erro ao atualizar pedido: ' + E.Message);
    end;
  end;
end;

procedure TPedidoRepositoryData.Deletar(const ANumero: Integer);
var
  DataSet: TFDQuery;
begin
  FConnection.StartTransaction;
  try
    CreateDataSet(DataSet, FConnection);
    try
      DataSet.Connection := FConnection;
      DataSet.SQL.Text := 'DELETE FROM PedidoItens WHERE NumeroPedido = :NumeroPedido';
      DataSet.ParamByName('NumeroPedido').AsInteger := ANumero;
      DataSet.ExecSQL;
    finally
      FreeDataSet(DataSet);
    end;

    CreateDataSet(DataSet, FConnection);
    try
      DataSet.Connection := FConnection;
      DataSet.SQL.Text := 'DELETE FROM Pedidos WHERE Numero = :Numero';
      DataSet.ParamByName('Numero').AsInteger := ANumero;
      DataSet.ExecSQL;
    finally
      FreeDataSet(DataSet);
    end;

    FConnection.Commit;
  except
    on E: Exception do
    begin
      FConnection.Rollback;
      raise Exception.Create('Erro ao excluir pedido: ' + E.Message);
    end;
  end;
end;

function TPedidoRepositoryData.GetTodos: TObjectList<TPedidos>;
begin
  // Podemos implementar listagem de pedidos depois (com JOIN nos itens)
  raise Exception.Create('Método GetAll não implementado.');
end;

function TPedidoRepositoryData.GetPedidoId(const ANumero: Integer): TPedidos;
begin
  // Podemos implementar busca de pedido por ID depois (com JOIN nos itens)
  raise Exception.Create('Método GetById não implementado.');
end;

end.
