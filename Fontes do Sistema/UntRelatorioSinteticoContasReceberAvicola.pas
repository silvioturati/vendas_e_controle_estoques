unit UntRelatorioSinteticoContasReceberAvicola;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, DBTables, Grids, DBGrids;

type
  TFrmRelatorioSinteticoContasReceberAvicola = class(TForm)
    RadioGroup1: TRadioGroup;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DsReceber: TDataSource;
    QueryReceber: TQuery;
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
  FrmRelatorioSinteticoContasReceberAvicola: TFrmRelatorioSinteticoContasReceberAvicola;
  nTotalGeral: Real;
implementation

uses UntQrRelatorioSinteticoContasReceberAvicola;

{$R *.DFM}


procedure TFrmRelatorioSinteticoContasReceberAvicola.RadioGroup1Click(Sender: TObject);
begin
  QueryReceber.Active := False;
  QueryReceber.SQL.Clear;
  QueryReceber.SQL.Add('Select Clientes.Codigo, Clientes.Razao, Clientes.Fantasia, Sum(ReceberFra.Total)');
  QueryReceber.SQL.Add('from Clientes, ReceberFra');
  QueryReceber.SQL.Add('Where Clientes.Codigo = ReceberFra.Codigo');
  QueryReceber.SQL.Add('AND not ReceberFra.Pago = "Ok"');
  QueryReceber.SQL.Add('Group by Codigo, Razao, Fantasia');
  If RadioGroup1.ItemIndex = 0 Then  // ordem por Nome Fantasia
    QueryReceber.SQL.Add('Order by Clientes.Fantasia')
  Else // ordem por Razao Social
    QueryReceber.SQL.Add('Order by Clientes.Razao');
  QueryReceber.Active := True;
  // Somar o Total Geral da QueryReceber
  QueryReceber.First;
  nTotalGeral := 0;
  While not QueryReceber.EOF do
  Begin
    nTotalGeral := nTotalGeral + QueryReceber.FieldByName('SUM OF TOTAL').AsFloat;
    QueryReceber.Next;
  End;
end;

procedure TFrmRelatorioSinteticoContasReceberAvicola.BitBtn1Click(Sender: TObject);
begin
  If FrmRelatorioSinteticoContasReceberAvicola.RadioGroup1.ItemIndex = 0 Then // Ordem por nome fantasia
  begin
    FrmQrRelatorioSinteticoContasReceberAvicola.QRLabel6.Caption    := 'Nome Fantasia';
    FrmQrRelatorioSinteticoContasReceberAvicola.QRDBText2.DataField := 'Fantasia';
  end
  Else
  begin
    FrmQrRelatorioSinteticoContasReceberAvicola.QRLabel6.Caption := 'Razao Social';
    FrmQrRelatorioSinteticoContasReceberAvicola.QRDBText2.DataField := 'Razao';
  End;
  FrmQrRelatorioSinteticoContasReceberAvicola.QRLabel9.Caption := FormatFloat('###,###,###,##0.00',nTotalGeral);
  FrmQrRelatorioSinteticoContasReceberAvicola.QuickRep1.Print;
end;

procedure TFrmRelatorioSinteticoContasReceberAvicola.BitBtn2Click(Sender: TObject);
begin
  If FrmRelatorioSinteticoContasReceberAvicola.RadioGroup1.ItemIndex = 0 Then // Ordem por nome fantasia
  begin
    FrmQrRelatorioSinteticoContasReceberAvicola.QRLabel6.Caption    := 'Nome Fantasia';
    FrmQrRelatorioSinteticoContasReceberAvicola.QRDBText2.DataField := 'Fantasia';
  end
  Else
  begin
    FrmQrRelatorioSinteticoContasReceberAvicola.QRLabel6.Caption := 'Razao Social';
    FrmQrRelatorioSinteticoContasReceberAvicola.QRDBText2.DataField := 'Razao';
  End;
  FrmQrRelatorioSinteticoContasReceberAvicola.QrLabel9.Caption := FormatFloat('###,###,###,##0.00',nTotalGeral);
  FrmQrRelatorioSinteticoContasReceberAvicola.QuickRep1.Preview;
end;

procedure TFrmRelatorioSinteticoContasReceberAvicola.BitBtn3Click(Sender: TObject);
begin
  FrmRelatorioSinteticoContasReceberAvicola.Close;
end;

procedure TFrmRelatorioSinteticoContasReceberAvicola.FormShow(Sender: TObject);
begin
  Application.CreateForm(TfrmQrRelatorioSinteticoContasReceberAvicola, FrmQrRelatorioSinteticoContasReceberAvicola);
  QueryReceber.Active := False;
  QueryReceber.SQL.Clear;
  QueryReceber.SQL.Add('Select Clientes.Codigo, Clientes.Razao, Clientes.Fantasia, Sum(ReceberFra.Total)');
  QueryReceber.SQL.Add('from Clientes, ReceberFra');
  QueryReceber.SQL.Add('Where Clientes.Codigo = ReceberFra.Codigo');
  QueryReceber.SQL.Add('AND not ReceberFra.Pago = "Ok"');
  QueryReceber.SQL.Add('Group by Codigo, Razao, Fantasia');
  QueryReceber.SQL.Add('Order by Clientes.Fantasia');
  QueryReceber.Active := True;
  QueryReceber.First;
  nTotalGeral := 0;
  While not QueryReceber.EOF do
  Begin
    nTotalGeral := nTotalGeral + QueryReceber.FieldByName('SUM OF TOTAL').AsFloat;
    QueryReceber.Next;
  End;
end;


procedure TFrmRelatorioSinteticoContasReceberAvicola.FormClose(
  Sender: TObject; var Action: TCloseAction);
begin
  FrmQrRelatorioSinteticoContasReceberAvicola.Destroy;
end;
end.
