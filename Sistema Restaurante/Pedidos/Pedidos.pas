unit Pedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TFrmPedidos = class(TForm)
    pnlImg: TPanel;
    ImgBack: TImage;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnRelatorio: TSpeedButton;
    Label6: TLabel;
    btnAnexarPedido: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    lblTotalPedidos: TLabel;
    btnAddItem: TSpeedButton;
    btnDeletar: TSpeedButton;
    gridPedidos: TDBGrid;
    EdtCodigoVenda: TEdit;
    edtCodigo: TEdit;
    edtQuantItem: TEdit;
    edtQuanDetalhes: TEdit;
    data: TDateTimePicker;
    EdtValor: TEdit;
    BtnIr: TButton;
    EdtNome: TEdit;
    EdtQuantidade: TEdit;
    grid: TDBGrid;
    cbMesa: TComboBox;
    Label3: TLabel;
    procedure btnAddItemClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure BtnIrClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
    procedure gridPedidosCellClick(Column: TColumn);
    procedure gridPedidosDblClick(Sender: TObject);
    procedure dataChange(Sender: TObject);
    procedure btnAnexarPedidoClick(Sender: TObject);
  private
    { Private declarations }
    procedure buscarTudoPedidos;
    procedure carregarCombobox;
    procedure associarCampos;
    procedure associarCamposPedidos;
    procedure buscarTudo;
    procedure buscarData;
  public
    { Public declarations }
  end;

var
  FrmPedidos: TFrmPedidos;
  total_venda: real;
  ultimoId: integer;

implementation

{$R *.dfm}

uses modulo, Pratos;


procedure LimparCampos();
begin


    With FrmPedidos do

    begin

    EdtNome.Text := '';
    EdtQuantidade.Text := '1';
    EdtValor.Text := '0';


    end
end;

procedure TFrmPedidos.associarCampos;
begin
DataModule1.tb_detalhes_pedidos.FieldByName('prato').Value := edtNome.text;
 DataModule1.tb_detalhes_pedidos.FieldByName('valor').Value := EdtValor.text;
 DataModule1.tb_detalhes_pedidos.FieldByName('quantidade').Value := EdtQuantidade.text;
 DataModule1.tb_detalhes_pedidos.FieldByName('valor_total').Value := strToFloat(EdtValor.text) * strToFloat(EdtQuantidade.text);
 DataModule1.tb_detalhes_pedidos.FieldByName('id_pedido').Value := '0' ;
 DataModule1.tb_detalhes_pedidos.FieldByName('mesa').Value := cbMesa.Text;
  DataModule1.tb_detalhes_pedidos.FieldByName('status').Value := 'Produção';

end;

procedure TFrmPedidos.associarCamposPedidos;
begin
  DataModule1.tb_pedidos.FieldByName('data').Value := DateToStr(Date);
  DataModule1.tb_pedidos.FieldByName('valor').Value := lblTotalPedidos.Caption;
  DataModule1.tb_pedidos.FieldByName('funcionario').Value := nomeFuncionario;
  DataModule1.tb_pedidos.FieldByName('id_venda').Value := '0' ;
  DataModule1.tb_pedidos.FieldByName('mesa').Value := cbMesa.Text;

end;



procedure TFrmPedidos.btnAddItemClick(Sender: TObject);
begin
  if (edtNome.Text <> '') and (edtQuantidade.Text > '0') then
begin
    DataModule1.tb_detalhes_pedidos.Insert;
    associarCampos;
    DataModule1.tb_detalhes_pedidos.Post;

    buscarTudo;
    LimparCampos();

    total_venda := total_venda + DataModule1.tb_detalhes_pedidos.FieldByName('valor_total').Value;
    lblTotalPedidos.Caption := FormatFloat('R$ #,,,,0.00', total_venda);
    cbMesa.Enabled := False;
end
else
begin
 MessageDlg('Selecione um produto e a quantidade', mtInformation, mbOKCancel, 0);
end;
end;



procedure TFrmPedidos.btnAnexarPedidoClick(Sender: TObject);
begin
  FrmPedidos := TFrmPedidos.Create(self);
  FrmPedidos.Show;
end;

procedure TFrmPedidos.btnDeletarClick(Sender: TObject);
begin
  DataModule1.tb_detalhes_pedidos.Delete;
  buscarTudo;
  btnDeletar.Enabled := false;


  total_venda := total_venda - strToFloat(edtQuantItem.Text);
  lblTotalPedidos.Caption := FormatFloat('R$ #,,,,0.00', total_venda);
end;



procedure TFrmPedidos.BtnIrClick(Sender: TObject);
begin
  FrmPratos := TFrmPratos.Create(self);
  FrmPratos.Show;
end;



