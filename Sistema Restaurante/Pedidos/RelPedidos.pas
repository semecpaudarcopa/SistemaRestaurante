unit RelPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TFrmRelPedidos = class(TForm)
    imgback: TImage;
    Label1: TLabel;
    Label2: TLabel;
    dataInicial: TDateTimePicker;
    dataFinal: TDateTimePicker;
    btnRel: TButton;
    procedure btnRelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelPedidos: TFrmRelPedidos;

implementation

{$R *.dfm}

uses modulo;

procedure TFrmRelPedidos.btnRelClick(Sender: TObject);
begin
  DataModule1.queryConPedidos.Close;
  DataModule1.queryConPedidos.SQL.Clear;
  DataModule1.queryConPedidos.SQL.Add('select * from pedidos where  data >= :dataInicial and data <= :dataFinal') ;
   DataModule1.queryConPedidos.ParamByName('dataInicial').Value :=  FormatDateTime('yyyy/mm/dd', dataInicial.Date);
   DataModule1.queryConPedidos.ParamByName('dataFinal').Value :=  FormatDateTime('yyyy/mm/dd', dataFinal.Date);
  DataModule1.queryConPedidos.Open;




DataModule1.rel_pedidos_data.LoadFromFile(GetCurrentDir + '\Rel\PedidosData.fr3');
DataModule1.rel_pedidos_data.Variables['dataInicial'] := dataInicial.Date;
DataModule1.rel_pedidos_data.Variables['dataFinal'] := dataFinal.Date;
DataModule1.rel_pedidos_data.ShowReport();
end;

procedure TFrmRelPedidos.FormShow(Sender: TObject);
begin
  dataInicial.Date := Date;
  dataFinal.Date := Date;
end;

end.
