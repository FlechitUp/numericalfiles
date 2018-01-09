program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp, Trapecioclass, unit1
  { you can add units after this };

type

  { Trapecio }

  Trapecio = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ Trapecio }

procedure Trapecio.DoRun;
var
  ErrorMsg: String;
  trap : TTrapecio;
  funcI, opcionStr :String;
  opcion : Integer;
  la,lb : Real;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h', 'help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h', 'help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  { add your program here }
    WriteLn('Trapecio');
    opcion:=1;
    while (opcionStr = 'Y') do begin
      WriteLn('Escrib 1 para area');
      WriteLn('Escrib 2 para integral');
      ReadLn(opcion);
      trap := TTrapecio.Create;
      if opcion = 1 then begin
        WriteLn('Escribe la Funcion');
        ReadLn(funcI);
        WriteLn('Escribe limit a');
        ReadLn(la);
        WriteLn('Escribe limit b');
        ReadLn(lb);
        WriteLn('Area es  ');
        writeln(trap.getArea(funcI,la,lb,6));
      end;

      if opcion = 2 then begin
        WriteLn('Escribe la Funcion');
        //ReadLn(func);
        WriteLn('Respuesta ');
        writeln(trap.Trapecio('1/(x*x+16)',0,3,6));
      end;
      WriteLn('Continuar Yes = 1, No = 2');
      ReadLn(opcionStr);
    end;
  // stop program loop
  Terminate;
end;

constructor Trapecio.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor Trapecio.Destroy;
begin
  inherited Destroy;
end;

procedure Trapecio.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: Trapecio;
begin
  Application:=Trapecio.Create(nil);
  Application.Title:='My Application';
  Application.Run;
  Application.Free;
end.

