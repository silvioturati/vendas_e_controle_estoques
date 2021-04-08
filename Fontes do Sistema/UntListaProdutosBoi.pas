unit UntListaProdutosBoi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons, ExtCtrls;

type
  TFrmListaProdutosBoi = class(TForm)
    RadioGroup1: TRadioGroup;
    BtnImprimir: TBitBtn;
    BtnVisualizar: TBitBtn;
    BtnFechar: TBitBtn;
    DsProdutosBoi: TDataSource;
    TbProdutosBoi: TTable;
    procedure BtnImprimirClick(Sender: TObject);
    procedure BtnVisualizarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmListaProdutosBoi: TFrmListaProdutosBoi;

implementation

uses UntQrListaProdutosBoi;

{$R *.DFM}

procedure TFrmListaProdutosBoi.BtnImprimirClick(Sender: TObject);
begin
  Application.CreateForm(TFrmQrListaProdutosBoi, FrmQrListaProdutosBoi);
  FrmQrListaProdutosBoi.QuickRep1.Print;
  FrmQrListaProdutosBoi.Destroy;
end;

procedure TFrmListaProdutosBoi.BtnVisualizarClick(Sender: TObject);
begin
  Application.CreateForm(TFrmQrListaProdutosBoi, FrmQrListaProdutosBoi);
  FrmQrListaProdutosBoi.QuickRep1.Preview;
  FrmQrListaProdutosBoi.Destroy;
end;

procedure TFrmListaProdutosBoi.BtnFecharClick(Sender: TObject);
begin
  FrmListaProdutosBoi.Close;
end;

procedure TFrmListaProdutosBoi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  TbProdutosBoi.IndexName := '';
  TbProdutosBoi.Active := False;
end;

procedure TFrmListaProdutosBoi.FormShow(Sender: TObject);
begin
  TbProdutosBoi.Active := True;
  TbProdutosBoi.IndexName := 'Pro_DescBoi';
end;

procedure TFrmListaProdutosBoi.RadioGroup1Click(Sender: TObject);
begin
  If RadioGroup1.ItemIndex = 0 Then
    TbProdutosBoi.IndexName := ''
  Else
    TbProdutosBoi.IndexName := 'Pro_DescBoi';
end;

end.
