unit UntCadVeiculos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, DBCtrls, Mask;

type
  TFrmCadVeiculos = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
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
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBNavigator1: TDBNavigator;
    procedure Congela_Descongela(bAcao: Boolean);
    procedure BtnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadVeiculos: TFrmCadVeiculos;

implementation

uses UntDataModulo;

{$R *.DFM}

procedure TFrmCadVeiculos.Congela_Descongela(bAcao: Boolean);
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

procedure TFrmCadVeiculos.BtnIncluirClick(Sender: TObject);
begin
  DmPrincipal.TbVeiculos.Last;
  DmPrincipal.TbVeiculos.Insert;
  Congela_Descongela(False);
  DbEdit1.SetFocus;
end;

procedure TFrmCadVeiculos.FormShow(Sender: TObject);
begin
   DmPrincipal.TbVeiculos.Active := True;
   Congela_descongela(True);
end;

procedure TFrmCadVeiculos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DmPrincipal.TbVeiculos.Active := False;
end;

procedure TFrmCadVeiculos.BtnAlterarClick(Sender: TObject);
begin
  DmPrincipal.TbVeiculos.Edit;
  Congela_Descongela(False);
end;

procedure TFrmCadVeiculos.BtnExcluirClick(Sender: TObject);
begin
 If Application.MessageBox('Deseja realmente excluir este Veículo?',' Confirmação de Exclusão ',36) = IDYes Then
    DmPrincipal.TbVeiculos.Delete;
end;

procedure TFrmCadVeiculos.BtnSalvarClick(Sender: TObject);
begin
  DmPrincipal.TbVeiculos.Post;
  Congela_Descongela(True);
end;

procedure TFrmCadVeiculos.BtnCancelarClick(Sender: TObject);
begin
  DmPrincipal.TbVeiculos.Cancel;
  Congela_Descongela(True);
end;

procedure TFrmCadVeiculos.BtnSairClick(Sender: TObject);
begin
   close;
end;

end.
