within IndustrialControlSystems.LinearSystems.Discrete;
model TransferFunction " Model of a generic rational transfer function
  [a(m)*s^m + a(m-1)*s^(m-1) + ... + a(1)*s + a(0) ]/[b(n)*s^n + b(n-1)*s^(n-1) + ... + b(1)*s + b(0) ] "
  extends Interfaces.DiscreteBaseBlock;
  parameter Real num[:] = {1,1}
    "|Block parameters| Numerators coefficients (4*s + 2) is {4,2}";
  parameter Real den[:] = {2,1,1}
    "|Block parameters| Denumerators coefficients (4*s + 2) is {4,2}";
  parameter Real y_start = 0 "|Initial conditions| Output initial value";
  parameter Boolean initOutput = false
    "|Initial conditions| Initialise the output";
  parameter Boolean initSteadyState = false
    "|Initial conditions| Initialise at steady state";
  parameter Boolean initSteadyOutput = false
    "|Initial conditions| Initialise at steady output";
protected
  parameter Integer N = size(num,1) "grade of the numerator";
  parameter Integer D = size(den,1) "grade of the denumerator";
  parameter Real b[D] = den[:] "den. coefficients";
  Real a[D] "num. coefficients";
  Real c[D-1] "num. coefficients (proper part)";
  discrete Real Y[D];
  discrete Real U[D-1];
  Real A "terms used if the system is not strictly proper";
  discrete Real w "proper part of the output";
initial equation
  if initOutput then
    y = y_start;
  end if;
  if initSteadyOutput then
    pre(y) = 0;
  end if;
  if initSteadyState then
    pre(w) = 0;
  end if;
equation
  assert(D >= N,"The system is not proper");

  if D==N then
    a[1:D] = num[1:D];
  else
    a[1:D-N] = zeros(D-N);
    a[D-N+1:D] = num[1:N];
  end if;

  A = a[1]/b[1];

  for i in 1:D-1 loop
    c[i] = a[i+1] - A*b[i+1];
  end for;

  when sample(0,Ts) then
    Y[1] = Functions.fDerivator(1,w,pre(w),pre(Y[1]),Ts,1);
    Y[2] = w;
    for i in 3:D loop
      Y[i] = Functions.fIntegrator(alfa,Y[i-1],pre(Y[i-1]),pre(Y[i]),Ts,1);
    end for;

    U[1] = u;
    for i in 2:D-1 loop
      U[i] = Functions.fIntegrator(alfa,U[i-1],pre(U[i-1]),pre(U[i]),Ts,1);
    end for;

    w = - b[1]*Y[1] - sum(b[i]*Y[i] for i in 3:D) + sum(c[i]*U[i] for i in 1:D-1);

    y = A*u + w;

  end when;

 annotation (Icon(graphics={
        Text(
          extent={{-26,28},{32,12}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="A(s)"),
        Line(
          points={{-42,0},{52,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-30,-8},{36,-26}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="B(s)")}),  Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Discretised version of the continuous time transfer function, defined by its numerator and denumerator.
  <pre>
   Y(s)     a(m)*s^m + a(m-1)*s^(m-1) + ... + a(1)*s + a(0) 
   ----  = -------------------------------------------------
   U(s)     b(n)*s^n + b(n-1)*s^(n-1) + ... + b(1)*s + b(0)
  </pre>
  <br>
  The order of the numerator cannot be higher than the denumerator one: <FONT FACE=Courier>m &lt;= n</FONT>.
  </p>
  <p>
  <h4>Discretisation</h4>
  The discretisation of the continuos time transfer function has been performed with the bilinear transformation formula
  <pre>
                 z - 1 
  s = ------------------------------
        z*alpha*Ts - (alpha - 1)*Ts
  </pre>
  that is equivalent to<br>
  <ul>
  <li>Forward Euler (FE) if <pre><FONT FACE=Courier>alpha = 0</FONT></pre></li>
  <li>Backward Euler (BE) if <pre><FONT FACE=Courier>alpha = 1</FONT></pre></li>
  <li>Tustin (TU) if <pre><FONT FACE=Courier>alpha = 0.5</FONT></pre></li>
  </ul>
  </p>
  </HTML>", revisions="<html>
<dl><dt>Industrial Control Systems (v 1.0.0) : April-May 2012</dt>
<dl><dt>List of revisions:</dt>
<p><ul>
<li>11 May 2012 (author: Marco Bonvini)</li>
</ul></p>
<dl><dt><b>Main Authors:</b> <br/></dt>
<dd>Marco Bonvini; &lt;<a href=\"mailto:bonvini@elet.polimi.it\">bonvini@elet.polimi.it</a>&gt;</dd>
<dd>Alberto Leva &lt;<a href=\"mailto:leva@elet.polimi.it\">leva@elet.polimi.it</a>&gt;<br/></dd>
<dd>Politecnico di Milano</dd>
<dd>Dipartimento di Elettronica e Informazione</dd>
<dd>Via Ponzio 34/5</dd>
<dd>20133 Milano - ITALIA -<br/></dd>
<dt><b>Copyright:</b> </dt>
<dd>Copyright &copy; 2010-2012, Marco Bonvini and Alberto Leva.<br/></dd>
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>.</i><br/></dd>
</dl></html>"));
end TransferFunction;
