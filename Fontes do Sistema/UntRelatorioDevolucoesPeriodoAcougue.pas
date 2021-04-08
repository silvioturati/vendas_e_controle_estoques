unit UntRelatorioDevolucoesPeriodoAcougue;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ExtCtrls, Buttons, Db, DBTables;

type
  TFrmRelatorioDevolucoesPeriodoAcougue = class(TForm)
    RadioGroup1: TRadioGroup;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit2: TMaskEdit;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    QueryPagar: TQuery;
    DsPagar: TDataSource;
    MaskEdit1: TMaskEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelatorioDevolucoesPeriodoAcougue: TFrmRelatorioDevolucoesPeriodoAcougue;
  nTotalGeral : Real;
implementation

uses UntQRRelatorioDevolucoesPeriodoAcougue;


{$R *.DFM}

procedure TFrmRelatorioDevolucoesPeriodoAcougue.BitBtn1Click(
  Sender: TObject);
begin
  Application.CreateForm(TFrmQRRelatorioDevolucoesPeriodoAcougue, FrmQRRelatorioDevolucoesPeriodoAcougue);
  If (MaskEdit1.Text = '  /  /    ') or (MaskEdit2.Text = '  /  /    ') Then
  Begin
    Application.MessageBox('Data em branco !!! '+Chr(13)+Chr(13)+' Preencha-a e tente novamente ','Advertência',48);
    Abort;
  End;
  QueryPagar.Active := False;
  QueryPagar.SQL.Clear;
  QueryPagar.SQL.Add('Select Clientes.Codigo, Clientes.Fantasia, Clientes.Razao,');
  QueryPagar.SQL.Add(' DevolucaoBoi.Codigo, DevolucaoBoi.Dev_Nr, DevolucaoBoi.Data, Sum(DevolucaoBoi.Total) AS TOTAL');
  QueryPagar.SQL.Add('From Clientes, DevolucaoBoi');
  QueryPagar.SQL.Add('Where Clientes.Codigo = DevolucaoBoi.Codigo AND');
  QueryPagar.SQL.Add('DevolucaoBoi.Data >= :MaskEdit1.Text AND');
  QueryPagar.SQL.Add('DevolucaoBoi.Data <= :MaskEdit2.Text');
  QueryPagar.SQL.Add('Group By Clientes.Codigo, Clientes.Fantasia, Clientes.Razao,');
  QueryPagar.SQL.Add(' DevolucaoBoi.Codigo, DevolucaoBoi.Dev_Nr, DevolucaoBoi.Data, DevolucaoBoi.Total');
  If RadioGroup1.ItemIndex = 0 Then // Por ordem de Nome Fantasia
    QueryPagar.SQL.Add('Order By Fantasia')
  Else
    QueryPagar.SQL.Add('Order By Razao');
  QueryPagar.Params[0].AsDateTime := StrToDate(MaskEdit1.Text);
  QueryPagar.Params[1].AsDateTime := StrToDate(MaskEdit2.Text);
  QueryPagar.Active := True;
  FrmQrRelatorioDevolucoesPeriodoAcougue.QRLabel6.Caption := MaskEdit1.Text + ' à '+MaskEdit2.Text;
  If RadioGroup1.ItemIndex = 0 Then // Por ordem de Nome Fantasia
  begin
    FrmQrRelatorioDevolucoesPeriodoAcougue.QRLabel8.Caption := 'Nome Fantasia';
    FrmQrRelatorioDevolucoesPeriodoAcougue.QrDbText2.DataField := 'Fantasia';
  End
  Else
  begin
    FrmQrRelatorioDevolucoesPeriodoAcougue.QRLabel8.Caption := 'Razão Social';
    FrmQrRelatorioDevolucoesPeriodoAcougue.QrDbText2.DataField := 'Razao';
  end;
  nTotalGeral := 0;
  QueryPagar.First;
  While not QueryPagar.EOF do
  begin
    nTotalGeral := nTotalGeral + QueryPagar.FieldByName('Total').AsFloat;
    QueryPagar.Next;
  End;
  FrmQrRelatorioDevolucoesPeriodoAcougue.QRLabel13.Caption := FormatFloat('###,###,###,##0.00',nTotalGeral);
  FrmQrRelatorioDevolucoesPeriodoAcougue.QuickRep1.Preview;
  FrmQRRelatorioDevolucoesPeriodoAcougue.Destroy;
