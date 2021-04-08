unit UntListaProdutosAvicola;

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

uses UntQrListaProdutosAvicola;

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
  Application.CreateForm(TFrmQrListaProdutosAvicola, FrmQrListaProdutosAvicola);
  FrmQrListaProdutosAvicola.QuickRep1.Print;
  FrmQrListaProdutosAvicola.Destroy;
end;

procedure TFrmListaProdutosAvicola.BitBtn2Click(Sender: TObject);
begin
  Application.CreateForm(TFrmQrListaProdutosAvicola, FrmQrListaProdutosAvicola);
  FrmQrListaProdutosAvicola.QuickRep1.Preview;
  FrmQrListaProdutosAvicola.Destroy;
end;

procedure TFrmListaProdutosAvicola.BitBtn3Click(Sender: TObject);
begin
  FrmListaProdutosAvicola.Close;
end;

procedure TFrmListaProdutosAvicola.FormShow(Sender: TObject);
begin
  TbProdutosFra.Active := True;
  TbProdutosFra.IndexName := 'Pro_DescFra';
end;

procedure TFrmListaProdutosAvicola.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  TbProdutosFra.IndexName := '';
  TbProdutosFra.Active := False;
end;

end.
