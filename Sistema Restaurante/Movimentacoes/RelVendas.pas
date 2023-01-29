unit RelVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TFrmRelVendas = class(TForm)
    imgback: TImage;
    Label1: TLabel;
    Label2: TLabel;
    dataInicial: TDateTimePicker;
    dataFinal: TDateTimePicker;
    btnRel: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnRelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelVendas: TFrmRelVendas;

implementation

{$R *.dfm}

uses modulo;

procedure TFrmRelVendas.btnRelClick(Sender: TObject);
begin
  DataModule1.queryConVendas.Close;
  DataModule1.queryConVendas.SQL.Clear;
  DataModule1.queryConVendas.SQL.Add('select * from vendas where  data >= :dataInicial and data <= :dataFinal') ;
   DataModule1.queryConVendas.ParamByName('dataInicial').Value :=  FormatDateTime('yyyy/mm/dd', dataInicial.Date);
   DataModule1.queryConVendas.ParamByName('dataFinal').Value :=  FormatDateTime('yyyy/mm/dd', dataFinal.Date);
  DataModule1.queryConVendas.Open;




DataModule1.rel_vendas.LoadFromFile(GetCurrentDir + '\Rel\RelVendas.fr3');
DataModule1.rel_vendas.Variables['dataInicial'] := dataInicial.Date;
DataModule1.rel_vendas.Variables['dataFinal'] := dataFinal.Date;
DataModule1.rel_vendas.ShowReport();
end;

procedure TFrmRelVendas.FormShow(Sender: TObject);
begin
  dataInicial.Date := Date;
dataFinal.Date := Date;
end;

end.
