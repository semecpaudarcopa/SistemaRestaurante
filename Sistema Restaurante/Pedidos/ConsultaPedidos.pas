unit ConsultaPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Buttons;

type
  TFrmConsultaPedidos = class(TForm)
    pnlImg: TPanel;
    ImgBack: TImage;
    gridPedidos: TDBGrid;
    grid: TDBGrid;
    btnDeletar: TSpeedButton;
    data: TDateTimePicker;
    Label6: TLabel;

    procedure btnDeletarClick(Sender: TObject);
    procedure dataChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure gridPedidosCellClick(Column: TColumn);
  private
    { Private declarations }
     procedure buscarPedidos;
     procedure buscarPorData;
     procedure buscarItensPedidos;
  public
    { Public declarations }
  end;

var
  FrmConsultaPedidos: TFrmConsultaPedidos;
  id : integer;

implementation

{$R *.dfm}

uses modulo;



procedure TFrmConsultaPedidos.btnDeletarClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o Registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

        begin



               {DELETANDO OS DADOS}
                  DataModule1.queryConPedidos.Close;
              DataModule1.queryConPedidos.SQL.Clear;
              DataModule1.queryConPedidos.SQL.Add('DELETE from pedidos where id = :id');
              DataModule1.queryConPedidos.ParamByName('id').Value :=  id;

              DataModule1.queryConPedidos.ExecSQL;
                MessageDlg('Excluído com Sucesso', mtInformation, mbOKCancel, 0);

                btnDeletar.Enabled := false;


                {DELETANDO OS DADOS DOS ITENS DO PEDIDO}
                 DataModule1.queryConDetPedidos.Close;
              DataModule1.queryConDetPedidos.SQL.Clear;
              DataModule1.queryConDetPedidos.SQL.Add('DELETE from detalhes_pedidos where id_pedido = :id');
              DataModule1.queryConDetPedidos.ParamByName('id').Value :=  id;

              DataModule1.queryConDetPedidos.ExecSQL;


               {DELETANDO PEDIDO NAS MOVIMENTAÇÕES}
                 DataModule1.queryConMov.Close;
              DataModule1.queryConMov.SQL.Clear;
              DataModule1.queryConMov.SQL.Add('DELETE from movimentacoes where id_movimento = :id');
              DataModule1.queryConMov.ParamByName('id').Value :=  id;

              DataModule1.queryConMov.ExecSQL;

               buscarPedidos;

        end;

end;

procedure TFrmConsultaPedidos.buscarItensPedidos;
begin
TFloatField(DataModule1.queryConDetPedidos.FieldByName('valor')).DisplayFormat:='R$ #,,,,0.00';
  TFloatField(DataModule1.queryConDetPedidos.FieldByName('valor_total')).DisplayFormat:='R$ #,,,,0.00';


 DataModule1.queryConDetPedidos.Close;
  DataModule1.queryConDetPedidos.SQL.Clear;
  DataModule1.queryConDetPedidos.SQL.Add('select * from detalhes_pedidos WHERE id_pedido = :id order by id desc') ;
  DataModule1.queryConDetPedidos.ParamByName('id').Value :=  id;
  DataModule1.queryConDetPedidos.Open;
end;

procedure TFrmConsultaPedidos.buscarPedidos;
begin

DataModule1.queryConDetPedidos.Close;
  DataModule1.queryConDetPedidos.SQL.Clear;

TFloatField(DataModule1.queryConPedidos.FieldByName('valor')).DisplayFormat:='R$ #,,,,0.00';

 DataModule1.queryConPedidos.Close;
  DataModule1.queryConPedidos.SQL.Clear;
  DataModule1.queryConPedidos.SQL.Add('select * from pedidos where data = curDate() order by id desc') ;

  DataModule1.queryConPedidos.Open;
end;

procedure TFrmConsultaPedidos.buscarPorData;
begin

DataModule1.queryConDetPedidos.Close;
  DataModule1.queryConDetPedidos.SQL.Clear;

TFloatField(DataModule1.queryConPedidos.FieldByName('valor')).DisplayFormat:='R$ #,,,,0.00';

 DataModule1.queryConPedidos.Close;
  DataModule1.queryConPedidos.SQL.Clear;
  DataModule1.queryConPedidos.SQL.Add('select * from pedidos where data = :data order by id desc') ;
  DataModule1.queryConPedidos.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', data.Date);
  DataModule1.queryConPedidos.Open;
end;

procedure TFrmConsultaPedidos.dataChange(Sender: TObject);
begin
  buscarPorData;
end;

procedure TFrmConsultaPedidos.FormShow(Sender: TObject);
begin
  btnDeletar.Enabled := false;

DataModule1.tb_pedidos.Active := False;
DataModule1.tb_pedidos.Active := True;
DataModule1.tb_detalhes_pedidos.Active := False;
DataModule1.tb_detalhes_pedidos.Active := True;


data.Date := Date;


buscarPedidos;
end;

procedure TFrmConsultaPedidos.gridPedidosCellClick(Column: TColumn);
begin
  id := DataModule1.queryConPedidos.FieldByName('id').Value;
  buscarItensPedidos;
  btnDeletar.Enabled := true;
end;

end.
