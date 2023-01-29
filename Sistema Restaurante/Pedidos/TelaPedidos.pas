unit TelaPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TFrmTelaPedidos = class(TForm)
    Panel1: TPanel;
    grid: TDBGrid;
    Panel2: TPanel;
    gridFinalizados: TDBGrid;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    procedure formatarGridProducao;
    procedure buscarPedProducao;

    procedure formatarGridFinalizados;
    procedure buscarPedFinalizados;
  public
    { Public declarations }
  end;

var
  FrmTelaPedidos: TFrmTelaPedidos;
  id : integer;
  linhaAnterior: integer;

implementation

{$R *.dfm}

uses modulo;

procedure TFrmTelaPedidos.buscarPedFinalizados;
begin

TFloatField(DataModule1.queryConDetPedFinalizados.FieldByName('valor')).DisplayFormat:='R$ #,,,,0.00';
  TFloatField(DataModule1.queryConDetPedFinalizados.FieldByName('valor_total')).DisplayFormat:='R$ #,,,,0.00';

    DataModule1.queryConDetPedFinalizados.Close;
  DataModule1.queryConDetPedFinalizados.SQL.Clear;
  DataModule1.queryConDetPedFinalizados.SQL.Add('select * from detalhes_pedidos WHERE status = "Finalizado" order by id desc limit 4') ;
  DataModule1.queryConDetPedFinalizados.Open;
  formatarGridFinalizados;
end;

procedure TFrmTelaPedidos.buscarPedProducao;
begin
 DataModule1.queryConDetPedProducao.Close;
  DataModule1.queryConDetPedProducao.SQL.Clear;
  DataModule1.queryConDetPedProducao.SQL.Add('select * from detalhes_pedidos WHERE status = "Produção" order by id asc') ;
  DataModule1.queryConDetPedProducao.Open;
  formatarGridProducao;
end;

procedure TFrmTelaPedidos.formatarGridFinalizados;
begin
gridFinalizados.Columns[0].Title.Alignment := taCenter;
gridFinalizados.Columns[1].Title.Alignment := taCenter;
gridFinalizados.Columns[2].Title.Alignment := taCenter;
gridFinalizados.Columns[3].Title.Alignment := taCenter;
gridFinalizados.Columns[4].Title.Alignment := taCenter;
gridFinalizados.Columns[5].Title.Alignment := taCenter;
gridFinalizados.Columns[6].Title.Alignment := taCenter;
end;

procedure TFrmTelaPedidos.formatarGridProducao;
begin
grid.Columns[0].Title.Alignment := taCenter;
grid.Columns[1].Title.Alignment := taCenter;
grid.Columns[2].Title.Alignment := taCenter;




end;

procedure TFrmTelaPedidos.FormShow(Sender: TObject);
begin
  buscarPedProducao;
  buscarPedFinalizados;
end;

procedure TFrmTelaPedidos.gridCellClick(Column: TColumn);
begin
  id := DataModule1.queryConDetPedProducao.FieldByName('id').Value;

if MessageDlg('Pedido Finalizado?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

        begin
              DataModule1.queryConDetPedProducao.Close;
              DataModule1.queryConDetPedProducao.SQL.Clear;
              DataModule1.queryConDetPedProducao.SQL.Add('update detalhes_pedidos set status = "Finalizado" where id = :id');
              DataModule1.queryConDetPedProducao.ParamByName('id').Value :=  id;

              DataModule1.queryConDetPedProducao.ExecSQL;
              buscarPedProducao;
              buscarPedFinalizados;
        end;
end;

procedure TFrmTelaPedidos.Timer1Timer(Sender: TObject);
var
linhaAtual: integer;

begin
buscarPedProducao;
buscarPedFinalizados;

linhaAtual := DataModule1.queryConDetPedProducao.RecordCount;

if linhaAtual > linhaAnterior then
begin
   Beep;
end;

linhaAnterior := DataModule1.queryConDetPedProducao.RecordCount;

end;

end.
