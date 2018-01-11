unit derivadaparcial;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, math, crt;
type
    TDerivParc = Class
    public
       Euler:Double;
       raizValor :Double;
       raizfound : Boolean;
       x_nRight1 :Double;
       function Mf_x(x:double):Double;
       function MDefinDeriv1(x_n, h: Double):Double;
       function MDefinDeriv2(x_n, x_nLeft1 :Double):Double;
       function MDefinDeriv3(x_n, h: Double):Double;
       constructor Create;
    end;
implementation

constructor TDerivParc.Create;
begin
    Euler:=2.71828182846;
    raizfound := False;
end;

function TDerivParc.Mf_x(x:double):Double;
begin
     try
       //f_x:=power(2.7182818285,power(x,2))+x-power(x,3)-5*ln(x)-5;
       //f_x:=sin(x)+(power(x,2)/(x-1))+3;
       //f_x:= power(x,2) + 3*x -4;
       //F_x:=ln(power(x,2)+1)-(power(E,x/2)*cos(PI*x));        //A=0.1, B=0.5
       //f_x:=7*sin(x)*power(E,-x)-1 ;                            //A= -1, B = 1
       //f_x:=power(x,3)-7*power(x,2)+14*x-6;                       //A=3.2, B=4
       //f_x:= 5*power(x,3)-5*power(x,2)+6*x-2;
       //Mf_x:=ln(power(x,2))-0.7;               //A=0.5 , B=2
       //f_x:=x-sqrt(18);                         //A=4, B=5
       //f_x:= power(x,4)-8*power(x,3)-35*power(x,2)+450*x-1001; //A=4.5, B=6
       //f_x:=-2*power(x,6)-1.5*power(x,4)+10*x+2;                 //A=0, B=1
       //f_x:=pi*power(x,2)*(9-x)-90;                                //A=1  B=2.9
       //f_x:= (power(x,5)/5)-(8*power(x,4)/4)-(35*power(x,3)/3)+(450*power(x,2)/2)-1001*x;
       //Mf_x:=power(Euler,x)-(1/x);
       //Mf_x:=30*sin(x);
       Mf_x:=cos(x)-x;
       if(Mf_x=0)then
       begin
            raizValor:=x;
            raizfound:=true;
       end;
     except
        on E: EDivByZero  do begin
          writeln( 'Error: '+ E.Message );
          readKey;
        end;
     end;
end;

function TDerivParc.MDefinDeriv1(x_n, h :Double):Double;
begin
     try

        MDefinDeriv1 := (Mf_x(x_n+h) - Mf_x(x_n))/h;
     Except
     on E: EDivByZero  do begin
         writeln( 'Error: '+ E.Message );
         exit;
        end;
     end;
end;


function TDerivParc.MDefinDeriv2(x_n, x_nLeft1 :Double):Double;
begin
     try
        MDefinDeriv2 :=  x_n-(( Mf_x(x_n)*(x_n-x_nLeft1) ) /(Mf_x(x_n)-Mf_x(x_nLeft1) ) );

     Except
      on E: EDivByZero  do begin

         writeln( 'Error: '+ E.Message );
         readKey;
         exit;
        end;
     end;
end;


function TDerivParc.MDefinDeriv3(x_n, h :Double):Double;
begin
     try
        MDefinDeriv3 :=  x_n-( (2*h*Mf_x(x_n) ) /(Mf_x(x_n + h) - Mf_x(x_n - h)) );
     Except
      on E: EDivByZero  do begin
         readKey;
         writeln( 'Error: '+ E.Message );
         exit;
        end;
     end;
end;

end.

