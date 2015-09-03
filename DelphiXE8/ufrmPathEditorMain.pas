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
    Label2: TLabel;
    cmbTheme: TComboBox;
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
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
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
    procedure FormCreate(Sender: TObject);
    procedure cmbThemeClick(Sender: TObject);
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
  private
    const
      BDS_RegPath = 'Software\Embarcadero\BDS';
    type
      TBDSPathEntry = class
      public
        DelphiVersion: string;
        RegistryPath: string;
        EnvVarPath: string;
        constructor Create(const BDSKey, RegPath, CurrEnvVarPath: string);
      end;
    var
      FChangesMade: Boolean;
    procedure ListPaths;
    procedure InitThemes;
    procedure InitDelphis;
    procedure AddDelphiPath(const BDSKey: string);
    procedure SetChangesMade(const Value: Boolean);
    property ChangesMade: Boolean read FChangesMade write SetChangesMade;
  end;

var
  frmPathEditorMain: TfrmPathEditorMain;

implementation

{$R *.dfm}

uses
  Registry, Clipbrd,
  VCL.Themes;

{ TfrmPathEditorMain.TBDSPathEntry }

constructor TfrmPathEditorMain.TBDSPathEntry.Create(const BDSKey, RegPath, CurrEnvVarPath: string);
var
  BDSVr: Double;
  IntVer: Integer;
begin
  {$IFDEF UseCodeSite} CodeSite.EnterMethod(Self, 'Create'); {$ENDIF}
  {$IFDEF UseCodeSite} CodeSite.Send('BDSKey', BDSKey); {$ENDIF}
  {$IFDEF UseCodeSite} CodeSite.Send('Registry Path to Environment Variables', RegPath); {$ENDIF}
  {$IFDEF UseCodeSite} CodeSite.Send('Path setting', CurrEnvVarPath); {$ENDIF}

  if TryStrToFloat(BDSKey, BDSVr) then
    IntVer := Round(BDSVr * 10.0)
  else
    IntVer := 0;

  case IntVer of
    70 : DelphiVersion := 'Vr 14: "Delphi 2010"';
    80 : DelphiVersion := 'Vr 15: "Delphi XE"';
    90 : DelphiVersion := 'Vr 16: "Delphi XE2"';
    100: DelphiVersion := 'Vr 17: "Delphi XE3"';
    110: DelphiVersion := 'Vr 18: "Delphi XE4"';
    120: DelphiVersion := 'Vr 19: "Delphi XE5"';
    140: DelphiVersion := 'Vr 20: "Delphi XE6"';
    150: DelphiVersion := 'Vr 21: "Delphi XE7"';
    160: DelphiVersion := 'Vr 22: "Delphi XE8"';
    170: DelphiVersion := 'Vr 23: "Delphi 10 Seattle"';
  else
    DelphiVersion := 'N/A';
  end;
  {$IFDEF UseCodeSite} CodeSite.Send('Delphi Version', DelphiVersion); {$ENDIF}

  RegistryPath := RegPath;
  EnvVarPath := CurrEnvVarPath;

  {$IFDEF UseCodeSite} CodeSite.ExitMethod(Self, 'Create'); {$ENDIF}
end;

{ TfrmPathEditorMain }

procedure TfrmPathEditorMain.actCancelExecute(Sender: TObject);
begin
  if ChangesMade then
    if dlgCancelChangesPrompt.Execute and (dlgCancelChangesPrompt.ModalResult = mrYes) then
      ListPaths;
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
  end;

  ChangesMade := True;
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
    lbPaths.ItemIndex := SaveItemIndex - 1;

    ChangesMade := True;
  end;
end;

procedure TfrmPathEditorMain.AddDelphiPath(const BDSKey: string);
var
  reg: TRegistry;
  EnvVarPath: string;
  EnvironPath: string;
  BDSEntry: TBDSPathEntry;
begin
  {$IFDEF UseCodeSite} CodeSite.EnterMethod(Self, 'AddDelphiPath'); {$ENDIF}
  {$IFDEF UseCodeSite} CodeSite.Send('BDSKey', BDSKey); {$ENDIF}

  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_CURRENT_USER;
    EnvVarPath := BDS_RegPath + '\' + BDSKey + '\Environment Variables';
    if reg.OpenKeyReadOnly(EnvVarPath) then begin
      EnvironPath := reg.ReadString('Path');
      BDSEntry := TBDSPathEntry.Create(BDSKey, EnvVarPath, EnvironPath);
      if Assigned(BDSEntry) then
        cmbDelphis.Items.AddObject(BDSEntry.DelphiVersion, BDSEntry);
      reg.CloseKey;
    end;
  finally
    reg.Free;
  end;

  {$IFDEF UseCodeSite} CodeSite.ExitMethod(Self, 'AddDelphiPath'); {$ENDIF}
end;

procedure TfrmPathEditorMain.ListPaths;
var
  BDSPathEntry: TBDSPathEntry;
