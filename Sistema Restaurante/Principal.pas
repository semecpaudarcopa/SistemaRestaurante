unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.pngimage;

type
  TfrmPrincipal = class(TForm)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    ShBarra: TShape;
    SpeedButton7: TSpeedButton;
    pnlMenu: TPanel;
    btnCadastro: TSpeedButton;
    btnProdutos: TSpeedButton;
    btnMovimentacoes: TSpeedButton;
    btnPedidos: TSpeedButton;
    btnReservas: TSpeedButton;
    btnRelatorios: TSpeedButton;
    pnlCadastros: TPanel;
    btnFuncionarios: TSpeedButton;
    btnCargos: TSpeedButton;
    btnPratos: TSpeedButton;
    btnMesas: TSpeedButton;
    btnFornecedores: TSpeedButton;
    pnlProdutos: TPanel;
    btnCadProdutos: TSpeedButton;
    btnNivelEstoque: TSpeedButton;
    btnEntradaProdutos: TSpeedButton;
    pnlMovimentacoes: TPanel;
    NovaVenda: TSpeedButton;
    btnPagamentos: TSpeedButton;
    btnGastos: TSpeedButton;
    btnEntradaseSaidas: TSpeedButton;
    pnlPedidos: TPanel;
    btnNovoPedido: TSpeedButton;
    btnConsultaPedidos: TSpeedButton;
    btnTelaPedidos: TSpeedButton;
    pnlReservas: TPanel;
    btnNovaReserva: TSpeedButton;
    btnQuadroReservas: TSpeedButton;
    pnlRelatorios: TPanel;
    btnRelProdutos: TSpeedButton;
    btnRelVendas: TSpeedButton;
    btnRelPedidos: TSpeedButton;
    btnRelMovimentacoes: TSpeedButton;
    btnSair: TSpeedButton;
    Panel1: TPanel;
    btnLogout: TSpeedButton;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ImgBack: TImage;
    Label13: TLabel;
    Image8: TImage;
    grid: TDBGrid;
    Image9: TImage;
    Label14: TLabel;
    Image10: TImage;
    Image11: TImage;
    gridVendas: TDBGrid;
    Panel2: TPanel;
    Image5: TImage;
    Image7: TImage;
    Image12: TImage;
    Image13: TImage;
    Panel3: TPanel;
    lblHora: TLabel;
    Label5: TLabel;
    lblData: TLabel;
    Image1: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Image2: TImage;
    lblCargo: TLabel;
    lblUsuario: TLabel;
    lblC: TLabel;
    Image3: TImage;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    lblEntradas: TLabel;
    lblSaidas: TLabel;
    lblSaldo: TLabel;
    Label18: TLabel;
    Image4: TImage;
    Label19: TLabel;
    Label20: TLabel;
    lblPedidos: TLabel;
    lblReservas: TLabel;
    Label21: TLabel;
    lblEstoque: TLabel;
    Panel4: TPanel;
    procedure btnCadastroMouseEnter(Sender: TObject);
    procedure pnlFundoMouseEnter(Sender: TObject);
    procedure btnFuncionariosClick(Sender: TObject);
    procedure btnFornecedoresClick(Sender: TObject);
    procedure btnCadProdutosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure btnCargosClick(Sender: TObject);
    procedure btnRelProdutosClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnMesasClick(Sender: TObject);
    procedure btnPratosClick(Sender: TObject);
    procedure btnEntradaProdutosClick(Sender: TObject);
    procedure NovaVendaClick(Sender: TObject);
    procedure btnEntradaseSaidasClick(Sender: TObject);
    procedure btnGastosClick(Sender: TObject);
    procedure btnPagamentosClick(Sender: TObject);
    procedure btnNovoPedidoClick(Sender: TObject);
    procedure btnTelaPedidosClick(Sender: TObject);
    procedure btnConsultaPedidosClick(Sender: TObject);
    procedure btnNovaReservaClick(Sender: TObject);
    procedure btnQuadroReservasClick(Sender: TObject);
    procedure btnRelVendasClick(Sender: TObject);
    procedure btnRelMovimentacoesClick(Sender: TObject);
    procedure btnRelPedidosClick(Sender: TObject);
    procedure Panel4Click(Sender: TObject);
    procedure btnNivelEstoqueClick(Sender: TObject);
    procedure pnlTopoMouseEnter(Sender: TObject);
    
  private
    procedure prc_controlar_menu ( Botao: TSpeedButton; Ativar : Boolean);
   procedure totalizarEntradas;
   procedure totalizarSaidas;
   procedure totalizar;
   procedure totalizarPedidos;
   procedure totalizarReservas;
   procedure verificarEstoque;
   procedure buscarAgendadas;
   procedure buscarMovimentacoes;
   procedure formatarGrid;
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses Funcionarios, Produtos, Cargos, modulo, Login, Fornecedores, Mesas, Pratos,
  EntradasProdutos, Vendas, Pedidos, Movimentacoes, Gastos, Pagamentos,
  TelaPedidos, ConsultaPedidos, Reserva, QuadroReservas, RelVendas,
  RelMovimentacoes, RelPedidos, Estoque;

