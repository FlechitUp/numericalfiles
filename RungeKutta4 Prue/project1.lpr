program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp, rungekuttaclass, StrMat
  { you can add units after this };

type

  { Rumgekuta4 }

  Rumgekuta4 = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ Rumgekuta4 }

procedure Rumgekuta4.DoRun;
var
  ErrorMsg: String;
  RumgeK4: TRungekutta;
  f_x : String;
  matStr : TStrMatriz;
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
  RumgeK4 := TRungekutta.Create;
  matStr := TStrMatriz.Create();
  f_x:='x*sqrt(y)';
  matStr:= RumgeK4.makeRK4(f_x,1,4,4,0.1);
  //WriteLn('mat str');
  matStr.print();
  // stop program loop
  ReadLn;
  Terminate;
end;

constructor Rumgekuta4.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor Rumgekuta4.Destroy;
begin
  inherited Destroy;
end;

procedure Rumgekuta4.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: Rumgekuta4;
begin
  Application:=Rumgekuta4.Create(nil);
  Application.Title:='My Application';
  Application.Run;
  Application.Free;
end.

