unit IClientesRepository;

interface

uses
  System.Generics.Collections, Clientes;

type
  IClienteRepository = interface
    ['{8A18A890-43B2-4BA0-96DB-3D52BFD6C18B}']
    function GetClienteId(const ACodigo: Integer): TClientes;
    function GetTodos: TObjectList<TClientes>;
    procedure Adicionar(ACliente: TClientes);
    procedure Editar(ACliente: TClientes);
    procedure Deletar(const ACodigo: Integer);
  end;

implementation

end.
