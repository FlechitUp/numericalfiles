unit NewtonRaphson;

//NEWTHON RAPHSON

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Jacobiana, ArrStr,ArrReal,Matrices, ParseMath, crt, math;
type TNewtonRap = class
  public

    valores_X : TArrReal;             //Arreglo de respuestas
    valores_Erores : TArrReal;
    constructor create();
    function EvaluateInvJacobiana(fx_ListI,var_ListI : TArrString; val_ListI: TArrReal; Nrovar:Integer): TMatrices;
    function f_x(fx_ListI,var_ListI : TArrString; val_ListI: TArrReal;Nrovar:Integer ):TMatrices;
    function AllNewton(fx_ListI,var_ListI : TArrString; val_ListI: TArrReal;Nrovar:Integer): TMatrices;
    function CalcError(Nrovar:Integer):Real;
    function CompleteNewton(fx_ListI,var_ListI : TArrString; val_ListI: TArrReal;Nrovar:Integer; ErrI : Real):TMatrices;
  end;

implementation

constructor TNewtonRap.create();

begin

  valores_X:= TArrReal.Create();
  valores_Erores := TArrReal.Create();
  valores_Erores.push(-0.1);

end;

function TNewtonRap.EvaluateInvJacobiana(fx_ListI,var_ListI : TArrString; val_ListI: TArrReal; Nrovar:Integer):TMatrices;
var
  MatricA :TMatrices;
  JacobNEWTON : TJacobiana;
begin
  JacobNEWTON := TJacobiana.create();
  MatricA:= TMatrices.Create(Nrovar,Nrovar);
  MatricA:= JacobNEWTON.Evaluate(fx_ListI,var_ListI, val_ListI, Nrovar);
  //WriteLn('Jacobia');
  //MatricA.printM();
  MatricA := MatricA.Inversa(MatricA);
  //WriteLn('Inversa Jacobia');
  //MatricA.printM();
  EvaluateInvJacobiana:= MatricA;
end;

function TNewtonRap.f_x(fx_ListI,var_ListI : TArrString; val_ListI: TArrReal;Nrovar:Integer ):TMatrices;
var
   m_function: TParseMath;
   MatricA :TMatrices;           //matriz f(x_0)
   i : Integer;
begin
   m_function:=TParseMath.create();
   MatricA:= TMatrices.Create(Nrovar,1);

   for i:=0 to Nrovar-1  do begin
      m_function.AddVariable(var_ListI.get(i),val_ListI.get(i));
  end;

   for i:=0 to Nrovar-1  do
      begin
        m_function.Expression:= fx_ListI.get(i);
        MatricA.A[i,0]:= m_function.Evaluate();
        //WriteLn('endl');
      end;
  //WriteLn('fx');
  //MatricA.printM();

  f_x:=MatricA;

end;


function TNewtonRap.AllNewton(fx_ListI,var_ListI : TArrString; val_ListI: TArrReal;Nrovar:Integer): TMatrices;
var
    MatricA,MatricB :TMatrices;
    i : Integer;
begin
  MatricA := TMatrices.Create(Nrovar,Nrovar);
  MatricB := TMatrices.Create(Nrovar,1);

  for i:=0 to Nrovar-1 do begin
    MatricB.A[i,0]:= val_ListI.get(i);
  end;

  MatricA := MatricA.Multiplicacion(EvaluateInvJacobiana(fx_ListI,var_ListI,val_ListI,Nrovar), f_x(fx_ListI,var_ListI,val_ListI,Nrovar));

  MatricA := MatricB.Resta(MatricA);


  for i:=0 to Length( MatricA.A)-1 do begin
        valores_X.push(MatricA.A[i,0]);
   end;
  //WriteLn('lOS valores ',valores_X.get());
  valores_Erores.push(CalcError(Nrovar));
  //MatricA.printM();
  AllNewton := MatricA;
end;

function TNewtonRap.CalcError(Nrovar :Integer):Real;
var
  i,j : Integer;
  sum : Real;
begin
  if (valores_X.tam()=Nrovar)then begin
     //WriteLn('--');
     CalcError := -1.0 ;
  end
  else
  begin
    sum :=0;
    i:=valores_X.tam-(2*Nrovar);
    j := i+ Nrovar;
    while i < j do begin
      //WriteLn('a-b',valores_X.get(i+Nrovar),' - ',valores_X.get(i) );
      //WriteLn('*********');
      sum:= sum + power(valores_X.get(i+Nrovar)-valores_X.get(i),2);;

      i:= i+1;
    end;
    sum := power(sum,0.5);
    //WriteLn('error ', sum:0:2);
    CalcError := sum;

  end;


end;

function TNewtonRap.CompleteNewton(fx_ListI,var_ListI : TArrString; val_ListI: TArrReal;Nrovar:Integer; ErrI : Real):TMatrices;
var
  ErrorO : Real;
  i : Integer;
  val_Aux :TArrReal;
  mat_Aux : TMatrices;
begin
    ErrorO:= 50;

    val_Aux :=TArrReal.Create();
    mat_Aux :=TMatrices.Create(Nrovar,1);

    for i:= 0 to val_ListI.tam()-1 do begin
     valores_X.push(val_ListI.get(i));
    end;

    for i:=0 to Nrovar-1 do begin
            val_Aux.push(val_ListI.get(i));
    end;

    while (ErrorO>ErrI) do begin

          mat_Aux := AllNewton(fx_ListI,var_ListI,val_Aux,Nrovar);

          for i:=0 to Nrovar-1 do begin
            val_Aux.setArr(i,mat_Aux.A[i,0]);
          end;


          ErrorO:= valores_Erores.get(valores_Erores.tam()-1); //el ultimo error obtenido
          //WriteLn('El error ', ErrorO);
          //ReadKey;
    end;

    WriteLn('respuestaaaa total ');
    valores_X.print(Nrovar);
    WriteLn(' ');
    WriteLn('Errores ');
    valores_Erores.print(Nrovar);
    CompleteNewton := mat_Aux;
end;

end.

