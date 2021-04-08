unit UntRelatorioDevolucoesPeriodoAvicola;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons, ExtCtrls, Mask, Grids, DBGrids;

type
  TFrmRelatorioDevolucoesPeriodoAvicola = class(TForm)
    RadioGroup2: TRadioGroup;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    QueryPagar: TQuery;
    DsPagar: TDataSource;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelatorioDevolucoesPeriodoAvicola: TFrmRelatorioDevolucoesPeriodoAvicola;
  nTotalGeral : Real;

implementation

uses UntQRRelatorioDevolucoesPeriodoAvicola;

{$R *.DFM}

procedure TFrmRelatorioDevolucoesPeriodoAvicola.BitBtn1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmQRRelatorioDevolucoesPeriodoAvicola, FrmQRRelatorioDevolucoesPeriodoAvicola);
  If (MaskEdit1.Text = '  /  /    ') or (MaskEdit2.Text = '  /  /    ') Then
  Begin
    Application.MessageBox('Data em branco !!! '+Chr(13)+Chr(13)+' Preencha-a e tente novamente ','Advertência',48);
    Abort;
  End;
  QueryPagar.Active := False;
  QueryPagar.SQL.Clear;
  QueryPagar.SQL.Add('Select Clientes.Codigo, Clientes.Fantasia, Clientes.Razao,');
  QueryPagar.SQL.Add('DevolucaoFra.Dev_nr, DevolucaoFra.Data, Sum(DevolucaoFra.Total) AS TOTAL');
  QueryPagar.SQL.Add('From Clientes, DevolucaoFra');
  QueryPagar.SQL.Add('Where Clientes.Codigo = DevolucaoFra.Codigo AND');
  QueryPagar.SQL.Add('DevolucaoFra.Data >= :MaskEdit1.Text AND');
  QueryPagar.SQL.Add('DevolucaoFra.Data <= :MaskEdit2.Text');
  QueryPagar.SQL.Add('Group By Clientes.Codigo, Clientes.Fantasia, Clientes.Razao,');
  QueryPagar.SQL.Add(' DevolucaoFra.Codigo, DevolucaoFra.Dev_Nr, DevolucaoFra.Data, DevolucaoFra.Total');
  If RadioGroup2.ItemIndex = 0 Then // Por ordem de Nome Fantasia
    QueryPagar.SQL.Add('Order By Fantasia')
  Else
    QueryPagar.SQL.Add('Order By Razao');
    QueryPagar.Params[0].AsDateTime := StrToDate(MaskEdit1.Text);
    QueryPagar.Params[1].AsDateTime := StrToDate(MaskEdit2.Text);
    QueryPagar.Active := True;
  FrmQrRelatorioDevolucoesPeriodoAvicola.QRLabel6.Caption := MaskEdit1.Text + ' à '+MaskEdit2.Text;
  If RadioGroup2.ItemIndex = 0 Then // Por ordem de Nome Fantasia
  begin
    FrmQrRelatorioDevolucoesPeriodoAvicola.QRLabel8.Caption := 'Nome Fantasia';
    FrmQrRelatorioDevolucoesPeriodoAvicola.QrDbText2.DataField := 'Fantasia';
  End
  Else
  begin
    FrmQrRelatorioDevolucoesPeriodoAvicola.QRLabel8.Caption := 'Razão Social';
    FrmQrRelatorioDevolucoesPeriodoAvicola.QrDbText2.DataField := 'Razao';
  end;
  nTotalGeral := 0;
  QueryPagar.First;
  While not QueryPagar.EOF do
  begin
    nTotalGeral := nTotalGeral + QueryPagar.FieldByName('Total').AsFloat;
    QueryPagar.Next;
  End;
  FrmQrRelatorioDevolucoesPeriodoAvicola.QRLabel13.Caption := FormatFloat('###,###,###,##0.00',nTotalGeral);
  FrmQrRelatorioDevolucoesPeriodoAvicola.QuickRep1.Print;
  FrmQRRelatorioDevolucoesPeriodoAvicola.Destroy;
