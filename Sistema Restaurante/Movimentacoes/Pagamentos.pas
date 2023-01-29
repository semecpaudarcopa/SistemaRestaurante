unit Pagamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.ExtCtrls, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TFrmPagamentos = class(TForm)
    pnlImg: TPanel;
    ImgBack: TImage;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnDeletar: TSpeedButton;
    edtCodigo: TEdit;
    Label2: TLabel;
    cbFuncionario: TComboBox;
    EdtValor: TEdit;
    grid: TDBGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure btnDeletarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
  private
    { Private declarations }
    procedure carregarCombobox;
  public
    { Public declarations }
  end;

var
  FrmPagamentos: TFrmPagamentos;
  ultimoId : integer;

implementation

{$R *.dfm}

uses modulo;

procedure TFrmPagamentos.btnDeletarClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o Registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

        begin
             if edtCodigo.Text <> '' then

                begin
                {SALVANDO OS DADOS}
                 DataModule1.tb_pagamentos.Delete;
                 MessageDlg('Excluído com Sucesso', mtInformation, mbOKCancel, 0);


                {DELETANDO PEDIDO NAS MOVIMENTAÇÕES}
                 DataModule1.queryConMov.Close;
                 DataModule1.queryConMov.SQL.Clear;
                 DataModule1.queryConMov.SQL.Add('DELETE from movimentacoes where id_movimento = :id');
                 DataModule1.queryConMov.ParamByName('id').Value :=  ultimoId;

                 DataModule1.queryConMov.ExecSQL;

                  cbFuncionario.Enabled := False;
                  EdtValor.Enabled := False;
                  btnEditar.Enabled := False;
                  btnDeletar.Enabled := False;
                end
                else
                begin
                   MessageDlg('Selecione um Registro para Exclusão', mtInformation, mbOKCancel, 0);

                 end;



        end;
end;



procedure TFrmPagamentos.btnEditarClick(Sender: TObject);
begin
  if (cbFuncionario.Text <> '') and (edtValor.Text <> '') then

         begin
             {SALVANDO OS DADOS}
              DataModule1.tb_pagamentos.Edit;
              MessageDlg('Alterado com Sucesso', mtInformation, mbOKCancel, 0);

              cbFuncionario.Enabled := False;
              EdtValor.Enabled := False;
              btnEditar.Enabled := False;
              btnDeletar.Enabled := False;
        end
        else
        begin
           MessageDlg('Preencha os Campos', mtInformation, mbOKCancel, 0);

        end;
end;

procedure TFrmPagamentos.btnNovoClick(Sender: TObject);
begin
   cbFuncionario.Enabled := True;
  EdtValor.Enabled := True;

  btnSalvar.Enabled := True;

  DataModule1.tb_pagamentos.Insert;
  DataModule1.tb_pagamentos.FieldByName('data').Value := DateToStr(Date);
  DataModule1.tb_pagamentos.FieldByName('gerente').Value := nomeFuncionario;
end;

procedure TFrmPagamentos.btnSalvarClick(Sender: TObject);
begin
  if (cbFuncionario.Text <> '') and (edtValor.Text <> '')  then

         begin
             {SALVANDO OS DADOS}

              StringReplace(edtValor.text, '.', ',', []);
              DataModule1.tb_pagamentos.Post;
              MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);


               {RECUPERAR O ULTIMO ID SALVO}
        DataModule1.queryConPgto.Close;
        DataModule1.queryConPgto.SQL.Clear;
        DataModule1.queryConPgto.SQL.Add('select * from pagamentos order by id desc') ;
        DataModule1.queryConPgto.Open;

        ultimoId := DataModule1.queryConPgto['id'];


                {INSERINDO A VENDA NA TABELA DE MOVIMENTAÇÕES}
         DataModule1.queryConMov.Close;
        DataModule1.queryConMov.SQL.Clear;
        DataModule1.queryConMov.SQL.Add('INSERT INTO movimentacoes (tipo, movimento, valor, funcionario, data, id_movimento) values (:tipo, :movimento, :valor, :funcionario, curDate(), :id_movimento)');
        DataModule1.queryConMov.ParamByName('tipo').Value :=  'Saída';
        DataModule1.queryConMov.ParamByName('movimento').Value :=  'Pagamento';
        DataModule1.queryConMov.ParamByName('valor').Value :=  edtValor.Text;
        DataModule1.queryConMov.ParamByName('funcionario').Value :=  nomeFuncionario;
         DataModule1.queryConMov.ParamByName('id_movimento').Value :=  ultimoId;
        DataModule1.queryConMov.ExecSQL;


             cbFuncionario.Enabled := False;
              EdtValor.Enabled := False;
              btnSalvar.Enabled := False;
        end
        else
        begin
           MessageDlg('Preencha os Campos', mtInformation, mbOKCancel, 0);

        end;

end;

procedure TFrmPagamentos.carregarCombobox;
begin
 With DataModule1.tb_funcionarios do
    begin


      Active := False;
      Active := True;

      if not isEmpty then
      begin
          while not Eof do
          begin
            cbFuncionario.Items.Add(FieldByName('nome').AsString);
            Next;

          end;


      end;

    end;
end;



procedure TFrmPagamentos.FormShow(Sender: TObject);
begin
  DataModule1.tb_funcionarios.Active := False;
  DataModule1.tb_funcionarios.Active := True;
  carregarCombobox;
end;

procedure TFrmPagamentos.gridCellClick(Column: TColumn);
begin
  cbFuncionario.Enabled := True;
  EdtValor.Enabled := True;
  btnEditar.Enabled := True;
  btnDeletar.Enabled := True;
end;

end.
