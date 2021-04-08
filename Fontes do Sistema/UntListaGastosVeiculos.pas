unit UntListaGastosVeiculos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ExtCtrls, Db, DBTables;

type
  TFrmListaGastosVeiculos = class(TForm)
    RadioGroup1: TRadioGroup;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Label3: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DataSource1: TDataSource;
    Query1: TQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmListaGastosVeiculos: TFrmListaGastosVeiculos;

implementation

uses UntQrListaGastosVeiculos;

{$R *.DFM}


procedure TFrmListaGastosVeiculos.BitBtn1Click(Sender: TObject);
Var iTotLitros: Real;
begin
  If (MaskEdit1.Text = '  /  /    ') or (MaskEdit2.Text = '  /  /    ') Then
  Begin
    Application.MessageBox('Data em branco !!! '+Chr(13)+Chr(13)+' Preencha-a e tente novamente ','Advertência',48);
    Abort;
  End;
  Query1.Active := False;
  Query1.SQL.Clear;
  Query1.SQL.Add('Select * From requisicao Where');
  Query1.SQL.Add('Requisicao.Data >= :MaskEdit1.Text AND');
  Query1.SQL.Add('Requisicao.Data <= :MaskEdit2.Text');
  If RadioGroup1.ItemIndex = 0 Then
  Begin
    Query1.SQL.Add('AND Requisicao.Placa = :Edit1.Text');
    Query1.SQL.Add('Order by Placa');
    Query1.Params[0].AsDateTime := StrToDate(MaskEdit1.Text);
    Query1.Params[1].AsDateTime := StrToDate(MaskEdit2.Text);
    Query1.Params[2].AsString   := Trim(Edit1.Text);
  End;
  If RadioGroup1.ItemIndex = 1 Then
  Begin
    Query1.SQL.Add('AND Requisicao.Nome_Posto = :Edit1.Text');
    Query1.SQL.Add('Order by Nome_Posto');
    Query1.Params[0].AsDateTime := StrToDate(MaskEdit1.Text);
    Query1.Params[1].AsDateTime := StrToDate(MaskEdit2.Text);
    Query1.Params[2].AsString   := Trim(Edit1.Text);
  End;
  If RadioGroup1.ItemIndex = 2 Then
  Begin
    Query1.SQL.Add('Order by Nome_Posto, Placa');
    Query1.Params[0].AsDateTime := StrToDate(MaskEdit1.Text);
    Query1.Params[1].AsDateTime := StrToDate(MaskEdit2.Text);
  End;
  Query1.Active := True;
  Query1.First;
  iTotLitros := 0;
  While not Query1.EOF do
  Begin
    iTotLitros := iTotLitros + Query1.FieldByName('Qtde').AsFloat;
    Query1.Next;
  End;
  FrmQrListaGastosVeiculos.QRLabel15.Caption := FormatFloat('###,###.###',iTotLitros);
  FrmQrListaGastosVeiculos.QRLabel11.Caption := MaskEdit1.Text;
  FrmQrListaGastosVeiculos.QRLabel6.Caption  := MaskEdit2.Text;
  Application.CreateForm(TFrmQrListaGastosVeiculos, FrmQrListaGastosVeiculos);
  FrmQrListaGastosVeiculos.QuickRep1.Print;
  FrmQrListaGastosVeiculos.Destroy;
end;

procedure TFrmListaGastosVeiculos.BitBtn3Click(Sender: TObject);
begin
  FrmListaGastosVeiculos.Close;
end;

procedure TFrmListaGastosVeiculos.FormShow(Sender: TObject);
begin
  MaskEdit1.Text := DateToStr(Date());
  MaskEdit2.Text := DateToStr(Date());
end;

procedure TFrmListaGastosVeiculos.RadioGroup1Click(Sender: TObject);
begin
  If RadioGroup1.ItemIndex = 0 Then
  Begin
    Label3.Caption := 'Placa Veículo :';
    Edit1.Enabled := True;
    Edit1.Width := 90;
    Edit1.Text := '';
  End;
  If RadioGroup1.ItemIndex = 1 Then
  Begin
    Label3.Caption := 'Nome Posto :';
    Edit1.Enabled := True;
    Edit1.Width := 259;
    Edit1.Text := '';
  End;
  If RadioGroup1.ItemIndex = 2 Then
  Begin
    Edit1.Enabled := False;
    Label3.Enabled := False;
  End;
end;

procedure TFrmListaGastosVeiculos.BitBtn2Click(Sender: TObject);
Var iTotLitros: Real;
begin
  If (MaskEdit1.Text = '  /  /    ') or (MaskEdit2.Text = '  /  /    ') Then
  Begin
    Application.MessageBox('Data em branco !!! '+Chr(13)+Chr(13)+' Preencha-a e tente novamente ','Advertência',48);
    Abort;
  End;
  Query1.Active := False;
  Query1.SQL.Clear;
  Query1.SQL.Add('Select * From requisicao Where');
  Query1.SQL.Add('Requisicao.Data >= :MaskEdit1.Text AND');
  Query1.SQL.Add('Requisicao.Data <= :MaskEdit2.Text');
  If RadioGroup1.ItemIndex = 0 Then
  Begin
    Query1.SQL.Add('AND Requisicao.Placa = :Edit1.Text');
    Query1.SQL.Add('Order by Placa');
    Query1.Params[0].AsDateTime := StrToDate(MaskEdit1.Text);
    Query1.Params[1].AsDateTime := StrToDate(MaskEdit2.Text);
    Query1.Params[2].AsString   := Trim(Edit1.Text);
  End;
  If RadioGroup1.ItemIndex = 1 Then
  Begin
    Query1.SQL.Add('AND Requisicao.Nome_Posto = :Edit1.Text');
    Query1.SQL.Add('Order by Nome_Posto');
    Query1.Params[0].AsDateTime := StrToDate(MaskEdit1.Text);
    Query1.Params[1].AsDateTime := StrToDate(MaskEdit2.Text);
    Query1.Params[2].AsString   := Trim(Edit1.Text);
  End;
  If RadioGroup1.ItemIndex = 2 Then
  Begin
    Query1.SQL.Add('Order by Nome_Posto, Placa');
    Query1.Params[0].AsDateTime := StrToDate(MaskEdit1.Text);
    Query1.Params[1].AsDateTime := StrToDate(MaskEdit2.Text);
  End;
  Query1.Active := True;
  Query1.First;
  iTotLitros := 0;
  While not Query1.EOF do
  Begin
    iTotLitros := iTotLitros + Query1.FieldByName('Qtde').AsFloat;
    Query1.Next;
  End;
  FrmQrListaGastosVeiculos.QRLabel15.Caption := FormatFloat('###,###.###',iTotLitros);
  FrmQrListaGastosVeiculos.QRLabel11.Caption := MaskEdit1.Text;
  FrmQrListaGastosVeiculos.QRLabel6.Caption  := MaskEdit2.Text;
  Application.CreateForm(TFrmQrListaGastosVeiculos, FrmQrListaGastosVeiculos);
  FrmQrListaGastosVeiculos.QuickRep1.Preview;
  FrmQrListaGastosVeiculos.Destroy;
end;
end.
