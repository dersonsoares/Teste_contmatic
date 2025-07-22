unit Produtos;

interface

type
  TProdutos = class
  private
    FCodigo: Integer;
    FDescricao: string;
    FPreco: Double;
  public
    property Codigo:     Integer read FCodigo     write FCodigo;
    property Descricao:  string  read FDescricao  write FDescricao;
    property Preco    :  Double  read FPreco      write FPreco;
  end;

implementation

end.
