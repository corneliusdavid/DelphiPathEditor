unit ufrmPathEditorMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList;

type
  TfrmPathEditorMain = class(TForm)
    Label1: TLabel;
    cmbDelphis: TComboBox;
    Label2: TLabel;
    cmbTheme: TComboBox;
    ListBox1: TListBox;
    imlActions: TImageList;
    actPathActions: TActionList;
    actSave: TAction;
    actCancel: TAction;
    actAdd: TAction;
    actRemove: TAction;
    btnSave: TSpeedButton;
    btnCancel: TSpeedButton;
    btnAdd: TSpeedButton;
    btnRemove: TSpeedButton;
    mnuPathActions: TPopupMenu;
    Save1: TMenuItem;
    Cancel1: TMenuItem;
    N1: TMenuItem;
    Add1: TMenuItem;
    Remove1: TMenuItem;
    dlgNoDelphi: TTaskDialog;
    procedure FormCreate(Sender: TObject);
    procedure cmbThemeClick(Sender: TObject);
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
    procedure InitThemes;
    procedure InitDelphis;
    procedure AddDelphiPath(const BDSKey: string);
  end;

var
  frmPathEditorMain: TfrmPathEditorMain;

implementation

{$R *.dfm}

uses
  Registry,
  VCL.Themes;

{ TfrmPathEditorMain.TBDSPathEntry }

constructor TfrmPathEditorMain.TBDSPathEntry.Create(const BDSKey, RegPath, CurrEnvVarPath: string);
var
  BDSVr: Double;
  IntVer: Integer;
begin
  if TryStrToFloat(BDSKey, BDSVr) then
    IntVer := Round(BDSVr * 10.0)
  else
    IntVer := 0;

  case IntVer of
    70 : DelphiVersion := 'Delphi 2010';
    80 : DelphiVersion := 'Delphi XE';
    90 : DelphiVersion := 'Delphi XE2';
    100: DelphiVersion := 'Delphi XE3';
    110: DelphiVersion := 'Delphi XE4';
    120: DelphiVersion := 'Delphi XE5';
    140: DelphiVersion := 'Delphi XE6';
    150: DelphiVersion := 'Delphi XE7';
    160: DelphiVersion := 'Delphi XE8';
    170: DelphiVersion := 'Delphi XE10';
  else
    DelphiVersion := 'N/A';
  end;

  RegistryPath := RegPath;
  EnvVarPath := CurrEnvVarPath;
end;

{ TfrmPathEditorMain }

procedure TfrmPathEditorMain.AddDelphiPath(const BDSKey: string);
var
  reg: TRegistry;
  EnvVarPath: string;
  EnvironPath: string;
  BDSEntry: TBDSPathEntry;
begin
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
begin
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
end;

procedure TfrmPathEditorMain.InitThemes;
var
  style: string;
begin
  for style in TStyleManager.StyleNames do
    cmbTheme.Items.Add(style);
  cmbTheme.ItemIndex := cmbTheme.Items.IndexOf(TStyleManager.ActiveStyle.Name);
end;

procedure TfrmPathEditorMain.FormCreate(Sender: TObject);
begin
  InitDelphis;
  InitThemes;
end;

end.
