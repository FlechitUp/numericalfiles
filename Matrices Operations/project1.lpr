program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp, Matrices, Crt, ParseMath, Jacobiana, ArrReal,
  ArrStr, NewtonRaphson, PuntoFijo;
  { you can add units after this }

type

  { Matric }

  Matric = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    MatricA: TMatrices;
    MatricB: TMatrices;
    MatricR: TMatrices;
    JacobA : TJacobiana;
    Newton : TNewtonRap;
    PtoFijo : TPuntoFijo;
    k_doub : Double;
    seg_Int, Nrovar, ic : Integer;
    fil, col, select, p_Int : Integer;
    fx_ListI : TArrString;
    var_ListI : TArrString;
    val_ListI : TArrReal;
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ Matric }

procedure Matric.DoRun;
var
  ErrorMsg: String;
  it : Integer;
  valI :String;
  valI2 : Real;
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

  repeat begin
  writeln('Elige');
  WriteLn('1 Suma +');
  WriteLn('2 Resta -');
  WriteLn('3 Multiplicacion *');
  WriteLn('4 K.A');
  WriteLn('5 Inversa A^-1');
  WriteLn('6 Potencia');
  WriteLn('7 Newton');
  WriteLn('8 PuntoFijo');
  ReadLn(select);

  if (select <>7) and (select<>8)then begin
  writeln('Ingresa filas para A[]');
  Readln(fil);
  if (select =6)then begin
     writeln('Matriz cuadrada A[',fil,', ',col,']');
      MatricA:= TMatrices.Create(fil,fil);
  end
  else begin
  writeln('Ingresa columnas para A[]');
  Readln(col);
  MatricA:= TMatrices.Create(fil,col);
  end;

  MatricA.setMatriz();
  MatricA.printM();
  end;

  if (select = 1) or (select = 2)then begin
     writeln('B[',fil,' ,',col,']');
     WriteLn('Ingresa datos para B');
     MatricB:= TMatrices.Create(fil,col);
     MatricB.setMatriz();
     MatricB.printM();
  end

  else begin
     if (select =3)then begin
       writeln('B[',col,' ,',fil,']');
       WriteLn('Ingresa datos para B');
       MatricB:= TMatrices.Create(col,fil);
       MatricB.setMatriz();
       MatricB.printM();
     end

    else if (select = 7) then begin
      fx_ListI:=TArrString.Create();
      var_ListI:=TArrString.Create();
      val_ListI:=TArrReal.Create();

      WriteLn('Ingresa la cantidad de variables');
      ReadLn(Nrovar);

      MatricA:= TMatrices.Create(Nrovar,Nrovar);
      WriteLn('Ingresa las variables');
      for it := 0 to Nrovar-1 do begin
        ReadLn(valI);
        var_ListI.push(valI);
      end;

      WriteLn('Ingresa las funciones');
      for it := 0 to Nrovar-1 do begin
        ReadLn(valI);
        fx_ListI.push(valI);
      end;

      WriteLn('Ingresa los valores');
      for it := 0 to Nrovar-1 do begin
        ReadLn(valI2);
        val_ListI.push(valI2);
      end;

      //Activar para Jacobiana
      {JacobA:=TJacobiana.create();
      MatricA:= JacobA.Evaluate(fx_ListI,var_ListI, val_ListI, Nrovar);
      MatricA.printM();       }

      //Activar para Newton
      Newton := TNewtonRap.create();
      //Newton.EvaluateInvJacobiana(fx_ListI,var_ListI,val_ListI,Nrovar);
      //Newton.f_x(fx_ListI,var_ListI,val_ListI,Nrovar);
      //Newton.AllNewton(fx_ListI,var_ListI , val_ListI,Nrovar);
      Newton.CompleteNewton(fx_ListI,var_ListI,val_ListI,Nrovar,0.0000001);

    end
    else if (select = 8) then begin
      PtoFijo := TPuntoFijo.create();
      fx_ListI:=TArrString.Create();
      var_ListI:=TArrString.Create();
      val_ListI:=TArrReal.Create();

      WriteLn('Ingresa la cantidad de variables');
      ReadLn(Nrovar);

      MatricA:= TMatrices.Create(Nrovar,Nrovar);
      WriteLn('Ingresa las variables');
      for it := 0 to Nrovar-1 do begin
        ReadLn(valI);
        var_ListI.push(valI);
      end;

      WriteLn('Ingresa las funciones');
      for it := 0 to Nrovar-1 do begin
        ReadLn(valI);
        fx_ListI.push(valI);
      end;

      WriteLn('Ingresa los valores');
      for it := 0 to Nrovar-1 do begin
        ReadLn(valI2);
        val_ListI.push(valI2);
      end;

      PtoFijo.f_x(fx_ListI,var_ListI,val_ListI,Nrovar,0.001);


    end

    else if(select <>4) and (select <>5) and (select<>6) then begin
      writeln('Ingresa filas para B[]');
      Readln(fil);
      writeln('Ingresa columnas para B[]');
      Readln(col);
      MatricB:= TMatrices.Create(fil,col);
      MatricB.setMatriz();
      MatricB.printM();
    end

  end;

   writeln('Respuesta');
  case select of
        1: begin
              MatricA := MatricA.Suma(MatricB); MatricA.printM();
        end;
        2: begin
              MatricA := MatricA.Resta(MatricB); MatricA.printM();
        end;
        3:begin
              MatricA := MatricA.Multiplicacion(MatricA ,MatricB); MatricA.printM();
        end;
        4 : begin
              writeln('Ingresa Escalar');
              Readln(k_doub);
              MatricA := MatricA.MultEscalar(MatricA,k_doub);
              MatricA.printM();
        end;
        5 : begin
              MatricA := MatricA.Inversa(MatricA);
              MatricA.printM();
        end;
        6:begin
              writeln('Ingresa Potencia');
              Readln(p_Int);
              MatricA := MatricA.Potencia(MatricA, p_Int);
              MatricA.printM();
        end;

   end;
  end;
   WriteLn('Continuar ? si = 1');
   ReadLn(seg_Int);
   MatricA.Destroy;
   //MatricB.Destroy;
  until (seg_Int<>1);


  // stop program loop
  Terminate;
end;

constructor Matric.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor Matric.Destroy;
begin
  inherited Destroy;
end;

procedure Matric.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: Matric;
begin
  Application:=Matric.Create(nil);
  Application.Title:='My Application';
  Application.Run;
  Application.Free;
end.