procedure TFrmPedidos.btnNovoClick(Sender: TObject);
begin
  total_venda := 0;
  LimparCampos();
  btnSalvar.Enabled := True;
  btnAddItem.Enabled := True;
  btnir.Enabled := True;
  edtQuantidade.Enabled := true;
  edtQuantidade.SetFocus;


  BtnNovo.Enabled := False;
  gridPedidos.Enabled := false;
  grid.Enabled := true;

  btnDeletar.Enabled := False;
  cbMesa.Enabled := True;
end;

procedure TFrmPedidos.btnRelatorioClick(Sender: TObject);
begin
  DataModule1.queryConVendas.Close;
  DataModule1.queryConVendas.SQL.Clear;
  DataModule1.queryConVendas.SQL.Add('select * from vendas where id = :id') ;
  DataModule1.queryConVendas.ParamByName('id').Value := edtCodigoVenda.Text;
  DataModule1.queryConVendas.Open;

   DataModule1.queryConDetalhes.Close;
  DataModule1.queryConDetalhes.SQL.Clear;
  DataModule1.queryConDetalhes.SQL.Add('select * from detalhes_venda where id_venda = :id') ;
  DataModule1.queryConDetalhes.ParamByName('id').Value := edtCodigoVenda.Text;
  DataModule1.queryConDetalhes.Open;

   DataModule1.queryConPedidos.Close;
  DataModule1.queryConPedidos.SQL.Clear;
  DataModule1.queryConPedidos.SQL.Add('select * from pedidos where id = :id') ;
  DataModule1.queryConPedidos.ParamByName('id').Value := edtCodigo.Text;
  DataModule1.queryConPedidos.Open;

  DataModule1.queryConDetPedidos.Close;
  DataModule1.queryConDetPedidos.SQL.Clear;
  DataModule1.queryConDetPedidos.SQL.Add('select * from detalhes_pedidos where id_pedido = :id') ;
  DataModule1.queryConDetPedidos.ParamByName('id').Value := edtCodigo.Text;
  DataModule1.queryConDetPedidos.Open;


  DataModule1.rel_comprovante.LoadFromFile(GetCurrentDir + '\Rel\Pedidos.fr3');

  DataModule1.rel_comprovante.ShowReport();

btnRelatorio.Enabled := false;
buscarTudoPedidos;
end;



procedure TFrmPedidos.btnSalvarClick(Sender: TObject);
begin
  if lblTotalPedidos.Caption > '0' then
begin
    DataModule1.tb_pedidos.Insert;
    associarCamposPedidos;
    DataModule1.tb_pedidos.Post;
    MessageDlg('Pedido Salvo com sucesso!', mtInformation, mbOKCancel, 0);




    {RELACIONAR O ID DO PEDIDO AOS ITENS}
      DataModule1.queryConPedidos.Close;
      DataModule1.queryConPedidos.SQL.Clear;
      DataModule1.queryConPedidos.SQL.Add('select * from pedidos order by id desc') ;
      DataModule1.queryConPedidos.Open;

      ultimoId := DataModule1.queryConPedidos['id'];
      EdtCodigoVenda.Text := ultimoId.ToString;


             DataModule1.queryConDetPedidos.Close;
             DataModule1.queryConDetPedidos.SQL.Clear;
             DataModule1.queryConDetPedidos.SQL.Add('update detalhes_pedidos set id_pedido = :id where id_pedido = 0');
             DataModule1.queryConDetPedidos.ParamByName('id').Value :=  ultimoId;
             DataModule1.queryConDetPedidos.ExecSQL;



                {INSERINDO O PEDIDO NA TABELA DE MOVIMENTAÇÕES}
        DataModule1.queryConMov.Close;
        DataModule1.queryConMov.SQL.Clear;
        DataModule1.queryConMov.SQL.Add('INSERT INTO movimentacoes (tipo, movimento, valor, funcionario, data, id_movimento) values (:tipo, :movimento, :valor, :funcionario, curDate(), :id_movimento)');
        DataModule1.queryConMov.ParamByName('tipo').Value :=  'Entrada';
        DataModule1.queryConMov.ParamByName('movimento').Value :=  'Pedido';
        DataModule1.queryConMov.ParamByName('valor').Value :=  total_venda;
        DataModule1.queryConMov.ParamByName('funcionario').Value :=  nomeFuncionario;
        DataModule1.queryConMov.ParamByName('id_movimento').Value :=  ultimoId;
        DataModule1.queryConMov.ExecSQL;




    LimparCampos();
    buscarTudoPedidos;
    btnNovo.Enabled := true;
    btnSalvar.Enabled := false;
    btnAddItem.Enabled := false;
    lblTotalPedidos.Caption := '0';
    total_venda := 0;


    gridPedidos.Enabled := true;