begin
  {$IFDEF UseCodeSite} CodeSite.EnterMethod( Self, 'ListPaths' ); {$ENDIF}

  if (cmbDelphis.ItemIndex > -1) and Assigned(cmbDelphis.Items.Objects[cmbDelphis.ItemIndex]) then begin
    BDSPathEntry := cmbDelphis.Items.Objects[cmbDelphis.ItemIndex] as TBDSPathEntry;
    lbPaths.Items.Delimiter := ';';
    lbPaths.Items.StrictDelimiter := True;
    lbPaths.Items.DelimitedText := BDSPathEntry.EnvVarPath;

    lbPaths.ItemIndex := -1;

    ChangesMade := False;
  end;

  {$IFDEF UseCodeSite} CodeSite.ExitMethod( Self, 'ListPaths' ); {$ENDIF}
end;

procedure TfrmPathEditorMain.SetChangesMade(const Value: Boolean);
begin
  FChangesMade := Value;
  lblChangeIndicator.Visible := FChangesMade;
  cmbDelphis.Enabled := not FChangesMade;

  actCancel.Enabled := ChangesMade;
  actSave.Enabled := ChangesMade;

  actAdd.Enabled := lbPaths.Items.Count > 0;
  actRemove.Enabled := lbPaths.Items.Count > 0;
  actEditCut.Enabled := lbPaths.Items.Count > 0;
  actEditCopy.Enabled := lbPaths.Items.Count > 0;
  actEditPaste.Enabled := lbPaths.Items.Count > 0;
  actMoveUp.Enabled := lbPaths.Items.Count > 0;
  actMoveDown.Enabled := lbPaths.Items.Count > 0;
end;

procedure TfrmPathEditorMain.cmbDelphisChange(Sender: TObject);
begin
  ListPaths;
end;

procedure TfrmPathEditorMain.cmbDelphisCloseUp(Sender: TObject);
begin
  ListPaths;
end;

procedure TfrmPathEditorMain.cmbThemeClick(Sender: TObject);
begin
  TStyleManager.SetStyle(cmbTheme.Text);
end;

procedure TfrmPathEditorMain.InitDelphis;
var
  reg: TRegistry;
  bdsKey: string;
  bdsKeys: TStringList;
  delphi_vr: string;
begin
  {$IFDEF UseCodeSite} CodeSite.EnterMethod(Self, 'InitDelphis'); {$ENDIF}

  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKeyReadOnly(BDS_RegPath) then begin
      bdsKeys := TStringList.Create;
      try
        reg.GetKeyNames(bdsKeys);
        for bdsKey in bdsKeys do
          AddDelphiPath(bdsKey);
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
  delphi_vr := Trim(ccRegistryLayoutSaver.ResstoreStrValue('LastDelphiProduct'));
  if Length(delphi_vr) > 0 then
    cmbDelphis.ItemIndex := cmbDelphis.Items.IndexOf(delphi_vr)
  else
    cmbDelphis.ItemIndex := 0;

  ListPaths;

  {$IFDEF UseCodeSite} CodeSite.ExitMethod(Self, 'InitDelphis'); {$ENDIF}
end;

procedure TfrmPathEditorMain.InitThemes;
var
  style: string;
begin
  {$IFDEF UseCodeSite} CodeSite.EnterMethod(Self, 'InitThemes'); {$ENDIF}

  // load the combo box
  for style in TStyleManager.StyleNames do
    cmbTheme.Items.Add(style);

  // restore saved setting
  style := Trim(ccRegistryLayoutSaver.ResstoreStrValue('Theme'));
  if Length(style) > 0 then
    TStyleManager.SetStyle(style);

  cmbTheme.ItemIndex := cmbTheme.Items.IndexOf(TStyleManager.ActiveStyle.Name);

  {$IFDEF UseCodeSite} CodeSite.ExitMethod(Self, 'InitThemes'); {$ENDIF}
end;

procedure TfrmPathEditorMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ChangesMade then
    CanClose := dlgCancelChangesPrompt.Execute and (dlgCancelChangesPrompt.ModalResult = mrYes);
end;

procedure TfrmPathEditorMain.FormCreate(Sender: TObject);
begin
  {$IFDEF UseCodeSite} CodeSite.EnterMethod(Self, 'FormCreate'); {$ENDIF}

  InitDelphis;
  InitThemes;

  {$IFDEF UseCodeSite} CodeSite.ExitMethod(Self, 'FormCreate'); {$ENDIF}
end;

procedure TfrmPathEditorMain.FormDestroy(Sender: TObject);
begin
  {$IFDEF UseCodeSite} CodeSite.EnterMethod(Self, 'FormDestroy'); {$ENDIF}

  ccRegistryLayoutSaver.SaveStrValue('Theme', TStyleManager.ActiveStyle.Name);
  ccRegistryLayoutSaver.SaveStrValue('LastDelphiProduct', cmbDelphis.Text);

  {$IFDEF UseCodeSite} CodeSite.ExitMethod(Self, 'FormDestroy'); {$ENDIF}
end;

end.
