unit Estoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TFrmEstoque = class(TForm)
    ImgBack: TImage;
    grid: TDBGrid;
    procedure FormActivate(Sender: TObject);
    procedure gridDblClick(Sender: TObject);
  private
    { Private declarations }
     procedure verificarEstoque;
  public
    { Public declarations }
  end;

var
  FrmEstoque: TFrmEstoque;

implementation

{$R *.dfm}

uses modulo, EntradasProdutos;

procedure TFrmEstoque.FormActivate(Sender: TObject);
begin
  verificarEstoque;
end;

procedure TFrmEstoque.gridDblClick(Sender: TObject);
begin
  idProduto := DataModule1.queryConProd.FieldByName('id').Value ;
nomeProduto := DataModule1.queryConProd.FieldByName('nome').Value ;
quantidadeProduto := DataModule1.queryConProd.FieldByName('quantidade').Value ;
  FrmEntradasProdutos := TFrmEntradasProdutos.Create(self);
  FrmEntradasProdutos.Show;
end;

procedure TFrmEstoque.verificarEstoque;
begin
  DataModule1.queryConProd.Close;
  DataModule1.queryConProd.SQL.Clear;
  DataModule1.queryConProd.SQL.Add('select p.id, p.nome, p.descricao, p.valor, p.quantidade, p.fornecedor, f.nome, p.imagem from produtos as p INNER JOIN fornecedores as f ON p.fornecedor = f.id where quantidade < 11') ;

  DataModule1.queryConProd.Prepare;
  DataModule1.queryConProd.Open;


end;

end.
