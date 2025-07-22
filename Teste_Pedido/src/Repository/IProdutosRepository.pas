unit IProdutosRepository;

interface

uses
  System.Generics.Collections, Produtos;

type
  IProdutoRepository = interface
    ['{39F1714B-5EC6-4E13-B0E8-472AB5743EC6}']
    function GetProdutoId(const ACodigo: Integer): TProdutos;
    function GetTodos: TObjectList<TProdutos>;
    procedure Adicionar(AProduto: TProdutos);
    procedure Editar(AProduto: TProdutos);
    procedure Deletar(const ACodigo: Integer);
  end;

implementation

end.
