unit PedidosController;

interface

uses
  Pedidos, ItensPedido, IPedidosRepository, System.SysUtils, System.Generics.Collections;

type
  IPedidoController = interface
    ['{6ACAB940-8B83-4F9E-8CF1-CB93B20673C9}']
    procedure NovoPedido;
    procedure AdicionarItem(ACodigoProduto: Integer; AQuantidade, AValorUnitario: Double);
    procedure EditarItem(Index: Integer; AQuantidade, AValorUnitario: Double);
    procedure RemoverItem(Index: Integer);
    procedure SalvarPedido;
    procedure CancelarPedido;
    function GetPedidoAtual: TPedidos;
    function GetItens: TObjectList<TItensPedido>;
  end;

  TPedidoController = class(TInterfacedObject, IPedidoController)
  private
    FPedido: TPedidos;
    FPedidoRepository: IPedidoRepository;
  public
    constructor Create(APedidoRepository: IPedidoRepository);
    destructor Destroy; override;

    procedure NovoPedido;
    procedure AdicionarItem(ACodigoProduto: Integer; AQuantidade, AValorUnitario: Double);
    procedure EditarItem(Index: Integer; AQuantidade, AValorUnitario: Double);
    procedure RemoverItem(Index: Integer);
    procedure SalvarPedido;
    procedure CancelarPedido;

    function GetPedidoAtual: TPedidos;
    function GetItens: TObjectList<TItensPedido>;
  end;

implementation

{ TPedidoController }

constructor TPedidoController.Create(APedidoRepository: IPedidoRepository);
begin
  inherited Create;
  FPedidoRepository := APedidoRepository;
  FPedido := TPedidos.Create;
end;

destructor TPedidoController.Destroy;
begin
  FPedido.Free;
  inherited;
end;

procedure TPedidoController.NovoPedido;
begin
  FPedido.Free;
  FPedido := TPedidos.Create;
  FPedido.Numero := FPedidoRepository.GetNextNumeroPedido;
  FPedido.DataEmissao := Now;
end;

procedure TPedidoController.AdicionarItem(ACodigoProduto: Integer; AQuantidade, AValorUnitario: Double);
var
  Item: TItensPedido;
begin
  Item := TItensPedido.Create;
  Item.CodigoProduto := ACodigoProduto;
  Item.Quantidade := AQuantidade;
  Item.ValorUnitario := AValorUnitario;
  Item.AtualizarTotal;
  FPedido.Itens.Add(Item);
  FPedido.AtualizarTotal;
end;

procedure TPedidoController.EditarItem(Index: Integer; AQuantidade, AValorUnitario: Double);
begin
  if (Index < 0) or (Index >= FPedido.Itens.Count) then
    raise Exception.Create('Índice de item inválido.');

  FPedido.Itens[Index].Quantidade := AQuantidade;
  FPedido.Itens[Index].ValorUnitario := AValorUnitario;
  FPedido.Itens[Index].AtualizarTotal;
  FPedido.AtualizarTotal;
end;

procedure TPedidoController.RemoverItem(Index: Integer);
begin
  if (Index < 0) or (Index >= FPedido.Itens.Count) then
    raise Exception.Create('Índice de item inválido.');

  FPedido.Itens.Delete(Index);
  FPedido.AtualizarTotal;
end;

procedure TPedidoController.SalvarPedido;
begin
  if FPedido.CodigoCliente = 0 then
    raise Exception.Create('Cliente não informado.');
  if FPedido.Itens.Count = 0 then
    raise Exception.Create('O pedido não possui itens.');

  FPedido.AtualizarTotal;
  FPedidoRepository.Adicionar(FPedido);
end;

procedure TPedidoController.CancelarPedido;
begin
  FPedido.Free;
  FPedido := TPedidos.Create;
end;

function TPedidoController.GetItens: TObjectList<TItensPedido>;
begin
  Result := FPedido.Itens;
end;

function TPedidoController.GetPedidoAtual: TPedidos;
begin
  Result := FPedido;
end;

end.
