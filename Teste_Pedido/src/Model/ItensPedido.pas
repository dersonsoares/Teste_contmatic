unit ItensPedido;

interface

type
  TItensPedido = class
  private
    FID: Integer;
    FNumeroPedido: Integer;
    FCodigoProduto: Integer;
    FQuantidade: Double;
    FValorUnitario: Double;
    FValorTotal: Double;
  public
    procedure AtualizarTotal;

    property ID:            Integer read FID            write FID;
    property NumeroPedido:  Integer read FNumeroPedido  write FNumeroPedido;
    property CodigoProduto: Integer read FCodigoProduto write FCodigoProduto;
    property Quantidade:    Double  read FQuantidade    write FQuantidade;
    property ValorUnitario: Double  read FValorUnitario write FValorUnitario;
    property ValorTotal:    Double  read FValorTotal    write FValorTotal;
  end;

implementation

procedure TItensPedido.AtualizarTotal;
begin
  FValorTotal := FQuantidade * FValorUnitario;
end;

end.