function ConverterRGB(r, g, b : Byte) : TColor;
begin
    Result := RGB(r, g, b);
end;


procedure TfrmPrincipal.btnEntradaProdutosClick(Sender: TObject);
begin
    FrmEntradasProdutos := TFrmEntradasProdutos.Create(self);
    FrmEntradasProdutos.ShowModal;
end;

procedure TfrmPrincipal.btnCadastroMouseEnter(Sender: TObject);
begin
  prc_controlar_menu (TComponent(Sender) as TSpeedButton, true);
end;

procedure TfrmPrincipal.btnCadProdutosClick(Sender: TObject);
begin
    FrmProdutos := TFrmProdutos.Create(self);
    FrmProdutos.ShowModal;
end;

procedure TfrmPrincipal.btnCargosClick(Sender: TObject);
begin
   FrmCargos := TFrmCargos.Create(self);
   FrmCargos.ShowModal;
end;

procedure TfrmPrincipal.btnConsultaPedidosClick(Sender: TObject);
begin
  FrmConsultaPedidos:= TFrmConsultaPedidos.Create(self);
  FrmConsultaPedidos.ShowModal;
end;

procedure TfrmPrincipal.btnEntradaseSaidasClick(Sender: TObject);
begin
   FrmMovimentacoes := TFrmMovimentacoes.Create(self);
  FrmMovimentacoes.ShowModal;
end;

procedure TfrmPrincipal.btnFornecedoresClick(Sender: TObject);
begin
  FrmFornecedores := TFrmFornecedores.Create(self);
  FrmFornecedores.ShowModal;
end;

procedure TfrmPrincipal.btnFuncionariosClick(Sender: TObject);
begin
  FrmFuncionarios := TFrmFuncionarios.Create(self);
  FrmFuncionarios.ShowModal;
end;

procedure TfrmPrincipal.btnGastosClick(Sender: TObject);
begin
  FrmGastos := TFrmGastos.Create(self);
  FrmGastos.Show;
end;

procedure TfrmPrincipal.btnLogoutClick(Sender: TObject);
begin
   FrmLogin := TFrmLogin.Create(self);
   Hide();
   FrmLogin.ShowModal;
end;

procedure TfrmPrincipal.btnMesasClick(Sender: TObject);
begin
  FrmMesas := TFrmMesas.Create(self);
  FrmMesas.ShowModal;
end;

procedure TfrmPrincipal.btnNivelEstoqueClick(Sender: TObject);
begin
  FrmEstoque := TFrmEstoque.Create(self);
  FrmEstoque.Show;
end;

procedure TfrmPrincipal.btnNovaReservaClick(Sender: TObject);
begin
   FrmReservas := TFrmReservas.Create(self);
   FrmReservas.ShowModal;
end;

procedure TfrmPrincipal.btnNovoPedidoClick(Sender: TObject);
begin
  FrmPedidos := TFrmPedidos.Create(self);
  FrmPedidos.Show;
end;

procedure TfrmPrincipal.btnPagamentosClick(Sender: TObject);
begin

   FrmPagamentos := TFrmPagamentos.Create(self);
   FrmPagamentos.ShowModal;
end;

procedure TfrmPrincipal.btnPratosClick(Sender: TObject);
begin
   FrmPratos := TFrmPratos.Create(self);
   FrmPratos.ShowModal;
end;

procedure TfrmPrincipal.btnQuadroReservasClick(Sender: TObject);
begin
    FrmQuadroReservas := TFrmQuadroReservas.Create(self);
  FrmQuadroReservas.Show;
end;

procedure TfrmPrincipal.btnRelMovimentacoesClick(Sender: TObject);
begin
   FrmRelMovimentacoes := TFrmRelMovimentacoes.Create(self);
  FrmRelMovimentacoes.Show;
end;

procedure TfrmPrincipal.btnRelPedidosClick(Sender: TObject);
begin
   FrmRelPedidos := TFrmRelPedidos.Create(self);
   FrmRelPedidos.Show;
end;

procedure TfrmPrincipal.btnRelProdutosClick(Sender: TObject);
begin
  {passando nova consulta parar o relatorio}
  DataModule1.queryConProd.Close;
  DataModule1.queryConProd.SQL.Clear;
  DataModule1.queryConProd.SQL.Add('select p.id, p.nome, p.descricao, p.valor, p.quantidade, p.fornecedor, f.nome, p.imagem from produtos as p INNER JOIN fornecedores as f ON p.fornecedor = f.id order by p.nome asc') ;
  DataModule1.queryConProd.Open;

