unit ufrmPathEditorMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, LayoutSaver, Vcl.StdActns,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls;

type
  TfrmPathEditorMain = class(TForm)
    Label1: TLabel;
    cmbDelphis: TComboBox;
    imlActions: TImageList;
    actPathActions: TActionList;
    actSave: TAction;
    actCancel: TAction;
    actAdd: TAction;
    actRemove: TAction;
    mnuPathActions: TPopupMenu;
    Save1: TMenuItem;
    Cancel1: TMenuItem;
    N1: TMenuItem;
    Add1: TMenuItem;
    Remove1: TMenuItem;
    dlgNoDelphi: TTaskDialog;
    ccRegistryLayoutSaver: TccRegistryLayoutSaver;
    N2: TMenuItem;
    Edit1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    actEditCut: TEditCut;
    actEditCopy: TEditCopy;
    actEditPaste: TEditPaste;
    N3: TMenuItem;
    actMoveUp: TAction;
    actMoveDown: TAction;
    lblChangeIndicator: TLabel;
    MoveUp1: TMenuItem;
    MoveDown1: TMenuItem;
    dlgCancelChangesPrompt: TTaskDialog;
    dlgSaveChangesPrompt: TTaskDialog;
    ToolBar1: TToolBar;
    ToolButton6: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    lbPaths: TListBox;
    txtDelphiInfo: TStaticText;
    StatusBar: TStatusBar;
    actBrowseForFolder: TBrowseForFolder;
    actEditModify: TAction;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmbDelphisChange(Sender: TObject);
    procedure cmbDelphisCloseUp(Sender: TObject);
    procedure actRemoveExecute(Sender: TObject);
    procedure actMoveUpExecute(Sender: TObject);
    procedure actMoveDownExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actEditCutExecute(Sender: TObject);
    procedure actEditCopyExecute(Sender: TObject);
    procedure actEditPasteExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actEditModifyExecute(Sender: TObject);
    procedure lbPathsClick(Sender: TObject);
  private
    const
      BDS_RegPath = 'Software\Embarcadero\BDS';
    type
      TBDSPathEntry = class
      public
        BDSKey: string;
        DelphiVersion: string;
        CompilerVer: string;
        DelphiInstallPath: string;
        RegistryPath: string;
        EnvVarPath: string;
        constructor Create(const NewBDSKey, NewRegPath, NewEnvVarPath, NewInstallPath: string);
      end;
    var
      FChangesMade: Boolean;
    function GetInstallPath(const BDSKey: string): string;
    function GetEnvironPaths(const BDSKey: string): string;
    function BuildEnvironmentVarRegPath(const BDSKey: string): string;
    procedure InitDelphis;
    procedure ParseAndListPaths(const EnvironmentVarPaths: string);
    procedure ListPathsForCurrentProduct;
    procedure WritePaths(BDSEntry: TBDSPathEntry);
    procedure SaveCurrentPaths;
    procedure AddDelphiEntry(const BDSKey: string);
    procedure SetChangesMade(const Value: Boolean);
    property ChangesMade: Boolean read FChangesMade write SetChangesMade;
    procedure ToggleEditActions;
  end;

var
  frmPathEditorMain: TfrmPathEditorMain;


implementation


{$R *.dfm}

uses
  {$IFDEF UseCodeSite} CodeSiteLogging, {$ENDIF}
  Registry, Clipbrd;

{ TfrmPathEditorMain.TBDSPathEntry }

constructor TfrmPathEditorMain.TBDSPathEntry.Create(const NewBDSKey, NewRegPath, NewEnvVarPath, NewInstallPath: string);
var
  BDSVr: Double;
  IntVer: Integer;
