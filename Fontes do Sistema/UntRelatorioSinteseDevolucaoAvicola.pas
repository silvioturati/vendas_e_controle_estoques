unit UntRelatorioSinteseDevolucaoAvicola;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, Mask, Menus, Db, DBTables;

type
  TFrmRelatorioSinteseDevolucaoAvicola = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    RadioGroup1: TRadioGroup;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    PopupMenu1: TPopupMenu;
    Pesquisar1: TMenuItem;
    TbAux_Temp: TTable;
    TbMov_DevFra: TTable;
    TbDevolucaoFra: TTable;
    TbProdutosFra: TTable;
    Ds_AuxTemp: TDataSource;
    DsMov_DevFra: TDataSource;
    DsDevolucaoFra: TDataSource;
    DsProdutosFra: TDataSource;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Atualiza_Temp;
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelatorioSinteseDevolucaoAvicola: TFrmRelatorioSinteseDevolucaoAvicola;

implementation

uses UntDataModulo, UntQRRelatorioSinteseDevolucaoAvicola, UntPesqCadCli;

{$R *.DFM}

procedure TFrmRelatorioSinteseDevolucaoAvicola.BitBtn1Click(Sender: TObject);
Var nTQtde, nTGeral: Real;
begin
  Application.CreateForm(TFrmQRRelatorioSinteseDevolucaoAvicola, FrmQRRelatorioSinteseDevolucaoAvicola);
  If (MaskEdit1.Text = '  /  /    ') OR (MaskEdit2.Text = '  /  /    ') Then
  Begin
    Application.MessageBox('Preencha as datas corretamente ... ', 'Advertência',64);
    MaskEdit1.SetFocus;
    Exit;
  End;
  Atualiza_Temp;
  nTQtde  := 0;
  nTGeral := 0;
  TbAux_Temp.First;
  While not TbAux_Temp.EOF do
  Begin
    nTQtde  := nTQtde  + TbAux_Temp.FieldByName('Qtde').AsFloat;
    nTGeral := nTGeral + TbAux_Temp.FieldByName('Total').AsFloat;
    TbAux_Temp.Next;
  End;
  FrmQRRelatorioSinteseDevolucaoAvicola.QRLabel6.Caption  := MaskEdit1.Text;
  FrmQRRelatorioSinteseDevolucaoAvicola.QRLabel8.Caption  := MaskEdit2.Text;
  FrmQRRelatorioSinteseDevolucaoAvicola.QRLabel15.Caption := FormatFloat('###,###,###.##',nTGeral);
  FrmQRRelatorioSinteseDevolucaoAvicola.QuickRep1.Print;
  FrmQRRelatorioSinteseDevolucaoAvicola.Destroy;
  TbAux_Temp.Active    := False;
  TbAux_Temp.Exclusive := False;
end;

procedure TFrmRelatorioSinteseDevolucaoAvicola.BitBtn2Click(Sender: TObject);
Var nTQtde, nTGeral: Real;
begin
  Application.CreateForm(TFrmQRRelatorioSinteseDevolucaoAvicola, FrmQRRelatorioSinteseDevolucaoAvicola);
  If (MaskEdit1.Text = '  /  /    ') OR (MaskEdit2.Text = '  /  /    ') Then
  Begin
    Application.MessageBox('Preencha as datas corretamente ... ', 'Advertência',64);
    MaskEdit1.SetFocus;
    Exit;
  End;
  Atualiza_Temp;
  nTQtde  := 0;
  nTGeral := 0;
  TbAux_Temp.First;
  While not TbAux_Temp.EOF do
  Begin
    nTQtde  := nTQtde  + TbAux_Temp.FieldByName('Qtde').AsFloat;
    nTGeral := nTGeral + TbAux_Temp.FieldByName('Total').AsFloat;
    TbAux_Temp.Next;
  End;
  FrmQRRelatorioSinteseDevolucaoAvicola.QRLabel6.Caption  := MaskEdit1.Text;
  FrmQRRelatorioSinteseDevolucaoAvicola.QRLabel8.Caption  := MaskEdit2.Text;
  FrmQRRelatorioSinteseDevolucaoAvicola.QRLabel15.Caption := FormatFloat('###,###,###.##',nTGeral);
  FrmQRRelatorioSinteseDevolucaoAvicola.QuickRep1.Preview;
  FrmQRRelatorioSinteseDevolucaoAvicola.Destroy;
  TbAux_Temp.Active    := False;
  TbAux_Temp.Exclusive := False;
end;