DataModule1.rel_produtos.LoadFromFile(GetCurrentDir + '\Rel\RelProdutos.fr3');

DataModule1.rel_produtos.ShowReport();
end;

procedure TfrmPrincipal.btnRelVendasClick(Sender: TObject);
begin
  FrmRelVendas := TFrmRelVendas.Create(self);
  FrmRelVendas.Show;
end;

procedure TfrmPrincipal.btnTelaPedidosClick(Sender: TObject);
begin
   FrmTelaPedidos := TFrmTelaPedidos.Create(self);
  FrmTelaPedidos.Show;
end;

procedure TfrmPrincipal.FormActivate(Sender: TObject);
begin
  totalizarEntradas;
  totalizarSaidas;
  totalizar;
  totalizarPedidos;
  totalizarReservas;
  verificarEstoque;
  buscarAgendadas;
  buscarMovimentacoes;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin

  Panel1.Color := ConverterRGB(148, 147, 149);
  Panel2.Color := ConverterRGB(238, 238, 238);
  lblEntradas.Font.Color := ConverterRGB(206, 254, 192);
  lblSaidas.Font.Color := ConverterRGB(254, 203, 203);

  lblUsuario.Caption := nomeFuncionario;
  lblCargo.Caption := cargoFuncionario;
  lblData.Caption := DateToStr(Date);
  lblHora.Caption := TimeToStr(Time);

  if lblCargo.Caption = 'Gerente' then
begin
  Panel4.Enabled := true;
    btnFuncionarios.Enabled := true;
    btnEntradaProdutos.Enabled := true;
    btnNivelEstoque.Enabled := true;
    btnConsultaPedidos.Enabled := true;
end;
end;

procedure TfrmPrincipal.NovaVendaClick(Sender: TObject);
begin
  FrmVendas := TFrmVendas.Create(self);
  FrmVendas.ShowModal;
end;

procedure TfrmPrincipal.Panel4Click(Sender: TObject);
begin
   FrmEstoque := TFrmEstoque.Create(self);
   FrmEstoque.Show;
end;

procedure TfrmPrincipal.pnlFundoMouseEnter(Sender: TObject);
begin
  //prc_controlar_menu (nil, false);
end;

procedure TfrmPrincipal.pnlTopoMouseEnter(Sender: TObject);
begin
    prc_controlar_menu (nil, false);
end;

procedure TfrmPrincipal.prc_controlar_menu(Botao: TSpeedButton;
  Ativar: Boolean);
  var
  i: Integer;
begin
   if Ativar then
   begin
     // percorrer todos os componentes do form
     for I := 0 to frmPrincipal.ComponentCount - 1 do
     begin
       //testa se o componente é painel  e se for tag <> 0 então é um painel de menu
       if (frmPrincipal.Components[i] is Tpanel)  and
       ((frmPrincipal.Components[i] as Tpanel).Tag <> 0) then
       begin
          //testa se o painel é o associado ao botao que foi passado por parametro
          if (frmPrincipal.Components[i] as Tpanel).Tag = Botao.Tag then
          begin
            //mostra o painel associado ao botao
            (frmPrincipal.Components[i] as Tpanel).Visible := True;
            (frmPrincipal.Components[i] as Tpanel).Left := Botao.Left;
          end else
          //se não for o painel associado ao botao que o mouse esta, então eu escondo
           (frmPrincipal.Components[i] as Tpanel).Visible := False;
       end;

     end;// fim do form

   end else //fim do ativar = true
   begin
     // percorre todos os componentes do form
      for I := 0 to frmPrincipal.ComponentCount - 1 do
     begin
          //testa se o componente é painel  e se for tag <> 0 então é um painel de menu
       if (frmPrincipal.Components[i] is Tpanel)  and
       ((frmPrincipal.Components[i] as Tpanel).Tag <> 0) then
         (frmPrincipal.Components[i] as Tpanel).Visible := False;
     end;
   end;
end;

procedure TFrmPrincipal.buscarAgendadas;
begin
DataModule1.queryConReservas.Close;
  DataModule1.queryConReservas.SQL.Clear;
  DataModule1.queryConReservas.SQL.Add('select * from reservas where data = curDate() and status = "Agendada" order by id asc') ;

  DataModule1.queryConReservas.Open;
end;

procedure TFrmPrincipal.buscarMovimentacoes;
begin
DataModule1.queryConMov.Close;
  DataModule1.queryConMov.SQL.Clear;
  DataModule1.queryConMov.SQL.Add('select * from movimentacoes WHERE data = curDate() order by id desc') ;
  DataModule1.queryConMov.Open;
  TFloatField(DataModule1.queryConMov.FieldByName('valor')).DisplayFormat:='R$ #,,,,0.00';
  formatarGrid;
