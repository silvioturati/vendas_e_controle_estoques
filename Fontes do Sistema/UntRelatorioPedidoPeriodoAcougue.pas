unit UntRelatorioPedidoPeriodoAcougue;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, DBTables, Grids, DBGrids;

type
  TFrmRelatorioPedidoPeriodoAcougue = class(TForm)
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    GroupBox2: TGroupBox;
    BtnVisualizar: TBitBtn;
    BtnImprimir: TBitBtn;
    BtnFechar: TBitBtn;
    DsReceber: TDataSource;
    QueryReceber: TQuery;
    procedure BtnVisualizarClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure consulta;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelatorioPedidoPeriodoAcougue: TFrmRelatorioPedidoPeriodoAcougue;
  nTotalGeral: real;
implementation

uses UntQrRelatorioPedidoPeriodoAcougue;


{$R *.DFM}

procedure TFrmRelatorioPedidoPeriodoAcougue.consulta;
Var cTipo: String;
Begin
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
  QueryReceber.SQL.Add('VendasBoi.Venda_Nr, VendasBoi.Data, Sum(VendasBoi.Total) AS TOTAL');
  QueryReceber.SQL.Add('From Clientes, VendasBoi');
  QueryReceber.SQL.Add('Where Clientes.Codigo = VendasBoi.Codigo AND');
  QueryReceber.SQL.Add('VendasBoi.Data >= :MaskEdit1.Text AND');
  QueryReceber.SQL.Add('VendasBoi.Data <= :MaskEdit2.Text AND');
  QueryReceber.SQL.Add('VendasBoi.Tp_Venda = :cTipo');
  QueryReceber.SQL.Add('Group By Clientes.Codigo, Clientes.Fantasia,');
  QueryReceber.SQL.Add('VendasBoi.Venda_Nr, VendasBoi.Data, Clientes.Razao,');
  QueryReceber.SQL.Add(' VendasBoi.Total');
  If RadioGroup2.ItemIndex = 0 Then // Por ordem de Nome Fantasia
    QueryReceber.SQL.Add('Order By Fantasia')
  Else
      QueryReceber.SQL.Add('Order By Razao');

  QueryReceber.Params[0].AsDateTime := StrToDate(MaskEdit1.Text);
  QueryReceber.Params[1].AsDateTime := StrToDate(MaskEdit2.Text);
  QueryReceber.Params[2].AsString   := cTipo;
  QueryReceber.Active := True;
  FrmQrRelatorioPedidoPeriodoAcougue.QRLabel6.Caption := cTipo;
  FrmQrRelatorioPedidoPeriodoAcougue.QRLabel8.Caption := MaskEdit1.Text + ' à '+MaskEdit2.Text;

  If RadioGroup2.ItemIndex = 0 Then // Por ordem de Nome Fantasia
  begin
    FrmQrRelatorioPedidoPeriodoAcougue.QRLabel10.Caption := 'Nome Fantasia';
    FrmQrRelatorioPedidoPeriodoAcougue.QrDbText2.DataField := 'Fantasia';
  End
  Else
  begin
    FrmQrRelatorioPedidoPeriodoAcougue.QRLabel10.Caption := 'Razão Social';
    FrmQrRelatorioPedidoPeriodoAcougue.QrDbText2.DataField := 'Razao';
  end;
  nTotalGeral := 0;
  QueryReceber.First;
  While not QueryReceber.EOF do
  begin
    nTotalGeral := nTotalGeral + QueryReceber.FieldByName('Total').AsFloat;
    QueryReceber.Next;
  End;
  QueryReceber.First;
  FrmQrRelatorioPedidoPeriodoAcougue.QRLabel15.Caption := FormatFloat('###,###,###,##0.00',nTotalGeral);
End;

procedure TFrmRelatorioPedidoPeriodoAcougue.BtnVisualizarClick(
  Sender: TObject);
begin
  consulta();
  FrmQrRelatorioPedidoPeriodoAcougue.QuickRep1.Preview;
end;

procedure TFrmRelatorioPedidoPeriodoAcougue.BtnImprimirClick(
  Sender: TObject);
begin
  consulta();
   FrmQrRelatorioPedidoPeriodoAcougue.QuickRep1.Print;
end;

procedure TFrmRelatorioPedidoPeriodoAcougue.BtnFecharClick(Sender: TObject);
begin
  FrmRelatorioPedidoPeriodoAcougue.Close;
end;

procedure TFrmRelatorioPedidoPeriodoAcougue.FormShow(Sender: TObject);
begin
  Application.CreateForm(TFrmQrRelatorioPedidoPeriodoAcougue, FrmQrRelatorioPedidoPeriodoAcougue);
  QueryReceber.Active := True;
end;

procedure TFrmRelatorioPedidoPeriodoAcougue.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QueryReceber.Active := False;
end;

end.
