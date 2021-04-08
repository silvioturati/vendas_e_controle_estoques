unit UntListaProdutosAvicla;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Db, DBTables;

type
  TFrmListaProdutosAvicola = class(TForm)
    RadioGroup1: TRadioGroup;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Bevel1: TBevel;
    DsProdutosFra: TDataSource;
    TbProdutosFra: TTable;
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmListaProdutosAvicola: TFrmListaProdutosAvicola;

implementation

uses UntQrListaProdutosFra;

{$R *.DFM}

procedure TFrmListaProdutosAvicola.RadioGroup1Click(Sender: TObject);
begin
  If RadioGroup1.ItemIndex = 0 Then
    TbProdutosFra.IndexName := ''
  Else
    TbProdutosFra.IndexName := 'Pro_DescFra';
end;

procedure TFrmListaProdutosAvicola.BitBtn1Click(Sender: TObject);
begin
  FrmQrListaProdutos.QuickRep1.Print;
end;

procedure TFrmListaProdutosAvicola.BitBtn2Click(Sender: TObject);
begin
  FrmQrListaProdutos.QuickRep1.Preview;
end;

procedure TFrmListaProdutosAvicola.BitBtn3Click(Sender: TObject);
begin
  FrmListaProdutosAvicola.Close;
end;

procedure TFrmListaProdutosAvicola.FormShow(Sender: TObject);
begin
  TbProdutosFra.Active := True;
end;

procedure TFrmListaProdutosAvicola.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  TbProdutosFra.Active := False;
end;

end.
