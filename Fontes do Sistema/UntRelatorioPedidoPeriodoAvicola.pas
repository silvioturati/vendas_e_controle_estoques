unit UntRelatorioPedidoPeriodoAvicola;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Mask, Db, DBTables, Grids, DBGrids;

type
  TFrmRelatorioPedidoPeriodoAvicola = class(TForm)
    RadioGroup1: TRadioGroup;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    DsReceber: TDataSource;
    QueryReceber: TQuery;
    RadioGroup2: TRadioGroup;
    GroupBox2: TGroupBox;
    BtnVisualizar: TBitBtn;
    BtnImprimir: TBitBtn;
    BtnFechar: TBitBtn;
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure BtnVisualizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelatorioPedidoPeriodoAvicola: TFrmRelatorioPedidoPeriodoAvicola;
  nTotalGeral: Real;

implementation

uses UntQrRelatorioEstatisticaPedidosAvicola,
  UntQrRelatorioPedidoPeriodoAvicola;

{$R *.DFM}

procedure TFrmRelatorioPedidoPeriodoAvicola.BtnFecharClick(
  Sender: TObject);
begin
  FrmRelatorioPedidoPeriodoAvicola.Close;
end;

procedure TFrmRelatorioPedidoPeriodoAvicola.BtnImprimirClick(
  Sender: TObject);
Var cTipo: String;
begin
  Application.CreateForm(TFrmQrRelatorioPedidoPeriodoAvicola, FrmQrRelatorioPedidoPeriodoAvicola);
  If (MaskEdit1.Text = '  /  /    ') or (MaskEdit2.Text = '  /  /    ') Then
  Begin
    Application.MessageBox('Data em branco !!! '+Chr(13)+Chr(13)+' Preencha-a e tente novamente ','Advertência',48);
    Abort;
  End;
  Case RadioGroup1.ItemIndex of
    0: cTipo := 'À Vista';
    1: cTipo := 'À Prazo';
    2: cTipo := 'Transferência';
    3: cTipo := 'Balcão';
  End;
  QueryReceber.Active := False;
  QueryReceber.SQL.Clear;
  QueryReceber.SQL.Add('Select Clientes.Codigo, Clientes.Fantasia, Clientes.Razao,');
  QueryReceber.SQL.Add('VendasFra.Venda_nr, VendasFra.Data, Sum(VendasFra.Total) AS TOTAL');
  QueryReceber.SQL.Add('From Clientes, VendasFra');
  QueryReceber.SQL.Add('Where Clientes.Codigo = VendasFra.Codigo AND');
  QueryReceber.SQL.Add('VendasFra.Data >= :MaskEdit1.Text AND');
  QueryReceber.SQL.Add('VendasFra.Data <= :MaskEdit2.Text AND');
  QueryReceber.SQL.Add('VendasFra.Tp_Venda = :cTipo');
  QueryReceber.SQL.Add('Group By Clientes.Codigo, Clientes.Fantasia,');
  QueryReceber.SQL.Add('Clientes.Razao, VendasFra.Venda_Nr, VendasFra.Data,');
  QueryReceber.SQL.Add(' VendasFra.Total');
  If RadioGroup2.ItemIndex = 0 Then // Por ordem de Nome Fantasia
    QueryReceber.SQL.Add('Order By Fantasia')
  Else
    QueryReceber.SQL.Add('Order By Razao');
  QueryReceber.Params[0].AsDateTime := StrToDate(MaskEdit1.Text);
  QueryReceber.Params[1].AsDateTime := StrToDate(MaskEdit2.Text);
  QueryReceber.Params[2].AsString   := cTipo;
  QueryReceber.Active := True;
  FrmQrRelatorioPedidoPeriodoAvicola.QRLabel6.Caption := cTipo;
  FrmQrRelatorioPedidoPeriodoAvicola.QRLabel8.Caption := MaskEdit1.Text + ' à '+MaskEdit2.Text;
  If RadioGroup2.ItemIndex = 0 Then // Por ordem de Nome Fantasia
  begin
    FrmQrRelatorioPedidoPeriodoAvicola.QRLabel10.Caption := 'Nome Fantasia';
    FrmQrRelatorioPedidoPeriodoAvicola.QrDbText2.DataField := 'Fantasia';
  End
  Else
  begin
    FrmQrRelatorioPedidoPeriodoAvicola.QRLabel10.Caption := 'Razão Social';
    FrmQrRelatorioPedidoPeriodoAvicola.QrDbText2.DataField := 'Razao';
  end;
  nTotalGeral := 0;
  QueryReceber.First;
  While not QueryReceber.EOF do
  begin
    nTotalGeral := nTotalGeral + QueryReceber.FieldByName('Total').AsFloat;
    QueryReceber.Next;
  End;
  FrmQrRelatorioPedidoPeriodoAvicola.QRLabel15.Caption := FormatFloat('###,###,###,##0.00',nTotalGeral);
  FrmQrRelatorioPedidoPeriodoAvicola.QuickRep1.Print;
  FrmQrRelatorioPedidoPeriodoAvicola.Destroy;