begin
  {$IFDEF UseCodeSite} CodeSite.EnterMethod(Self, 'Create'); {$ENDIF}
  {$IFDEF UseCodeSite} CodeSite.Send('NewBDSKey', NewBDSKey); {$ENDIF}
  {$IFDEF UseCodeSite} CodeSite.Send('New Registry Path to Environment Variables', NewRegPath); {$ENDIF}
  {$IFDEF UseCodeSite} CodeSite.Send('New Path setting', NewEnvVarPath); {$ENDIF}

  BDSKey := NewBDSKey;
  RegistryPath := NewRegPath;
  EnvVarPath := NewEnvVarPath;
  DelphiInstallPath := NewInstallPath;

  if TryStrToFloat(BDSKey, BDSVr) then
    IntVer := Round(BDSVr * 10.0)
  else
    IntVer := 0;

  case IntVer of
    60 : begin DelphiVersion := 'BDS 06: "Delphi 2009"';       CompilerVer := 'Compiler vr. 13' end;
    70 : begin DelphiVersion := 'BDS 07: "Delphi 2010"';       CompilerVer := 'Compiler vr. 14' end;
    80 : begin DelphiVersion := 'BDS 08: "Delphi XE"';         CompilerVer := 'Compiler vr. 15' end;
    90 : begin DelphiVersion := 'BDS 09: "Delphi XE2"';        CompilerVer := 'Compiler vr. 16' end;
    100: begin DelphiVersion := 'BDS 10: "Delphi XE3"';        CompilerVer := 'Compiler vr. 17' end;
    110: begin DelphiVersion := 'BDS 11: "Delphi XE4"';        CompilerVer := 'Compiler vr. 18' end;
    120: begin DelphiVersion := 'BDS 12: "Delphi XE5"';        CompilerVer := 'Compiler vr. 19' end;
    140: begin DelphiVersion := 'BDS 14: "Delphi XE6"';        CompilerVer := 'Compiler vr. 20' end;
    150: begin DelphiVersion := 'BDS 15: "Delphi XE7"';        CompilerVer := 'Compiler vr. 21' end;
    160: begin DelphiVersion := 'BDS 16: "Delphi XE8"';        CompilerVer := 'Compiler vr. 22' end;
    170: begin DelphiVersion := 'BDS 17: "Delphi 10 Seattle"'; CompilerVer := 'Compiler vr. 23' end;
    else begin DelphiVersion := 'N/A';                         CompilerVer := 'N/A'; end;
  end;
  {$IFDEF UseCodeSite} CodeSite.Send('Delphi Version', DelphiVersion); {$ENDIF}

  {$IFDEF UseCodeSite} CodeSite.ExitMethod(Self, 'Create'); {$ENDIF}
end;

{ TfrmPathEditorMain }

procedure TfrmPathEditorMain.actSaveExecute(Sender: TObject);
begin
  if ChangesMade then begin
    SaveCurrentPaths;
    ChangesMade := False;
    cmbDelphis.SetFocus;
  end;
end;

procedure TfrmPathEditorMain.actAddExecute(Sender: TObject);
begin
  if actBrowseForFolder.Execute then begin
    if lbPaths.ItemIndex = -1 then
      lbPaths.Items.Add(actBrowseForFolder.Folder)
    else
      lbPaths.Items.Insert(lbPaths.ItemIndex + 1, actBrowseForFolder.Folder);

    ChangesMade := True;
  end;
end;

procedure TfrmPathEditorMain.actCancelExecute(Sender: TObject);
begin
  if ChangesMade then
    if dlgCancelChangesPrompt.Execute and (dlgCancelChangesPrompt.ModalResult = mrYes) then
      ListPathsForCurrentProduct;
end;

procedure TfrmPathEditorMain.actEditCopyExecute(Sender: TObject);
begin
  if lbPaths.ItemIndex > -1 then
    Clipboard.AsText := lbPaths.Items[lbPaths.ItemIndex];
end;

procedure TfrmPathEditorMain.actEditCutExecute(Sender: TObject);
begin
  if lbPaths.ItemIndex > -1 then begin
    Clipboard.AsText := lbPaths.Items[lbPaths.ItemIndex];
    lbPaths.Items.Delete(lbPaths.ItemIndex);

    ChangesMade := True;
  end;
end;

procedure TfrmPathEditorMain.actEditModifyExecute(Sender: TObject);
begin
  if lbPaths.ItemIndex > -1 then begin
    actBrowseForFolder.Folder := lbPaths.Items[lbPaths.ItemIndex];
    if actBrowseForFolder.Execute then begin
      lbPaths.Items[lbPaths.ItemIndex] := actBrowseForFolder.Folder;

      ChangesMade := True;
    end;
  end;
end;

procedure TfrmPathEditorMain.actEditPasteExecute(Sender: TObject);
begin
  if lbPaths.ItemIndex = -1 then
    lbPaths.ItemIndex := 0;

  lbPaths.Items.Insert(lbPaths.ItemIndex, Clipboard.AsText);

  ChangesMade := True;
end;