end;

procedure TFrmPrincipal.formatarGrid;
begin

gridVendas.Columns.Items[0].Visible := false;

gridVendas.Columns.Items[1].FieldName := 'tipo';
gridVendas.Columns.Items[1].Title.Caption := 'Tipo';

gridVendas.Columns.Items[2].FieldName := 'movimento';
gridVendas.Columns.Items[2].Title.Caption := 'Movimento';

gridVendas.Columns.Items[3].FieldName := 'valor';
gridVendas.Columns.Items[3].Title.Caption := 'Valor';

gridVendas.Columns.Items[4].FieldName := 'funcionario';
gridVendas.Columns.Items[4].Title.Caption := 'Funcionário';


gridVendas.Columns.Items[5].Visible := false;

gridVendas.Columns.Items[6].Visible := false;
end;

procedure TFrmPrincipal.totalizar;
var
tot: real;
begin
tot := TotEntradas - TotSaidas;
if tot >= 0 then
begin
  lblSaldo.Font.Color := ConverterRGB(206, 254, 192);
  end
  else
  begin
  lblSaldo.Font.Color := ConverterRGB(254, 203, 203);
end;

lblSaldo.Caption := FormatFloat('R$ #,,,,0.00', tot);

end;

procedure TFrmPrincipal.totalizarEntradas;
var
tot: real;
begin
DataModule1.queryConMov.Close;
  DataModule1.queryConMov.SQL.Clear;
  DataModule1.queryConMov.SQL.Add('select sum(valor) as total from movimentacoes where data = curDate() and tipo = "Entrada" ') ;

  DataModule1.queryConMov.Open;
  tot := DataModule1.queryConMov.FieldByName('total').AsFloat;
  TotEntradas := tot;
  lblEntradas.Caption := FormatFloat('R$ #,,,,0.00', tot);


end;

procedure TFrmPrincipal.totalizarPedidos;
begin
DataModule1.queryConPedidos.Close;
  DataModule1.queryConPedidos.SQL.Clear;
  DataModule1.queryConPedidos.SQL.Add('select * from pedidos where data = CurDate()') ;

  DataModule1.queryConPedidos.Prepare;
  DataModule1.queryConPedidos.Open;
  lblPedidos.Caption := inttoStr(DataModule1.queryConPedidos.RecordCount);
end;

procedure TFrmPrincipal.totalizarReservas;
begin
DataModule1.queryConReservas.Close;
  DataModule1.queryConReservas.SQL.Clear;
  DataModule1.queryConReservas.SQL.Add('select * from reservas where data = CurDate()') ;

  DataModule1.queryConReservas.Prepare;
  DataModule1.queryConReservas.Open;
  lblReservas.Caption := inttoStr(DataModule1.queryConReservas.RecordCount);
end;

procedure TFrmPrincipal.totalizarSaidas;
var
tot: real;
begin
DataModule1.queryConMov.Close;
  DataModule1.queryConMov.SQL.Clear;
  DataModule1.queryConMov.SQL.Add('select sum(valor) as total from movimentacoes where data = CurDate() and tipo = "Saída" ') ;

  DataModule1.queryConMov.Prepare;
  DataModule1.queryConMov.Open;
  tot := DataModule1.queryConMov.FieldByName('total').AsFloat;
  TotSaidas := tot;
  lblSaidas.Caption := FormatFloat('R$ #,,,,0.00', tot);

end;

procedure TFrmPrincipal.verificarEstoque;
begin
DataModule1.queryConProd.Close;
  DataModule1.queryConProd.SQL.Clear;
  DataModule1.queryConProd.SQL.Add('select p.id, p.nome, p.descricao, p.valor, p.quantidade, p.fornecedor, f.nome, p.imagem from produtos as p INNER JOIN fornecedores as f ON p.fornecedor = f.id where quantidade < 11') ;

  DataModule1.queryConProd.Prepare;
  DataModule1.queryConProd.Open;

   if DataModule1.queryConProd.RecordCount > 0 then
   begin
     Panel4.Color := ConverterRGB(250, 54, 38);
     lblEstoque.Caption := 'Estoque Baixo';
     end
     else
     begin
     Panel4.Color := ConverterRGB(90, 204, 55);
     lblEstoque.Caption := 'Estoque Bom';
   end;

end;


procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
  lblHora.Caption := TimeToStr(Time);
  lblData.Caption := FormatDateTime('dddd',Date)+ (',')+ FormatDateTime('dd',Date)+(' de ')+FormatDateTime('mmmm',Date)+(' de ')+FormatDateTime('yyyy',Date);
end;

end.
