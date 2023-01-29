unit RelMovimentacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls;

type
  TFrmRelMovimentacoes = class(TForm)
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
  FrmRelMovimentacoes: TFrmRelMovimentacoes;

implementation

{$R *.dfm}

uses modulo;

procedure TFrmRelMovimentacoes.btnRelClick(Sender: TObject);
var
totalEntradas : real;
totalSaidas: real;
begin
  DataModule1.queryConMov.Close;
  DataModule1.queryConMov.SQL.Clear;
  DataModule1.queryConMov.SQL.Add('select * from movimentacoes where  data >= :dataInicial and data <= :dataFinal') ;
  DataModule1.queryConMov.ParamByName('dataInicial').Value :=  FormatDateTime('yyyy/mm/dd', dataInicial.Date);
  DataModule1.queryConMov.ParamByName('dataFinal').Value :=  FormatDateTime('yyyy/mm/dd', dataFinal.Date);
  DataModule1.queryConMov.Open;





  DataModule1.queryRelMovEntradas.Close;
  DataModule1.queryRelMovEntradas.SQL.Clear;


  DataModule1.queryRelMovEntradas.SQL.Add('select sum(valor) as total from movimentacoes where data >= :dataInicial and data <= :dataFinal and tipo = "Entrada" ') ;
  DataModule1.queryRelMovEntradas.ParamByName('dataInicial').Value :=  FormatDateTime('yyyy/mm/dd', dataInicial.Date);
  DataModule1.queryRelMovEntradas.ParamByName('dataFinal').Value :=  FormatDateTime('yyyy/mm/dd', dataFinal.Date);
  DataModule1.queryRelMovEntradas.Prepare;
  DataModule1.queryRelMovEntradas.Open;
  totalEntradas := DataModule1.queryRelMovEntradas.FieldByName('total').AsFloat;



  DataModule1.queryRelMovSaidas.Close;
  DataModule1.queryRelMovSaidas.SQL.Clear;
  DataModule1.queryRelMovSaidas.SQL.Add('select sum(valor) as total from movimentacoes where data >= :dataInicial and data <= :dataFinal and tipo = "Saída"') ;
  DataModule1.queryRelMovSaidas.ParamByName('dataInicial').Value :=  FormatDateTime('yyyy/mm/dd', dataInicial.Date);
  DataModule1.queryRelMovSaidas.ParamByName('dataFinal').Value :=  FormatDateTime('yyyy/mm/dd', dataFinal.Date);

  DataModule1.queryRelMovSaidas.Prepare;
  DataModule1.queryRelMovSaidas.Open;
  totalSaidas := DataModule1.queryRelMovSaidas.FieldByName('total').AsFloat;


  DataModule1.rel_movimentacoes.LoadFromFile(GetCurrentDir + '\Rel\Movimentacoes.fr3');
  DataModule1.rel_movimentacoes.Variables['valorEntrada'] := totalEntradas;
  DataModule1.rel_movimentacoes.Variables['valorSaida'] := totalSaidas;
  DataModule1.rel_movimentacoes.Variables['dataInicial'] := dataInicial.Date;
  DataModule1.rel_movimentacoes.Variables['dataFinal'] := dataFinal.Date;
  DataModule1.rel_movimentacoes.ShowReport();
end;

procedure TFrmRelMovimentacoes.FormShow(Sender: TObject);
begin
  dataInicial.Date := Date;
  dataFinal.Date := Date;
end;

end.
