unit UntBackupRestore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, FileCtrl, backup, ComCtrls, ExtCtrls;

type
  TFrmBackupRestore = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    FileListBox: TFileListBox;
    RGModoBackup: TRadioGroup;
    RgNivelCompactacao: TRadioGroup;
    CbGravarNomeArquivo: TCheckBox;
    GroupBox2: TGroupBox;
    BtnDesmarcar: TBitBtn;
    BtnSelecionar: TBitBtn;
    GroupBox3: TGroupBox;
    EdtNomeBackup: TEdit;
    GroupBox4: TGroupBox;
    BtnCriarArquivo: TBitBtn;
    BtnSair: TBitBtn;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    GroupBox5: TGroupBox;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    RgOpcoesRestauracao: TRadioGroup;
    Edit2: TEdit;
    Edit3: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    MeFiles: TMemo;
    GroupBox6: TGroupBox;
    RbDiretorioOriginal: TRadioButton;
    RbOutroDiretorio: TRadioButton;
    CbCaminhoCompleto: TCheckBox;
    EdtDiretorio: TEdit;
    GroupBox7: TGroupBox;
    BtnRestaurar: TBitBtn;
    BtnSair2: TBitBtn;
    BackupFile1: TBackupFile;
    procedure BtnSelecionarClick(Sender: TObject);
    procedure BtnDesmarcarClick(Sender: TObject);
    procedure BackupFile1Progress(Sender: TObject; Filename: String;
      Percent: TPercentage; var Continue: Boolean);
    procedure BtnCriarArquivoClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure RbDiretorioOriginalClick(Sender: TObject);
    procedure BtnRestaurarClick(Sender: TObject);
    procedure FileListBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSair2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBackupRestore: TFrmBackupRestore;

implementation

{$R *.DFM}

procedure TFrmBackupRestore.BtnSelecionarClick(Sender: TObject);
Var I: Integer;
begin
  If OpenDialog.Execute Then
  Begin
    FileListBox.Items.BeginUpdate;
    For I:= 0 to OpenDialog.Files.Count -1 do
      If FileListBox.Items.Indexof(LowerCase(OpenDialog.Files[I])) = -1 Then
        FileListBox.Items.Add(LowerCase(OpenDialog.Files[I]));
    FileListBox.Items.EndUpdate;
  End;
end;

procedure TFrmBackupRestore.BtnDesmarcarClick(Sender: TObject);
begin
  FileListBox.Items.Clear;
end;

procedure TFrmBackupRestore.BackupFile1Progress(Sender: TObject;
  Filename: String; Percent: TPercentage; var Continue: Boolean);
begin
  ProgressBar1.Visible := Percent < 100;
  If ProgressBar1.Visible Then
    ProgressBar1.Position := Percent;
  If Percent < 100 Then
    Label1.Caption := FileName
  Else
    Label1.Caption := '...';
end;

procedure TFrmBackupRestore.BtnCriarArquivoClick(Sender: TObject);
begin
  If FileListBox.Items.Count = 0 Then
    Application.MessageBox('Não há nenhum arquivo selecionado !!!',' Advertência ',48)
  Else
  Begin
    SaveDialog.FileName := EdtNomeBackup.Text;
    If SaveDialog.Execute Then
      If UpperCase(Copy(SaveDialog.FileName,1,1)) = 'A' Then
      Begin
        Application.MessageBox('Você selecionou o drive <A> para backup'+Chr(13)+Chr(13)+'Por favor, coloque um disquete vazio no drive.',' Insira um disquete na unidade <A> ',64);
        BackupFile1.MaxSize := 1400000;
      End
      Else
        BackupFile1.MaxSize := 0;

      BackupFile1.BackupTitle      := EdtNomeBackup.Text;
      BackupFile1.BackupMode       := TBackupMode(RgModoBackup.ItemIndex);
      BackupFile1.CompressionLevel := TCompressionLevel(RgNivelCompactacao.ItemIndex);
      BackupFile1.SaveFileID       := CbGravarNomeArquivo.Checked;

      If BackupFile1.Backup(FileListbox.Items,SaveDialog.FileName) Then
        MessageDlg('Operação realizada com sucesso.'+Chr(13)+Chr(13)+'Taxa de compactação : '+IntToStr(BackupFile1.CompressionRate)+' %',MtInformation,[MbOk],0)

      Else
        Application.MessageBox('Ocorreu alguma falha com o Backup.'+Chr(13)+Chr(13)+'      Verifique !!!',' Erro na execução do Backup ',16);
  End;
