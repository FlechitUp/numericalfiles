program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp, Bisec, crt
  { you can add units after this };

type

  { Biseccion }

  Biseccion = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    rpt :Double;
    fn : String;
    Bisec : TBiseccion;
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ Biseccion }

procedure Biseccion.DoRun;
var
  ErrorMsg: String;
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
   Bisec := TBiseccion.Create;
   WriteLn('Escribe la fx');
   ReadLn(fn);
   Bisec.set_MyFunction(fn);
   writeln('ok');
   rpt:= Bisec.bisection(-0.5, 0.5, 0.0001);
   WriteLn('Respuesta ',rpt:0:2, ' = ', rpt);
   WriteLn('**--------------------');
   readkey;
   rpt:= Bisec.falsa_pos(0.4, 0.8, 0.0001);
   WriteLn('Respuesta ',rpt:0:2, ' = ', rpt);
   readkey;
  // stop program loop
  Terminate;
end;

constructor Biseccion.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor Biseccion.Destroy;
begin
  inherited Destroy;
end;

procedure Biseccion.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: Biseccion;
begin
  Application:=Biseccion.Create(nil);
  Application.Title:='My Application';
  Application.Run;
  Application.Free;
end.

