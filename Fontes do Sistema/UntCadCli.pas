unit UntCadCli;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, Mask, Buttons, ExtCtrls, ComCtrls;

type
  TFrmCadCli = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Bevel1: TBevel;
    Label16: TLabel;
    Label17: TLabel;
    Label15: TLabel;
    MaskEdit1: TMaskEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    MaskEdit2: TMaskEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    MaskEdit3: TMaskEdit;
    MaskEdit4: TMaskEdit;
    DBComboBox1: TDBComboBox;
    MaskEdit5: TMaskEdit;
    DBRichEdit1: TDBRichEdit;
    MaskEdit6: TMaskEdit;
    MaskEdit7: TMaskEdit;
    Panel1: TPanel;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    BtnIncluir: TBitBtn;
    BtnAlterar: TBitBtn;
    BtnExcluir: TBitBtn;
    BtnSalvar: TBitBtn;
    BtnCancelar: TBitBtn;
    BtnPesquisar: TBitBtn;
    BtnSair: TBitBtn;
    GroupBox2: TGroupBox;
    DBNavigator1: TDBNavigator;
    GroupBox3: TGroupBox;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    MaskEdit10: TMaskEdit;
    MaskEdit11: TMaskEdit;
    DBComboBox2: TDBComboBox;
    MaskEdit12: TMaskEdit;
    GroupBox4: TGroupBox;
    DBEdit7: TDBEdit;
    Label20: TLabel;
    Label18: TLabel;
    Label30: TLabel;
    MaskEdit13: TMaskEdit;
    Label31: TLabel;
    MaskEdit14: TMaskEdit;
    GroupBox5: TGroupBox;
    Label19: TLabel;
    DBEdit11: TDBEdit;
    Label21: TLabel;
    DBEdit12: TDBEdit;
    GroupBox6: TGroupBox;
    DBEdit14: TDBEdit;
    Label33: TLabel;
    Label34: TLabel;
    DBEdit15: TDBEdit;
    GroupBox7: TGroupBox;
    Label29: TLabel;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    Label32: TLabel;
    DBRichEdit2: TDBRichEdit;
    DBEdit13: TDBEdit;
    Label35: TLabel;
    MaskEdit8: TMaskEdit;
    procedure DBRadioGroup1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnIncluirClick(Sender: TObject);
    procedure Congela_Descongela(bAcao: Boolean);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure Carregar;
    procedure DBEdit1Enter(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure MudaCor(C:TComponent; GetFocus:Boolean);
    procedure DBEdit2Enter(Sender: TObject);
    procedure DBEdit3Enter(Sender: TObject);
    procedure DBEdit4Enter(Sender: TObject);
    procedure DBEdit5Enter(Sender: TObject);
    procedure DBComboBox1Enter(Sender: TObject);
    procedure DBRichEdit1Enter(Sender: TObject);
    procedure DBRichEdit1Exit(Sender: TObject);
    procedure MaskEdit2Enter(Sender: TObject);
    procedure MaskEdit2Exit(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure DBEdit2Exit(Sender: TObject);
    procedure DBEdit3Exit(Sender: TObject);
    procedure DBEdit4Exit(Sender: TObject);
    procedure MaskEdit5Enter(Sender: TObject);
    procedure MaskEdit5Exit(Sender: TObject);
    procedure DBEdit5Exit(Sender: TObject);
    procedure DBComboBox1Exit(Sender: TObject);
    procedure MaskEdit3Enter(Sender: TObject);
    procedure MaskEdit3Exit(Sender: TObject);
    procedure MaskEdit4Enter(Sender: TObject);
    procedure MaskEdit4Exit(Sender: TObject);
    procedure MaskEdit8Enter(Sender: TObject);
    procedure MaskEdit8Exit(Sender: TObject);
    procedure MaskEdit13Enter(Sender: TObject);
    procedure MaskEdit13Exit(Sender: TObject);
    procedure MaskEdit14Enter(Sender: TObject);
    procedure MaskEdit14Exit(Sender: TObject);
    procedure MaskEdit10Enter(Sender: TObject);
    procedure MaskEdit10Exit(Sender: TObject);
    procedure MaskEdit12Enter(Sender: TObject);
    procedure MaskEdit12Exit(Sender: TObject);
    procedure MaskEdit11Enter(Sender: TObject);
    procedure MaskEdit11Exit(Sender: TObject);
    procedure DBEdit7Enter(Sender: TObject);
    procedure DBEdit7Exit(Sender: TObject);
    procedure DBEdit11Enter(Sender: TObject);
    procedure DBEdit11Exit(Sender: TObject);
    procedure DBEdit12Enter(Sender: TObject);
    procedure DBEdit12Exit(Sender: TObject);
    procedure DBEdit8Enter(Sender: TObject);
    procedure DBEdit8Exit(Sender: TObject);
    procedure DBEdit9Enter(Sender: TObject);
    procedure DBEdit9Exit(Sender: TObject);
    procedure DBEdit10Enter(Sender: TObject);
    procedure DBEdit10Exit(Sender: TObject);
    procedure DBComboBox2Enter(Sender: TObject);
    procedure DBComboBox2Exit(Sender: TObject);
    procedure DBEdit13Enter(Sender: TObject);
    procedure DBEdit13Exit(Sender: TObject);
    procedure DBEdit15Enter(Sender: TObject);
    procedure DBEdit15Exit(Sender: TObject);
    procedure DBEdit16Enter(Sender: TObject);
    procedure DBEdit16Exit(Sender: TObject);
    procedure DBEdit14Enter(Sender: TObject);
    procedure DBEdit14Exit(Sender: TObject);
    procedure DBEdit17Enter(Sender: TObject);
    procedure DBEdit17Exit(Sender: TObject);
    procedure ProcessaMsg(Var Msg: TMsg; Var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadCli: TFrmCadCli;

implementation

uses UntDataModulo, UntPesqCadCli;

{$R *.DFM}

procedure TFrmCadCli.ProcessaMsg(Var Msg: TMsg; Var Handled: Boolean);
begin
  If Msg.message = WM_KEYDOWN Then
    If not(Screen.ActiveControl is TCustomMemo) And not(Screen.ActiveControl is TButtonControl) Then
    begin
      If not(Screen.ActiveControl is TCustomControl) Then
      begin
        If Msg.wParam = VK_Down Then
          Msg.wParam := VK_Tab;
        If Msg.wParam = VK_UP Then
        begin
          Msg.wParam := VK_CLEAR;
          Screen.ActiveForm.Perform(WM_NextDlgCtl,1,0);
        end;
      end;
      If Msg.wParam = VK_Return Then
        Msg.wParam := VK_Tab;
    end;
end;

Procedure TFrmCadCli.MudaCor(C:TComponent; GetFocus:Boolean);
Var cCor: Integer;
begin
  If GetFocus = True Then
    cCor := ClInfoBk
  Else
    cCor := ClWindow;

  IF C.ClassType = TEdit Then
    (C as TEdit).Color := cCor;
  If C.ClassType = TDbEdit Then
    (C as TDBEdit).Color := cCor;
  If C.ClassType = TDBLookupComboBox Then
    (C as TDBLookupComboBox).Color := cCor;
  If C.ClassType = TDbMemo Then
    (C as TDBMemo).Color := cCor;
  If C.ClassType = TMaskEdit then
    (C as TMaskEdit).Color := cCor;
end;

procedure TFrmCadCli.Carregar;
Begin
  MaskEdit1.Text := DmPrincipal.TbClientes.FieldByName('Codigo').AsString;
  MaskEdit2.Text := DmPrincipal.TbClientes.FieldByName('Data').AsString;
  MaskEdit5.Text := DmPrincipal.TbClientes.FieldByName('Cep').AsString;
  MaskEdit3.Text := DmPrincipal.TbClientes.FieldByName('Telefone').AsString;
  MaskEdit4.Text := DmPrincipal.TbClientes.FieldByName('Fax').AsString;
  MaskEdit13.Text:= DmPrincipal.TbClientes.FieldByName('RGProp').AsString;
  MaskEdit8.Text := DmPrincipal.TbClientes.FieldByName('DataNasc').AsString;
  MaskEdit14.Text:= DmPrincipal.TbClientes.FieldByName('CICProp').AsString;
  MaskEdit12.Text:= DmPrincipal.TbClientes.FieldByName('CEPProp').AsString;
  MaskEdit10.Text:= DmPrincipal.TbClientes.FieldByName('TelProp').AsString;
  MaskEdit11.Text := DmPrincipal.TbClientes.FieldByName('FaxProp').AsString;

  If DmPrincipal.TbClientes.FieldByName('Tipo').AsString = 'J' Then
  Begin
    MaskEdit6.Text := DmPrincipal.TbClientes.FieldByName('CGC').AsString;
    MaskEdit7.Text := DmPrincipal.TbClientes.FieldByName('IE').AsString;
  End
  Else
  Begin
    MaskEdit6.Text := DmPrincipal.TbClientes.FieldByName('CPF').AsString;
    MaskEdit7.Text := DmPrincipal.TbClientes.FieldByName('RG').AsString;
  End;
End;

procedure TFrmCadCli.Congela_Descongela(bAcao: Boolean);
Begin
  BtnIncluir.Enabled   := bAcao;
  BtnAlterar.Enabled   := bAcao;
  BtnExcluir.Enabled   := bAcao;
  BtnSalvar.Enabled    := Not bAcao;
  BtnCancelar.Enabled  := Not bAcao;
  BtnPesquisar.Enabled := bAcao;
  BtnSair.Enabled      := bAcao;
  GroupBox1.Enabled    := Not bAcao;
  GroupBox3.Enabled    := Not bAcao;
  DBNavigator1.Enabled := bAcao;
End;

procedure TFrmCadCli.DBRadioGroup1Change(Sender: TObject);
begin
  If DbRadioGroup1.ItemIndex = 0 Then  // Se for Pessoa Juridica
  Begin
    Label16.Caption := 'C.G.C.';
    Label17.Caption := 'I.E.';
    MaskEdit6.EditMask := '99.999.999/9999-99';
    MaskEdit7.EditMask := '999.999.999.999';
    Label15.Caption    := ' Dados Cadastrais ';
  End
  Else  // Senao, se for Pessoa Fisica
  Begin
    Label16.Caption := '  C.P.F.';
    Label17.Caption := 'R.G.';
    MaskEdit6.EditMask := '999.999.999-99';
    MaskEdit7.EditMask := '99.999.999-aa';
    Label15.Caption    := ' Dados Pessoais ';
  End;
end;

procedure TFrmCadCli.FormShow(Sender: TObject);
begin
  DmPrincipal.TbClientes.Active := True;
  Carregar;
end;

procedure TFrmCadCli.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DmPrincipal.TbClientes.Active := False;
end;

procedure TFrmCadCli.BtnIncluirClick(Sender: TObject);
begin
  DmPrincipal.TbClientes.Last;
  MaskEdit1.Text := IntToStr(DmPrincipal.TbClientes.FieldByName('Codigo').AsInteger + 1);
  DmPrincipal.TbClientes.Insert;
  Congela_Descongela(False);
  DbRadioGroup1.ItemIndex := 0;
  DbComboBox1.SelText := 'SP';
  DbComboBox2.SelText := 'SP';
  MaskEdit2.Text := DateToStr(Date());
  MaskEdit3.Text  := '';
  MaskEdit4.Text  := '';
  MaskEdit5.Text  := '';
  MaskEdit6.Text  := '';
  MaskEdit7.Text  := '';
  MaskEdit8.Text  := '';
  MaskEdit13.Text := '';
  MaskEdit14.Text := '';
  MaskEdit10.Text := '';
  MaskEdit11.Text := '';
  MaskEdit12.Text := '';
  if pagecontrol1.ActivePage = TabSheet1 then
    MaskEdit2.SetFocus
  else
    DBEdit7.SetFocus;
end;

procedure TFrmCadCli.BtnCancelarClick(Sender: TObject);
begin
  Congela_Descongela(True);
  DmPrincipal.TbClientes.Cancel;
  Carregar;
end;

procedure TFrmCadCli.BtnAlterarClick(Sender: TObject);
begin
  DmPrincipal.TbClientes.Edit;
  Congela_Descongela(False);
end;

procedure TFrmCadCli.BtnExcluirClick(Sender: TObject);
begin
 If Application.MessageBox('Deseja realmente excluir este cliente ?',' Confirmação de Exclusão ',36) = IDYes Then
    DmPrincipal.TbClientes.Delete;
end;

procedure TFrmCadCli.BtnSalvarClick(Sender: TObject);
begin
  DmPrincipal.TbClientes.FieldByName('Codigo').AsString   := Trim(MaskEdit1.Text);
  DmPrincipal.TbClientes.FieldByName('Data').AsString     := MaskEdit2.Text;
  DmPrincipal.TbClientes.FieldByName('Cep').AsString      := MaskEdit5.Text;
  DmPrincipal.TbClientes.FieldByName('Telefone').AsString := MaskEdit3.Text;
  DmPrincipal.TbClientes.FieldByName('Fax').AsString      := MaskEdit4.Text;
  DmPrincipal.TbClientes.FieldByName('RGProp').AsString   := MaskEdit13.Text;
  DmPrincipal.TbClientes.FieldByName('DataNasc').AsString := MaskEdit8.Text;
  DmPrincipal.TbClientes.FieldByName('CICProp').AsString  := MaskEdit14.Text;
  DmPrincipal.TbClientes.FieldByName('CEPProp').AsString  := MaskEdit12.Text;
  DmPrincipal.TbClientes.FieldByName('TelProp').AsString  := MaskEdit10.Text;
  DmPrincipal.TbClientes.FieldByName('FaxProp').AsString  := MaskEdit11.Text;
  If DbRadioGroup1.ItemIndex = 0 Then // Pessoa Juridica
  Begin
    DmPrincipal.TbClientes.FieldByName('CGC').AsString := MaskEdit6.Text;
    DmPrincipal.TbClientes.FieldByName('IE').AsString  := MaskEdit7.Text;
    DmPrincipal.TbClientes.FieldByName('CPF').AsString := '';
    DmPrincipal.TbClientes.FieldByName('RG').AsString  := '';
  End
  Else
  Begin
    DmPrincipal.TbClientes.FieldByName('CPF').AsString := MaskEdit6.Text;
    DmPrincipal.TbClientes.FieldByName('RG').AsString  := MaskEdit7.Text;
    DmPrincipal.TbClientes.FieldByName('CGC').AsString := '';
    DmPrincipal.TbClientes.FieldByName('IE').AsString  := '';
  End;
  DmPrincipal.TbClientes.Post;
  Congela_Descongela(True);
end;

procedure TFrmCadCli.DBEdit1Enter(Sender: TObject);
begin
  MudaCor(DbEdit1,True);
end;

procedure TFrmCadCli.BtnSairClick(Sender: TObject);
begin
  FrmCadCli.Close;
end;

procedure TFrmCadCli.DBNavigator1Click(Sender: TObject;
  Button: TNavigateBtn);
begin
  Carregar;
end;

procedure TFrmCadCli.BtnPesquisarClick(Sender: TObject);
begin
  Application.CreateForm(TfrmPesqCadCli, frmPesqCadCli);
  FrmPesqCadCli.ShowModal;
  Carregar;
  FrmPesqCadCli.Destroy;
end;

procedure TFrmCadCli.DBEdit2Enter(Sender: TObject);
begin
  MudaCor(DbEdit2,True);
end;

procedure TFrmCadCli.DBEdit3Enter(Sender: TObject);
begin
  MudaCor(DbEdit3,True);
end;

procedure TFrmCadCli.DBEdit4Enter(Sender: TObject);
begin
  MudaCor(DbEdit4,True);
end;

procedure TFrmCadCli.DBEdit5Enter(Sender: TObject);
begin
  MudaCor(DbEdit5,True);
end;

procedure TFrmCadCli.DBComboBox1Enter(Sender: TObject);
begin
  MudaCor(DbComboBox1,True);
end;

procedure TFrmCadCli.DBRichEdit1Enter(Sender: TObject);
begin
  MudaCor(DbRichEdit1,True);
end;

procedure TFrmCadCli.DBRichEdit1Exit(Sender: TObject);
begin
  MudaCor(DbRichEdit1,False);
end;

procedure TFrmCadCli.MaskEdit2Enter(Sender: TObject);
begin
  MudaCor(MaskEdit2,True);
end;

procedure TFrmCadCli.MaskEdit2Exit(Sender: TObject);
begin
  MudaCor(MaskEdit2,False);
end;

procedure TFrmCadCli.DBEdit1Exit(Sender: TObject);
begin
    MudaCor(DbEdit1,False);
end;

procedure TFrmCadCli.DBEdit2Exit(Sender: TObject);
begin
    MudaCor(DbEdit2,False);
end;

procedure TFrmCadCli.DBEdit3Exit(Sender: TObject);
begin
    MudaCor(DbEdit3,False);
end;

procedure TFrmCadCli.DBEdit4Exit(Sender: TObject);
begin
  MudaCor(DbEdit4,False);
end;

procedure TFrmCadCli.MaskEdit5Enter(Sender: TObject);
begin
  MudaCor(MaskEdit5,True);
end;

procedure TFrmCadCli.MaskEdit5Exit(Sender: TObject);
begin
  MudaCor(MaskEdit5,False);
end;

procedure TFrmCadCli.DBEdit5Exit(Sender: TObject);
begin
  MudaCor(DbEdit5,False);
end;

procedure TFrmCadCli.DBComboBox1Exit(Sender: TObject);
begin
  MudaCor(DbComboBox1,False);
end;

procedure TFrmCadCli.MaskEdit3Enter(Sender: TObject);
begin
  MudaCor(MaskEdit3,True);
end;

procedure TFrmCadCli.MaskEdit3Exit(Sender: TObject);
begin
  MudaCor(MaskEdit3,False);
end;

procedure TFrmCadCli.MaskEdit4Enter(Sender: TObject);
begin
  MudaCor(MaskEdit4,True);
end;

procedure TFrmCadCli.MaskEdit4Exit(Sender: TObject);
begin
  MudaCor(MaskEdit4,False);
end;

procedure TFrmCadCli.MaskEdit8Enter(Sender: TObject);
begin
  MudaCor(MaskEdit8,True);
end;

procedure TFrmCadCli.MaskEdit8Exit(Sender: TObject);
begin
  MudaCor(MaskEdit8,False);
end;

procedure TFrmCadCli.MaskEdit13Enter(Sender: TObject);
begin
  MudaCor(MaskEdit13,True);
end;

procedure TFrmCadCli.MaskEdit13Exit(Sender: TObject);
begin
  MudaCor(MaskEdit13,False);
end;

procedure TFrmCadCli.MaskEdit14Enter(Sender: TObject);
begin
  MudaCor(MaskEdit14,True);
end;

procedure TFrmCadCli.MaskEdit14Exit(Sender: TObject);
begin
    MudaCor(MaskEdit14,False);
end;

procedure TFrmCadCli.MaskEdit10Enter(Sender: TObject);
begin
    MudaCor(MaskEdit10,True);
end;

procedure TFrmCadCli.MaskEdit10Exit(Sender: TObject);
begin
    MudaCor(MaskEdit10,True);
end;

procedure TFrmCadCli.MaskEdit12Enter(Sender: TObject);
begin
  MudaCor(MaskEdit12,True);
end;

procedure TFrmCadCli.MaskEdit12Exit(Sender: TObject);
begin
    MudaCor(MaskEdit12,False);
end;

procedure TFrmCadCli.MaskEdit11Enter(Sender: TObject);
begin
    MudaCor(MaskEdit11,True);
end;

procedure TFrmCadCli.MaskEdit11Exit(Sender: TObject);
begin
  MudaCor(MaskEdit11,False);
end;

procedure TFrmCadCli.DBEdit7Enter(Sender: TObject);
begin
  MudaCor(DBEdit7,True);
end;

procedure TFrmCadCli.DBEdit7Exit(Sender: TObject);
begin
  MudaCor(DBEdit7,False);
end;

procedure TFrmCadCli.DBEdit11Enter(Sender: TObject);
begin
  MudaCor(DBEdit11,True);
end;

procedure TFrmCadCli.DBEdit11Exit(Sender: TObject);
begin
  MudaCor(DBEdit11,False);
end;

procedure TFrmCadCli.DBEdit12Enter(Sender: TObject);
begin
  MudaCor(DBEdit12,True);
end;

procedure TFrmCadCli.DBEdit12Exit(Sender: TObject);
begin
  MudaCor(DBEdit12,False);
end;

procedure TFrmCadCli.DBEdit8Enter(Sender: TObject);
begin
  MudaCor(DBEdit8,True);
end;

procedure TFrmCadCli.DBEdit8Exit(Sender: TObject);
begin
  MudaCor(DBEdit8,False);
end;

procedure TFrmCadCli.DBEdit9Enter(Sender: TObject);
begin
  MudaCor(DBEdit9,True);
end;

procedure TFrmCadCli.DBEdit9Exit(Sender: TObject);
begin
  MudaCor(DBEdit9,False);
end;

procedure TFrmCadCli.DBEdit10Enter(Sender: TObject);
begin
  MudaCor(DBEdit10,True);
end;

procedure TFrmCadCli.DBEdit10Exit(Sender: TObject);
begin
  MudaCor(DBEdit10,False);
end;

procedure TFrmCadCli.DBComboBox2Enter(Sender: TObject);
begin
  MudaCor(DBComboBox2,True);
end;

procedure TFrmCadCli.DBComboBox2Exit(Sender: TObject);
begin
  MudaCor(DBComboBox2,False);
end;

procedure TFrmCadCli.DBEdit13Enter(Sender: TObject);
begin
  MudaCor(DBEdit13,True);
end;

procedure TFrmCadCli.DBEdit13Exit(Sender: TObject);
begin
  MudaCor(DBEdit13,False);
end;

procedure TFrmCadCli.DBEdit15Enter(Sender: TObject);
begin
  MudaCor(DBEdit15,True);
end;

procedure TFrmCadCli.DBEdit15Exit(Sender: TObject);
begin
  MudaCor(DBEdit15,False);
end;

procedure TFrmCadCli.DBEdit16Enter(Sender: TObject);
begin
  MudaCor(DBEdit16,True);
end;

procedure TFrmCadCli.DBEdit16Exit(Sender: TObject);
begin
  MudaCor(DBEdit16,False);
end;

procedure TFrmCadCli.DBEdit14Enter(Sender: TObject);
begin
  MudaCor(DBEdit14,True);
end;

procedure TFrmCadCli.DBEdit14Exit(Sender: TObject);
begin
  MudaCor(DBEdit14,False);
end;

procedure TFrmCadCli.DBEdit17Enter(Sender: TObject);
begin
  MudaCor(DBEdit17,True);
end;

procedure TFrmCadCli.DBEdit17Exit(Sender: TObject);
begin
  MudaCor(DBEdit17,False);
end;
end.