end;

procedure TFrmRelatorioDevolucoesPeriodoAcougue.BitBtn2Click(
  Sender: TObject);
begin
  Application.CreateForm(TFrmQRRelatorioDevolucoesPeriodoAcougue, FrmQRRelatorioDevolucoesPeriodoAcougue);
  If (MaskEdit1.Text = '  /  /    ') or (MaskEdit2.Text = '  /  /    ') Then
  Begin
    Application.MessageBox('Data em branco !!! '+Chr(13)+Chr(13)+' Preencha-a e tente novamente ','Advertência',48);
    Abort;
  End;
  QueryPagar.Active := False;
  QueryPagar.SQL.Clear;
  QueryPagar.SQL.Add('Select Clientes.Codigo, Clientes.Fantasia, Clientes.Razao,');
  QueryPagar.SQL.Add(' DevolucaoBoi.Codigo, DevolucaoBoi.Dev_Nr, DevolucaoBoi.Data, Sum(DevolucaoBoi.Total) AS TOTAL');
  QueryPagar.SQL.Add('From Clientes, DevolucaoBoi');
  QueryPagar.SQL.Add('Where Clientes.Codigo = DevolucaoBoi.Codigo AND');
  QueryPagar.SQL.Add('DevolucaoBoi.Data >= :MaskEdit1.Text AND');
  QueryPagar.SQL.Add('DevolucaoBoi.Data <= :MaskEdit2.Text');
  QueryPagar.SQL.Add('Group By Clientes.Codigo, Clientes.Fantasia, Clientes.Razao,');
  QueryPagar.SQL.Add(' DevolucaoBoi.Codigo, DevolucaoBoi.Dev_Nr, DevolucaoBoi.Data, DevolucaoBoi.Total');
  If RadioGroup1.ItemIndex = 0 Then // Por ordem de Nome Fantasia
    QueryPagar.SQL.Add('Order By Fantasia')
  Else
    QueryPagar.SQL.Add('Order By Razao');
  QueryPagar.Params[0].AsDateTime := StrToDate(MaskEdit1.Text);
  QueryPagar.Params[1].AsDateTime := StrToDate(MaskEdit2.Text);
  QueryPagar.Active := True;
  FrmQrRelatorioDevolucoesPeriodoAcougue.QRLabel6.Caption := MaskEdit1.Text + ' à '+MaskEdit2.Text;
  If RadioGroup1.ItemIndex = 0 Then // Por ordem de Nome Fantasia
  begin
    FrmQrRelatorioDevolucoesPeriodoAcougue.QRLabel8.Caption := 'Nome Fantasia';
    FrmQrRelatorioDevolucoesPeriodoAcougue.QrDbText2.DataField := 'Fantasia';
  End
  Else
  begin
    FrmQrRelatorioDevolucoesPeriodoAcougue.QRLabel8.Caption := 'Razão Social';
    FrmQrRelatorioDevolucoesPeriodoAcougue.QrDbText2.DataField := 'Razao';
  end;
  nTotalGeral := 0;
  QueryPagar.First;
  While not QueryPagar.EOF do
  begin
    nTotalGeral := nTotalGeral + QueryPagar.FieldByName('Total').AsFloat;
    QueryPagar.Next;
  End;
  FrmQrRelatorioDevolucoesPeriodoAcougue.QRLabel13.Caption := FormatFloat('###,###,###,##0.00',nTotalGeral);
  FrmQrRelatorioDevolucoesPeriodoAcougue.QuickRep1.Print;
  FrmQRRelatorioDevolucoesPeriodoAcougue.Destroy;
end;

procedure TFrmRelatorioDevolucoesPeriodoAcougue.BitBtn3Click(
  Sender: TObject);
begin
   close;
end;

end.