end;

procedure TFrmBackupRestore.BtnSairClick(Sender: TObject);
begin
  If Not BackupFile1.Busy Then
    Close
  Else
    If Application.MessageBox('Deseja cancelar o backup ?',' Abortar ',52) = IdYes Then
      BackupFile1.Stop;
end;

procedure TFrmBackupRestore.RbDiretorioOriginalClick(Sender: TObject);
begin
  EdtDiretorio.Enabled      := RbOutroDiretorio.Checked;
  CbCaminhoCompleto.Enabled := RbOutroDiretorio.Checked;
end;

procedure TFrmBackupRestore.BtnRestaurarClick(Sender: TObject);
Var S: String;
begin
  BackupFile1.RestoreMode := TRestoreMode(RgOpcoesrestauracao.ItemIndex);
  If RbDiretorioOriginal.Checked Then
    S := ''
  Else
  Begin
    S := EdtDiretorio.Text;
    If Trim(S) = '' Then
    Begin
      Application.MessageBox('Por favor, digite o nome do diretório(pasta)',' Advertência ',48);
      Exit;
    End;
  End;
  BackupFile1.RestoreFullPath := CbCaminhoCompleto.Enabled and CbCaminhoCompleto.Checked;
  If BackupFile1.Restore(FileListbox1.FileName,S) Then
    MessageDlg('Restauração terminada com sucesso !'+CHR(13)+CHR(13)+IntToStr(BackupFile1.FilesProcessed)+' Arquivos de '+IntToStr(BackupFile1.FilesTotal)+' restaurados.',MtInformation,[MbOk],0)
  Else
    Application.MessageBox('Falha na restauração dos arquivos'+CHR(13)+'ou o usuário cancelou-o.',' Erro na restauração ',16);
end;

procedure TFrmBackupRestore.FileListBox1Click(Sender: TObject);
Var Files: TStringList;
    I:     Integer;
    S, FA, SZ: String;
begin
  Files := TStringList.Create;
  MeFiles.Lines.Clear;
  Edit2.Text := BackupFile1.GetArchiveTitle(FileListbox1.FileName,Files);
  If Edit2.Text = '' Then
    Edit3.Text := ''
  Else
  Begin
    Edit2.Text := IntToStr(BackupFile1.FilesTotal)+' Arquivos, '+IntToStr(Round(BackupFile1.SizeTotal / 1024))+ ' Kb total';
    MeFiles.Lines.BeginUpdate;
    For I := 0 to Files.Count -1 do
    Begin
      S  := Copy(Files[I],1,Pos(#9,Files[I])-1);  // Nome do arquivo
      FA := Copy(Files[I],Pos(#9,Files[I])+1,Pos('=',Files[I])-1); // Ano do arquivo
      FA := DateToStr(FileDateToDateTime(StrToInt(FA)));  // Integer file date is system + language independent;
      Sz := Copy(Files[I],Pos('=',Files[I])+1, Length(Files[I])-Pos('=',Files[I])); // Tamanho do arquivo em Bytes
      MeFiles.Lines.Add(S + ' from ' + FA + ', '+ SZ + ' bytes');
    End;
    If Files.Count = 0 Then
      MeFiles.Lines.Add('Não há informações dos arquivos neste Backup');
    MeFiles.Lines.EndUpdate;
  End;
  Files.Free;
end;
procedure TFrmBackupRestore.FormShow(Sender: TObject);
begin
  FileListBox.Clear;
end;

procedure TFrmBackupRestore.BtnSair2Click(Sender: TObject);
begin
  FrmBackupRestore.Close;
end;

end.