end;

procedure TFrmRelatorioPedidoPeriodoAvicola.BtnVisualizarClick(
  Sender: TObject);
Var cTipo: String;
begin
  Application.CreateForm(TFrmQrRelatorioPedidoPeriodoAvicola, FrmQrRelatorioPedidoPeriodoAvicola);
  If (MaskEdit1.Text = '  /  /    ') or (MaskEdit2.Text = '  /  /    ') Then
  Begin
    Application.MessageBox('Data em branco !!! '+Chr(13)+Chr(13)+' Preencha-a e tente novamente ','Advertência',48);
    Abort;
  End;
  Case RadioGroup1.ItemIndex of
    0: cTipo := 'À Vista';
    1: cTipo := 'À Prazo';
    2: cTipo := 'Balcão';
    3: cTipo := 'Transferência';
  End;
  QueryReceber.Active := False;
  QueryReceber.SQL.Clear;
  QueryReceber.SQL.Add('Select Clientes.Codigo, Clientes.Fantasia, Clientes.Razao,');
  QueryReceber.SQL.Add('VendasFra.Venda_Nr, VendasFra.Data, Sum(VendasFra.Total) AS TOTAL');
  QueryReceber.SQL.Add('From Clientes, VendasFra');
  QueryReceber.SQL.Add('Where Clientes.Codigo = VendasFra.Codigo AND');
  QueryReceber.SQL.Add('VendasFra.Data >= :MaskEdit1.Text AND');
  QueryReceber.SQL.Add('VendasFra.Data <= :MaskEdit2.Text AND');
  QueryReceber.SQL.Add('VendasFra.Tp_Venda = :cTipo');
  QueryReceber.SQL.Add('Group By Clientes.Codigo, Clientes.Fantasia,');
  QueryReceber.SQL.Add('VendasFra.Venda_Nr, VendasFra.Data, Clientes.Razao,');
  QueryReceber.SQL.Add(' VendasFra.Total');
  If RadioGroup2.ItemIndex = 0 Then // Por ordem de Nome Fantasia
    QueryReceber.SQL.Add('Order By Fantasia')
  Else
      QueryReceber.SQL.Add('Order By Razao');

  QueryReceber.Params[0].AsDateTime := StrToDate(MaskEdit1.Text);
  QueryReceber.Params[1].AsDateTime := StrToDate(MaskEdit2.Text);
  QueryReceber.Params[2].AsString   := cTipo;
  QueryReceber.Active := True;
  FrmQrRelatorioPedidoPeriodoAvicola.QRLabel6.Caption := cTipo;
  FrmQrRelatorioPedidoPeriodoAvicola.QRLabel8.Caption := MaskEdit1.Text + ' à '+MaskEdit2.Text;
  If RadioGroup2.ItemIndex = 0 Then // Por ordem de Nome Fantasia
  begin
    FrmQrRelatorioPedidoPeriodoAvicola.QRLabel10.Caption := 'Nome Fantasia';
    FrmQrRelatorioPedidoPeriodoAvicola.QrDbText2.DataField := 'Fantasia';
  End
  Else
  begin
    FrmQrRelatorioPedidoPeriodoAvicola.QRLabel10.Caption := 'Razão Social';
    FrmQrRelatorioPedidoPeriodoAvicola.QrDbText2.DataField := 'Razao';
  end;
  nTotalGeral := 0;
  QueryReceber.First;
  While not QueryReceber.EOF do
  begin
    nTotalGeral := nTotalGeral + QueryReceber.FieldByName('Total').AsFloat;
    QueryReceber.Next;
  End;

  FrmQrRelatorioPedidoPeriodoAvicola.QRLabel15.Caption := FormatFloat('###,###,###,##0.00',nTotalGeral);
  FrmQrRelatorioPedidoPeriodoAvicola.QuickRep1.Preview;
  FrmQrRelatorioPedidoPeriodoAvicola.Destroy;
end;

end.
