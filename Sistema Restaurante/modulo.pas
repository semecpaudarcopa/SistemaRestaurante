unit modulo;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, frxClass, frxDBSet;

type
  TDataModule1 = class(TDataModule)
    FDConnection1: TFDConnection;
    Driver: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    tb_cargo: TFDTable;
    dsCargo: TDataSource;
    tb_cargoid: TFDAutoIncField;
    tb_cargonome: TStringField;
    tb_funcionarios: TFDTable;
    tb_funcionariosid: TFDAutoIncField;
    tb_funcionariosnome: TStringField;
    tb_funcionarioscpf: TStringField;
    tb_funcionariostelefone: TStringField;
    tb_funcionariosendereco: TStringField;
    tb_funcionarioscargo: TStringField;
    tb_funcionariosusuario: TStringField;
    tb_funcionariossenha: TStringField;
    tb_funcionariosdata: TDateField;
    dsFuncionarios: TDataSource;
    queryFunc: TFDQuery;
    queryConFunc: TFDQuery;
    queryConFuncid: TFDAutoIncField;
    queryConFuncnome: TStringField;
    queryConFunccpf: TStringField;
    queryConFunctelefone: TStringField;
    queryConFuncendereco: TStringField;
    queryConFunccargo: TStringField;
    queryConFuncusuario: TStringField;
    queryConFuncsenha: TStringField;
    queryConFuncdata: TDateField;
    dsConFuncionarios: TDataSource;
    tb_fornecedores: TFDTable;
    dsFornecedores: TDataSource;
    queryConForn: TFDQuery;
    ConFornecedores: TDataSource;
    tb_fornecedoresid: TFDAutoIncField;
    tb_fornecedoresnome: TStringField;
    tb_fornecedorestelefone: TStringField;
    tb_fornecedoresemail: TStringField;
    tb_fornecedoressite: TStringField;
    tb_fornecedoresendereco: TStringField;
    queryConFornid: TFDAutoIncField;
    queryConFornnome: TStringField;
    queryConForntelefone: TStringField;
    queryConFornemail: TStringField;
    queryConFornsite: TStringField;
    queryConFornendereco: TStringField;
    tb_produtos: TFDTable;
    tb_produtosid: TFDAutoIncField;
    tb_produtosnome: TStringField;
    tb_produtosdescricao: TStringField;
    tb_produtosvalor: TBCDField;
    tb_produtosquantidade: TIntegerField;
    tb_produtosfornecedor: TIntegerField;
    tb_produtosimagem: TBlobField;
    dsProdutos: TDataSource;
    queryConProd: TFDQuery;
    queryConProdid: TFDAutoIncField;
    queryConProdnome: TStringField;
    queryConProddescricao: TStringField;
    queryConProdvalor: TBCDField;
    queryConProdquantidade: TIntegerField;
    queryConProdnome_1: TStringField;
    queryConProdfornecedor: TIntegerField;
    queryConProdimagem: TBlobField;
    ConProdutos: TDataSource;
    tb_mesas: TFDTable;
    tb_mesasid: TFDAutoIncField;
    tb_mesasmesa: TStringField;
    dsMesas: TDataSource;
    tb_pratos: TFDTable;
    tb_pratosid: TFDAutoIncField;
    tb_pratosnome: TStringField;
    tb_pratosvalor: TBCDField;
    dsPratos: TDataSource;
    tb_detalhes_vendas: TFDTable;
    tb_detalhes_vendasid: TFDAutoIncField;
    tb_detalhes_vendasid_venda: TIntegerField;
    tb_detalhes_vendasproduto: TStringField;
    tb_detalhes_vendasvalor: TBCDField;
    tb_detalhes_vendasquantidade: TIntegerField;
    tb_detalhes_vendasvalor_total: TBCDField;
    tb_detalhes_vendasid_produto: TIntegerField;
    tb_vendas: TFDTable;
    tb_vendasid: TFDAutoIncField;
    tb_vendasvalor: TBCDField;
    tb_vendasfuncionario: TStringField;
    tb_vendasdata: TDateField;
    queryConVendas: TFDQuery;
    queryConVendasid: TFDAutoIncField;
    queryConVendasvalor: TBCDField;
    queryConVendasfuncionario: TStringField;
    queryConVendasdata: TDateField;
    ConVendas: TDataSource;
    queryConDetalhes: TFDQuery;
    queryConDetalhesid: TFDAutoIncField;
    queryConDetalhesid_venda: TIntegerField;
    queryConDetalhesproduto: TStringField;
    queryConDetalhesvalor: TBCDField;
    queryConDetalhesquantidade: TIntegerField;
    queryConDetalhesvalor_total: TBCDField;
    queryConDetalhesid_produto: TIntegerField;
    ConDetalhes: TDataSource;
    queryConMov: TFDQuery;
    ConMov: TDataSource;
    tb_reservas: TFDTable;
    tb_reservasid: TFDAutoIncField;
    tb_reservascliente: TStringField;
    tb_reservasmesa: TStringField;
    tb_reservasdata: TDateField;
    tb_reservasstatus: TStringField;
    queryConReservas: TFDQuery;
    queryConReservasid: TFDAutoIncField;
    queryConReservascliente: TStringField;
    queryConReservasmesa: TStringField;
    queryConReservasdata: TDateField;
    queryConReservasstatus: TStringField;
    ConReservas: TDataSource;
    queryConPedidos: TFDQuery;
    queryConPedidosid: TFDAutoIncField;
    queryConPedidosid_venda: TIntegerField;
    queryConPedidosvalor: TBCDField;
    queryConPedidosmesa: TStringField;
    queryConPedidosfuncionario: TStringField;
    queryConPedidosdata: TDateField;
    ConPedidos: TDataSource;
    tb_pedidos: TFDTable;
    tb_pedidosid: TFDAutoIncField;
    tb_pedidosid_venda: TIntegerField;
    tb_pedidosvalor: TBCDField;
    tb_pedidosmesa: TStringField;
    tb_pedidosfuncionario: TStringField;
    tb_pedidosdata: TDateField;
    tb_detalhes_pedidos: TFDTable;
    tb_detalhes_pedidosid: TFDAutoIncField;
    tb_detalhes_pedidosid_pedido: TIntegerField;
    tb_detalhes_pedidosprato: TStringField;
    tb_detalhes_pedidosvalor: TBCDField;
    tb_detalhes_pedidosquantidade: TIntegerField;
    tb_detalhes_pedidosvalor_total: TBCDField;
    tb_detalhes_pedidosmesa: TStringField;
    tb_detalhes_pedidosstatus: TStringField;
    ConDetPedidos: TDataSource;
    queryConDetPedidos: TFDQuery;
    queryConDetPedidosid: TFDAutoIncField;
    queryConDetPedidosid_pedido: TIntegerField;
    queryConDetPedidosprato: TStringField;
    queryConDetPedidosvalor: TBCDField;
    queryConDetPedidosquantidade: TIntegerField;
    queryConDetPedidosvalor_total: TBCDField;
    queryConDetPedidosmesa: TStringField;
    queryConDetPedidosstatus: TStringField;
    tb_movimentacoes: TFDTable;
    tb_movimentacoesid: TFDAutoIncField;
    tb_movimentacoestipo: TStringField;
    tb_movimentacoesmovimento: TStringField;
    tb_movimentacoesvalor: TBCDField;
    tb_movimentacoesfuncionario: TStringField;
    tb_movimentacoesdata: TDateField;
    tb_movimentacoesid_movimento: TIntegerField;
    tb_gastos: TFDTable;
    tb_gastosid: TFDAutoIncField;
    tb_gastosdescricao: TStringField;
    tb_gastosvalor: TBCDField;
    tb_gastosfuncionario: TStringField;
    tb_gastosdata: TDateField;
    ds_gastos: TDataSource;
    tb_pagamentos: TFDTable;
    tb_pagamentosid: TFDAutoIncField;
    tb_pagamentosfuncionario: TStringField;
    tb_pagamentosvalor: TBCDField;
    tb_pagamentosgerente: TStringField;
    tb_pagamentosdata: TDateField;
    ds_pagamentos: TDataSource;
    queryConGastos: TFDQuery;
    queryConGastosid: TFDAutoIncField;
    queryConGastosdescricao: TStringField;
    queryConGastosvalor: TBCDField;
    queryConGastosfuncionario: TStringField;
    queryConGastosdata: TDateField;
    queryConPgto: TFDQuery;
    queryConPgtoid: TFDAutoIncField;
    queryConPgtofuncionario: TStringField;
    queryConPgtovalor: TBCDField;
    queryConPgtogerente: TStringField;
    queryConPgtodata: TDateField;
    queryConDetPedProducao: TFDQuery;
    queryConDetPedProducaoid: TFDAutoIncField;
    queryConDetPedProducaoid_pedido: TIntegerField;
    queryConDetPedProducaoprato: TStringField;
    queryConDetPedProducaovalor: TBCDField;
    queryConDetPedProducaoquantidade: TIntegerField;
    queryConDetPedProducaovalor_total: TBCDField;
    queryConDetPedProducaomesa: TStringField;
    queryConDetPedProducaostatus: TStringField;
    ConDetPedProducao: TDataSource;
    queryConDetPedFinalizados: TFDQuery;
    queryConDetPedFinalizadosid: TFDAutoIncField;
    queryConDetPedFinalizadosid_pedido: TIntegerField;
    queryConDetPedFinalizadosprato: TStringField;
    queryConDetPedFinalizadosvalor: TBCDField;
    queryConDetPedFinalizadosquantidade: TIntegerField;
    queryConDetPedFinalizadosvalor_total: TBCDField;
    queryConDetPedFinalizadosmesa: TStringField;
    queryConDetPedFinalizadosstatus: TStringField;
    ConDetPedFin: TDataSource;
    queryRelMovEntradas: TFDQuery;
    queryRelMovSaidas: TFDQuery;
    rel_produtos: TfrxReport;
    rel_ds_produtos: TfrxDBDataset;
    rel_pedidos: TfrxReport;
    rel_ds_pedidos: TfrxDBDataset;
    rel_ds_detalhe_pedidos: TfrxDBDataset;
    rel_comprovante: TfrxReport;
    rel_ds_comprovante: TfrxDBDataset;
    rel_ds_comprovante_detalhes: TfrxDBDataset;
    frxReport1: TfrxReport;
    rel_ds_comp_vendas: TfrxDBDataset;
    frxReport2: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    rel_ds_det_pedidos: TfrxDBDataset;
    rel_movimentacoes: TfrxReport;
    rel_ds_mov: TfrxDBDataset;
    rel_ds_mov_ent: TfrxDBDataset;
    rek_ds_mov_saida: TfrxDBDataset;
    rel_pedidos_data: TfrxReport;
    rel_ds_pedidos_data: TfrxDBDataset;
    rel_vendas: TfrxReport;
    rel_ds_vendas: TfrxDBDataset;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;
   nomeUsuario: String;
  nomeFuncionario: String;
  cargoFuncionario: String;


  idProduto: string;
  nomeProduto: string;
  quantidadeProduto: string;
  valorProduto: string;

  idPrato: string;
  nomePrato: string;
  valorPrato: string;

  numeroMesa: string;
  dataReserva: Tdate;

  numeroPedido: string;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  {CONECTANDO AO BANCO DE DADOS LOCAL  }

  FDConnection1.Params.Database := 'restaurante';
  FDConnection1.Params.UserName := 'root';
  FDConnection1.Params.Password := '';

  Driver.VendorLib := GetCurrentDir + '\libmysql.dll';


  //CONECTANDO AO BANCO HOSPEDADO



  {FDConnection1.Params.Database := 'sisrestaurante';
  FDConnection1.Params.UserName := 'berg456';
  FDConnection1.Params.Password := 'restaurante';
  Driver.VendorLib := GetCurrentDir + '\libmysql.dll';}


  FDConnection1.Connected := True;


  {INFORMAÇÕES DAS TABELAS - ASSOCIAÇÃO VIA CÓDIGO }
   tb_cargo.TableName := 'cargo';
   tb_cargo.Active := True;
   tb_mesas.Active := True;
   tb_pratos.Active := True;
   tb_gastos.Active := True;
   tb_pagamentos.Active := True;
end;

end.
