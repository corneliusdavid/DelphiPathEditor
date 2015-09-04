program DelphiPathEditor;

uses
  Vcl.Forms,
  ufrmPathEditorMain in 'ufrmPathEditorMain.pas' {frmPathEditorMain},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Aqua Light Slate');
  Application.CreateForm(TfrmPathEditorMain, frmPathEditorMain);
  Application.Run;
end.