procedure TFrmRelatorioSinteseDevolucaoAvicola.BitBtn3Click(Sender: TObject);
begin
  Application.CreateForm(TfrmPesqCadCli, frmPesqCadCli);
  FrmPesqCadCli.ShowModal;
  FrmPesqCadCli.Destroy;
end;

procedure TFrmRelatorioSinteseDevolucaoAvicola.RadioGroup1Click(Sender: TObject);
begin
  If RadioGroup1.ItemIndex = 0 Then
  begin
    DmPrincipal.TBClientes.IndexFieldNames := 'Fantasia';
    DbGrid1.Columns[0].Title.Caption := 'Nome Fantasia';
    DbGrid1.Columns[0].FieldName := 'Fantasia';
    DbGrid1.Columns[1].Title.Caption := 'Razão Social';
    DbGrid1.Columns[1].FieldName := 'Razao';
  end
  else
  begin
    DmPrincipal.TBClientes.IndexFieldNames := 'Razao';
    DbGrid1.Columns[0].Title.Caption := 'Razão Social';
    DbGrid1.Columns[0].FieldName := 'Razão';
    DbGrid1.Columns[1].Title.Caption := 'Nome Fantasia';
    DbGrid1.Columns[1].FieldName := 'Fantasia';
  end;
end;

procedure TFrmRelatorioSinteseDevolucaoAvicola.FormShow(Sender: TObject);
begin
  DmPrincipal.TBClientes.Active := True;
end;

procedure TFrmRelatorioSinteseDevolucaoAvicola.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DmPrincipal.TBClientes.Active := False;
end;

procedure TFrmRelatorioSinteseDevolucaoAvicola.Atualiza_Temp;
Var Nr_Devolucao, nCodProd: Integer;
begin
  TbAux_Temp.Exclusive := True;
  TbAux_temp.Active    := True;
  TbAux_Temp.EmptyTable;

  TbProdutosFra.Active   := True;
  TbMov_DevFra.Active    := True;
  TbDevolucaoFra.Active  := True;

  TbDevolucaoFra.FindNearest([DmPrincipal.TbClientes.FieldByName('Codigo').AsInteger]);

  While not TbDevolucaoFra.EOF do
  Begin
    If (TbDevolucaoFra.FieldByName('Data').AsDateTime >= StrToDate(MaskEdit1.Text)) AND (TbDevolucaoFra.FieldByName('Data').AsDateTime <= StrToDate(MaskEdit2.Text)) Then
    Begin
      Nr_Devolucao := TbDevolucaoFra.FieldByName('Dev_Nr').AsInteger;
      TbMov_DevFra.FindNearest([Nr_Devolucao]);
      While not TbMov_DevFra.EOF do
      Begin
        If Nr_Devolucao <> TbMov_DevFra.FieldByName('Dev_Nr').AsInteger Then
          Break;
        nCodProd := TbMov_DevFra.FieldByName('Cod_Prod').AsInteger;
        TbProdutosFra.FindKey([nCodProd]);
        If TbAux_Temp.FindKey([nCodProd]) Then
          TbAux_Temp.Edit
        Else
          TbAux_Temp.Insert;

        TbAux_Temp.FieldByName('Cod_Prod').AsInteger := nCodProd;
        TbAux_Temp.FieldByName('Descricao').AsString := TbProdutosFra.FieldByName('Descricao').AsString;
        TbAux_Temp.FieldByName('Unidade').AsString   := TbProdutosFra.FieldByName('Unidade').AsString;
        TbAux_Temp.FieldByName('Qtde').AsFloat  := TbAux_Temp.FieldByName('Qtde').AsFloat + TbMov_DevFra.FieldByName('Qtde').AsFloat;
        TbAux_Temp.FieldByName('Total').AsFloat := TbAux_Temp.FieldByName('Total').AsFloat + (TbMov_DevFra.FieldByName('Qtde').AsFloat * TbMov_DevFra.FieldByName('Unitario').AsFloat);
        TbAux_Temp.Post;
        TbMov_DevFra.Next;
        If Nr_Devolucao <> TbMov_DevFra.FieldByName('Dev_Nr').AsInteger Then
          Break;
      End;
    End;
    TbDevolucaoFra.Next;
    If TbDevolucaoFra.FieldByName('Codigo').AsString <> DmPrincipal.TbClientes.FieldByName('Codigo').AsString Then
      Break;
  End;
  TbProdutosFra.Active    := False;
  TbMov_DevFra.Active     := False;
  TbDevolucaoFra.Active   := False;
End;

procedure TFrmRelatorioSinteseDevolucaoAvicola.BitBtn4Click(Sender: TObject);
begin
  Close;
end;


end.