procedure TfrmPathEditorMain.actMoveDownExecute(Sender: TObject);
var
  SavePath: string;
  SaveItemIndex: Integer;
begin
  if lbPaths.ItemIndex < lbPaths.Count - 1 then begin
    SaveItemIndex := lbPaths.ItemIndex;
    SavePath := lbPaths.Items[SaveItemIndex + 1];
    lbPaths.Items[SaveItemIndex + 1] := lbPaths.Items[SaveItemIndex];
    lbPaths.Items[SaveItemIndex] := SavePath;
    lbPaths.ItemIndex := SaveItemIndex + 1;

    ChangesMade := True;
  end;
end;

procedure TfrmPathEditorMain.actMoveUpExecute(Sender: TObject);
var
  SavePath: string;
  SaveItemIndex: Integer;
begin
  if lbPaths.ItemIndex > 0 then begin
    SaveItemIndex := lbPaths.ItemIndex;
    SavePath := lbPaths.Items[SaveItemIndex - 1];
    lbPaths.Items[SaveItemIndex - 1] := lbPaths.Items[SaveItemIndex];
    lbPaths.Items[SaveItemIndex] := SavePath;
    lbPaths.ItemIndex := SaveItemIndex - 1;

    ChangesMade := True;
  end;
end;

procedure TfrmPathEditorMain.actRemoveExecute(Sender: TObject);
var
  SaveItemIndex: Integer;
begin
  if lbPaths.ItemIndex > -1 then begin
    SaveItemIndex := lbPaths.ItemIndex;
    lbPaths.Items.Delete(SaveItemIndex);
    lbPaths.ItemIndex := SaveItemIndex;

    ChangesMade := True;
  end;
end;

procedure TfrmPathEditorMain.AddDelphiEntry(const BDSKey: string);
var
  BDSEntry: TBDSPathEntry;
begin
  BDSEntry := TBDSPathEntry.Create(BDSKey, BuildEnvironmentVarRegPath(BDSKey),
                                           GetEnvironPaths(BDSKey),
                                           GetInstallPath(BDSKey));
  if Assigned(BDSEntry) then
    cmbDelphis.Items.AddObject(BDSEntry.DelphiVersion, BDSEntry);
end;

procedure TfrmPathEditorMain.ParseAndListPaths(const EnvironmentVarPaths: string);
begin
  lbPaths.Items.DelimitedText := EnvironmentVarPaths;
  lbPaths.ItemIndex := -1;
  ChangesMade := False;
end;

procedure TfrmPathEditorMain.ListPathsForCurrentProduct;
const
  CRLF = #13#10;
var
  BDSPathEntry: TBDSPathEntry;
begin
  if (cmbDelphis.ItemIndex > -1) and Assigned(cmbDelphis.Items.Objects[cmbDelphis.ItemIndex]) then begin
    BDSPathEntry := cmbDelphis.Items.Objects[cmbDelphis.ItemIndex] as TBDSPathEntry;
    ParseAndListPaths(BDSPathEntry.EnvVarPath);

    // other useful info
    StatusBar.Panels[1].Text := 'Registry Path: HKEY_CURRENT_USER\' + BDSPathEntry.RegistryPath;
    txtDelphiInfo.Caption := BDSPathEntry.CompilerVer + CRLF + CRLF +
                             'Installed at:' + CRLF +
                             BDSPathEntry.DelphiInstallPath;
  end;
end;

procedure TfrmPathEditorMain.SetChangesMade(const Value: Boolean);
begin
  FChangesMade := Value;
  lblChangeIndicator.Visible := FChangesMade;
  cmbDelphis.Enabled := not FChangesMade;

  actCancel.Visible := ChangesMade;
  actSave.Visible := ChangesMade;

  ToggleEditActions;
end;

procedure TfrmPathEditorMain.ToggleEditActions;
begin
  actAdd.Enabled := lbPaths.Items.Count > 0;
  actRemove.Enabled := lbPaths.Items.Count > 0;
  actEditCut.Enabled := lbPaths.Items.Count > 0;
  actEditCopy.Enabled := lbPaths.Items.Count > 0;
  actEditPaste.Enabled := lbPaths.Items.Count > 0;
  actMoveUp.Enabled := (lbPaths.Items.Count > 0) and (lbPaths.ItemIndex > 0);
  actMoveDown.Enabled := (lbPaths.Items.Count > 0) and (lbPaths.ItemIndex < lbPaths.Items.Count - 1);
