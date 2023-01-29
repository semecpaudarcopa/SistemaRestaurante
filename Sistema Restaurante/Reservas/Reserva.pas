unit Reserva;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Data.DB,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.Buttons;

type
  TFrmReservas = class(TForm)
    pnlImg: TPanel;
    ImgBack: TImage;
    cbMesa: TComboBox;
    data: TDateTimePicker;
    dataBuscar: TDateTimePicker;
    edtCodigo: TEdit;
    EdtNome: TEdit;
    grid: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    btnDeletar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    procedure btnDeletarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure dataBuscarChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
  private
    { Private declarations }
    procedure buscarTudo;
    procedure carregarCombobox;
    procedure associarCampos;
    procedure buscarData;
    procedure buscarAgendadas;
  public
    { Public declarations }
  end;

var
  FrmReservas: TFrmReservas;

implementation

{$R *.dfm}

uses modulo;

procedure LimparCampos();
begin
    With FrmReservas do

    begin
    EdtNome.Text := '';
    cbMesa.ItemIndex := 0;
    data.Date := Date;
    end
end;


procedure HabilitarCampos();
begin
    With FrmReservas do

    begin
    EdtNome.Enabled := True;
    data.Enabled := True;
    cbMesa.Enabled := true;
    end
end;


procedure DesabilitarCampos();
begin
    With FrmReservas do

    begin
    LimparCampos;
    EdtNome.Enabled := False;
    data.Enabled := False;
    cbMesa.Enabled := False;
    end
end;

procedure TFrmReservas.associarCampos;
begin


      DataModule1.tb_reservas.FieldByName('cliente').Value := edtNome.Text;
      DataModule1.tb_reservas.FieldByName('mesa').Value := cbMesa.text;
      DataModule1.tb_reservas.FieldByName('data').Value := data.Date;
      DataModule1.tb_reservas.FieldByName('status').Value := 'Agendada';

end;



procedure TFrmReservas.btnDeletarClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o Registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

        begin
             if edtCodigo.Text <> '' then

                begin
               {DELETANDO OS DADOS}
                DataModule1.tb_reservas.Delete;
                MessageDlg('Excluído com Sucesso', mtInformation, mbOKCancel, 0);
                buscarTudo;
                DesabilitarCampos();
                btnEditar.Enabled := False;
                btnDeletar.Enabled := False;
                end
                else
                begin
                   MessageDlg('Selecione um Registro para Exclusão', mtInformation, mbOKCancel, 0);
                   edtNome.SetFocus;
                 end;



        end;
end;

procedure TFrmReservas.btnEditarClick(Sender: TObject);
begin
    DataModule1.tb_reservas.Edit;
     if (edtNome.Text <> '') then

         begin
             {EDITANDO OS DADOS}
              associarCampos;


             {VERIFICAR SE A MESA ESTÁ LIBERADA}

              DataModule1.queryConReservas.sql.Clear;
              DataModule1.queryConReservas.sql.Add('select * from reservas where mesa = :mesa and data = :data' );
               DataModule1.queryConReservas.ParamByName('mesa').Value :=  cbMesa.Text;
               DataModule1.queryConReservas.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', data.Date);
              DataModule1.queryConReservas.Open;



              if not DataModule1.queryConReservas.IsEmpty then
              begin

               MessageDlg('Essa mesa não está disponível nessa data', mtInformation, [mbOk], 0);

               Exit;
              end;



              DataModule1.queryConReservas.Close;
              DataModule1.queryConReservas.SQL.Clear;
              DataModule1.queryConReservas.SQL.Add('update reservas set cliente = :nome, mesa = :mesa, data = :data where id = :id');
              DataModule1.queryConReservas.ParamByName('nome').Value := edtNome.Text;
              DataModule1.queryConReservas.ParamByName('mesa').Value := cbMesa.Text;
              DataModule1.queryConReservas.ParamByName('data').Value := FormatDateTime('yyyy/mm/dd', data.Date);


              DataModule1.queryConReservas.ParamByName('id').Value := edtCodigo.Text;
              DataModule1.queryConReservas.ExecSQL;



              MessageDlg('Alterado com Sucesso', mtInformation, mbOKCancel, 0);
              buscarTudo;
              DesabilitarCampos();
              btnEditar.Enabled := False;
              btnDeletar.Enabled := False;
        end
        else
        begin
           MessageDlg('Preencha os Campos', mtInformation, mbOKCancel, 0);
           edtNome.SetFocus;
        end;
