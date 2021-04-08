unit UntCadPrestadora;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask;

type
  TFrmCadPrestadora = class(TForm)
    Panel1: TPanel;
    BtnIncluir: TBitBtn;
    BtnAlterar: TBitBtn;
    BtnExcluir: TBitBtn;
    BtnSalvar: TBitBtn;
    BtnCancelar: TBitBtn;
    BtnPesquisar: TBitBtn;
    BtnSair: TBitBtn;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DBNavigator1: TDBNavigator;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    MaskEdit3: TMaskEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    procedure BtnIncluirClick(Sender: TObject);
    procedure Congela_Descongela(bAcao: Boolean);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure Carregar;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadPrestadora: TFrmCadPrestadora;

implementation

uses UntDataModulo;

{$R *.DFM}

procedure TFrmCadPrestadora.Congela_Descongela(bAcao: Boolean);
Begin
  BtnIncluir.Enabled   := bAcao;
  BtnAlterar.Enabled   := bAcao;
  BtnExcluir.Enabled   := bAcao;
  BtnSalvar.Enabled    := Not bAcao;
  BtnCancelar.Enabled  := Not bAcao;
  BtnPesquisar.Enabled := bAcao;
  BtnSair.Enabled      := bAcao;
  GroupBox1.Enabled    := Not bAcao;
  DBNavigator1.Enabled := bAcao;
End;

procedure TFrmCadPrestadora.BtnIncluirClick(Sender: TObject);
Var nCodigo: Integer;
begin
  DmPrincipal.TbPrestadora.Last;
  nCodigo := (DmPrincipal.TbPrestadora.FieldByName('Cod_Pres').AsInteger + 1);
  DmPrincipal.TbPrestadora.Insert;
  DbEdit1.Field.Value := IntToStr(nCodigo);
  Congela_Descongela(False);
  MaskEdit1.Text := '';
  MaskEdit2.Text := '';
  MaskEdit3.Text := '';
  DbEdit2.SetFocus;
end;

procedure TFrmCadPrestadora.BtnSalvarClick(Sender: TObject);
begin
  DmPrincipal.TbPrestadora.FieldByName('Telefone').asString := MaskEdit1.Text;
  DmPrincipal.TbPrestadora.FieldByName('FAX').asString := MaskEdit2.Text;
  DmPrincipal.TbPrestadora.FieldByName('Celular').asString := MaskEdit3.Text;
  DmPrincipal.TbPrestadora.Post;
  Congela_Descongela(True);
end;

procedure TFrmCadPrestadora.BtnCancelarClick(Sender: TObject);
begin
  DmPrincipal.TbPrestadora.Cancel;
  Congela_Descongela(True);
  Carregar;
end;

procedure TFrmCadPrestadora.BtnAlterarClick(Sender: TObject);
begin
  DmPrincipal.TbPrestadora.Edit;
  Congela_Descongela(False);
end;

procedure TFrmCadPrestadora.Carregar;
begin
  MaskEdit1.Text := DmPrincipal.TbPrestadora.FieldByName('Telefone').AsString;
  MaskEdit2.Text := DmPrincipal.TbPrestadora.FieldByName('Fax').AsString;
  MaskEdit3.Text := DmPrincipal.TbPrestadora.FieldByName('Celular').AsString;
end;

procedure TFrmCadPrestadora.BtnExcluirClick(Sender: TObject);
begin
 If Application.MessageBox('Deseja realmente excluir esta Prestadora de Serviço?',' Confirmação de Exclusão ',36) = IDYes Then
    DmPrincipal.TbPrestadora.Delete;
end;

procedure TFrmCadPrestadora.BtnSairClick(Sender: TObject);
begin
   close;
end;

procedure TFrmCadPrestadora.FormShow(Sender: TObject);
begin
  DmPrincipal.TbPrestadora.Active := True;
  Congela_Descongela(True);
  Carregar;
end;

procedure TFrmCadPrestadora.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   DmPrincipal.TbPrestadora.Active := False;
end;

procedure TFrmCadPrestadora.DBNavigator1Click(Sender: TObject;
  Button: TNavigateBtn);
begin
  Carregar;
end;

end.
