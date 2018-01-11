unit Jacobiana;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ParseMath, Matrices, ArrStr, ArrReal;
type TJacobiana = Class
     public
      fx_List : TArrString;     //para Jacobiana
      var_List : TArrString;    //para Jacobiana
      val_List : TArrReal;      //Para Jacobiana
      tam : Integer;
      constructor create();
      function Evaluate(fx_ListI, var_ListI : TArrString;  val_ListI : TArrReal; fil_colI: Integer ): TMatrices;
      function derivadaParcial(fun:TParseMath;x:string;valor:Real): Real;


     end;

implementation

constructor TJacobiana.create();
var
  i1 : Integer;
begin
   fx_List := TArrString.Create();
   var_List := TArrString.Create();
   val_List := TArrReal.Create();

end;



function TJacobiana.Evaluate(fx_ListI, var_ListI : TArrString;  val_ListI : TArrReal; fil_colI : Integer ): TMatrices;
var
  m_function:TParseMath;
  aux_mat:TMatrices;
  i,j:integer;
begin
  tam := fil_colI;

  for i:=0 to tam-1 do begin
    //WriteLn('a');
    fx_List.push(fx_ListI.get(i));
    // WriteLn('b');
    var_List.push(var_ListI.get(i));
    val_List.push(val_ListI.get(i));
  end;

  m_function:=TParseMath.create();


  for i:=0 to tam-1  do begin
      m_function.AddVariable(var_List.get(i),val_List.get(i));
  end;

  aux_mat:= TMatrices.create(tam,tam);
  for i:=0 to tam-1  do
      begin
        m_function.Expression:= fx_List.get(i);
        for j:=0 to tam-1  do
          begin
            //WriteLn('eval  ', m_function.Expression,' ->', var_List.get(j),',',val_List.get(j));
            //help[j,i]:=derivadaParcial(m_function,Jvariables[0,j],Jvalores[0,j]);
            aux_mat.A[i,j]:= derivadaParcial(m_function,var_List.get(j),val_List.get(j));
          end;
        //WriteLn('endl');
      end;
  Evaluate:=aux_mat;


end;

function TJacobiana.derivadaParcial(fun:TParseMath;x:string;valor:Real): Real;
var
  h,a,b,v : Real;
  funaux:TParseMath;
begin
  //Lo acabo de escribir //
  //funaux := TParseMath.create();
  h:=0.0001;
  v:=valor;
  funaux:=fun;
  funaux.NewValue(x,v);
  b:=funaux.Evaluate();
  //WriteLn( 'evaluando ' + FloatToStr(b));
  funaux.NewValue(x,v+h);
  a:=funaux.Evaluate();
  //Writeln( 'evaluando2 ' + FloatToStr(a));
  derivadaParcial:=(a-b)/h;

  //WriteLn('Respuesta deriv :    ', derivadaParcial);
end;


end.

