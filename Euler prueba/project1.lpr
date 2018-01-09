program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp, Eulerclass, StrMat
  { you can add units after this };

type

  { Euler }

  Euler = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ Euler }

procedure Euler.DoRun;
var
  ErrorMsg: String;
  euler : TEuler;
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
  euler := TEuler.Create;
  matStr := TStrMatriz.Create();
  f_x:='power(y+1,2)/(power(x,2)*y*ln(x))';
  //matStr :=  euler.makeEuler(13, 1, 4, '(power(x,5)*power(y,1/2)-power(x,5)*y)/x');   //power((2*y+3)/(4*x+5),2)
  matStr := euler.makeEuler(20,1,3,f_x);
  euler.comprobar(20,matStr,f_x);
  //matStr :=  euler.makeEuler(3, 0,3, 'y');
  WriteLn('mat str');
  matStr.print();
  {matStr :=  euler.makeHeun(10, 1, 2, 'x*power(y,1/2)');
  WriteLn('mat str');
  matStr.print();}
  ReadLn;

  // stop program loop
  Terminate;
end;

constructor Euler.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor Euler.Destroy;
begin
  inherited Destroy;
end;

procedure Euler.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: Euler;
begin
  Application:=Euler.Create(nil);
  Application.Title:='My Application';
  Application.Run;
  Application.Free;
end.

