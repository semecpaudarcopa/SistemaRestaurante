unit Gastos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.ExtCtrls, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TFrmGastos = class(TForm)
    pnlImg: TPanel;
    ImgBack: TImage;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnDeletar: TSpeedButton;
    grid: TDBGrid;
    EdtValor: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EdtNome: TEdit;
    edtCodigo: TEdit;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    procedure btnDeletarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmGastos: TFrmGastos;
  ultimoId : integer;

implementation

{$R *.dfm}

uses modulo;

procedure TFrmGastos.btnDeletarClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o Registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

        begin
             if edtCodigo.Text <> '' then

                begin
               {SALVANDO OS DADOS}
                DataModule1.tb_gastos.Delete;
                MessageDlg('Excluído com Sucesso', mtInformation, mbOKCancel, 0);


                 {DELETANDO PEDIDO NAS MOVIMENTAÇÕES}
                 DataModule1.queryConMov.Close;
                DataModule1.queryConMov.SQL.Clear;
                DataModule1.queryConMov.SQL.Add('DELETE from movimentacoes where id_movimento = :id');
                DataModule1.queryConMov.ParamByName('id').Value :=  ultimoId;

                DataModule1.queryConMov.ExecSQL;


                EdtNome.Enabled := False;
                EdtValor.Enabled := False;
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

procedure TFrmGastos.btnEditarClick(Sender: TObject);
begin
  if (edtNome.Text <> '') and (edtValor.Text <> '') then

         begin
             {SALVANDO OS DADOS}
              DataModule1.tb_gastos.Edit;
              MessageDlg('Alterado com Sucesso', mtInformation, mbOKCancel, 0);

              EdtNome.Enabled := False;
              EdtValor.Enabled := False;
              btnEditar.Enabled := False;
              btnDeletar.Enabled := False;
        end
        else
        begin
           MessageDlg('Preencha os Campos', mtInformation, mbOKCancel, 0);
           edtNome.SetFocus;
        end;
end;

procedure TFrmGastos.btnNovoClick(Sender: TObject);
begin
  EdtNome.Enabled := True;
  EdtValor.Enabled := True;
  EdtNome.Text := '';
  btnSalvar.Enabled := True;
  edtNome.SetFocus;
  DataModule1.tb_gastos.Insert;
  DataModule1.tb_gastos.FieldByName('data').Value := DateToStr(Date);
  DataModule1.tb_gastos.FieldByName('funcionario').Value := nomeFuncionario;

end;

procedure TFrmGastos.btnSalvarClick(Sender: TObject);
begin
  if (edtNome.Text <> '') and (edtValor.Text <> '')  then

         begin
             {SALVANDO OS DADOS}

              StringReplace(edtValor.text, '.', ',', []);
              DataModule1.tb_gastos.Post;
              MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);



              {RECUPERAR O ULTIMO ID SALVO}
        DataModule1.queryConGastos.Close;
        DataModule1.queryConGastos.SQL.Clear;
        DataModule1.queryConGastos.SQL.Add('select * from gastos order by id desc') ;
        DataModule1.queryConGastos.Open;

        ultimoId := DataModule1.queryConGastos['id'];



                 {INSERINDO A VENDA NA TABELA DE MOVIMENTAÇÕES}
        DataModule1.queryConMov.Close;
        DataModule1.queryConMov.SQL.Clear;
        DataModule1.queryConMov.SQL.Add('INSERT INTO movimentacoes (tipo, movimento, valor, funcionario, data, id_movimento) values (:tipo, :movimento, :valor, :funcionario, curDate(), :id_movimento)');
        DataModule1.queryConMov.ParamByName('tipo').Value :=  'Saída';
        DataModule1.queryConMov.ParamByName('movimento').Value :=  'Gasto';
        DataModule1.queryConMov.ParamByName('valor').Value :=  edtValor.Text;
        DataModule1.queryConMov.ParamByName('funcionario').Value :=  nomeFuncionario;
         DataModule1.queryConMov.ParamByName('id_movimento').Value :=  ultimoId;
        DataModule1.queryConMov.ExecSQL;



              EdtNome.Enabled := False;
              EdtValor.Enabled := False;
              btnSalvar.Enabled := False;
        end
        else
        begin
           MessageDlg('Preencha os Campos', mtInformation, mbOKCancel, 0);
           edtNome.SetFocus;
        end;
end;

procedure TFrmGastos.gridCellClick(Column: TColumn);
begin
  edtNome.Enabled := True;
  EdtValor.Enabled := True;
  btnEditar.Enabled := True;
  btnDeletar.Enabled := True;

end;

end.
