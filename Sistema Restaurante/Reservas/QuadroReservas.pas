unit QuadroReservas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TFrmQuadroReservas = class(TForm)
    pnlImg: TPanel;
    ImgBack: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel6: TPanel;
    Panel5: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel4: TPanel;
    Panel3: TPanel;
    dataBuscar: TDateTimePicker;
    Label6: TLabel;
    procedure dataBuscarChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure Panel4Click(Sender: TObject);
    procedure Panel5Click(Sender: TObject);
    procedure Panel6Click(Sender: TObject);
    procedure Panel7Click(Sender: TObject);
    procedure Panel8Click(Sender: TObject);
  private
    { Private declarations }
    procedure buscarData;
  public
    { Public declarations }
  end;

var
  FrmQuadroReservas: TFrmQuadroReservas;

implementation

{$R *.dfm}

uses modulo, Reserva;

function ConverterRGB(r, g, b : Byte) : TColor;
begin
    Result := RGB(r, g, b);
end;


procedure TFrmQuadroReservas.buscarData;
begin

              {DISPONIBILIDADE DA MESA 1}
              DataModule1.queryConReservas.sql.Clear;
              DataModule1.queryConReservas.sql.Add('select * from reservas where mesa = 1 and data = :data' );
              DataModule1.queryConReservas.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', dataBuscar.Date);
              DataModule1.queryConReservas.Open;

              if not DataModule1.queryConReservas.IsEmpty then
              begin

              Panel1.Color := ConverterRGB(255, 117, 117);
              Panel1.Enabled := false;
              end
              else
              begin
              Panel1.Color := ConverterRGB(155, 249, 188);
              Panel1.Enabled := true;
              end;


              {DISPONIBILIDADE DA MESA 2}
              DataModule1.queryConReservas.sql.Clear;
              DataModule1.queryConReservas.sql.Add('select * from reservas where mesa = 2 and data = :data' );
              DataModule1.queryConReservas.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', dataBuscar.Date);
              DataModule1.queryConReservas.Open;

              if not DataModule1.queryConReservas.IsEmpty then
              begin

              Panel2.Color := ConverterRGB(255, 117, 117);
              Panel2.Enabled := false;
              end
              else
              begin
              Panel2.Color := ConverterRGB(155, 249, 188);
              Panel2.Enabled := true;
              end;


              {DISPONIBILIDADE DA MESA 3}
              DataModule1.queryConReservas.sql.Clear;
              DataModule1.queryConReservas.sql.Add('select * from reservas where mesa = 3 and data = :data' );
              DataModule1.queryConReservas.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', dataBuscar.Date);
              DataModule1.queryConReservas.Open;

              if not DataModule1.queryConReservas.IsEmpty then
              begin

              Panel3.Color := ConverterRGB(255, 117, 117);
              Panel3.Enabled := false;
              end
              else
              begin
              Panel3.Color := ConverterRGB(155, 249, 188);
              Panel3.Enabled := true;
              end;



              {DISPONIBILIDADE DA MESA 4}
              DataModule1.queryConReservas.sql.Clear;
              DataModule1.queryConReservas.sql.Add('select * from reservas where mesa = 4 and data = :data' );
              DataModule1.queryConReservas.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', dataBuscar.Date);
              DataModule1.queryConReservas.Open;

              if not DataModule1.queryConReservas.IsEmpty then
              begin

              Panel4.Color := ConverterRGB(255, 117, 117);
              Panel4.Enabled := false;
              end
              else
              begin
              Panel4.Color := ConverterRGB(155, 249, 188);
              Panel4.Enabled := true;
              end;



              {DISPONIBILIDADE DA MESA 5}
              DataModule1.queryConReservas.sql.Clear;
              DataModule1.queryConReservas.sql.Add('select * from reservas where mesa = 5 and data = :data' );
              DataModule1.queryConReservas.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', dataBuscar.Date);
              DataModule1.queryConReservas.Open;

              if not DataModule1.queryConReservas.IsEmpty then
              begin

              Panel5.Color := ConverterRGB(255, 117, 117);
              Panel5.Enabled := false;
              end
              else
              begin
              Panel5.Color := ConverterRGB(155, 249, 188);
              Panel5.Enabled := true;
              end;




              {DISPONIBILIDADE DA MESA 6}
              DataModule1.queryConReservas.sql.Clear;
              DataModule1.queryConReservas.sql.Add('select * from reservas where mesa = 6 and data = :data' );
              DataModule1.queryConReservas.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', dataBuscar.Date);
              DataModule1.queryConReservas.Open;

              if not DataModule1.queryConReservas.IsEmpty then
              begin

              Panel6.Color := ConverterRGB(255, 117, 117);
              Panel6.Enabled := false;
              end
              else
              begin
              Panel6.Color := ConverterRGB(155, 249, 188);
              Panel6.Enabled := true;
              end;



              {DISPONIBILIDADE DA MESA 7}
              DataModule1.queryConReservas.sql.Clear;
              DataModule1.queryConReservas.sql.Add('select * from reservas where mesa = 7 and data = :data' );
              DataModule1.queryConReservas.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', dataBuscar.Date);
              DataModule1.queryConReservas.Open;

              if not DataModule1.queryConReservas.IsEmpty then
              begin

              Panel7.Color := ConverterRGB(255, 117, 117);
              Panel7.Enabled := false;
              end
              else
              begin
              Panel7.Color := ConverterRGB(155, 249, 188);
              Panel7.Enabled := true;
              end;




              {DISPONIBILIDADE DA MESA 8}
              DataModule1.queryConReservas.sql.Clear;
              DataModule1.queryConReservas.sql.Add('select * from reservas where mesa = 8 and data = :data' );
              DataModule1.queryConReservas.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', dataBuscar.Date);
              DataModule1.queryConReservas.Open;

              if not DataModule1.queryConReservas.IsEmpty then
              begin

              Panel8.Color := ConverterRGB(255, 117, 117);
              Panel8.Enabled := false;
              end
              else
              begin
              Panel8.Color := ConverterRGB(155, 249, 188);
              Panel8.Enabled := true;

              end;
