unit UntRelatorioEstatisticaPedidosAcougue;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, DBTables, Db;

type
  TFrmRelatorioEstatiticaPedidosAcougue = class(TForm)
    GroupBox1: TGroupBox;
    Bevel1: TBevel;
    BtnImprimir: TBitBtn;
    BtnVisualizar: TBitBtn;
    BtnFechar: TBitBtn;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    DataSource1: TDataSource;
    Query1: TQuery;
    DsAux_Temp: TDataSource;
    TbAux_Temp: TTable;
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnVisualizarClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelatorioEstatiticaPedidosAcougue: TFrmRelatorioEstatiticaPedidosAcougue;

implementation

uses UntQrRelatorioEstatisticaPedidosAcougue;

{$R *.DFM}

procedure TFrmRelatorioEstatiticaPedidosAcougue.BtnFecharClick(
  Sender: TObject);
begin
  FrmRelatorioEstatiticaPedidosAcougue.Close;
end;

procedure TFrmRelatorioEstatiticaPedidosAcougue.BtnVisualizarClick(
  Sender: TObject);
Var nTotQtde, nTotValor: Real;
begin
  Application.CreateForm(TFrmQrRelatorioEstatisticaPedidosAcougue, FrmQrRelatorioEstatisticaPedidosAcougue);
  TbAux_Temp.Active    := False;
  TbAux_Temp.Exclusive := False;
  TbAux_Temp.Exclusive := True;
  TbAux_Temp.Active    := True;
  TbAux_Temp.EmptyTable;
  Query1.Active := False;
  Query1.SQL.Clear;
  Query1.SQL.Add('Select VendasBoi.Data, Mov_VendasBoi.Cod_Prod,');
  Query1.SQL.Add('Mov_VendasBoi.Qtde, Mov_VendasBoi.Unitario, ProdutosBoi.Descricao, ');
  Query1.SQL.Add('ProdutosBoi.Unidade');
  Query1.SQL.Add('From VendasBoi, Mov_VendasBoi, ProdutosBoi');
  Query1.SQL.Add('Where VendasBoi.Venda_Nr = Mov_VendasBoi.Venda_Nr');
  Query1.SQL.Add('AND VendasBoi.Data >= :MaskEdit1.Text AND ');
  Query1.SQL.Add('VendasBoi.Data <= :MaskEdit2.Text AND ');
  Query1.SQL.Add('Mov_VendasBoi.Cod_Prod = ProdutosBoi.Codigo');
  Query1.SQL.Add('Order By Data, Cod_Prod, Qtde, Descricao, Unidade');
  Query1.Params[0].AsDateTime := StrToDate(MaskEdit1.Text);
  Query1.Params[1].AsDateTime := StrToDate(MaskEdit2.Text);
  Query1.Active := True;

  Query1.First;
  nTotQtde := 0;
  nTotValor:= 0;
  While not Query1.EOF do
  begin
    If TbAux_Temp.FindKey([Query1.FieldByName('Cod_Prod').AsString]) Then
      TbAux_Temp.Edit
    Else
      TbAux_Temp.Insert;
    TbAux_Temp.FieldByName('Cod_Prod').AsString  := Query1.FieldByName('Cod_Prod').AsString;
    TbAux_Temp.FieldByName('Descricao').AsString := Query1.FieldByName('Descricao').AsString;
    TbAux_Temp.FieldByName('Unidade').AsString   := Query1.FieldByName('Unidade').AsString;
    TbAux_Temp.FieldByName('Qtde').AsFloat       := TbAux_Temp.FieldByName('Qtde').AsFloat + Query1.FieldByName('Qtde').AsFloat;
    TbAux_Temp.FieldByName('Total').AsFloat      := TbAux_Temp.FieldByName('Total').AsFloat + (Query1.FieldByName('Qtde').AsFloat * Query1.FieldByName('Unitario').AsFloat);
    TbAux_Temp.FieldByName('Data').AsDateTime    := Query1.FieldByName('Data').AsDateTime;
    TbAux_Temp.Post;
    nTotQtde := nTotQtde  + Query1.FieldByName('Qtde').AsFloat;
    nTotValor:= nTotValor + (Query1.FieldByName('Qtde').AsFloat * Query1.FieldByName('Unitario').AsFloat);
    Query1.Next;
  end;
  FrmQrRelatorioEstatisticaPedidosAcougue.QrLabel11.Caption := MaskEdit1.Text + ' à ' + MaskEdit2.Text;
  FrmQrRelatorioEstatisticaPedidosAcougue.QrLabel13.Caption := FormatFloat('###,###,##0.000',nTotQtde);
  FrmQrRelatorioEstatisticaPedidosAcougue.QrLabel14.Caption := FormatFloat('###,###,###,##0.00',nTotValor);
  FrmQrRelatorioEstatisticaPedidosAcougue.QuickRep1.Preview;
  FrmQrRelatorioEstatisticaPedidosAcougue.Destroy;
  Query1.Active := False;
