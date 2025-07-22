unit uDMConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, System.IniFiles, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite;

type
  TDMConexao = class(TDataModule)
    Conexao: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ConectarBanco;
    procedure CriarBanco;
  end;

var
  DMConexao: TDMConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMConexao }

procedure TDMConexao.ConectarBanco;
var
  Ini: TIniFile;
  IniPath, DBDriver, DBDatabase: string;
begin
  IniPath := ExtractFilePath(ParamStr(0)) + 'teste.ini';
  if not FileExists(IniPath) then
    raise Exception.Create('Arquivo config.ini não encontrado!');

  Ini := TIniFile.Create(IniPath);
  try
    DBDriver   := Ini.ReadString('Database', 'Driver', 'SQLite');
    DBDatabase := Ini.ReadString('Database', 'Database', '');
  finally
    Ini.Free;
  end;

  Conexao.Connected := False;
  Conexao.Params.Clear;
  Conexao.Params.DriverID := DBDriver;
  Conexao.Params.Database := DBDatabase;
  Conexao.LoginPrompt := False;

  try
    Conexao.Connected := True;
  except
    on E: Exception do
      raise Exception.Create('Erro ao conectar ao banco SQLite: ' + E.Message);
  end;
end;

procedure TDMConexao.CriarBanco;
begin
  if Conexao.Connected then
  begin
    Conexao.ExecSQL('CREATE TABLE IF NOT EXISTS Clientes ( ' +
                    ' Codigo INTEGER PRIMARY KEY, ' +
                    ' Nome TEXT NOT NULL, ' +
                    ' Cidade TEXT, ' +
                    ' UF TEXT);');
  end;

end;

procedure TDMConexao.DataModuleCreate(Sender: TObject);
begin
  ConectarBanco;
  CriarBanco;
end;

end.
