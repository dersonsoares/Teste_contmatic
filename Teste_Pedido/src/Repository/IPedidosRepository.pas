unit IPedidosRepository;

interface

uses
  Pedidos, System.Generics.Collections;

type
  IPedidoRepository = interface
    ['{9B6AB3AD-6A91-49C8-967C-84D2633CC5AA}']
    function GetPedidoId(const ANumero: Integer): TPedidos;
    function GetTodos: TObjectList<TPedidos>;
    procedure Adicionar(APedido: TPedidos);
    procedure Editar(APedido: TPedidos);
    procedure Deletar(const ANumero: Integer);

    function GetNextNumeroPedido: Integer;
  end;

implementation

end.
