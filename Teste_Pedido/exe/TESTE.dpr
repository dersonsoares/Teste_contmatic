program TESTE;

uses
  Vcl.Forms,
  uPrincipal.View in '..\src\View\uPrincipal.View.pas' {frmPrincipal},
  Clientes in '..\src\Model\Clientes.pas',
  Produtos in '..\src\Model\Produtos.pas',
  Pedidos in '..\src\Model\Pedidos.pas',
  ItensPedido in '..\src\Model\ItensPedido.pas',
  IClientesRepository in '..\src\Repository\IClientesRepository.pas',
  ClienteRepositoryData in '..\src\Repository\ClienteRepositoryData.pas',
  ObjetosUteis in '..\src\Util\ObjetosUteis.pas',
  IProdutosRepository in '..\src\Repository\IProdutosRepository.pas',
  ProdutoRepositoryData in '..\src\Repository\ProdutoRepositoryData.pas',
  IPedidosRepository in '..\src\Repository\IPedidosRepository.pas',
  PedidoRepositoryData in '..\src\Repository\PedidoRepositoryData.pas',
  PedidosController in '..\src\Controller\PedidosController.pas',
  uDMConexao in '..\src\Dados\uDMConexao.pas' {DMConexao: TDataModule},
  uSelecionaCliente.View in '..\src\View\uSelecionaCliente.View.pas' {frmSelecionarCliente},
  uSelecionaProduto.View in '..\src\View\uSelecionaProduto.View.pas' {frmSelecionarProduto};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