end;

procedure TFrmRelatorioDevolucoesPeriodoAvicola.BitBtn2Click(Sender: TObject);
begin
  Application.CreateForm(TFrmQRRelatorioDevolucoesPeriodoAvicola, FrmQRRelatorioDevolucoesPeriodoAvicola);
  If (MaskEdit1.Text = '  /  /    ') or (MaskEdit2.Text = '  /  /    ') Then
  Begin
    Application.MessageBox('Data em branco !!! '+Chr(13)+Chr(13)+' Preencha-a e tente novamente ','Advertência',48);
    Abort;
  End;
  QueryPagar.Active := False;
  QueryPagar.SQL.Clear;
  QueryPagar.SQL.Add('Select Clientes.Codigo, Clientes.Fantasia, Clientes.Razao,');
  QueryPagar.SQL.Add(' DevolucaoFra.Codigo, DevolucaoFra.Dev_Nr, DevolucaoFra.Data, Sum(DevolucaoFra.Total) AS TOTAL');
  QueryPagar.SQL.Add('From Clientes, DevolucaoFra');
  QueryPagar.SQL.Add('Where Clientes.Codigo = DevolucaoFra.Codigo AND');
  QueryPagar.SQL.Add('DevolucaoFra.Data >= :MaskEdit1.Text AND');
  QueryPagar.SQL.Add('DevolucaoFra.Data <= :MaskEdit2.Text');
  QueryPagar.SQL.Add('Group By Clientes.Codigo, Clientes.Fantasia, Clientes.Razao,');
  QueryPagar.SQL.Add(' DevolucaoFra.Codigo, DevolucaoFra.Dev_Nr, DevolucaoFra.Data, DevolucaoFra.Total');
  If RadioGroup2.ItemIndex = 0 Then // Por ordem de Nome Fantasia
    QueryPagar.SQL.Add('Order By Fantasia')
  Else
    QueryPagar.SQL.Add('Order By Razao');
  QueryPagar.Params[0].AsDateTime := StrToDate(MaskEdit1.Text);
  QueryPagar.Params[1].AsDateTime := StrToDate(MaskEdit2.Text);
  QueryPagar.Active := True;
  FrmQrRelatorioDevolucoesPeriodoAvicola.QRLabel6.Caption := MaskEdit1.Text + ' à '+MaskEdit2.Text;
  If RadioGroup2.ItemIndex = 0 Then // Por ordem de Nome Fantasia
  begin
    FrmQrRelatorioDevolucoesPeriodoAvicola.QRLabel8.Caption := 'Nome Fantasia';
    FrmQrRelatorioDevolucoesPeriodoAvicola.QrDbText2.DataField := 'Fantasia';
  End
  Else
  begin
    FrmQrRelatorioDevolucoesPeriodoAvicola.QRLabel8.Caption := 'Razão Social';
    FrmQrRelatorioDevolucoesPeriodoAvicola.QrDbText2.DataField := 'Razao';
  end;
  nTotalGeral := 0;
  QueryPagar.First;
  While not QueryPagar.EOF do
  begin
    nTotalGeral := nTotalGeral + QueryPagar.FieldByName('Total').AsFloat;
    QueryPagar.Next;
  End;
  FrmQrRelatorioDevolucoesPeriodoAvicola.QRLabel13.Caption := FormatFloat('###,###,###,##0.00',nTotalGeral);
  FrmQrRelatorioDevolucoesPeriodoAvicola.QuickRep1.Preview;
  FrmQRRelatorioDevolucoesPeriodoAvicola.Destroy;
end;

procedure TFrmRelatorioDevolucoesPeriodoAvicola.BitBtn3Click(Sender: TObject);
begin
   close;
end;
end.
