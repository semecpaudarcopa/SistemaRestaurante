unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage;

type
  TFrmLogin = class(TForm)
    pnl_Principal: TPanel;
    btnFechar: TSpeedButton;
    Shape1: TShape;
    pnl_Imagem: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Image2: TImage;
    pnl_Usuario: TPanel;
    Label3: TLabel;
    edtUsuario: TEdit;
    pnlBarra_Nome: TPanel;
    pnlEntrar: TPanel;
    btnEntrar: TSpeedButton;
    Panel1: TPanel;
    btnCancelar: TSpeedButton;
    pnlImagemLogo: TPanel;
    ImagemLogo: TImage;
    Label4: TLabel;
    edtSenha: TEdit;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ChamarLogin;
    procedure btnEntrarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

uses Principal, modulo;
procedure TFrmLogin.ChamarLogin;
begin
     if (Trim(edtUsuario.Text) <> '') and (Trim(edtSenha.Text) <> '') then
      begin
             {AQUI ENTRA O LOGIN}

             {VERIFICAR SE O USUARIO e A SENHA EXISTEM NO BANCO}
                DataModule1.queryFunc.sql.Clear;
              DataModule1.queryFunc.sql.Add('select * from funcionarios where usuario = :usuario and senha = :senha');
              DataModule1.queryFunc.ParamByName('usuario').Value := edtUsuario.Text;
              DataModule1.queryFunc.ParamByName('senha').Value := edtSenha.Text;
              DataModule1.queryFunc.Open;



              if not DataModule1.queryFunc.IsEmpty then
              begin
                  {RECUPERAR DADOS DO USUÁRIO LOGADO}
              nomeUsuario := FrmLogin.edtUsuario.Text;
              nomeFuncionario := DataModule1.queryFunc['nome'];
              cargoFuncionario := DataModule1.queryFunc['cargo'];



             FrmPrincipal := TFrmPrincipal.Create(FrmLogin);

             FrmPrincipal.ShowModal;
             end
             else
             begin
               MessageDlg('Dados Incorretos', mtInformation, mbOKCancel, 0);
               edtUsuario.SetFocus;
              end;



      end
      else
      begin
         MessageDlg('Preencha os Campos', mtInformation, mbOKCancel, 0);
      end;

end;


procedure TFrmLogin.btnCancelarClick(Sender: TObject);
begin
Close;
end;

procedure TFrmLogin.btnEntrarClick(Sender: TObject);
begin
  ChamarLogin();

end;

procedure TFrmLogin.btnFecharClick(Sender: TObject);
begin
Application.Terminate;
end;

procedure TFrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
end;

procedure TFrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
        ChamarLogin()
end;

procedure TFrmLogin.FormResize(Sender: TObject);
begin
pnl_Principal.Top := Round ( FrmLogin.Height / 2 - pnl_Principal.Height / 2 );
pnl_Principal.Left := Round ( FrmLogin.Width / 2 - pnl_Principal.Width / 2 );
end;

end.