end;

procedure TFrmQuadroReservas.dataBuscarChange(Sender: TObject);
begin
  buscarData;
end;

procedure TFrmQuadroReservas.FormActivate(Sender: TObject);
begin
  buscarData;
end;

procedure TFrmQuadroReservas.FormShow(Sender: TObject);
begin
  dataBuscar.Date := Date;
buscarData;
end;

procedure TFrmQuadroReservas.Panel1Click(Sender: TObject);
begin
  numeroMesa := '1';
dataReserva := dataBuscar.Date;
FrmReservas := TFrmReservas.Create(self);
FrmReservas.Show;
end;

procedure TFrmQuadroReservas.Panel2Click(Sender: TObject);
begin
  numeroMesa := '2';
dataReserva := dataBuscar.Date;
FrmReservas := TFrmReservas.Create(self);
FrmReservas.Show;
end;

procedure TFrmQuadroReservas.Panel3Click(Sender: TObject);
begin
  numeroMesa := '3';
dataReserva := dataBuscar.Date;
FrmReservas := TFrmReservas.Create(self);
FrmReservas.Show;
end;

procedure TFrmQuadroReservas.Panel4Click(Sender: TObject);
begin
  numeroMesa := '4';
dataReserva := dataBuscar.Date;
FrmReservas := TFrmReservas.Create(self);
FrmReservas.Show;
end;

procedure TFrmQuadroReservas.Panel5Click(Sender: TObject);
begin
  numeroMesa := '5';
dataReserva := dataBuscar.Date;
FrmReservas := TFrmReservas.Create(self);
FrmReservas.Show;
end;

procedure TFrmQuadroReservas.Panel6Click(Sender: TObject);
begin
  numeroMesa := '6';
dataReserva := dataBuscar.Date;
FrmReservas := TFrmReservas.Create(self);
FrmReservas.Show;
end;

procedure TFrmQuadroReservas.Panel7Click(Sender: TObject);
begin
  numeroMesa := '7';
dataReserva := dataBuscar.Date;
FrmReservas := TFrmReservas.Create(self);
FrmReservas.Show;
end;

procedure TFrmQuadroReservas.Panel8Click(Sender: TObject);
begin
  numeroMesa := '8';
dataReserva := dataBuscar.Date;
FrmReservas := TFrmReservas.Create(self);
FrmReservas.Show;
end;

end.
