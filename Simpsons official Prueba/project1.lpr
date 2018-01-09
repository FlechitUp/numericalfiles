program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp, Ssimpsonclass
  { you can add units after this };

type

  { Simpsons2Methods }

  Simpsons2Methods = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ Simpsons2Methods }

procedure Simpsons2Methods.DoRun;
var
  ErrorMsg: String;
  simpson : TSimpsonMethods;
  limit_a, limit_b, Respta :Real;
  N_ : Integer;
  func: String;
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
  simpson := TSimpsonMethods.Create();
   WriteLn('Simpson Methods');
 WriteLn('Ingrese funcion');
  ReadLn(func);
   WriteLn('Ingrese limit a');
  ReadLn(limit_a);
   WriteLn('Ingrese limit b');
  ReadLn(limit_b);
  WriteLn('Ingrese N');
  ReadLn(N_);
  Respta := simpson.SimpsonUm3(func,limit_a,limit_b,N_);
  WriteLn('Respuesta con Simpson 1/3 ', Respta,' = ',Respta:2:5);
  Respta := simpson.Simpson38(func,limit_a,limit_b,N_);
  WriteLn('Respuesta con Simpson 3/8 ', Respta,' = ',Respta:2:5);

 { Respta := simpson.SimpsonUm3('power(2.718281,2*x)-x',-2,1,1000);
  WriteLn('Respuesta con Simpson 1/3 ', Respta,' = ',Respta:2:5);
  Respta := simpson.Simpson38('power(2.718281,2*x)-x',-2,1,1000000);
  WriteLn('Respuesta con Simpson 3/8 ', Respta,' = ',Respta:2:5);}
  ReadLn;
  // stop program loop
  Terminate;
end;

constructor Simpsons2Methods.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor Simpsons2Methods.Destroy;
begin
  inherited Destroy;
end;

procedure Simpsons2Methods.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: Simpsons2Methods;
begin
  Application:=Simpsons2Methods.Create(nil);
  Application.Title:='My Application';
  Application.Run;
  Application.Free;
end.