end;

procedure TFrmReservas.btnNovoClick(Sender: TObject);
begin
  HabilitarCampos();
LimparCampos();
btnSalvar.Enabled := True;
edtNome.SetFocus;

DataModule1.tb_reservas.Insert;


BtnNovo.Enabled := False;
grid.Enabled := False;
end;

procedure TFrmReservas.btnSalvarClick(Sender: TObject);
begin
  if (edtNome.Text <> '') then

         begin
             {SALVANDO OS DADOS}
             associarCampos;




             {VERIFICAR SE A MESA ESTÁ LIBERADA}

              DataModule1.queryConReservas.sql.Clear;
              DataModule1.queryConReservas.sql.Add('select * from reservas where mesa = :mesa and data = :data' );
               DataModule1.queryConReservas.ParamByName('mesa').Value :=  cbMesa.Text;
               DataModule1.queryConReservas.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', data.Date);
              DataModule1.queryConReservas.Open;



              if not DataModule1.queryConReservas.IsEmpty then
              begin

               MessageDlg('Essa mesa não está disponível nessa data', mtInformation, [mbOk], 0);

               Exit;
              end;



              DataModule1.tb_reservas.Post;
              MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
              buscarTudo;
              DesabilitarCampos();


              btnSalvar.Enabled := False;
              btnNovo.Enabled := True;
              grid.Enabled := True;


        end
        else
        begin
           MessageDlg('Preencha os Campos', mtInformation, mbOKCancel, 0);
           edtNome.SetFocus;
        end;


end;

procedure TFrmReservas.buscarAgendadas;
begin
DataModule1.queryConReservas.Close;
  DataModule1.queryConReservas.SQL.Clear;
  DataModule1.queryConReservas.SQL.Add('select * from reservas where data = curDate() and status = "Agendada" order by id asc') ;

  DataModule1.queryConReservas.Open;
end;

procedure TFrmReservas.buscarData;
begin
 DataModule1.queryConReservas.Close;
  DataModule1.queryConReservas.SQL.Clear;
  DataModule1.queryConReservas.SQL.Add('select * from reservas where data = :data order by id asc') ;
  DataModule1.queryConReservas.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', dataBuscar.Date);
  DataModule1.queryConReservas.Open;
end;

procedure TFrmReservas.buscarTudo;
begin
DataModule1.queryConReservas.Close;
  DataModule1.queryConReservas.SQL.Clear;
  DataModule1.queryConReservas.SQL.Add('select * from reservas order by data asc') ;
  DataModule1.queryConReservas.Open;
end;

procedure TFrmReservas.carregarCombobox;
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

procedure TFrmReservas.dataBuscarChange(Sender: TObject);
begin
buscarData;
end;

procedure TFrmReservas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
numeroMesa := '';
end;

procedure TFrmReservas.FormShow(Sender: TObject);
begin
  buscarAgendadas;
DataModule1.tb_reservas.Active := False;
DataModule1.tb_reservas.Active := True;
carregarCombobox;
data.Date := Date;
dataBuscar.Date := Date;

btnEditar.Enabled := false;
btnSalvar.Enabled := false;
btnDeletar.Enabled := false;
if numeroMesa <> '' then
begin
HabilitarCampos();

btnSalvar.Enabled := True;
edtNome.SetFocus;

DataModule1.tb_reservas.Insert;


BtnNovo.Enabled := False;
grid.Enabled := False;

cbMesa.Text := numeroMesa;
data.Date := dataReserva;
end;
end;

procedure TFrmReservas.gridCellClick(Column: TColumn);
begin
  HabilitarCampos();
btnEditar.Enabled := True;
btnDeletar.Enabled := True;

DataModule1.tb_reservas.Edit;

if DataModule1.queryConReservas.FieldByName('cliente').Value <> null then
edtNome.Text := DataModule1.queryConReservas.FieldByName('cliente').Value;

if DataModule1.queryConReservas.FieldByName('mesa').Value <> null then
cbMesa.Text := DataModule1.queryConReservas.FieldByName('mesa').Value;

if DataModule1.queryConReservas.FieldByName('data').Value <> null then
data.Date  := DataModule1.queryConReservas.FieldByName('data').Value ;



EdtCodigo.Text := DataModule1.queryConReservas.FieldByName('id').Value ;
end;

end.
