unit Pedidos;

interface

uses
  System.Generics.Collections, ItensPedido;

type
  TPedidos = class
  private
    FNumero: Integer;
    FDataEmissao: TDateTime;
    FCodigoCliente: Integer;
    FTotal: Double;
    FItens: TObjectList<TItensPedido>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AtualizarTotal;

    property Numero:        Integer                  read FNumero        write FNumero;
    property DataEmissao:   TDateTime                read FDataEmissao   write FDataEmissao;
    property CodigoCliente: Integer                  read FCodigoCliente write FCodigoCliente;
    property Total:         Double                   read FTotal         write FTotal;
    property Itens:         TObjectList<TItensPedido> read FItens;
  end;

implementation

constructor TPedidos.Create;
begin
  FItens := TObjectList<TItensPedido>.Create;
end;

destructor TPedidos.Destroy;
begin
  FItens.Free;
  inherited;
end;

procedure TPedidos.AtualizarTotal;
var
  Item: TItensPedido;
begin
  FTotal := 0;
  for Item in FItens do
    FTotal := FTotal + Item.ValorTotal;
end;

end.
