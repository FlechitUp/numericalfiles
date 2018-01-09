program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp, Lagrangeclass, Matrices
  { you can add units after this };

type

  { Lagrange }

  Lagrange = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ Lagrange }

procedure Lagrange.DoRun;
var
  ErrorMsg, polinom: String;
  lagrangeI : TLagrange;
  cantcols : Integer;
  numbI, numbO : Real;
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
   WriteLn('Ingresa cantidad de columnas');
   Read(cantcols);
   lagrangeI := TLagrange.Create(cantcols);
   lagrangeI.getPolinomio();
   cantcols := 1;
   while (cantcols = 1) do begin
         WriteLn('Ingresa valor a evaluar');
         ReadLn(numbI);
         numbO := lagrangeI.evaluar_function(numbI);
         WriteLn('El numero es ',numbO);
         WriteLn('Continuar Yes = 1, No = 2');
         ReadLn(cantcols);
   end;

  //ReadLn;
  // stop program loop
  Terminate;
end;

constructor Lagrange.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor Lagrange.Destroy;
begin
  inherited Destroy;
end;

procedure Lagrange.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: Lagrange;
begin
  Application:=Lagrange.Create(nil);
  Application.Title:='My Application';
  Application.Run;
  Application.Free;
end.

