unit ObjetosUteis;

interface

uses Windows, DB, classes, ADODb, dbctrls, buttons, comctrls, stdctrls, Forms,
     Sysutils, Dialogs, FileCtrl, inifiles, Shellapi, dbclient,  variants,
     FireDAC.Comp.Client;

  procedure CreateDataset(var Dataset: TFDQuery; Conexao: TFDConnection);
  procedure FreeDataset(var Dataset: TFDQuery);


implementation

procedure CreateDataset(var Dataset: TFDQuery; Conexao: TFDConnection);
begin
  Dataset := TFDQuery.Create(nil);
  Dataset.Connection := Conexao;
  Dataset.Close;
  Dataset.SQL.Clear;
end;

procedure FreeDataset(var Dataset: TFDQuery);
begin
  Dataset.Close;
  FreeAndNil(Dataset);
end;

end.