end;

procedure TFrmRelatorioEstatiticaPedidosAcougue.BtnImprimirClick(
  Sender: TObject);
Var nTotQtde, nTotValor: Real;
begin
  Application.CreateForm(TFrmQrRelatorioEstatisticaPedidosAcougue, FrmQrRelatorioEstatisticaPedidosAcougue);
  TbAux_Temp.Active    := False;
  TbAux_Temp.Exclusive := False;
  TbAux_Temp.Exclusive := True;
  TbAux_Temp.Active    := True;
  TbAux_Temp.EmptyTable;
  Query1.Active := False;
  Query1.SQL.Clear;
  Query1.SQL.Add('Select VendasBoi.Data, Mov_VendasBoi.Cod_Prod,');
  Query1.SQL.Add('Mov_VendasBoi.Qtde, Mov_VendasBoi.Unitario, ProdutosBoi.Descricao, ');
  Query1.SQL.Add('ProdutosBoi.Unidade');
  Query1.SQL.Add('From VendasBoi, Mov_VendasBoi, ProdutosBoi');
  Query1.SQL.Add('Where VendasBoi.Venda_Nr = Mov_VendasBoi.Venda_Nr');
  Query1.SQL.Add('AND VendasBoi.Data >= :MaskEdit1.Text AND ');
  Query1.SQL.Add('VendasBoi.Data <= :MaskEdit2.Text AND ');
  Query1.SQL.Add('Mov_VendasBoi.Cod_Prod = ProdutosBoi.Codigo');
  Query1.SQL.Add('Order By Data, Cod_Prod, Qtde, Descricao, Unidade');
  Query1.Params[0].AsDateTime := StrToDate(MaskEdit1.Text);
  Query1.Params[1].AsDateTime := StrToDate(MaskEdit2.Text);
  Query1.Active := True;

  Query1.First;
  nTotQtde := 0;
  nTotValor:= 0;
  While not Query1.EOF do
  begin
    If TbAux_Temp.FindKey([Query1.FieldByName('Cod_Prod').AsString]) Then
      TbAux_Temp.Edit
    Else
      TbAux_Temp.Insert;
    TbAux_Temp.FieldByName('Cod_Prod').AsString  := Query1.FieldByName('Cod_Prod').AsString;
    TbAux_Temp.FieldByName('Descricao').AsString := Query1.FieldByName('Descricao').AsString;
    TbAux_Temp.FieldByName('Unidade').AsString   := Query1.FieldByName('Unidade').AsString;
    TbAux_Temp.FieldByName('Qtde').AsFloat       := TbAux_Temp.FieldByName('Qtde').AsFloat + Query1.FieldByName('Qtde').AsFloat;
    TbAux_Temp.FieldByName('Total').AsFloat      := TbAux_Temp.FieldByName('Total').AsFloat + (Query1.FieldByName('Qtde').AsFloat * Query1.FieldByName('Unitario').AsFloat);
    TbAux_Temp.FieldByName('Data').AsDateTime    := Query1.FieldByName('Data').AsDateTime;
    TbAux_Temp.Post;
    nTotQtde := nTotQtde  + Query1.FieldByName('Qtde').AsFloat;
    nTotValor:= nTotValor + (Query1.FieldByName('Qtde').AsFloat * Query1.FieldByName('Unitario').AsFloat);
    Query1.Next;
  end;
  FrmQrRelatorioEstatisticaPedidosAcougue.QrLabel11.Caption := MaskEdit1.Text + ' à ' + MaskEdit2.Text;
  FrmQrRelatorioEstatisticaPedidosAcougue.QrLabel13.Caption := FormatFloat('###,###,##0.000',nTotQtde);
  FrmQrRelatorioEstatisticaPedidosAcougue.QrLabel14.Caption := FormatFloat('###,###,###,##0.00',nTotValor);
  FrmQrRelatorioEstatisticaPedidosAcougue.QuickRep1.Print;
  FrmQrRelatorioEstatisticaPedidosAcougue.Destroy;
  Query1.Active := False;
end;

end.
