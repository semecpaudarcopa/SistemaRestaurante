unit Cargos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.ExtCtrls, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TFrmCargos = class(TForm)
    pnlImg: TPanel;
    ImgBack: TImage;
    Label2: TLabel;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnDeletar: TSpeedButton;
    EdtNome: TEdit;
    grid: TDBGrid;
    edtCodigo: TEdit;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCargos: TFrmCargos;

implementation

{$R *.dfm}

uses modulo;

procedure TFrmCargos.btnDeletarClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o Registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

        begin
             if edtCodigo.Text <> '' then

                begin
               {DELETANDO OS DADOS}
                DataModule1.tb_cargo.Delete;
                MessageDlg('Excluído com Sucesso', mtInformation, mbOKCancel, 0);
                EdtNome.Enabled := False;
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

procedure TFrmCargos.btnEditarClick(Sender: TObject);
begin
  if (edtNome.Text <> '') then

         begin
             {EDITANDO OS DADOS}
              DataModule1.tb_cargo.Edit;
              MessageDlg('Alterado com Sucesso', mtInformation, mbOKCancel, 0);

              EdtNome.Enabled := False;
              btnEditar.Enabled := False;
              btnDeletar.Enabled := False;
        end
        else
        begin
           MessageDlg('Preencha os Campos', mtInformation, mbOKCancel, 0);
           edtNome.SetFocus;
        end;
end;

procedure TFrmCargos.btnNovoClick(Sender: TObject);
begin

  EdtNome.Enabled := True;
  EdtNome.Text := '';
  btnSalvar.Enabled := True;
  edtNome.SetFocus;
  DataModule1.tb_cargo.Insert;
  end;

procedure TFrmCargos.btnSalvarClick(Sender: TObject);
begin
  if (edtNome.Text <> '')  then

         begin
             {SALVANDO OS DADOS}


              DataModule1.tb_cargo.Post;
              MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);

              EdtNome.Enabled := False;
              btnSalvar.Enabled := False;
        end
        else
        begin
           MessageDlg('Preencha os Campos', mtInformation, mbOKCancel, 0);
           edtNome.SetFocus;
        end;
end;

procedure TFrmCargos.gridCellClick(Column: TColumn);
begin
  edtNome.Enabled := True;
  btnEditar.Enabled := True;
  btnDeletar.Enabled := True;
end;

end.
