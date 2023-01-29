unit Pratos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.ExtCtrls, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TFrmPratos = class(TForm)
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
    EdtValor: TEdit;
    Label1: TLabel;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    procedure btnDeletarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
    procedure gridDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPratos: TFrmPratos;

implementation

{$R *.dfm}

uses modulo;

procedure TFrmPratos.btnDeletarClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o Registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

        begin
             if edtCodigo.Text <> '' then

                begin
               {SALVANDO OS DADOS}
                DataModule1.tb_pratos.Delete;
                MessageDlg('Exclu�do com Sucesso', mtInformation, mbOKCancel, 0);
                EdtNome.Enabled := False;
                EdtValor.Enabled := False;
                btnEditar.Enabled := False;
                btnDeletar.Enabled := False;
                end
                else
                begin
                   MessageDlg('Selecione um Registro para Exclus�o', mtInformation, mbOKCancel, 0);
                   edtNome.SetFocus;
                 end;



        end;
end;

procedure TFrmPratos.btnEditarClick(Sender: TObject);
begin
  if (edtNome.Text <> '') then

         begin
             {SALVANDO OS DADOS}
              DataModule1.tb_pratos.Edit;
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

procedure TFrmPratos.btnNovoClick(Sender: TObject);
begin
  EdtNome.Enabled := True;
  EdtValor.Enabled := True;
  EdtNome.Text := '';
  btnSalvar.Enabled := True;
  edtNome.SetFocus;
  DataModule1.tb_pratos.Insert;
end;

procedure TFrmPratos.btnSalvarClick(Sender: TObject);
begin
  if (edtNome.Text <> '')  then

         begin
             {SALVANDO OS DADOS}

              StringReplace(edtValor.text, '.', ',', []);
              DataModule1.tb_pratos.Post;
              MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);

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

procedure TFrmPratos.gridCellClick(Column: TColumn);
begin
  edtNome.Enabled := True;
  EdtValor.Enabled := True;
  btnEditar.Enabled := True;
  btnDeletar.Enabled := True;
end;

procedure TFrmPratos.gridDblClick(Sender: TObject);
begin
  nomePrato := edtNome.Text;
  valorPrato := EdtValor.Text;

  FrmPratos.Close;
end;

end.
