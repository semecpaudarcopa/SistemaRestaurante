program SistemaRestaurante;

uses
  Vcl.Forms,
  Login in 'Login.pas' {FrmLogin},
  Principal in 'Principal.pas' {frmPrincipal},
  modulo in 'modulo.pas' {DataModule1: TDataModule},
  Funcionarios in 'Cadastros\Funcionarios.pas' {FrmFuncionarios},
  Produtos in 'Produtos\Produtos.pas' {FrmProdutos},
  Cargos in 'Cadastros\Cargos.pas' {FrmCargos},
  Fornecedores in 'Cadastros\Fornecedores.pas' {FrmFornecedores},
  Mesas in 'Cadastros\Mesas.pas' {FrmMesas},
  Pratos in 'Cadastros\Pratos.pas' {FrmPratos},
  EntradasProdutos in 'Produtos\EntradasProdutos.pas' {FrmEntradasProdutos},
  Vendas in 'Movimentacoes\Vendas.pas' {FrmVendas},
  Movimentacoes in 'Movimentacoes\Movimentacoes.pas' {FrmMovimentacoes},
  Gastos in 'Movimentacoes\Gastos.pas' {FrmGastos},
  Pagamentos in 'Movimentacoes\Pagamentos.pas' {FrmPagamentos},
  TelaPedidos in 'Pedidos\TelaPedidos.pas' {FrmTelaPedidos},
  ConsultaPedidos in 'Pedidos\ConsultaPedidos.pas' {FrmConsultaPedidos},
  Reserva in 'Reservas\Reserva.pas' {FrmReservas},
  QuadroReservas in 'Reservas\QuadroReservas.pas' {FrmQuadroReservas},
  RelVendas in 'Movimentacoes\RelVendas.pas' {FrmRelVendas},
  RelMovimentacoes in 'Movimentacoes\RelMovimentacoes.pas' {FrmRelMovimentacoes},
  Estoque in 'Produtos\Estoque.pas' {FrmEstoque},
  Pedidos in 'Pedidos\Pedidos.pas' {FrmPedidos},
  RelPedidos in 'Pedidos\RelPedidos.pas' {FrmRelPedidos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
