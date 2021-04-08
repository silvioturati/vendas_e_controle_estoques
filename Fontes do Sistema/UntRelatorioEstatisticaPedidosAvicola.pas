unit UntRelatorioEstatisticaPedidosAvicola;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids, StdCtrls, Mask, ExtCtrls, Buttons;

type
  TFrmRelatorioEstatiticaPedidosAvicola = class(TForm)
    DsAux_Temp: TDataSource;
    TbAux_Temp: TTable;
    GroupBox1: TGroupBox;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Bevel1: TBevel;
    DataSource1: TDataSource;
    Query1: TQuery;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelatorioEstatiticaPedidosAvicola: TFrmRelatorioEstatiticaPedidosAvicola;

implementation

uses UntQrRelatorioEstatisticaPedidosAvicola;

{$R *.DFM}
procedure TFrmRelatorioEstatiticaPedidosAvicola.BitBtn2Click(Sender: TObject);
Var nTotQtde, nTotValor: Real;
begin
  Application.CreateForm(TFrmQrRelatorioEstatisticaPedidosAvicola, FrmQrRelatorioEstatisticaPedidosAvicola);
  TbAux_Temp.Active    := False;
  TbAux_Temp.Exclusive := False;
  TbAux_Temp.Exclusive := True;
  TbAux_Temp.Active    := True;
  TbAux_Temp.EmptyTable;
  Query1.Active := False;
  Query1.SQL.Clear;
  Query1.SQL.Add('Select VendasFra.Data, Mov_VendasFra.Cod_Prod,');
  Query1.SQL.Add('Mov_VendasFra.Qtde, Mov_VendasFra.Unitario, ProdutosFra.Descricao, ');
  Query1.SQL.Add('ProdutosFra.Unidade');
  Query1.SQL.Add('From VendasFra, Mov_VendasFra, ProdutosFra');
  Query1.SQL.Add('Where VendasFra.Venda_Nr = Mov_VendasFra.Venda_Nr');
  Query1.SQL.Add('AND VendasFra.Data >= :MaskEdit1.Text AND ');
  Query1.SQL.Add('VendasFra.Data <= :MaskEdit2.Text AND ');
  Query1.SQL.Add('Mov_VendasFra.Cod_Prod = ProdutosFra.Codigo');
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
  FrmQrRelatorioEstatisticaPedidosAvicola.QrLabel11.Caption := MaskEdit1.Text + ' à ' + MaskEdit2.Text;
  FrmQrRelatorioEstatisticaPedidosAvicola.QrLabel13.Caption := FormatFloat('###,###,##0.000',nTotQtde);
  FrmQrRelatorioEstatisticaPedidosAvicola.QrLabel14.Caption := FormatFloat('###,###,###,##0.00',nTotValor);
  FrmQrRelatorioEstatisticaPedidosAvicola.QuickRep1.Preview;
  FrmQrRelatorioEstatisticaPedidosAvicola.Destroy;
  Query1.Active := False;
end;

procedure TFrmRelatorioEstatiticaPedidosAvicola.BitBtn3Click(Sender: TObject);
begin
  FrmRelatorioEstatiticaPedidosAvicola.Close;
end;

procedure TFrmRelatorioEstatiticaPedidosAvicola.BitBtn1Click(Sender: TObject);
Var nTotQtde, nTotValor: Real;
begin
  Application.CreateForm(TFrmQrRelatorioEstatisticaPedidosAvicola, FrmQrRelatorioEstatisticaPedidosAvicola);
  TbAux_Temp.Active    := False;
  TbAux_Temp.Exclusive := False;
  TbAux_Temp.Exclusive := True;
  TbAux_Temp.Active    := True;
  TbAux_Temp.EmptyTable;
  Query1.Active := False;
  Query1.SQL.Clear;
  Query1.SQL.Add('Select VendasFra.Data, Mov_VendasFra.Cod_Prod,');
  Query1.SQL.Add('Mov_VendasFra.Qtde, Mov_VendasFra.Unitario, ProdutosFra.Descricao, ');
  Query1.SQL.Add('ProdutosFra.Unidade');
  Query1.SQL.Add('From VendasFra, Mov_VendasFra, ProdutosFra');
  Query1.SQL.Add('Where VendasFra.Venda_Nr = Mov_VendasFra.Venda_Nr');
  Query1.SQL.Add('AND VendasFra.Data >= :MaskEdit1.Text AND ');
  Query1.SQL.Add('VendasFra.Data <= :MaskEdit2.Text AND ');
  Query1.SQL.Add('Mov_VendasFra.Cod_Prod = ProdutosFra.Codigo');
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
  FrmQrRelatorioEstatisticaPedidosAvicola.QrLabel11.Caption := MaskEdit1.Text + ' à ' + MaskEdit2.Text;
  FrmQrRelatorioEstatisticaPedidosAvicola.QrLabel13.Caption := FormatFloat('###,###,##0.000',nTotQtde);
  FrmQrRelatorioEstatisticaPedidosAvicola.QrLabel14.Caption := FormatFloat('###,###,###,##0.00',nTotValor);
  FrmQrRelatorioEstatisticaPedidosAvicola.QuickRep1.Print;
  FrmQrRelatorioEstatisticaPedidosAvicola.Destroy;
  Query1.Active := False;
end;


end.