grid.Enabled := false;

    end
    else
    begin
    MessageDlg('Adicione produtos ao pedido', mtInformation, mbOKCancel, 0);
end;

end;

procedure TFrmPedidos.buscarData;
begin
  grid.Visible := false;
  gridPedidos.Visible := True;
  DataModule1.queryConPedidos.Close;
  DataModule1.queryConPedidos.SQL.Clear;
  DataModule1.queryConPedidos.SQL.Add('select * from pedidos where data = :data order by id desc') ;
  DataModule1.queryConPedidos.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', data.Date);
  DataModule1.queryConPedidos.Open;
end;

procedure TFrmPedidos.buscarTudo;
begin
 TFloatField(DataModule1.queryConDetPedidos.FieldByName('valor')).DisplayFormat:='R$ #,,,,0.00';
  TFloatField(DataModule1.queryConDetPedidos.FieldByName('valor_total')).DisplayFormat:='R$ #,,,,0.00';


grid.Visible := true;
  gridPedidos.Visible := false;
  DataModule1.queryConDetPedidos.Close;
  DataModule1.queryConDetPedidos.SQL.Clear;
  DataModule1.queryConDetPedidos.SQL.Add('select * from detalhes_pedidos WHERE id_pedido = 0 order by id desc') ;
  DataModule1.queryConDetPedidos.Open;
end;

procedure TFrmPedidos.buscarTudoPedidos;
begin

 TFloatField(DataModule1.queryConPedidos.FieldByName('valor')).DisplayFormat:='R$ #,,,,0.00';

  grid.Visible := false;
  gridPedidos.Visible := True;
  DataModule1.queryConPedidos.Close;
  DataModule1.queryConPedidos.SQL.Clear;
  DataModule1.queryConPedidos.SQL.Add('select * from pedidos where data = curDate() order by id desc') ;
  DataModule1.queryConPedidos.Open;
end;



procedure TFrmPedidos.FormActivate(Sender: TObject);
begin
  edtNome.Text := nomePrato;
  edtValor.Text := valorPrato;
end;

procedure TFrmPedidos.FormShow(Sender: TObject);
begin
  lblTotalPedidos.Caption := FormatFloat('R$ #,,,,0.00', strToFloat(lblTotalPedidos.Caption));


  DataModule1.tb_pedidos.Active := False;
  DataModule1.tb_pedidos.Active := True;
  DataModule1.tb_detalhes_pedidos.Active := False;
  DataModule1.tb_detalhes_pedidos.Active := True;

  btnSalvar.Enabled := false;
  btnDeletar.Enabled := false;
  btnAddItem.Enabled := false;
  btnRelatorio.Enabled := false;

  data.Date := Date;

  carregarCombobox;
  buscarTudoPedidos;
  cbMesa.ItemIndex := 0;
end;



procedure TFrmPedidos.gridCellClick(Column: TColumn);
begin
  btnDeletar.Enabled := True;

if DataModule1.queryConDetPedidos.FieldByName('valor_total').Value <> null then
edtQuantItem.Text := DataModule1.queryConDetPedidos.FieldByName('valor_total').Value;

if DataModule1.queryConDetPedidos.FieldByName('quantidade').Value <> null then
EdtQuanDetalhes.Text := DataModule1.queryConDetPedidos.FieldByName('quantidade').Value;


if DataModule1.queryConDetPedidos.FieldByName('mesa').Value <> null then
cbMesa.Text := DataModule1.queryConDetPedidos.FieldByName('mesa').Value;
end;

procedure TFrmPedidos.gridPedidosCellClick(Column: TColumn);
begin
  if DataModule1.queryConPedidos.FieldByName('id').Value <> null then
edtCodigo.Text := DataModule1.queryConPedidos.FieldByName('id').Value;

if DataModule1.queryConPedidos.FieldByName('id_venda').Value <> null then
EdtCodigoVenda.Text := DataModule1.queryConPedidos.FieldByName('id_venda').Value;

btnRelatorio.Enabled := True;
end;



procedure TFrmPedidos.gridPedidosDblClick(Sender: TObject);
begin
  numeroPedido := DataModule1.queryConPedidos.FieldByName('id').Value;
  numeroMesa := DataModule1.queryConPedidos.FieldByName('mesa').Value;
  dataReserva := DataModule1.queryConPedidos.FieldByName('data').Value;
  Close;
end;

procedure TFrmPedidos.carregarCombobox;
begin



    With DataModule1.tb_mesas do
    begin


      Active := False;
      Active := True;

      if not isEmpty then
      begin
          while not Eof do
          begin
            cbMesa.Items.Add(FieldByName('mesa').AsString);
            Next;

          end;


      end;

    end;
end;



procedure TFrmPedidos.dataChange(Sender: TObject);
begin
  buscarData;
end;

end.