end;

function TfrmPathEditorMain.BuildEnvironmentVarRegPath(const BDSKey: string): string;
begin
  Result := BDS_RegPath + '\' + BDSKey + '\Environment Variables';
end;

function TfrmPathEditorMain.GetEnvironPaths(const BDSKey: string): string;
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    if reg.OpenKeyReadOnly(BuildEnvironmentVarRegPath(BDSKey)) then begin
      Result := reg.ReadString('Path');
      reg.CloseKey;
    end;
  finally
    reg.Free;
  end;
end;

function TfrmPathEditorMain.GetInstallPath(const BDSKey: string): string;
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKeyReadOnly(BDS_RegPath + '\' + BDSKey) then begin
      Result := reg.ReadString('RootDir');
      reg.CloseKey;
    end else
      Result := EmptyStr;
  finally
    reg.Free;
  end;
end;

procedure TfrmPathEditorMain.SaveCurrentPaths;
var
  CurrBDSEntry: TBDSPathEntry;
begin
  CurrBDSEntry := cmbDelphis.Items.Objects[cmbDelphis.ItemIndex] as TBDSPathEntry;
  CurrBDSEntry.EnvVarPath := lbPaths.Items.DelimitedText;
  WritePaths(CurrBDSEntry);
end;

procedure TfrmPathEditorMain.WritePaths(BDSEntry: TBDSPathEntry);
var
  reg: TRegistry;
begin
  {$IFDEF UseCodeSite} CodeSite.EnterMethod(Self, 'WritePaths'); {$ENDIF}
  {$IFDEF UseCodeSite} CodeSite.Send( 'RegistryPath', BDSEntry.RegistryPath ); {$ENDIF}

  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(BDSEntry.RegistryPath, False) then begin
      reg.LazyWrite := False;
      reg.WriteString('Path', BDSEntry.EnvVarPath);
      reg.CloseKey;
    end;
  finally
    reg.Free;
  end;

  {$IFDEF UseCodeSite} CodeSite.ExitMethod(Self, 'WritePaths'); {$ENDIF}
end;

procedure TfrmPathEditorMain.cmbDelphisChange(Sender: TObject);
begin
  ListPathsForCurrentProduct;
end;

procedure TfrmPathEditorMain.cmbDelphisCloseUp(Sender: TObject);
begin
  ListPathsForCurrentProduct;
end;

procedure TfrmPathEditorMain.InitDelphis;
var
  reg: TRegistry;
  bdsKey: string;
  bdsKeys: TStringList;
  last_delphi: string;
begin
  lbPaths.Items.Delimiter := ';';
  lbPaths.Items.StrictDelimiter := True;

  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKeyReadOnly(BDS_RegPath) then begin
      bdsKeys := TStringList.Create;
      try
        reg.GetKeyNames(bdsKeys);
        for bdsKey in bdsKeys do
          AddDelphiEntry(bdsKey);
      finally
        bdsKeys.Free;
      end;
    end else begin
      dlgNoDelphi.Execute;
      Application.Terminate;
    end;
    reg.CloseKey;
  finally
    reg.Free;
  end;

  // restore saved setting
  last_delphi := Trim(ccRegistryLayoutSaver.ResstoreStrValue('LastDelphiProduct'));
  if Length(last_delphi) > 0 then
    cmbDelphis.ItemIndex := cmbDelphis.Items.IndexOf(last_delphi)
  else
    cmbDelphis.ItemIndex := 0;

  ListPathsForCurrentProduct;
end;

procedure TfrmPathEditorMain.lbPathsClick(Sender: TObject);
begin
  ToggleEditActions;
end;

procedure TfrmPathEditorMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ChangesMade then begin
    if dlgSaveChangesPrompt.Execute then
      case dlgSaveChangesPrompt.ModalResult of
        mrYes:
          begin
            SaveCurrentPaths;
            CanClose := True;
          end;
        mrNo:
          CanClose := True;
        mrCancel:
          CanClose := False;
      end
    else
      CanClose := False;
  end else
    CanClose := True;
end;

procedure TfrmPathEditorMain.FormCreate(Sender: TObject);
begin
  InitDelphis;
end;

procedure TfrmPathEditorMain.FormDestroy(Sender: TObject);
begin
  ccRegistryLayoutSaver.SaveStrValue('LastDelphiProduct', cmbDelphis.Text);
end;

end.
